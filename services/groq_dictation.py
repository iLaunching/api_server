"""
Groq dictation: one key for speech and cleanup.

Audio goes to whisper-large-v3-turbo. When formatting is on, the transcript
text (not the audio) goes to gpt-oss-20b. The phone still sees one stream.
"""

from __future__ import annotations

import asyncio
import os
import re

import httpx
import structlog

from services.dictation_asr import pcm16_to_wav_bytes

logger = structlog.get_logger()


def _env_secret(name: str) -> str:
    raw = os.getenv(name, "") or ""
    return raw.strip().strip('"').strip("'")


GROQ_API_KEY = _env_secret("GROQ_API_KEY")
GROQ_BASE_URL = (
    _env_secret("GROQ_BASE_URL") or "https://api.groq.com/openai/v1"
).rstrip("/")
GROQ_ASR_MODEL = _env_secret("GROQ_ASR_MODEL") or "whisper-large-v3-turbo"
GROQ_ASR_LANGUAGE = _env_secret("GROQ_ASR_LANGUAGE") or "en"
GROQ_FORMAT_MODEL = _env_secret("GROQ_FORMAT_MODEL") or "openai/gpt-oss-20b"
GROQ_ASR_PROMPT = (
    _env_secret("GROQ_ASR_PROMPT")
    or "Punctuate correctly, remove stutters, and keep capitalization intact."
)
GROQ_USER_DICTIONARY = _env_secret("GROQ_USER_DICTIONARY")

_FORMAT_SYSTEM = """You are an expert real-time dictation processor. Transform raw, noisy Speech-to-Text (ASR) transcripts into clean, polished written text ready to be pasted.

CRITICAL RULES:
1. PRESERVE INTENT & VOICE: Clean up structure without rephrasing, summarizing, or changing tone. Maintain the speaker's exact vocabulary, style, and persona.
2. REMOVE VERBAL FILLERS: Strip out hesitation words and verbal clutter (e.g., "um", "uh", "you know", "like", "I mean", "so basically").
3. EXECUTE BACKTRACKS & SELF-CORRECTIONS: Recognize spoken edits and replace earlier text with the final intended phrase.
   - Pattern: "[Mistake] -> [Pivot Phrase] -> [Correction]"
   - Pivot Phrases: "no wait", "scratch that", "actually", "I mean", "rather", "sorry", "make that".
   - Example: "Meet at 3, no wait, make that 4 PM" -> "Meet at 4 PM"
4. FORMAT SPOKEN PUNCTUATION & LISTS:
   - Convert spoken layout commands into formatting (e.g., "new line" -> newline, "bullet point" -> •).
   - Normalize numbers, dates, times, and currency (e.g., "five dollars" -> "$5", "friday" -> "Friday").
   - Spoken lists: "first ... second ... third ..." become a numbered list.
5. OUTPUT STRICTNESS: Return ONLY the processed text. Never add meta-comments, quotes, introductory text ("Here is your text:"), or explanatory notes.
6. NO-SPEECH FILTER: If the input consists purely of background noise, hallucinated ASR tags (e.g., "Amara.org", "Subtitles by"), or non-speech sounds, output an empty string.

Input Transcript:"""

_RETRY_AFTER_RE = re.compile(r"try again in\s+(\d+(?:\.\d+)?)\s*s", re.IGNORECASE)


class GroqDictationError(RuntimeError):
    def __init__(self, status_code: int, message: str):
        self.status_code = status_code
        self.message = message
        super().__init__(message)


def groq_configured() -> bool:
    return bool(GROQ_API_KEY)


def _retry_after_seconds(detail: str, fallback: float = 3.0) -> float:
    match = _RETRY_AFTER_RE.search(detail or "")
    if not match:
        return fallback
    try:
        return max(0.5, min(15.0, float(match.group(1))))
    except ValueError:
        return fallback


async def transcribe_pcm16(
    pcm16: bytes,
    sample_rate: int = 16_000,
    *,
    retry_rate_limits: bool = False,
) -> str:
    if not GROQ_API_KEY:
        raise GroqDictationError(503, "Speech service is not configured yet.")
    if len(pcm16) < sample_rate * 2 // 10:
        return ""
    wav = pcm16_to_wav_bytes(pcm16, sample_rate=sample_rate)
    headers = {"Authorization": f"Bearer {GROQ_API_KEY}"}
    data = {
        "model": GROQ_ASR_MODEL,
        "response_format": "json",
        "temperature": "0",
    }
    if GROQ_ASR_PROMPT:
        data["prompt"] = GROQ_ASR_PROMPT[:800]
    if GROQ_ASR_LANGUAGE:
        data["language"] = GROQ_ASR_LANGUAGE

    attempts = 4 if retry_rate_limits else 1
    last_error: GroqDictationError | None = None
    async with httpx.AsyncClient(timeout=45.0) as client:
        for attempt in range(attempts):
            try:
                response = await client.post(
                    f"{GROQ_BASE_URL}/audio/transcriptions",
                    headers=headers,
                    files={"file": ("speech.wav", wav, "audio/wav")},
                    data=data,
                )
            except httpx.TimeoutException as exc:
                raise GroqDictationError(504, "Speech provider timed out.") from exc
            except httpx.HTTPError as exc:
                raise GroqDictationError(502, "Could not reach speech provider.") from exc
            if response.status_code < 400:
                payload = response.json()
                return (payload.get("text") or "").strip()
            detail = (response.text or "")[:240]
            logger.warning(
                "groq_asr_failed",
                status=response.status_code,
                model=GROQ_ASR_MODEL,
                detail=detail,
                attempt=attempt + 1,
            )
            last_error = GroqDictationError(
                response.status_code,
                f"Speech provider error ({response.status_code}).",
            )
            if response.status_code == 429 and attempt + 1 < attempts:
                await asyncio.sleep(_retry_after_seconds(detail))
                continue
            raise last_error
    if last_error:
        raise last_error
    return ""


