"""
User Navigation Model - Tracks current Smart Hub and navigation state
"""

import uuid
from datetime import datetime
from typing import Optional
from sqlalchemy import Column, ForeignKey, DateTime
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
import structlog

from config.database import Base

logger = structlog.get_logger()


class UserNavigation(Base):
    """User Navigation - Tracks current active Smart Hub and navigation memory"""
    __tablename__ = "user_navigation"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, unique=True, index=True)
    current_smart_hub_id = Column(UUID(as_uuid=True), ForeignKey("smart_hubs.id", ondelete="SET NULL"), nullable=True, index=True)
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow, index=True)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    smart_hub = relationship("SmartHub", foreign_keys=[current_smart_hub_id])
    
    def __repr__(self):
        return f"<UserNavigation(id={self.id}, user_id={self.user_id}, current_smart_hub_id={self.current_smart_hub_id})>"
    
    def to_dict(self):
        """Convert user navigation to dictionary"""
        return {
            "id": str(self.id),
            "user_id": str(self.user_id),
            "current_smart_hub_id": str(self.current_smart_hub_id) if self.current_smart_hub_id else None,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None,
        }
    
    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "UserNavigation":
        """Create a new user navigation record."""
        navigation = cls(**kwargs)
        db.add(navigation)
        await db.commit()
        await db.refresh(navigation)
        logger.info("User navigation created", navigation_id=str(navigation.id), user_id=str(navigation.user_id))
        return navigation
    
    @classmethod
    async def get_by_user_id(cls, db: AsyncSession, user_id: uuid.UUID) -> Optional["UserNavigation"]:
        """Get navigation record for a user."""
        stmt = select(cls).where(cls.user_id == user_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    @classmethod
    async def get_or_create(cls, db: AsyncSession, user_id: uuid.UUID) -> "UserNavigation":
        """Get existing navigation record or create new one."""
        navigation = await cls.get_by_user_id(db, user_id)
        if not navigation:
            navigation = await cls.create(db=db, user_id=user_id)
        return navigation
    
    async def update_current_hub(self, db: AsyncSession, smart_hub_id: uuid.UUID):
        """Update the current Smart Hub for this user."""
        self.current_smart_hub_id = smart_hub_id
        await db.commit()
        await db.refresh(self)
        logger.info("Current Smart Hub updated", 
                   user_id=str(self.user_id), 
                   smart_hub_id=str(smart_hub_id))
