"""
SQLAlchemy database models for the Business AI Advisor.
"""

import uuid
from datetime import datetime
from typing import Optional, List, Dict, Any
from sqlalchemy import (
    Column, String, Integer, DateTime, Text, 
    ForeignKey, DECIMAL, ARRAY, Boolean, func
)
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import relationship, selectinload
from sqlalchemy.future import select
from config.database import Base
import structlog

logger = structlog.get_logger()

class AnalysisJob(Base):
    __tablename__ = "analysis_jobs"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    company_name = Column(String(255), nullable=False)
    industry = Column(String(100))
    analysis_type = Column(String(50), nullable=False)
    status = Column(String(20), default="queued")
    created_at = Column(DateTime(timezone=True), default=func.now())
    updated_at = Column(DateTime(timezone=True), default=func.now(), onupdate=func.now())
    completed_at = Column(DateTime(timezone=True))
    user_session = Column(String(255))
    job_metadata = Column(JSONB, default={})
    progress = Column(Integer, default=0)
    error_message = Column(Text)
    
    # Relationships
    results = relationship("AnalysisResult", back_populates="job", cascade="all, delete-orphan")
    llm_usage = relationship("LLMUsage", back_populates="job", cascade="all, delete-orphan")
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization."""
        return {
            "id": str(self.id),
            "company_name": self.company_name,
            "industry": self.industry,
            "analysis_type": self.analysis_type,
            "status": self.status,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None,
            "completed_at": self.completed_at.isoformat() if self.completed_at else None,
            "user_session": self.user_session,
            "metadata": self.job_metadata,
            "progress": self.progress,
            "error_message": self.error_message
        }

    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "AnalysisJob":
        """Create a new analysis job."""
        job = cls(**kwargs)
        db.add(job)
        await db.commit()
        await db.refresh(job)
        logger.info("Analysis job created", job_id=str(job.id), company=job.company_name)
        return job
    
    @classmethod
    async def get_by_id(cls, db: AsyncSession, job_id: uuid.UUID) -> Optional["AnalysisJob"]:
        """Get job by ID with results."""
        stmt = select(cls).options(selectinload(cls.results)).where(cls.id == job_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    async def update_status(self, db: AsyncSession, status: str, progress: int = None, error_message: str = None):
        """Update job status and progress."""
        self.status = status
        if progress is not None:
            self.progress = progress
        if error_message is not None:
            self.error_message = error_message
        if status == "completed":
            self.completed_at = func.now()
        
        await db.commit()
        await db.refresh(self)
        logger.info("Job status updated", job_id=str(self.id), status=status, progress=progress)

class AnalysisResult(Base):
    __tablename__ = "analysis_results"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    job_id = Column(UUID(as_uuid=True), ForeignKey("analysis_jobs.id", ondelete="CASCADE"), nullable=False)
    worker_type = Column(String(50), nullable=False)
    result_data = Column(JSONB, nullable=False)
    confidence_score = Column(DECIMAL(3, 2))
    created_at = Column(DateTime(timezone=True), default=func.now())
    processing_time_ms = Column(Integer)
    data_sources = Column(ARRAY(String))
    
    # Relationships
    job = relationship("AnalysisJob", back_populates="results")
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization."""
        return {
            "id": str(self.id),
            "job_id": str(self.job_id),
            "worker_type": self.worker_type,
            "result_data": self.result_data,
            "confidence_score": float(self.confidence_score) if self.confidence_score else None,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "processing_time_ms": self.processing_time_ms,
            "data_sources": self.data_sources
        }

    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "AnalysisResult":
        """Create a new analysis result."""
        result = cls(**kwargs)
        db.add(result)
        await db.commit()
        await db.refresh(result)
        logger.info("Analysis result created", result_id=str(result.id), worker_type=result.worker_type)
        return result

