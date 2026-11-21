"""
One-shot Stage-3 Style Compiler (Save path only).

Merges Tier1+Tier2+Tier3 (+ optional tuners/sample) into a schema-valid
Compiled Style Contract via Groq structured outputs. Never called on the
live WebSocket finalize path.
"""

from __future__ import annotations

import json
import uuid
from typing import Any, Dict, List, Optional

import httpx
import structlog
from pydantic import BaseModel, Field

from services.groq_dictation import (
    GROQ_API_KEY,
    GROQ_BASE_URL,
    GROQ_FORMAT_MODEL,
    GroqDictationError,
)

logger = structlog.get_logger()

# Always injected into compiled contracts (and required by COMPILER_SYSTEM_PROMPT).
ASR_FILLER_DIRECTIVE = (
    "Strip all filler words, hesitations, and false starts from the ASR transcript."
)
ASR_SELF_CORRECTION_DIRECTIVE = (
    "When the speaker corrects themselves mid-thought, keep only the final corrected fact or phrasing."
)
ASR_CLEANUP_DIRECTIVES = (ASR_FILLER_DIRECTIVE, ASR_SELF_CORRECTION_DIRECTIVE)

COMPILER_SYSTEM_PROMPT = """
You are an expert AI Communication Architect. Your job is to compile a 3-tier style configuration and optional writing sample into a deterministic, machine-readable JSON contract for a real-time speech-to-text formatter.

COMPILATION RULES:
1. MERGE HIERARCHY: Combine Tier 1 (Category), Tier 2 (Subcategory), and Tier 3 (Playbook). If tunerOverrides are provided, they take precedence over default Tier 2/3 layout or length settings.
2. EXTRACT VOICE FROM SAMPLE: If 'userSampleText' is provided, analyze its greeting style, sentence cadence, vocabulary, and sign-off, and encode those exact traits into 'system_directives' and 'formatting_rules'.
3. SYNTHESIZE FEW-SHOT PAIR:
   - If 'userSampleText' is provided, set 'few_shot_anchor.ideal_output' to a cleaned version of that sample, and reverse-engineer a realistic messy spoken voice note ('spoken_input' with natural hesitations like "um" or a quick backtrack) that captures the exact same facts.
   - If no 'userSampleText' is provided, refine the Tier 3 playbook's default example so it reflects any tuner overrides. If the playbook already includes a few_shot, preserve its facts and polish the pair.
4. IMPERATIVE DIRECTIVES: Write 'system_directives' as 3 to 5 strict, actionable transformation commands. Never include vague fluff. Spend slots on real behavioral rules (structure, tone, ask shape, what not to pitch)—not meta instructions. Every directive must govern end-user message content or tone—never include compiler formatting rules (ASCII/Unicode character rules, hyphen/dash policy, or punctuation meta-rules) in the output.
5. PUNCTUATION VS STRUCTURE (COMPILER-ONLY — FOLLOW SILENTLY): Do not invent punctuation rules that contradict the playbook structure. If the output includes a question (binary ask, closing question, etc.), never require every sentence to end with a period—describe sentence roles instead (e.g. "exactly two sentences: a declarative observation followed by a single binary question"). Leave terminal . vs ? to formatting_rules.punctuation and normal English. Do NOT quote this rule into system_directives. When writing directive text yourself, use only ASCII hyphen "-".
6. ASR CLEANUP (REQUIRED): Always include directives that (a) strip ASR filler words, hesitations, and false starts, and (b) resolve spoken self-corrections in favor of the speaker's final correction (e.g. "20—actually 25", "Tuesday — no wait, Thursday").
7. BANNED PHRASES: Merge Tier 1 hedges/forbidden phrases with Tier 3 banned_phrases into a single list. Do not invent unrelated bans. Do NOT generate a system_directive telling the model to check or remove banned_phrases—that list is enforced separately at runtime (e.g. never write "Remove any phrases that appear in the banned_phrases list.").
8. max_sentences: Prefer Tier 2 max_sentences when present. If the playbook name or directive specifies an exact count (e.g. "two-sentence", "2-Sentence", "exactly two sentences"), set max_sentences to that positive integer. Map length ultra_brief to 2 and brief/tighten to 4. For open-ended playbooks with no fixed sentence count (meeting summaries, long-form proposals, etc.), set max_sentences to null — never use 0.
""".strip()

