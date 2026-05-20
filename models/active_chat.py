"""
Active Chat per smart hub theme/avatar configuration.
Linked from smart_hubs."activeChat"; column defaults mirror user_profiles (6, 10, 24).
"""

from datetime import datetime

from sqlalchemy import Column, DateTime, ForeignKey, Integer, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from config.database import Base


class ActiveChat(Base):
    __tablename__ = "activeChat"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    appearance_option_id = Column(
        Integer,
        ForeignKey("option_values.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
        default=6,
    )
    itheme_option_id = Column(
        Integer,
        ForeignKey("option_values.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
        default=10,
    )
    avatar_display_option_id = Column(Integer, nullable=True, index=True, default=24)
    profile_icon_id = Column(
        Integer,
        ForeignKey("option_values.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    avatar_color_id = Column(
        Integer,
        ForeignKey("option_values.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    avatar_icon = Column(Text)
    avatar_image = Column(Text)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )

    appearance = relationship("OptionValue", foreign_keys=[appearance_option_id])
    itheme = relationship("OptionValue", foreign_keys=[itheme_option_id])
    profile_icon = relationship("OptionValue", foreign_keys=[profile_icon_id])
    avatar_color = relationship("OptionValue", foreign_keys=[avatar_color_id])
    smart_hubs = relationship(
        "SmartHub",
        foreign_keys="SmartHub.activeChat",
        back_populates="active_chat",
    )

    def __repr__(self):
        return f"<ActiveChat(id={self.id}, user_id={self.user_id})>"

    def to_dict(self):
        appearance_data = None
        if self.appearance:
            appearance_data = {
                "id": self.appearance.id,
                "value_name": self.appearance.value_name,
                "display_name": self.appearance.display_name,
            }
        itheme_data = None
        if self.itheme:
            itheme_data = {
                "id": self.itheme.id,
                "value_name": self.itheme.value_name,
                "display_name": self.itheme.display_name,
            }
        return {
            "id": self.id,
            "user_id": str(self.user_id),
            "appearance_option_id": self.appearance_option_id,
            "appearance": appearance_data,
            "itheme_option_id": self.itheme_option_id,
            "itheme": itheme_data,
            "avatar_display_option_id": self.avatar_display_option_id,
            "profile_icon_id": self.profile_icon_id,
            "avatar_color_id": self.avatar_color_id,
            "avatar_icon": self.avatar_icon,
            "avatar_image": self.avatar_image,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None,
        }
