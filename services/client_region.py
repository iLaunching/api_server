"""
Infer user region (ISO 3166-1 alpha-2) for onboarding defaults.

Priority (handled by resolve_onboarding_country_hint):
1. Explicit `country` from client (body / query) — most reliable when user chooses.
2. Edge / CDN headers (Cloudflare `CF-IPCountry`, Vercel `X-Vercel-IP-Country`) — good country-level signal when proxied.
3. Browser IANA timezone (e.g. from `Intl.DateTimeFormat().resolvedOptions().timeZone`) — strong hint for UK vs US, not perfect (VPN, border regions).

For legal/billing address, always prefer an explicit country picker; this module optimizes UX for synthetic phone prefixes.
"""

from __future__ import annotations

from typing import Optional

from fastapi import Request

# IANA tz database id → ISO2 (primary country for that zone). Curated; unknown → None.
_IANA_TZ_TO_ISO2: dict[str, str] = {
    "Europe/London": "GB",
    "Europe/Jersey": "GB",
    "Europe/Guernsey": "GB",
    "Europe/Isle_of_Man": "GB",
    "Europe/Dublin": "IE",
    "Europe/Paris": "FR",
    "Europe/Berlin": "DE",
    "Europe/Amsterdam": "NL",
    "Europe/Brussels": "BE",
    "Europe/Zurich": "CH",
    "Europe/Vienna": "AT",
    "Europe/Rome": "IT",
    "Europe/Madrid": "ES",
    "Europe/Lisbon": "PT",
    "Atlantic/Azores": "PT",
    "Atlantic/Madeira": "PT",
    "Europe/Stockholm": "SE",
    "Europe/Oslo": "NO",
    "Europe/Copenhagen": "DK",
    "Europe/Helsinki": "FI",
    "Europe/Warsaw": "PL",
    "Europe/Prague": "CZ",
    "Europe/Budapest": "HU",
    "Europe/Bucharest": "RO",
    "Europe/Sofia": "BG",
    "Europe/Athens": "GR",
    "Europe/Istanbul": "TR",
    "Europe/Kiev": "UA",
    "Europe/Riga": "LV",
    "Europe/Tallinn": "EE",
    "Europe/Vilnius": "LT",
    "Europe/Luxembourg": "LU",
    "Europe/Monaco": "MC",
    "Europe/Malta": "MT",
    "Europe/Cyprus": "CY",
    "Europe/Zagreb": "HR",
    "Europe/Belgrade": "RS",
    "Europe/Skopje": "MK",
    "Europe/Ljubljana": "SI",
    "Europe/Bratislava": "SK",
    "Europe/Sarajevo": "BA",
    "Europe/Podgorica": "ME",
    "Europe/Tirane": "AL",
    "Europe/Chisinau": "MD",
    "Europe/Minsk": "BY",
    "Europe/Moscow": "RU",
    "Europe/Simferopol": "UA",
    "Europe/Volgograd": "RU",
    "Europe/Kaliningrad": "RU",
    "America/New_York": "US",
    "America/Detroit": "US",
    "America/Kentucky/Louisville": "US",
    "America/Kentucky/Monticello": "US",
    "America/Indiana/Indianapolis": "US",
    "America/Indiana/Vincennes": "US",
    "America/Indiana/Winamac": "US",
    "America/Indiana/Marengo": "US",
    "America/Indiana/Petersburg": "US",
    "America/Indiana/Vevay": "US",
    "America/Chicago": "US",
    "America/Menominee": "US",
    "America/North_Dakota/Center": "US",
    "America/North_Dakota/New_Salem": "US",
    "America/North_Dakota/Beulah": "US",
    "America/Denver": "US",
    "America/Boise": "US",
    "America/Phoenix": "US",
    "America/Los_Angeles": "US",
    "America/Anchorage": "US",
    "America/Juneau": "US",
    "America/Sitka": "US",
    "America/Yakutat": "US",
    "America/Nome": "US",
    "America/Adak": "US",
    "America/Honolulu": "US",
    "America/Toronto": "CA",
    "America/Vancouver": "CA",
    "America/Winnipeg": "CA",
    "America/Edmonton": "CA",
    "America/Regina": "CA",
    "America/Halifax": "CA",
    "America/St_Johns": "CA",
    "America/Montreal": "CA",
    "America/Whitehorse": "CA",
    "America/Dawson": "CA",
    "America/Inuvik": "CA",
    "America/Iqaluit": "CA",
    "America/Rankin_Inlet": "CA",
    "America/Resolute": "CA",
    "America/Cancun": "MX",
    "America/Mexico_City": "MX",
    "America/Sao_Paulo": "BR",
    "America/Buenos_Aires": "AR",
    "America/Santiago": "CL",
    "America/Bogota": "CO",
    "America/Lima": "PE",
    "Australia/Sydney": "AU",
    "Australia/Melbourne": "AU",
    "Australia/Brisbane": "AU",
    "Australia/Perth": "AU",
    "Australia/Adelaide": "AU",
    "Australia/Darwin": "AU",
    "Australia/Hobart": "AU",
    "Pacific/Auckland": "NZ",
    "Asia/Singapore": "SG",
    "Asia/Tokyo": "JP",
    "Asia/Seoul": "KR",
    "Asia/Shanghai": "CN",
    "Asia/Hong_Kong": "HK",
    "Asia/Taipei": "TW",
    "Asia/Kolkata": "IN",
    "Asia/Dubai": "AE",
    "Asia/Riyadh": "SA",
    "Asia/Tel_Aviv": "IL",
    "Africa/Johannesburg": "ZA",
    "Asia/Bangkok": "TH",
    "Asia/Jakarta": "ID",
    "Asia/Manila": "PH",
    "Asia/Kuala_Lumpur": "MY",
    "Asia/Ho_Chi_Minh": "VN",
    "Europe/Gibraltar": "GI",
    "Atlantic/Reykjavik": "IS",
    "Europe/Reykjavik": "IS",
}


def iso2_from_iana_timezone(iana_tz: str) -> Optional[str]:
    """Map a single IANA zone id to a primary ISO2 country, or None."""
    if not iana_tz or not str(iana_tz).strip():
        return None
    key = str(iana_tz).strip()
    return _IANA_TZ_TO_ISO2.get(key)


def infer_country_iso2_from_request(request: Request) -> Optional[str]:
    """
    Read country from reverse-proxy headers (ISO2), if present and plausible.

    Cloudflare: https://developers.cloudflare.com/fundamentals/reference/http-request-headers/#cf-ipcountry
    Vercel: X-Vercel-IP-Country
    """
    for header_name in ("CF-IPCountry", "X-Vercel-IP-Country"):
        raw = request.headers.get(header_name)
        if not raw:
            continue
        c = raw.strip().upper()
        # CF: XX unknown, T1 Tor
        if len(c) == 2 and c.isalpha() and c not in ("XX", "T1"):
            return c
    return None


def resolve_onboarding_country_hint(
    *,
    explicit: Optional[str],
    time_zone: Optional[str],
    http_request: Request,
) -> Optional[str]:
    """
    Single string for downstream normalize_country_to_iso2 / storage, or None.

    None means: fall back to existing profile.country_code or default region in synthetic_phone.
    """
    if explicit and str(explicit).strip():
        return str(explicit).strip()

    from_edge = infer_country_iso2_from_request(http_request)
    if from_edge:
        return from_edge

    if time_zone and str(time_zone).strip():
        iso2 = iso2_from_iana_timezone(time_zone.strip())
        if iso2:
            return iso2

    return None