COMPILED_STYLE_SCHEMA: Dict[str, Any] = {
    "name": "compiled_dictation_style",
    "strict": True,
    "schema": {
        "type": "object",
        "additionalProperties": False,
        "required": [
            "objective",
            "system_directives",
            "banned_phrases",
            "formatting_rules",
            "few_shot_anchor",
        ],
        "properties": {
            "objective": {
                "type": "string",
                "description": "Single crisp sentence defining the communication goal.",
            },
            "system_directives": {
                "type": "array",
                "items": {"type": "string"},
                "description": (
                    "3 to 5 concrete, imperative rules for transforming spoken ASR into the target style. "
                    "Must include stripping fillers/hesitations/false starts and resolving spoken "
                    "self-corrections in favor of the speaker's final correction. "
                    "Do not include a meta rule about checking banned_phrases—that is enforced separately. "
                    "Every item must govern end-user message content or tone—never compiler formatting "
                    "(ASCII/Unicode, hyphen policy, punctuation meta-rules)."
                ),
            },
            "banned_phrases": {
                "type": "array",
                "items": {"type": "string"},
                "description": "Exact filler, hedging, or off-brand phrases to strip or replace.",
            },
            "formatting_rules": {
                "type": "object",
                "additionalProperties": False,
                "required": ["casing", "punctuation", "layout", "max_sentences"],
                "properties": {
                    "casing": {
                        "type": "string",
                        "enum": ["standard", "lowercase_all"],
                    },
                    "punctuation": {
                        "type": "string",
                        "enum": ["strict", "relaxed_no_trailing_period", "minimal"],
                    },
                    "layout": {
                        "type": "string",
                        "enum": ["single_paragraph", "short_paragraphs", "bullet_list"],
                    },
                    "max_sentences": {
                        "type": ["integer", "null"],
                        "description": (
                            "Hard sentence cap when the playbook is sentence-locked; "
                            "null when there is no fixed sentence count."
                        ),
                    },
                },
            },
            "few_shot_anchor": {
                "type": "object",
                "additionalProperties": False,
                "required": ["spoken_input", "ideal_output"],
                "properties": {
                    "spoken_input": {
                        "type": "string",
                        "description": "Realistic messy spoken ASR that would produce ideal_output.",
                    },
                    "ideal_output": {
                        "type": "string",
                        "description": "Polished target message matching the user sample or playbook.",
                    },
                },
            },
        },
    },
}


class TunerOverrides(BaseModel):
    length: Optional[str] = None
    layout: Optional[str] = None
    energy: Optional[str] = None


class StyleCompilationInput(BaseModel):
    style_name: str = Field(..., min_length=1, max_length=120)
    taxonomy_path: str = Field(..., min_length=1, max_length=200)
    category_data: Dict[str, Any] = Field(default_factory=dict)
    subcategory_data: Dict[str, Any] = Field(default_factory=dict)
    playbook_data: Dict[str, Any] = Field(default_factory=dict)
    tuner_overrides: Optional[TunerOverrides] = None
    user_sample_text: Optional[str] = Field(default=None, max_length=4000)
    # Optional override for Catalog Studio / staff tooling. Falls back to GROQ_FORMAT_MODEL.
    model: Optional[str] = Field(default=None, max_length=120)


def _seed_banned(category: Dict[str, Any], playbook: Dict[str, Any]) -> List[str]:
    banned: List[str] = []
    for key in ("forbidden_hedges", "banned_phrases"):
        raw = category.get(key) or playbook.get(key) or []
        if isinstance(raw, list):
            banned.extend(str(item).strip() for item in raw if str(item).strip())
    # de-dupe preserve order
    seen = set()
    out: List[str] = []
    for item in banned:
        low = item.lower()
        if low in seen:
            continue
        seen.add(low)
        out.append(item)
    return out


def _map_layout(raw: Any) -> str:
    value = str(raw or "").strip().lower()
    if value in ("single_paragraph", "short_paragraphs", "bullet_list"):
        return value
    if value in ("paragraphs", "short_paragraph", "paragraph"):
        return "short_paragraphs"
    if value in ("bullets", "bullet", "list"):
        return "bullet_list"
    if value in ("action_first", "single", "one_paragraph"):
        return "single_paragraph"
    return "short_paragraphs"


