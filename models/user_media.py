"""User-owned media masters (R2 user bucket)."""

from datetime import datetime
import uuid

from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.dialects.postgresql import UUID

from config.database import Base


class UserMedia(Base):
    __tablename__ = "user_media"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    kind = Column(String, nullable=False, default="wallpaper")
    object_path = Column(Text, nullable=False, unique=True)
    content_type = Column(String, nullable=False, default="image/webp")
    byte_size = Column(Integer, nullable=False, default=0)
    width = Column(Integer, nullable=True)
    height = Column(Integer, nullable=True)
    title = Column(Text, nullable=True)
    source_kind = Column(String, nullable=False, default="upload")
    source_catalog_photo_id = Column(Text, nullable=True)
    source_collection_slug = Column(Text, nullable=True)
    last_used_at = Column(DateTime(timezone=True), nullable=True)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )
