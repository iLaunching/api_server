"""
User Navigation Model - Tracks current Smart Hub and navigation state
"""

import uuid
from datetime import datetime
from typing import Optional, Dict, Any
from sqlalchemy import Column, ForeignKey, DateTime, JSON
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
import structlog

from config.database import Base

logger = structlog.get_logger()


class UserNavigation(Base):
    """
    User Navigation - Tracks current contexts and navigation state.
    
    Future-proof design that can track:
    - current_smart_hub_id: Active Smart Hub
    - navigation_state: JSONB for additional contexts (projects, workspaces, views, filters, etc.)
    
    One-to-one relationship with users (via user_profile).
    """
    __tablename__ = "user_navigation"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, unique=True, index=True)
    
    # Navigation contexts
    current_smart_hub_id = Column(UUID(as_uuid=True), ForeignKey("smart_hubs.id", ondelete="SET NULL"), nullable=True, index=True)
    navigation_state = Column(JSON, default=dict, nullable=False)  # Flexible JSONB for future contexts
    
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
            "navigation_state": self.navigation_state or {},
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None,
        }
    
    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "UserNavigation":
        """Create a new user navigation record."""
        # Ensure navigation_state has default value if not provided
        if "navigation_state" not in kwargs:
            kwargs["navigation_state"] = {}
        
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
    
    async def update_navigation_state(self, db: AsyncSession, state_updates: Dict[str, Any]):
        """
        Update navigation_state JSONB field with new contexts.
        
        Examples:
        - await navigation.update_navigation_state(db, {"current_view": "dashboard"})
        - await navigation.update_navigation_state(db, {"current_project_id": str(project_uuid)})
        - await navigation.update_navigation_state(db, {"filters": {"status": "active"}})
        """
        if self.navigation_state is None:
            self.navigation_state = {}
        
        # Merge updates into existing state
        self.navigation_state = {**self.navigation_state, **state_updates}
        await db.commit()
        await db.refresh(self)
        logger.info("Navigation state updated", 
                   user_id=str(self.user_id), 
                   state_keys=list(state_updates.keys()))
    
    def get_navigation_context(self, key: str, default: Any = None) -> Any:
        """Get a specific value from navigation_state"""
        if not self.navigation_state:
            return default
        return self.navigation_state.get(key, default)
    
    async def clear_context(self, db: AsyncSession, key: str):
        """Remove a specific context from navigation_state"""
        if self.navigation_state and key in self.navigation_state:
            del self.navigation_state[key]
            await db.commit()
            await db.refresh(self)
            logger.info("Navigation context cleared", 
                       user_id=str(self.user_id), 
                       context_key=key)