class DataCache(Base):
    __tablename__ = "data_cache"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    cache_key = Column(String(255), unique=True, nullable=False)
    data_source = Column(String(50), nullable=False)
    cached_data = Column(JSONB, nullable=False)
    expires_at = Column(DateTime(timezone=True), nullable=False)
    created_at = Column(DateTime(timezone=True), default=func.now())
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization."""
        return {
            "id": str(self.id),
            "cache_key": self.cache_key,
            "data_source": self.data_source,
            "cached_data": self.cached_data,
            "expires_at": self.expires_at.isoformat() if self.expires_at else None,
            "created_at": self.created_at.isoformat() if self.created_at else None
        }

    @classmethod
    async def get_by_key(cls, db: AsyncSession, cache_key: str) -> Optional["DataCache"]:
        """Get cached data by key if not expired."""
        stmt = select(cls).where(
            cls.cache_key == cache_key,
            cls.expires_at > func.now()
        )
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    @classmethod
    async def set_cache(cls, db: AsyncSession, cache_key: str, data_source: str, 
                       cached_data: Dict[str, Any], expires_at: datetime) -> "DataCache":
        """Set cached data."""
        # Delete existing cache entry
        await db.execute(select(cls).where(cls.cache_key == cache_key))
        
        cache_entry = cls(
            cache_key=cache_key,
            data_source=data_source,
            cached_data=cached_data,
            expires_at=expires_at
        )
        db.add(cache_entry)
        await db.commit()
        await db.refresh(cache_entry)
        return cache_entry

class LLMUsage(Base):
    __tablename__ = "llm_usage"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    job_id = Column(UUID(as_uuid=True), ForeignKey("analysis_jobs.id"), nullable=True)
    model_name = Column(String(100), nullable=False)
    provider = Column(String(50), nullable=False)
    prompt_tokens = Column(Integer)
    completion_tokens = Column(Integer)
    total_tokens = Column(Integer)
    cost_usd = Column(DECIMAL(10, 6))
    latency_ms = Column(Integer)
    created_at = Column(DateTime(timezone=True), default=func.now())
    
    # Relationships
    job = relationship("AnalysisJob", back_populates="llm_usage")
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization."""
        return {
            "id": str(self.id),
            "job_id": str(self.job_id) if self.job_id else None,
            "model_name": self.model_name,
            "provider": self.provider,
            "prompt_tokens": self.prompt_tokens,
            "completion_tokens": self.completion_tokens,
            "total_tokens": self.total_tokens,
            "cost_usd": float(self.cost_usd) if self.cost_usd else None,
            "latency_ms": self.latency_ms,
            "created_at": self.created_at.isoformat() if self.created_at else None
        }

    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "LLMUsage":
        """Create a new LLM usage record."""
        usage = cls(**kwargs)
        db.add(usage)
        await db.commit()
        await db.refresh(usage)
        logger.info("LLM usage recorded", usage_id=str(usage.id), model=usage.model_name)
        return usage

