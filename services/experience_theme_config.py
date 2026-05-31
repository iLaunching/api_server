"""Build effective appearance / theme JSON blobs for synapticExpressiveExperience."""

from __future__ import annotations

from typing import Any

from models.database_models import ThemeConfig

DEFAULT_FONT_FAMILY_ID = "work-sans"


def ensure_appearance_typography(appearance_config: dict[str, Any]) -> dict[str, Any]:
    """Ensure appearance_config.typography.family_id is set (default Work Sans)."""
    config = dict(appearance_config or {})
    typo = config.get("typography")
    if not isinstance(typo, dict):
        typo = {}
    else:
        typo = dict(typo)
    family_id = typo.get("family_id")
    if not isinstance(family_id, str) or not family_id.strip():
        typo["family_id"] = DEFAULT_FONT_FAMILY_ID
    else:
        typo["family_id"] = family_id.strip()
    config["typography"] = typo
    return config


def theme_config_to_appearance_config(
    theme_config: ThemeConfig,
    *,
    source_option_value_id: int | None = None,
) -> dict[str, Any]:
    """Map a theme_configs row (appearance option) to appearance_config JSON."""
    payload: dict[str, Any] = {
        "name": theme_config.name,
        "text_color": theme_config.text_color,
        "background_color": theme_config.background_color,
        "menu_color": theme_config.menu_color,
        "border_line_color": theme_config.border_line_color,
        "header_overlay_color": theme_config.header_overlay_color,
        "user_button_color": theme_config.user_button_color,
        "user_button_hover": theme_config.user_button_hover,
        "user_button_icon": theme_config.user_button_icon,
        "title_menu_color_light": theme_config.title_menu_color_light,
        "border_line_color_light": theme_config.border_line_color_light,
        "global_button_hover": theme_config.global_button_hover,
        "chat_bk_1": theme_config.chat_bk_1,
        "prompt_bk": theme_config.prompt_bk,
        "prompt_text_color": theme_config.prompt_text_color,
        "ai_acknowledge_text_color": theme_config.ai_acknowledge_text_color,
        "danger_button_solid_color": theme_config.danger_button_solid_color,
        "danger_button_hover": theme_config.danger_button_hover,
        "danger_tone_bk": theme_config.danger_tone_bk,
        "danger_tone_border": theme_config.danger_tone_border,
        "danger_tone_text": theme_config.danger_tone_text,
        "danger_bk_light_color": theme_config.danger_bk_light_color,
        "danger_bk_solid_color": theme_config.danger_bk_solid_color,
        "danger_bk_solid_text_color": theme_config.danger_bk_solid_text_color,
        "line_grid_color": theme_config.line_grid_color,
        "dotted_grid_color": theme_config.dotted_grid_color,
    }
    if source_option_value_id is not None:
        payload["source_option_value_id"] = source_option_value_id

    metadata = theme_config.theme_metadata or {}
    if isinstance(metadata, dict):
        for key, value in metadata.items():
            if value is not None:
                payload[key] = value

    return ensure_appearance_typography(
        {k: v for k, v in payload.items() if v is not None and v != ""}
    )


def palette_catalog_entry_to_experience_patch(entry: dict[str, Any]) -> dict[str, Any]:
    """Extract apply payload fields from an asset_server catalog palette entry."""
    kind = entry.get("kind")
    if kind == "appearance":
        return {
            "appearance_palette_id": entry.get("id"),
            "appearance_config": ensure_appearance_typography(
                entry.get("appearance_config") or {}
            ),
        }
    if kind == "theme":
        return {
            "theme_palette_id": entry.get("id"),
            "theme_config": entry.get("theme_config") or {},
        }
    return {}


def combined_experience_patch(
    appearance_entry: dict[str, Any] | None = None,
    theme_entry: dict[str, Any] | None = None,
) -> dict[str, Any]:
    """Merge appearance + theme catalog entries for a full experience apply."""
    patch: dict[str, Any] = {}
    if appearance_entry:
        patch.update(palette_catalog_entry_to_experience_patch(appearance_entry))
    if theme_entry:
        patch.update(palette_catalog_entry_to_experience_patch(theme_entry))
    return patch