# Unicode dashes → ASCII hyphen so LLM "self‑correction" (U+2011) matches tokens.
_DASH_TO_ASCII = str.maketrans({
    "\u2010": "-",  # hyphen
    "\u2011": "-",  # non-breaking hyphen
    "\u2012": "-",  # figure dash
    "\u2013": "-",  # en dash
    "\u2014": "-",  # em dash
    "\u2015": "-",  # horizontal bar
    "\u2212": "-",  # minus sign
})
_WORD_COUNTS = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
}


def _infer_max_sentences_from_text(*parts: str) -> int:
    """
    Infer a hard sentence cap from playbook title/directive text.
    Save/compile only — scans short strings for 'two-sentence', 'exactly 2 sentences', etc.
    """
    blob = " ".join(str(p) for p in parts if p).lower().translate(_DASH_TO_ASCII)
    if not blob:
        return 0
    # Highest confidence first.
    for word, value in _WORD_COUNTS.items():
        if f"exactly {word} sentences" in blob or f"exactly {value} sentences" in blob:
            return value
        if f"exactly {word} sentence" in blob or f"exactly {value} sentence" in blob:
            return value
    for word, value in _WORD_COUNTS.items():
        if f"{word}-sentence" in blob or f"{value}-sentence" in blob:
            return value
        if f"{word} sentences" in blob or f"{value} sentences" in blob:
            return value
        if f"{word} sentence" in blob or f"{value} sentence" in blob:
            return value
    return 0


def _map_max_sentences(
    tuner_length: Optional[str],
    subcategory: Dict[str, Any],
    *text_hints: str,
) -> Optional[int]:
    """
    Positive hard cap when sentence-locked; None for open-ended playbooks.
    Never returns 0 — uncapped is null so runtimes do not see max_sentences=0.
    """
    length = str(tuner_length or "").strip().lower()
    if not length:
        length = str(
            subcategory.get("length")
            or subcategory.get("compression")
            or ""
        ).strip().lower()
    if length in ("ultra_brief", "ultra-brief"):
        return 2
    if length in ("tighten_30", "tighten", "brief"):
        return 4
    try:
        from_sub = int(subcategory.get("max_sentences", 0) or 0)
        if from_sub > 0:
            return from_sub
    except (TypeError, ValueError):
        pass
    inferred = _infer_max_sentences_from_text(*text_hints)
    return inferred if inferred > 0 else None


def _normalize_max_sentences(value: Any) -> Optional[int]:
    """Coerce raw formatting max_sentences; 0/missing/invalid -> None (uncapped)."""
    if value is None:
        return None
    try:
        parsed = int(value)
    except (TypeError, ValueError):
        return None
    return parsed if parsed > 0 else None


# High-signal substring tokens only — no regex. Save/compile path; ≤5 short lines.
_FILLER_TOKENS = (
    "filler",
    "fillers",
    "hesitation",
    "hesitations",
    "false start",
    "false starts",
)
_SELF_CORRECTION_TOKENS = (
    "self-correction",
    "self correction",
    "self-correct",
    "selfcorrections",
    "selfcorrection",
    "corrects themselves",
    "correct themselves",
    "corrected phrase",
    "mid-thought",
    "mid thought",
    "final corrected",
    "final correction",
    "final intended",
    "no wait",
    "scratch that",
    "backtrack",
)
_FACTS_PAD = "Preserve the speaker's facts, names, dates, and numbers."
_FACTS_PAD_LOW = _FACTS_PAD.lower()


def _normalize_directive_key(text: str) -> str:
    """Lowercase + ASCII-normalize dashes for semantic matching (no regex)."""
    return text.strip().lower().translate(_DASH_TO_ASCII)


def _is_generic_filler_pad(low: str) -> bool:
    """True for the old pad string we used to fill short directive lists."""
    return low.startswith("strip fillers") and "facts intact" in low


def _is_banned_phrases_meta(low: str) -> bool:
    """Drop redundant 'check banned_phrases' directives — enforced via Never output."""
    if "banned_phrases" in low or "banned phrases" in low:
        return True
    return "banned phrase" in low and any(
        hint in low for hint in ("list", "remove", "check", "appear", "never output")
    )


