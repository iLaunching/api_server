"""
Synaptic expressive experience for an Active Chat.

Single-row store for the hub's applied experience: wallpaper, appearance_config, and theme_config.
"""

from datetime import datetime

from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import relationship
from sqlalchemy.sql.sqltypes import Float

from config.database import Base


class SynapticExpressiveExperience(Base):
    __tablename__ = "synapticExpressiveExperience"

    id = Column(Integer, primary_key=True, autoincrement=True)

    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    active_chat_id = Column(
        Integer,
        ForeignKey('activeChat.id', ondelete="CASCADE"),
        nullable=False,
        unique=True,
        index=True,
    )

    background_kind = Column(String, nullable=False, default="none")

    solid_hex = Column(Text, nullable=True)

    wallpaper_color_palette_id = Column(Text, nullable=True)
    background_config = Column(JSONB, nullable=True)

    pattern_category_slug = Column(Text, nullable=True)
    pattern_id = Column(Text, nullable=True)
    pattern_delivery_url = Column(Text, nullable=True)
    pattern_opacity = Column(Float, nullable=False, default=1.0)
    pattern_overlay_gradient = Column(JSONB, nullable=True)

    media_photo_id = Column(Text, nullable=True)
    user_photo_id = Column(UUID(as_uuid=True), nullable=True)

    pan_x = Column(Float, nullable=False, default=0.0)
    pan_y = Column(Float, nullable=False, default=0.0)
    dim_opacity = Column(Float, nullable=False, default=0.0)

    appearance_config = Column(JSONB, nullable=True)
    theme_config = Column(JSONB, nullable=True)

    appearance_palette_id = Column(Text, nullable=True)
    theme_palette_id = Column(Text, nullable=True)

    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )

    active_chat = relationship("ActiveChat", foreign_keys=[active_chat_id], uselist=False)

    def __repr__(self):
        return f"<SynapticExpressiveExperience(id={self.id}, active_chat_id={self.active_chat_id})>"