_CASUAL_STYLE_RULES = (
    "Capitalize the start of sentences. "
    "Omit the period at the end of a one-line message. "
    "Do not rewrite words."
)


def _style_block(style_rules: str) -> str:
    rules = (style_rules or "").strip()[:500] or _CASUAL_STYLE_RULES
    return (
        "\n\nSTYLE RULES FOR THIS REQUEST:\n"
        f"{rules}\n"
        "These rules control casing, punctuation, and tone only.\n"
    )


async def draft_style_rules(description: str) -> str:
    """Turn a short voice description into paste-style rules. Not used on the live paste path."""
    if not GROQ_API_KEY or not description.strip():
        raise GroqDictationError(503, "Speech service is not configured yet.")
    body = {
        "model": GROQ_FORMAT_MODEL,
        "temperature": 0.0,
        "max_tokens": 160,
        "reasoning_effort": "low",
        "messages": [
            {
                "role": "system",
                "content": (
                    "Write a short dictation style block for composer paste. "
                    "Return ONLY the rules, four lines or fewer. "
                    "Rules may set casing, punctuation, and energy. "
                    "They must not ask to change the speaker's words. "
                    "Do not write a sample message."
                ),
            },
            {"role": "user", "content": description.strip()[:400]},
        ],
    }
    headers = {
        "Authorization": f"Bearer {GROQ_API_KEY}",
        "Content-Type": "application/json",
    }
    try:
        async with httpx.AsyncClient(timeout=8.0) as client:
            response = await client.post(
                f"{GROQ_BASE_URL}/chat/completions",
                headers=headers,
                json=body,
            )
    except Exception as exc:
        raise GroqDictationError(502, "Could not draft a style.") from exc
    if response.status_code >= 400:
        raise GroqDictationError(response.status_code, "Could not draft a style.")
    text = (
        response.json()
        .get("choices", [{}])[0]
        .get("message", {})
        .get("content", "")
        .strip()
    )
    if not text:
        raise GroqDictationError(502, "Could not draft a style.")
    return text[:500]


async def format_transcript(
    asr_text: str,
    *,
    before_text: str = "",
    style_rules: str = "",
    style_contract: dict | None = None,
) -> str | None:
    """Rewrite the transcript. None means the call failed and the caller should keep raw text. "" means no speech."""
    if not GROQ_API_KEY or not asr_text.strip():
        return None
    if isinstance(style_contract, dict) and style_contract.get("system_directives"):
        # Compiled playbook styles: hydrate prebuilt contract (no second LLM).
        from services.style_compiler import build_live_dictation_system_prompt

        system = build_live_dictation_system_prompt(style_contract)
    else:
        system = _FORMAT_SYSTEM + _style_block(style_rules)
    if GROQ_USER_DICTIONARY:
        terms = ", ".join(
            part.strip() for part in GROQ_USER_DICTIONARY.split(",") if part.strip()
        )
        if terms:
            system += (
                "\n\nUSER DICTIONARY & CONTEXT:\n"
                f"- Terminology: {terms}\n"
                "- Directives: Treat any phonetically similar words as these exact terms.\n"
            )
    context = (before_text or "").strip()[-200:]
    user = asr_text.strip()
    if context:
        user = f"Composer context (do not repeat unless the speaker continues it): {context}\n\n{user}"
    body = {
        "model": GROQ_FORMAT_MODEL,
        "temperature": 0.0,
        "max_tokens": 256,
        "reasoning_effort": "low",
        "stop": ["\nInput Transcript:", "```"],
        "messages": [
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
    }
    headers = {
        "Authorization": f"Bearer {GROQ_API_KEY}",
        "Content-Type": "application/json",
    }
    try:
        async with httpx.AsyncClient(timeout=8.0) as client:
            response = await client.post(
                f"{GROQ_BASE_URL}/chat/completions",
                headers=headers,
                json=body,
            )
    except Exception as exc:
        logger.warning("groq_format_failed", error=str(exc))
        return None
    if response.status_code >= 400:
        logger.warning(
            "groq_format_failed",
            status=response.status_code,
            detail=(response.text or "")[:240],
        )
        return None
    data = response.json()
    text = (
        data.get("choices", [{}])[0]
        .get("message", {})
        .get("content", "")
        .strip()
    )
    return text