def _is_punctuation_structure_meta(low: str) -> bool:
    """Drop compiler-echoed punctuation-vs-structure meta rules — follow silently."""
    if "force a period" in low and "question" in low:
        return True
    if "period on a question" in low or "periods on a question" in low:
        return True
    return "punctuation" in low and "contradict" in low


def _is_compiler_formatting_meta(low: str) -> bool:
    """Drop compiler-only formatting rules that must not burn runtime directive slots."""
    if _is_punctuation_structure_meta(low):
        return True
    if "ascii" in low and any(tok in low for tok in ("hyphen", "dash", "unicode", "character")):
        return True
    if "unicode" in low and any(tok in low for tok in ("hyphen", "dash", "ascii")):
        return True
    return "only ascii" in low


def _directive_covers_filler(low: str) -> bool:
    """Semantic match — catches LLM paraphrases of the filler rule."""
    return any(token in low for token in _FILLER_TOKENS)


def _directive_covers_self_correction(low: str) -> bool:
    """Semantic match — catches LLM paraphrases of the self-correction rule."""
    if any(token in low for token in _SELF_CORRECTION_TOKENS):
        return True
    # Hyphen-stripped form catches odd spacing after dash normalize.
    compact = low.replace("-", "").replace(" ", "")
    return "selfcorrection" in compact


def _ensure_asr_cleanup_directives(directives: List[str], *, min_count: int = 3) -> List[str]:
    """
    Guarantee filler + self-correction imperatives in system_directives.

    Sync, allocation-light, O(n) over ≤5 short strings. Called only from Save
    compile / _post_validate — never on the live finalize WebSocket path.

    Ordering: up to 3 playbook-specific directives first, then the 2 canonical ASR
    rules. Unicode-dash paraphrases, banned_phrases meta-lines, and punctuation-
    structure meta echoes are dropped so they cannot burn playbook slots.
    """
    playbook: List[str] = []
    seen_exact: set[str] = set()

    for raw in directives:
        item = str(raw).strip()
        if not item:
            continue
        key = _normalize_directive_key(item)
        if (
            key in seen_exact
            or _is_generic_filler_pad(key)
            or _is_banned_phrases_meta(key)
            or _is_compiler_formatting_meta(key)
        ):
            continue
        seen_exact.add(key)

        is_filler = _directive_covers_filler(key)
        is_self = _directive_covers_self_correction(key)
        if is_filler or is_self:
            # Collapse into the canonical ASR pair appended below.
            continue
        playbook.append(item)

    # Always emit canonical ASCII wording for the reserved ASR slots.
    out = playbook[:3] + [ASR_FILLER_DIRECTIVE, ASR_SELF_CORRECTION_DIRECTIVE]

    seen = {_normalize_directive_key(d) for d in out}
    while len(out) < min_count:
        if _FACTS_PAD_LOW not in seen:
            out.append(_FACTS_PAD)
            seen.add(_FACTS_PAD_LOW)
        else:
            break

    return out[:5]


def _deterministic_compile(input_data: StyleCompilationInput) -> Dict[str, Any]:
    """Build a valid contract from Tier1–3 without calling Groq (Save must always work)."""
    playbook = input_data.playbook_data or {}
    subcategory = input_data.subcategory_data or {}
    category = input_data.category_data or {}
    tuners = (
        input_data.tuner_overrides.model_dump(exclude_none=True)
        if input_data.tuner_overrides
        else {}
    )
    directive = str(playbook.get("directive") or "").strip()
    objective = directive or f"Produce messages in the {input_data.style_name} style."

    directives: List[str] = []
    if directive:
        directives.append(directive)
    voice = str(category.get("voice") or subcategory.get("voice") or "").strip()
    if voice:
        directives.append(f"Keep a {voice.replace('_', ' ')} voice.")
    length = str(tuners.get("length") or "").strip()
    if length:
        directives.append(f"Apply length preference: {length.replace('_', ' ')}.")
    energy = str(tuners.get("energy") or "").strip()
    if energy:
        directives.append(f"Keep energy {energy}.")
    # ASR hygiene is applied once in _post_validate (no double pass).

    few = playbook.get("few_shot") or {}
    sample = (input_data.user_sample_text or "").strip()
    ideal = sample or str(few.get("target") or directive or input_data.style_name).strip()
    spoken = str(few.get("raw_asr") or "").strip() or f"um so basically {ideal}"

    layout = _map_layout(tuners.get("layout") or subcategory.get("default_layout"))
    max_sentences = _map_max_sentences(
        tuners.get("length"),
        subcategory,
        input_data.style_name,
        directive,
        str(playbook.get("display_name") or ""),
        objective,
    )
    casing = "lowercase_all" if str(category.get("grammar_strictness") or "").lower() == "low" and "personal" in str(category.get("domain") or "").lower() else "standard"
    if str(subcategory.get("casing") or "").lower() in ("standard", "lowercase_all"):
        casing = str(subcategory.get("casing")).lower()

    raw = {
        "objective": objective,
        "system_directives": directives,
        "banned_phrases": _seed_banned(category, playbook),
        "formatting_rules": {
            "casing": casing,
            "punctuation": "relaxed_no_trailing_period" if casing == "lowercase_all" else "strict",
            "layout": layout,
            "max_sentences": max_sentences,
        },
        "few_shot_anchor": {
            "spoken_input": spoken,
            "ideal_output": ideal,
        },
    }
    return _post_validate(raw, input_data)


