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

COMPILER_SYSTEM_PROMPT = """
You are an expert AI Communication Architect. Your job is to compile a 3-tier style configuration and optional writing sample into a deterministic, machine-readable JSON contract for a real-time speech-to-text formatter.

COMPILATION RULES:
1. MERGE HIERARCHY: Combine Tier 1 (Category), Tier 2 (Subcategory), and Tier 3 (Playbook). If tunerOverrides are provided, they take precedence over default Tier 2/3 layout or length settings.
2. EXTRACT VOICE FROM SAMPLE: If 'userSampleText' is provided, analyze its greeting style, sentence cadence, vocabulary, and sign-off, and encode those exact traits into 'system_directives' and 'formatting_rules'.
3. SYNTHESIZE FEW-SHOT PAIR:
   - If 'userSampleText' is provided, set 'few_shot_anchor.ideal_output' to a cleaned version of that sample, and reverse-engineer a realistic messy spoken voice note ('spoken_input' with natural hesitations like "um" or a quick backtrack) that captures the exact same facts.
   - If no 'userSampleText' is provided, refine the Tier 3 playbook's default example so it reflects any tuner overrides. If the playbook already includes a few_shot, preserve its facts and polish the pair.
4. IMPERATIVE DIRECTIVES: Write 'system_directives' as 3 to 5 strict, actionable transformation commands. Never include vague fluff.
5. BANNED PHRASES: Merge Tier 1 hedges/forbidden phrases with Tier 3 banned_phrases into a single list. Do not invent unrelated bans.
6. max_sentences: Use the Tier 2 max_sentences when present. Use 0 when there is no hard sentence cap.
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
                "description": "3 to 5 concrete, imperative rules for transforming spoken ASR into the target style.",
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
                    "max_sentences": {"type": "integer"},
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


def _map_max_sentences(tuner_length: Optional[str], subcategory: Dict[str, Any]) -> int:
    length = str(tuner_length or "").strip().lower()
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
    return 0


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
    while len(directives) < 3:
        directives.append("Strip fillers and keep the speaker's facts intact.")
    directives = directives[:5]

    few = playbook.get("few_shot") or {}
    sample = (input_data.user_sample_text or "").strip()
    ideal = sample or str(few.get("target") or directive or input_data.style_name).strip()
    spoken = str(few.get("raw_asr") or "").strip() or f"um so basically {ideal}"

    layout = _map_layout(tuners.get("layout") or subcategory.get("default_layout"))
    max_sentences = _map_max_sentences(tuners.get("length"), subcategory)
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
        if directive:
            directives.append(directive)
        while len(directives) < 3:
            directives.append("Strip fillers and keep the speaker's facts intact.")
    directives = directives[:5]

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
    try:
        max_sentences = int(formatting.get("max_sentences", 0))
    except (TypeError, ValueError):
        max_sentences = 0
    if max_sentences < 0:
        max_sentences = 0

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

    return {
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

    body = {
        "model": GROQ_FORMAT_MODEL,
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
- Formatting: Casing={formatting.get("casing")}, Punctuation={formatting.get("punctuation")}, Layout={formatting.get("layout")}, MaxSentences={formatting.get("max_sentences")}

GOLDEN EXAMPLE:
Raw ASR: "{few.get("spoken_input") or ""}"
Target Output: "{few.get("ideal_output") or ""}"
""".strip()