_APPEARANCE_CONFIG_TO_THEME: dict[str, str | tuple[str, ...]] = {
    "background_color": "background",
    "text_color": ("text", "appearance_text_color"),
    "menu_color": "menu",
    "border_line_color": "border",
    "header_overlay_color": "header_overlay",
    "user_button_color": "user_button_color",
    "user_button_hover": "user_button_hover",
    "user_button_icon": "user_button_icon",
    "title_menu_color_light": "title_menu_color_light",
    "border_line_color_light": "border_line_color_light",
    "global_button_hover": "global_button_hover",
    "chat_bk_1": "chat_bk_1",
    "prompt_bk": "prompt_bk",
    "prompt_text_color": "prompt_text_color",
    "ai_acknowledge_text_color": "ai_acknowledge_text_color",
    "danger_button_solid_color": "danger_button_solid_color",
    "danger_button_hover": "danger_button_hover",
    "danger_tone_bk": "danger_tone_bk",
    "danger_tone_border": "danger_tone_border",
    "danger_tone_text": "danger_tone_text",
    "danger_bk_light_color": "danger_bk_light_color",
    "danger_bk_solid_color": "danger_bk_solid_color",
    "danger_bk_solid_text_color": "danger_bk_solid_text_color",
    "line_grid_color": "line_grid_color",
    "dotted_grid_color": "dotted_grid_color",
}

_THEME_CONFIG_TO_THEME: dict[str, str | tuple[str, ...]] = {
    "solid_color": ("solid_color", "header_background"),
    "bg_opacity": "bg_opacity",
    "menu_bg_opacity": "menu_bg_opacity",
    "toneButton_bk_color": "tone_button_bk_color",
    "toneButton_text_color": "tone_button_text_color",
    "toneButton_border_color": "tone_button_border_color",
    "button_bk_color": "button_bk_color",
    "button_text_color": "button_text_color",
    "button_hover_color": "button_hover_color",
}


def _apply_config_map(
    theme_data: dict[str, Any],
    config: dict[str, Any],
    key_map: dict[str, str | tuple[str, ...]],
) -> dict[str, Any]:
    merged = dict(theme_data)
    for source_key, target in key_map.items():
        value = config.get(source_key)
        if value is None or value == "":
            continue
        targets = (target,) if isinstance(target, str) else target
        for theme_key in targets:
            merged[theme_key] = value
    return merged


def apply_experience_config_to_theme_data(
    theme_data: dict[str, Any] | None,
    *,
    appearance_config: dict[str, Any] | None = None,
    theme_config: dict[str, Any] | None = None,
) -> dict[str, Any] | None:
    """
    Overlay synapticExpressiveExperience.appearance_config / theme_config onto hub theme JSON.
    Experience columns win over legacy activeChat option_values when present.
    """
    base: dict[str, Any] = dict(theme_data or {})
    if appearance_config:
        normalized = ensure_appearance_typography(appearance_config)
        base = _apply_config_map(base, normalized, _APPEARANCE_CONFIG_TO_THEME)
        feedback = normalized.get("feedback_indicator_bk")
        if isinstance(feedback, str) and feedback.strip():
            base["feedback_indicator_bk"] = feedback.strip()
    if theme_config and isinstance(theme_config, dict):
        base = _apply_config_map(base, theme_config, _THEME_CONFIG_TO_THEME)
    return base or None


def theme_option_to_experience_theme_config(
    theme_config: ThemeConfig,
    *,
    source_option_value_id: int | None = None,
) -> dict[str, Any]:
    """Map a theme_configs row (theme/accent option) to theme_config JSON on the experience row."""
    payload: dict[str, Any] = {"name": theme_config.name}
    if source_option_value_id is not None:
        payload["source_option_value_id"] = source_option_value_id

    metadata = theme_config.theme_metadata or {}
    if isinstance(metadata, dict):
        payload.update(metadata)

    return {k: v for k, v in payload.items() if v is not None and v != ""}
