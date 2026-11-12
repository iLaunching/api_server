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
    if not GROQ_API_KEY:
        raise GroqDictationError(503, "Speech service is not configured yet.")

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
        async with httpx.AsyncClient(timeout=20.0) as client:
            response = await client.post(
                f"{GROQ_BASE_URL}/chat/completions",
                headers=headers,
                json=body,
            )
    except httpx.TimeoutException as exc:
        raise GroqDictationError(504, "Style compiler timed out.") from exc
    except httpx.HTTPError as exc:
        raise GroqDictationError(502, "Could not reach style compiler.") from exc

    if response.status_code >= 400:
        detail = (response.text or "")[:240]
        logger.warning(
            "style_compiler_failed",
            status=response.status_code,
            detail=detail,
        )
        raise GroqDictationError(
            response.status_code,
            f"Style compiler error ({response.status_code}).",
        )

    content = (
        response.json()
        .get("choices", [{}])[0]
        .get("message", {})
        .get("content", "")
        .strip()
    )
    if not content:
        raise GroqDictationError(502, "Style compiler returned empty output.")

    try:
        raw = json.loads(content)
    except json.JSONDecodeError as exc:
        raise GroqDictationError(502, "Style compiler returned invalid JSON.") from exc

    if not isinstance(raw, dict):
        raise GroqDictationError(502, "Style compiler returned invalid JSON object.")

    contract = _post_validate(raw, input_data)
    logger.info(
        "style_contract_compiled",
        style_id=contract["style_id"],
        taxonomy_path=contract["taxonomy_path"],
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