def _post_validate(raw: Dict[str, Any], input_data: StyleCompilationInput) -> Dict[str, Any]:
    objective = str(raw.get("objective") or "").strip()
    if not objective:
        objective = f"Produce messages in the {input_data.style_name} style."

    directives = [
        str(item).strip()
        for item in (raw.get("system_directives") or [])
        if str(item).strip()
    ]
    if len(directives) < 3:
        directive = str(input_data.playbook_data.get("directive") or "").strip()
        if directive and directive.lower() not in {d.lower() for d in directives}:
            directives.append(directive)
    directives = _ensure_asr_cleanup_directives(directives)

    banned = [
        str(item).strip()
        for item in (raw.get("banned_phrases") or [])
        if str(item).strip()
    ]
    for seed in _seed_banned(input_data.category_data, input_data.playbook_data):
        if seed.lower() not in {b.lower() for b in banned}:
            banned.append(seed)

    formatting = raw.get("formatting_rules") or {}
    casing = formatting.get("casing") if formatting.get("casing") in ("standard", "lowercase_all") else "standard"
    punctuation = formatting.get("punctuation")
    if punctuation not in ("strict", "relaxed_no_trailing_period", "minimal"):
        punctuation = "strict"
    layout = formatting.get("layout")
    if layout not in ("single_paragraph", "short_paragraphs", "bullet_list"):
        layout = "short_paragraphs"
    max_sentences = _normalize_max_sentences(formatting.get("max_sentences"))
    if max_sentences is None:
        tuners = (
            input_data.tuner_overrides.model_dump(exclude_none=True)
            if input_data.tuner_overrides
            else {}
        )
        max_sentences = _map_max_sentences(
            tuners.get("length"),
            input_data.subcategory_data or {},
            input_data.style_name,
            str((input_data.playbook_data or {}).get("directive") or ""),
            str((input_data.playbook_data or {}).get("display_name") or ""),
            objective,
            *directives[:3],
        )

    few = raw.get("few_shot_anchor") or {}
    spoken = str(few.get("spoken_input") or "").strip()
    ideal = str(few.get("ideal_output") or "").strip()
    playbook_few = input_data.playbook_data.get("few_shot") or {}
    if not ideal:
        ideal = str(
            input_data.user_sample_text
            or playbook_few.get("target")
            or input_data.playbook_data.get("directive")
            or input_data.style_name
        ).strip()
    if not spoken:
        spoken = str(
            playbook_few.get("raw_asr")
            or f"um so basically {ideal}"
        ).strip()

    playbook = input_data.playbook_data or {}
    structure = str(
        raw.get("structure") or playbook.get("structure") or ""
    ).strip()
    do_examples = [
        str(item).strip()
        for item in (raw.get("do_examples") or playbook.get("do_examples") or [])
        if str(item).strip()
    ][:4]
    dont_examples = [
        str(item).strip()
        for item in (raw.get("dont_examples") or playbook.get("dont_examples") or [])
        if str(item).strip()
    ][:4]
    # Glossary/wordbook are room-scoped user data — never bake into global template contracts.

    contract = {
        "style_id": f"style_{uuid.uuid4().hex[:12]}",
        "name": input_data.style_name.strip(),
        "taxonomy_path": input_data.taxonomy_path.strip(),
        "objective": objective,
        "system_directives": directives,
        "banned_phrases": banned,
        "formatting_rules": {
            "casing": casing,
            "punctuation": punctuation,
            "layout": layout,
            "max_sentences": max_sentences,
        },
        "few_shot_anchor": {
            "spoken_input": spoken,
            "ideal_output": ideal,
        },
    }
    if structure:
        contract["structure"] = structure
    if do_examples:
        contract["do_examples"] = do_examples
    if dont_examples:
        contract["dont_examples"] = dont_examples
    return contract


