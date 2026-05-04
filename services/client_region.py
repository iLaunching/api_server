"""
Infer user region (ISO 3166-1 alpha-2) for onboarding defaults.

Priority (handled by resolve_onboarding_country_hint):
1. Explicit `country` from client (body / query) — most reliable when user chooses.
2. Edge / CDN headers (Cloudflare `CF-IPCountry`, Vercel `X-Vercel-IP-Country`) — good country-level signal when proxied.
3. Browser IANA timezone (e.g. from `Intl.DateTimeFormat().resolvedOptions().timeZone`) — strong hint for UK vs US, not perfect (VPN, border regions).

For legal/billing address, always prefer an explicit country picker; this module optimizes UX for synthetic phone prefixes.
"""

from __future__ import annotations

import ipaddress
import os
from typing import Optional

from fastapi import Request

# Optional dependency: enabled when `maxminddb` is installed + MMDB path configured.
try:
    import maxminddb  # type: ignore
except Exception:  # pragma: no cover
    maxminddb = None

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


def _first_public_ip_from_headers(request: Request) -> Optional[str]:
    """
    Best-effort client IP extraction when behind proxies (Railway, etc).

    We prefer the first *public* IP in X-Forwarded-For. If none, fall back to X-Real-IP,
    then request.client.host.
    """
    # X-Forwarded-For: "client, proxy1, proxy2"
    xff = request.headers.get("X-Forwarded-For")
    if xff:
        for raw in xff.split(","):
            ip = raw.strip()
            if not ip:
                continue
            try:
                addr = ipaddress.ip_address(ip)
            except ValueError:
                continue
            if addr.is_global:
                return ip

    xri = request.headers.get("X-Real-IP")
    if xri:
        ip = xri.strip()
        try:
            addr = ipaddress.ip_address(ip)
            if addr.is_global:
                return ip
        except ValueError:
            pass

    if request.client and request.client.host:
        ip = request.client.host
        try:
            addr = ipaddress.ip_address(ip)
            if addr.is_global:
                return ip
        except ValueError:
            pass

    return None


_MAXMIND_READER = None
_MAXMIND_PATH: Optional[str] = None


def _geoip_country_from_ip(ip: str) -> Optional[str]:
    """
    GeoIP lookup using a local MaxMind MMDB (GeoLite2-Country).

    To enable:
    - Install `maxminddb`
    - Set env `GEOLITE2_COUNTRY_MMDB_PATH` to the .mmdb absolute path in the container
    """
    global _MAXMIND_READER, _MAXMIND_PATH

    if maxminddb is None:
        return None

    mmdb_path = os.getenv("GEOLITE2_COUNTRY_MMDB_PATH", "").strip()
    if not mmdb_path:
        return None

    # (Re)load reader if path changes (e.g. hot reload / different env)
    if _MAXMIND_READER is None or _MAXMIND_PATH != mmdb_path:
        _MAXMIND_PATH = mmdb_path
        _MAXMIND_READER = maxminddb.open_database(mmdb_path)

    try:
        record = _MAXMIND_READER.get(ip)  # type: ignore[union-attr]
    except Exception:
        return None

    if not isinstance(record, dict):
        return None

    # GeoLite2-Country provides both `country` and sometimes `registered_country`
    for key in ("country", "registered_country"):
        node = record.get(key)
        if isinstance(node, dict):
            iso = node.get("iso_code")
            if isinstance(iso, str) and len(iso) == 2 and iso.isalpha():
                return iso.upper()

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

    # Railway-only (no CDN country header): infer from client IP via local GeoLite2 if configured.
    ip = _first_public_ip_from_headers(http_request)
    if ip:
        from_geoip = _geoip_country_from_ip(ip)
        if from_geoip:
            return from_geoip

    if time_zone and str(time_zone).strip():
        iso2 = iso2_from_iana_timezone(time_zone.strip())
        if iso2:
            return iso2

    return None
