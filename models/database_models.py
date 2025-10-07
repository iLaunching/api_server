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