async def compile_style_contract(input_data: StyleCompilationInput) -> Dict[str, Any]:
    """Prefer Groq structured compile; always fall back to deterministic merge so Save works."""
    if not GROQ_API_KEY:
        logger.warning("style_compiler_groq_missing_using_fallback")
        contract = _deterministic_compile(input_data)
        logger.info(
            "style_contract_compiled",
            style_id=contract["style_id"],
            taxonomy_path=contract["taxonomy_path"],
            source="deterministic",
        )
        return contract

    payload = {
        "styleName": input_data.style_name,
        "taxonomyPath": input_data.taxonomy_path,
        "categoryData": input_data.category_data,
        "subcategoryData": input_data.subcategory_data,
        "playbookData": input_data.playbook_data,
        "tunerOverrides": (
            input_data.tuner_overrides.model_dump(exclude_none=True)
            if input_data.tuner_overrides
            else None
        ),
        "userSampleText": (input_data.user_sample_text or "").strip() or None,
    }

    model_override = (input_data.model or "").strip()
    selected_model = model_override or GROQ_FORMAT_MODEL

    body = {
        "model": selected_model,
        "temperature": 0.1,
        "max_tokens": 1200,
        "reasoning_effort": "low",
        "response_format": {
            "type": "json_schema",
            "json_schema": COMPILED_STYLE_SCHEMA,
        },
        "messages": [
            {"role": "system", "content": COMPILER_SYSTEM_PROMPT},
            {"role": "user", "content": json.dumps(payload, ensure_ascii=False)},
        ],
    }
    headers = {
        "Authorization": f"Bearer {GROQ_API_KEY}",
        "Content-Type": "application/json",
    }
    try:
        async with httpx.AsyncClient(timeout=45.0) as client:
            response = await client.post(
                f"{GROQ_BASE_URL}/chat/completions",
                headers=headers,
                json=body,
            )
    except Exception as exc:
        logger.warning("style_compiler_transport_failed", error=str(exc))
        contract = _deterministic_compile(input_data)
        logger.info(
            "style_contract_compiled",
            style_id=contract["style_id"],
            taxonomy_path=contract["taxonomy_path"],
            source="deterministic_transport",
        )
        return contract

    if response.status_code >= 400:
        detail = (response.text or "")[:240]
        logger.warning(
            "style_compiler_failed",
            status=response.status_code,
            detail=detail,
        )
        contract = _deterministic_compile(input_data)
        logger.info(
            "style_contract_compiled",
            style_id=contract["style_id"],
            taxonomy_path=contract["taxonomy_path"],
            source="deterministic_http",
        )
        return contract

    content = (
        response.json()
        .get("choices", [{}])[0]
        .get("message", {})
        .get("content", "")
        .strip()
    )
    if not content:
        logger.warning("style_compiler_empty_using_fallback")
        contract = _deterministic_compile(input_data)
        logger.info(
            "style_contract_compiled",
            style_id=contract["style_id"],
            taxonomy_path=contract["taxonomy_path"],
            source="deterministic_empty",
        )
        return contract

    try:
        raw = json.loads(content)
    except json.JSONDecodeError:
        logger.warning("style_compiler_invalid_json_using_fallback")
        contract = _deterministic_compile(input_data)
        logger.info(
            "style_contract_compiled",
            style_id=contract["style_id"],
            taxonomy_path=contract["taxonomy_path"],
            source="deterministic_json",
        )
        return contract

    if not isinstance(raw, dict):
        contract = _deterministic_compile(input_data)
        logger.info(
            "style_contract_compiled",
            style_id=contract["style_id"],
            taxonomy_path=contract["taxonomy_path"],
            source="deterministic_shape",
        )
        return contract

    contract = _post_validate(raw, input_data)
    logger.info(
        "style_contract_compiled",
        style_id=contract["style_id"],
        taxonomy_path=contract["taxonomy_path"],
        source="groq",
    )
    return contract


