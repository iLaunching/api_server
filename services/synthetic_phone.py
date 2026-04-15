"""
Synthetic onboarding phone numbers: region-based dial prefix + random 10-digit suffix.
Stored on user_profiles.phone; region ISO2 on user_profiles.country_code.
"""

from __future__ import annotations

import secrets
from typing import Optional

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from models.user import UserProfile

# ISO 3166-1 alpha-2 -> E.164 country calling code (string after +)
_DIAL_BY_ISO2: dict[str, str] = {
    "US": "1",
    "CA": "1",
    "GB": "44",
    "IE": "353",
    "AU": "61",
    "NZ": "64",
    "DE": "49",
    "FR": "33",
    "ES": "34",
    "IT": "39",
    "NL": "31",
    "BE": "32",
    "CH": "41",
    "AT": "43",
    "SE": "46",
    "NO": "47",
    "DK": "45",
    "FI": "358",
    "PL": "48",
    "PT": "351",
    "GR": "30",
    "IN": "91",
    "JP": "81",
    "KR": "82",
    "CN": "86",
    "SG": "65",
    "HK": "852",
    "TW": "886",
    "MY": "60",
    "TH": "66",
    "PH": "63",
    "ID": "62",
    "VN": "84",
    "AE": "971",
    "SA": "966",
    "IL": "972",
    "ZA": "27",
    "BR": "55",
    "MX": "52",
    "AR": "54",
    "CL": "56",
    "CO": "57",
}

# Common names / typos -> ISO2
_ALIASES_TO_ISO2: dict[str, str] = {
    "UK": "GB",
    "GREATBRITAIN": "GB",
    "UNITEDKINGDOM": "GB",
    "ENGLAND": "GB",
    "SCOTLAND": "GB",
    "WALES": "GB",
    "USA": "US",
    "UNITEDSTATES": "US",
    "UNITEDSTATESOFAMERICA": "US",
}


def _compact(s: str) -> str:
    return "".join(s.split()).upper()


def normalize_country_to_iso2(country: Optional[str]) -> str:
    """Resolve user-facing region (e.g. 'UK', 'GB', 'United Kingdom') to ISO2; default US."""
    if not country or not str(country).strip():
        return "US"
    c = _compact(str(country))
    if c in _ALIASES_TO_ISO2:
        return _ALIASES_TO_ISO2[c]
    if len(c) == 2 and c.isalpha():
        return c
    return "US"


def dial_prefix_for_iso2(iso2: str) -> str:
    digits = _DIAL_BY_ISO2.get(iso2.upper(), "1")
    return f"+{digits}"


def _random_ten_digit_suffix() -> str:
    return str(secrets.randbelow(10**10)).zfill(10)


async def _phone_exists(db: AsyncSession, phone: str) -> bool:
    q = await db.execute(
        select(func.count()).select_from(UserProfile).where(UserProfile.phone == phone)
    )
    return (q.scalar() or 0) > 0


async def ensure_synthetic_onboarding_phone(
    db: AsyncSession,
    profile: UserProfile,
    country_hint: Optional[str] = None,
    *,
    max_attempts: int = 25,
) -> Optional[str]:
    """
    If profile.phone is empty, assign +<country><10 random digits>, set country_code (ISO2).
    Returns the new phone string, or None if phone was already set (idempotent).
    """
    if profile.phone and str(profile.phone).strip():
        return None

    raw_hint = country_hint if (country_hint and str(country_hint).strip()) else profile.country_code
    iso2 = normalize_country_to_iso2(raw_hint)
    prefix = dial_prefix_for_iso2(iso2)

    for _ in range(max_attempts):
        candidate = f"{prefix}{_random_ten_digit_suffix()}"
        if len(candidate) > 20:
            raise RuntimeError(f"Synthetic phone exceeds VARCHAR(20): prefix={prefix!r}")
        if await _phone_exists(db, candidate):
            continue
        profile.phone = candidate
        profile.country_code = iso2
        return candidate

    raise RuntimeError(
        f"Could not allocate unique synthetic phone after {max_attempts} attempts "
        f"(profile_id={profile.id})"
    )
