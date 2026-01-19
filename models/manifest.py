"""
SQLAlchemy model for Manifest (Tier A - Master Manifest)
Stores spatial state and business DNA for each Smart Matrix
"""

import uuid
from datetime import datetime
from typing import Optional, Dict, Any
from sqlalchemy import Column, String, Float, DateTime, Boolean, ForeignKey, func
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import relationship, foreign, remote
from sqlalchemy.future import select
from config.database import Base
import structlog

logger = structlog.get_logger()


class Manifest(Base):
    """
    Tier A: Master Manifest
    
    The global state table that stores the "world view" for each Smart Matrix.
    Each Smart Matrix has exactly ONE manifest (one-to-one relationship).
    
    Hierarchy:
    User → SmartHub → SmartMatrix → Manifest → Contexts → Nodes
    """
    __tablename__ = "tbl_manifest"
    
    # Primary key
    manifest_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    
    # Foreign keys
    smart_matrix_id = Column(
        UUID(as_uuid=True), 
        ForeignKey("smart_matrices.id", ondelete="CASCADE"), 
        nullable=False, 
        unique=True,  # One-to-one relationship
        index=True
    )
    user_id = Column(UUID(as_uuid=True), nullable=False, index=True)
    
    # Spatial state (camera position and zoom)
    current_x = Column(Float, default=0.0, nullable=False)
    current_y = Column(Float, default=0.0, nullable=False)
    zoom_level = Column(Float, default=1.0, nullable=False)
    
    # Business DNA (founder intent, constraints, style)
    business_dna = Column(JSONB, default={})
    
    # Status and timestamps
    last_heartbeat = Column(DateTime(timezone=True), default=func.now())
    is_active = Column(Boolean, default=True, index=True)
    created_at = Column(DateTime(timezone=True), default=func.now(), index=True)
    updated_at = Column(DateTime(timezone=True), default=func.now(), onupdate=func.now())
    
    # Relationships
    # Bidirectional one-to-one for fast access: SmartMatrix ↔ Manifest
    smart_matrix = relationship(
        "SmartMatrix",
        primaryjoin="foreign(Manifest.smart_matrix_id) == remote(SmartMatrix.id)",
        back_populates="manifest"
    )
    
    def __repr__(self):
        return f"<Manifest(manifest_id={self.manifest_id}, smart_matrix_id={self.smart_matrix_id}, position=({self.current_x}, {self.current_y}), zoom={self.zoom_level})>"
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert manifest to dictionary for JSON serialization"""
        return {
            "manifest_id": str(self.manifest_id),
            "smart_matrix_id": str(self.smart_matrix_id),
            "user_id": str(self.user_id),
            "current_x": self.current_x,
            "current_y": self.current_y,
            "zoom_level": self.zoom_level,
            "business_dna": self.business_dna,
            "last_heartbeat": self.last_heartbeat.isoformat() if self.last_heartbeat else None,
            "is_active": self.is_active,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None,
        }
    
    @classmethod
    async def create(cls, db: AsyncSession, smart_matrix_id: uuid.UUID, user_id: uuid.UUID, 
                     business_dna: Optional[Dict[str, Any]] = None, **kwargs) -> "Manifest":
        """
        Create a new manifest for a Smart Matrix.
        
        Args:
            db: Database session
            smart_matrix_id: UUID of the Smart Matrix
            user_id: UUID of the user
            business_dna: Optional business DNA (intent, constraints, style)
            **kwargs: Additional fields (current_x, current_y, zoom_level, etc.)
        
        Returns:
            Created Manifest instance
        """
        manifest = cls(
            smart_matrix_id=smart_matrix_id,
            user_id=user_id,
            business_dna=business_dna or {},
            **kwargs
        )
        db.add(manifest)
        await db.commit()
        await db.refresh(manifest)
        logger.info(
            "Manifest created",
            manifest_id=str(manifest.manifest_id),
            smart_matrix_id=str(smart_matrix_id),
            user_id=str(user_id)
        )
        return manifest
    
    @classmethod
    async def get_by_id(cls, db: AsyncSession, manifest_id: uuid.UUID) -> Optional["Manifest"]:
        """Get manifest by ID"""
        stmt = select(cls).where(cls.manifest_id == manifest_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    @classmethod
    async def get_by_smart_matrix_id(cls, db: AsyncSession, smart_matrix_id: uuid.UUID) -> Optional["Manifest"]:
        """
        Get manifest by Smart Matrix ID (one-to-one relationship).
        
        Args:
            db: Database session
            smart_matrix_id: UUID of the Smart Matrix
        
        Returns:
            Manifest instance or None if not found
        """
        stmt = select(cls).where(cls.smart_matrix_id == smart_matrix_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    async def update_position(self, db: AsyncSession, current_x: float, current_y: float, 
                             zoom_level: Optional[float] = None):
        """
        Update camera position and zoom level.
        
        Args:
            db: Database session
            current_x: New X coordinate
            current_y: New Y coordinate
            zoom_level: Optional new zoom level
        """
        self.current_x = current_x
        self.current_y = current_y
        if zoom_level is not None:
            self.zoom_level = zoom_level
        self.last_heartbeat = func.now()
        
        await db.commit()
        await db.refresh(self)
        logger.info(
            "Manifest position updated",
            manifest_id=str(self.manifest_id),
            position=(current_x, current_y),
            zoom=zoom_level
        )
    
    async def update_business_dna(self, db: AsyncSession, business_dna: Dict[str, Any]):
        """
        Update business DNA (founder intent, constraints, style).
        
        Args:
            db: Database session
            business_dna: New business DNA dictionary
        """
        self.business_dna = business_dna
        self.last_heartbeat = func.now()
        
        await db.commit()
        await db.refresh(self)
        logger.info(
            "Manifest business DNA updated",
            manifest_id=str(self.manifest_id),
            dna_keys=list(business_dna.keys())
        )
    
    async def heartbeat(self, db: AsyncSession):
        """Update last_heartbeat timestamp"""
        self.last_heartbeat = func.now()
        await db.commit()
        await db.refresh(self)