def build_live_dictation_system_prompt(contract: Dict[str, Any]) -> str:
    """Pure string hydration for the live format path (<1ms)."""
    directives = contract.get("system_directives") or []
    rules_block = "\n".join(f"  * {rule}" for rule in directives)
    formatting = contract.get("formatting_rules") or {}
    few = contract.get("few_shot_anchor") or {}
    banned = contract.get("banned_phrases") or []
    structure = str(contract.get("structure") or "").strip()
    do_examples = [
        str(item).strip()
        for item in (contract.get("do_examples") or [])
        if str(item).strip()
    ]
    dont_examples = [
        str(item).strip()
        for item in (contract.get("dont_examples") or [])
        if str(item).strip()
    ]
    extras = []
    if structure:
        extras.append(f"- Structure: {structure}")
    if do_examples:
        extras.append(
            "- Do (good outputs):\n"
            + "\n".join(f"  * {item}" for item in do_examples[:4])
        )
    if dont_examples:
        extras.append(
            "- Don't (avoid outputs like):\n"
            + "\n".join(f"  * {item}" for item in dont_examples[:4])
        )
    room_assets = room_dictation_assets_block(contract)
    if room_assets:
        extras.append(room_assets)
    extras_block = ("\n" + "\n".join(extras)) if extras else ""
    max_sentences = _normalize_max_sentences(formatting.get("max_sentences"))
    formatting_line = (
        f"Casing={formatting.get('casing')}, "
        f"Punctuation={formatting.get('punctuation')}, "
        f"Layout={formatting.get('layout')}"
    )
    if max_sentences is not None:
        formatting_line += f", MaxSentences={max_sentences}"

    return f"""
You are a real-time dictation processor. Transform raw Speech-to-Text (ASR) into a ready-to-send message.

CORE GUARDRAILS (NEVER VIOLATE):
1. Strip verbal fillers ("um", "uh", "like", "you know").
2. Execute spoken self-corrections ("Tuesday — no wait, Wednesday" -> "Wednesday").
3. NEVER invent facts, names, dates, or numbers not present in the transcript.
4. Output ONLY the final message text. Zero commentary, quotes, or preambles.

STYLE CONTRACT:
- Goal: {contract.get("objective") or ""}
- Rules:
{rules_block}
- Banned Phrases (never output): {json.dumps(banned, ensure_ascii=False)}
- Formatting: {formatting_line}{extras_block}

GOLDEN EXAMPLE:
Raw ASR: "{few.get("spoken_input") or ""}"
Target Output: "{few.get("ideal_output") or ""}"
""".strip()


def room_dictation_assets_block(contract: Dict[str, Any] | None) -> str:
    """Pure string hydration for room Wordbook/glossary + Shortcuts (<1ms)."""
    if not isinstance(contract, dict):
        return ""
    glossary_lines = []
    for row in contract.get("glossary") or []:
        if not isinstance(row, dict):
            continue
        heard = str(row.get("heard") or "").strip()
        written = str(row.get("written") or "").strip()
        if heard and written:
            glossary_lines.append(f'  * "{heard}" → "{written}"')
    shortcut_lines = []
    for row in contract.get("shortcuts") or []:
        if not isinstance(row, dict):
            continue
        trigger = str(row.get("trigger") or "").strip()
        expansion = str(row.get("expansion") or "").strip()
        if trigger and expansion:
            shortcut_lines.append(f'  * If the speaker says "{trigger}", output: {expansion}')

    parts = []
    if glossary_lines:
        parts.append(
            "- Room Wordbook / glossary (prefer these exact spellings):\n"
            + "\n".join(glossary_lines[:24])
        )
    if shortcut_lines:
        parts.append(
            "- Room Shortcuts (expand spoken triggers to the canned text):\n"
            + "\n".join(shortcut_lines[:16])
        )
    return "\n".join(parts)
