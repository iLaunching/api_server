"""User dictation style library + catalog download/rating stats."""

from __future__ import annotations

from datetime import datetime
import uuid

from sqlalchemy import (
    BigInteger,
    Column,
    DateTime,
    ForeignKey,
    Integer,
    String,
    Text,
    UniqueConstraint,
)
from sqlalchemy.dialects.postgresql import JSONB, UUID

from config.database import Base


class UserDictationCategory(Base):
    __tablename__ = "user_dictation_categories"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    name = Column(Text, nullable=False)
    type_kind = Column(String, nullable=False, default="personal_casual")
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )


class UserDictationStyle(Base):
    __tablename__ = "user_dictation_styles"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    category_id = Column(
        UUID(as_uuid=True),
        ForeignKey("user_dictation_categories.id", ondelete="SET NULL"),
        nullable=True,
    )
    name = Column(Text, nullable=False)
    explanation = Column(Text, nullable=False, default="")
    rules = Column(Text, nullable=False, default="")
    taxonomy_path = Column(Text, nullable=True)
    compiled_contract = Column(JSONB, nullable=True)
    source_catalog_id = Column(Text, nullable=True)
    catalog_version = Column(Integer, nullable=True)
    parent_style_id = Column(
        UUID(as_uuid=True),
        ForeignKey("user_dictation_styles.id", ondelete="SET NULL"),
        nullable=True,
    )
    bound_room_id = Column(Text, nullable=True)
    kind = Column(String, nullable=False, default="template")
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )


class DictationStyleStats(Base):
    __tablename__ = "dictation_style_stats"

    catalog_style_id = Column(Text, primary_key=True)
    download_count = Column(BigInteger, nullable=False, default=0)
    rating_sum = Column(BigInteger, nullable=False, default=0)
    rating_count = Column(BigInteger, nullable=False, default=0)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )


class DictationStyleRating(Base):
    __tablename__ = "dictation_style_ratings"
    __table_args__ = (
        UniqueConstraint("user_id", "catalog_style_id", name="uq_dictation_style_rating"),
    )

    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
    )
    catalog_style_id = Column(Text, primary_key=True)
    stars = Column(Integer, nullable=False)
    updated_at = Column(
        DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow
    )


class DictationStyleInstall(Base):
    __tablename__ = "dictation_style_installs"

    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
    )
    catalog_style_id = Column(Text, primary_key=True)
    style_id = Column(
        UUID(as_uuid=True),
        ForeignKey("user_dictation_styles.id", ondelete="SET NULL"),
        nullable=True,
    )
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
