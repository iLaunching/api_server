"""
Active Chat per smart hub theme configuration (appearance + itheme).
Avatar/display fields live on user_profiles only. Linked from smart_hubs."activeChat".
"""

from datetime import datetime

from sqlalchemy import Column, DateTime, ForeignKey, Integer
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
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )

    appearance = relationship("OptionValue", foreign_keys=[appearance_option_id])
    itheme = relationship("OptionValue", foreign_keys=[itheme_option_id])
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
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None,
        }