class WorkerHealth(Base):
    __tablename__ = "worker_health"
    
    worker_id = Column(String(100), primary_key=True)
    worker_type = Column(String(50), nullable=False)
    status = Column(String(20), nullable=False)
    last_heartbeat = Column(DateTime(timezone=True), default=func.now())
    tasks_completed = Column(Integer, default=0)
    tasks_failed = Column(Integer, default=0)
    avg_processing_time_ms = Column(Integer)
    worker_metadata = Column(JSONB, default={})
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization."""
        return {
            "worker_id": self.worker_id,
            "worker_type": self.worker_type,
            "status": self.status,
            "last_heartbeat": self.last_heartbeat.isoformat() if self.last_heartbeat else None,
            "tasks_completed": self.tasks_completed,
            "tasks_failed": self.tasks_failed,
            "avg_processing_time_ms": self.avg_processing_time_ms,
            "metadata": self.worker_metadata
        }

    @classmethod
    async def update_heartbeat(cls, db: AsyncSession, worker_id: str, worker_type: str, 
                              status: str = "healthy", **metadata) -> "WorkerHealth":
        """Update worker heartbeat."""
        stmt = select(cls).where(cls.worker_id == worker_id)
        result = await db.execute(stmt)
        worker = result.scalar_one_or_none()
        
        if worker:
            worker.status = status
            worker.last_heartbeat = func.now()
            worker.worker_metadata = {**worker.worker_metadata, **metadata}
        else:
            worker = cls(
                worker_id=worker_id,
                worker_type=worker_type,
                status=status,
                worker_metadata=metadata
            )
            db.add(worker)
        
        await db.commit()
        await db.refresh(worker)
        return worker


class OptionSet(Base):
    """Configuration option sets for static data management"""
    __tablename__ = "option_sets"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), unique=True, nullable=False, index=True)
    description = Column(Text)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    option_values = relationship("OptionValue", back_populates="option_set", cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<OptionSet(id={self.id}, name={self.name})>"
    
    def to_dict(self):
        """Convert option set to dictionary"""
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }


class OptionValue(Base):
    """Individual option values within option sets"""
    __tablename__ = "option_values"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    option_set_id = Column(Integer, ForeignKey("option_sets.id", ondelete="CASCADE"), nullable=False, index=True)
    value_name = Column(String(100), nullable=False)
    display_name = Column(String(200))
    sort_order = Column(Integer, default=0)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    option_set = relationship("OptionSet", back_populates="option_values")
    theme_config = relationship("ThemeConfig", back_populates="option_value", uselist=False, cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<OptionValue(id={self.id}, value_name={self.value_name})>"
    
    def to_dict(self):
        """Convert option value to dictionary"""
        return {
            "id": self.id,
            "option_set_id": self.option_set_id,
            "value_name": self.value_name,
            "display_name": self.display_name,
            "sort_order": self.sort_order,
            "is_active": self.is_active,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }


class ThemeConfig(Base):
    """Theme configuration attributes for appearance option values"""
    __tablename__ = "theme_configs"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    option_value_id = Column(Integer, ForeignKey("option_values.id", ondelete="CASCADE"), nullable=False, unique=True)
    name = Column(String(100), nullable=False)  # Theme display name
    text_color = Column(String(7), nullable=False)  # Hex color code
    background_color = Column(String(7), nullable=False)  # Hex color code
    menu_color = Column(String(7), nullable=False)  # Hex color code
    border_line_color = Column(String(7), nullable=False)  # Hex color code
    header_overlay_color = Column(String(9))  # Hex color code with alpha (RRGGBBAA)
    user_button_color = Column(String(9))  # Button background color
    user_button_hover = Column(String(9))  # Button hover state color
    user_button_icon = Column(String(7))  # Button icon color
    title_menu_color_light = Column(String(7))  # Light title/menu text color
    border_line_color_light = Column(String(9))  # Light border with transparency
    global_button_hover = Column(String(9))  # Global button hover color with transparency
    theme_metadata = Column(JSONB, default={})  # Additional theme properties (renamed from metadata)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    option_value = relationship("OptionValue", back_populates="theme_config")
    
    def __repr__(self):
        return f"<ThemeConfig(id={self.id}, name={self.name})>"
    
    def to_dict(self):
        """Convert theme config to dictionary"""
        return {
            "id": self.id,
            "option_value_id": self.option_value_id,
            "name": self.name,
            "text_color": self.text_color,
            "background_color": self.background_color,
            "menu_color": self.menu_color,
            "border_line_color": self.border_line_color,
            "header_overlay_color": self.header_overlay_color,
            "metadata": self.theme_metadata,  # Return as 'metadata' in API
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }


class SmartHub(Base):
    """Smart Hub workspace for users - self-contained collaboration space"""
    __tablename__ = "smart_hubs"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    owner_id = Column(UUID(as_uuid=True), nullable=False, index=True)  # References users.id in auth-api
    
    # Hub identity
    name = Column(String(255), nullable=False)
    description = Column(Text)
    avatar = Column(Text)  # Avatar image/icon for the hub
    hub_color = Column(String(50))  # Color theme for this hub
    order_number = Column(Integer, default=0)  # Display order for user's hubs
    
    # Hub status
    is_active = Column(Boolean, default=True, index=True)
    is_default = Column(Boolean, default=False)  # First hub is default
    
    # Hub settings (JSONB for flexibility)
    settings = Column(JSONB, default={})
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), default=func.now(), index=True)
    modified_at = Column(DateTime(timezone=True), default=func.now(), onupdate=func.now())
    
    # Relationships
    smart_matrix = relationship("SmartMatrix", back_populates="smart_hub", uselist=False, cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<SmartHub(id={self.id}, name={self.name}, owner_id={self.owner_id})>"
    
    def to_dict(self):
        """Convert smart hub to dictionary"""
        return {
            "id": str(self.id),
            "owner_id": str(self.owner_id),
            "name": self.name,
            "description": self.description,
            "avatar": self.avatar,
            "hub_color": self.hub_color,
            "order_number": self.order_number,
            "is_active": self.is_active,
            "is_default": self.is_default,
            "settings": self.settings,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "modified_at": self.modified_at.isoformat() if self.modified_at else None,
        }
    
    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "SmartHub":
        """Create a new smart hub."""
        hub = cls(**kwargs)
        db.add(hub)
        await db.commit()
        await db.refresh(hub)
        logger.info("Smart hub created", hub_id=str(hub.id), owner_id=str(hub.owner_id))
        return hub
    
    @classmethod
    async def get_by_id(cls, db: AsyncSession, hub_id: uuid.UUID) -> Optional["SmartHub"]:
        """Get hub by ID."""
        stmt = select(cls).where(cls.id == hub_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    @classmethod
    async def get_user_hubs(cls, db: AsyncSession, owner_id: uuid.UUID, active_only: bool = True) -> List["SmartHub"]:
        """Get all hubs for a user."""
        stmt = select(cls).where(cls.owner_id == owner_id)
        if active_only:
            stmt = stmt.where(cls.is_active == True)
        stmt = stmt.order_by(cls.is_default.desc(), cls.order_number.asc(), cls.created_at.desc())
        result = await db.execute(stmt)
        return result.scalars().all()


class SmartMatrix(Base):
    """Smart Matrix - The brain/data center for each Smart Hub (one per hub)"""
    __tablename__ = "smart_matrices"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    smart_hub_id = Column(UUID(as_uuid=True), ForeignKey("smart_hubs.id", ondelete="CASCADE"), nullable=False, unique=True, index=True)
    owner_id = Column(UUID(as_uuid=True), nullable=False, index=True)  # References users.id in auth-api
    
    # Matrix identity
    name = Column(Text, nullable=False)
    color = Column(Text)  # Color theme for this matrix
    order_number = Column(Integer, default=0)  # Display order within hub
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), default=func.now(), index=True)
    modified_at = Column(DateTime(timezone=True), default=func.now(), onupdate=func.now())
    
    # Relationships
    smart_hub = relationship("SmartHub", back_populates="smart_matrix")
    
    def __repr__(self):
        return f"<SmartMatrix(id={self.id}, name={self.name}, smart_hub_id={self.smart_hub_id})>"
    
    def to_dict(self):
        """Convert smart matrix to dictionary"""
        return {
            "id": str(self.id),
            "smart_hub_id": str(self.smart_hub_id),
            "owner_id": str(self.owner_id),
            "name": self.name,
            "color": self.color,
            "order_number": self.order_number,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "modified_at": self.modified_at.isoformat() if self.modified_at else None,
        }
    
    @classmethod
    async def create(cls, db: AsyncSession, **kwargs) -> "SmartMatrix":
        """Create a new smart matrix."""
        matrix = cls(**kwargs)
        db.add(matrix)
        await db.commit()
        await db.refresh(matrix)
        logger.info("Smart matrix created", matrix_id=str(matrix.id), smart_hub_id=str(matrix.smart_hub_id))
        return matrix
    
    @classmethod
    async def get_by_id(cls, db: AsyncSession, matrix_id: uuid.UUID) -> Optional["SmartMatrix"]:
        """Get matrix by ID."""
        stmt = select(cls).where(cls.id == matrix_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    @classmethod
    async def get_by_hub_id(cls, db: AsyncSession, smart_hub_id: uuid.UUID) -> Optional["SmartMatrix"]:
        """Get the matrix for a smart hub (one-to-one)."""
        stmt = select(cls).where(cls.smart_hub_id == smart_hub_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()


class UserNavigation(Base):
    """User navigation tracking - stores current user context and navigation state"""
    __tablename__ = "user_navigation"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    
    # One-to-one with user_profile (in auth-api)
    user_profile_id = Column(UUID(as_uuid=True), nullable=False, unique=True, index=True)
    
    # One-to-one with current smart hub
    current_smart_hub_id = Column(UUID(as_uuid=True), ForeignKey("smart_hubs.id", ondelete="SET NULL"), nullable=True, unique=True, index=True)
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), default=func.now())
    updated_at = Column(DateTime(timezone=True), default=func.now(), onupdate=func.now())
    
    # Relationships
    current_smart_hub = relationship("SmartHub", foreign_keys=[current_smart_hub_id])
    
    def __repr__(self):
        return f"<UserNavigation(id={self.id}, user_profile_id={self.user_profile_id}, current_smart_hub_id={self.current_smart_hub_id})>"
    
    def to_dict(self):
        """Convert user navigation to dictionary"""
        return {
            "id": str(self.id),
            "user_profile_id": str(self.user_profile_id),
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
        logger.info("User navigation created", navigation_id=str(navigation.id), user_profile_id=str(navigation.user_profile_id))
        return navigation
    
    @classmethod
    async def get_by_user_profile_id(cls, db: AsyncSession, user_profile_id: uuid.UUID) -> Optional["UserNavigation"]:
        """Get navigation by user profile ID (one-to-one)."""
        stmt = select(cls).where(cls.user_profile_id == user_profile_id)
        result = await db.execute(stmt)
        return result.scalar_one_or_none()
    
    @classmethod
    async def update_current_hub(cls, db: AsyncSession, user_profile_id: uuid.UUID, current_smart_hub_id: uuid.UUID) -> Optional["UserNavigation"]:
        """Update the current smart hub for a user."""
        navigation = await cls.get_by_user_profile_id(db, user_profile_id)
        if navigation:
            navigation.current_smart_hub_id = current_smart_hub_id
            await db.commit()
            await db.refresh(navigation)
            logger.info("User navigation updated", user_profile_id=str(user_profile_id), current_smart_hub_id=str(current_smart_hub_id))
        return navigation