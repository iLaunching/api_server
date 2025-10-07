"""
Database configuration and connection management.
"""

import os
import asyncio
from typing import AsyncGenerator
import structlog
from sqlalchemy.ext.asyncio import (
    AsyncSession,
    create_async_engine,
    async_sessionmaker
)
from sqlalchemy.orm import declarative_base
import redis.asyncio as redis

logger = structlog.get_logger()

# Database configuration
DATABASE_URL = os.getenv("DATABASE_URL")
if DATABASE_URL and DATABASE_URL.startswith("postgres://"):
    DATABASE_URL = DATABASE_URL.replace("postgres://", "postgresql+asyncpg://", 1)

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379")

# SQLAlchemy setup
engine = create_async_engine(
    DATABASE_URL,
    echo=os.getenv("DATABASE_ECHO", "false").lower() == "true",
    pool_size=20,
    max_overflow=0,
    pool_pre_ping=True,
    pool_recycle=300
)

async_session_maker = async_sessionmaker(
    engine,
    class_=AsyncSession,
    expire_on_commit=False
)

Base = declarative_base()

# Redis setup
redis_client = None

async def init_redis():
    """Initialize Redis connection."""
    global redis_client
    try:
        redis_client = redis.from_url(
            REDIS_URL,
            encoding="utf-8",
            decode_responses=True,
            socket_connect_timeout=5,
            socket_timeout=5,
            retry_on_timeout=True
        )
        # Test connection
        await redis_client.ping()
        logger.info("Redis connection established", url=REDIS_URL)
        return redis_client
    except Exception as e:
        logger.error("Failed to connect to Redis", error=str(e), url=REDIS_URL)
        raise

async def get_redis():
    """Get Redis client."""
    global redis_client
    if redis_client is None:
        redis_client = await init_redis()
    return redis_client

async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """
    Get database session.
    
    Yields:
        AsyncSession: Database session
    """
    async with async_session_maker() as session:
        try:
            yield session
        finally:
            await session.close()

async def init_database():
    """Initialize database connection and create tables."""
    try:
        # Test database connection
        async with engine.begin() as conn:
            # Import models to register them with Base
            from models.database_models import (
                AnalysisJob, AnalysisResult, DataCache, LLMUsage, WorkerHealth
            )
            
            # Create all tables
            await conn.run_sync(Base.metadata.create_all)
            
        logger.info("Database connection established", url=DATABASE_URL)
        
    except Exception as e:
        logger.error("Failed to connect to database", error=str(e), url=DATABASE_URL)
        raise

async def close_database():
    """Close database connections."""
    global redis_client
    
    try:
        if redis_client:
            await redis_client.close()
            logger.info("Redis connection closed")
    except Exception as e:
        logger.error("Error closing Redis connection", error=str(e))
    
    try:
        await engine.dispose()
        logger.info("Database connection closed")
    except Exception as e:
        logger.error("Error closing database connection", error=str(e))

# Health check functions
async def check_database_health() -> dict:
    """Check database connectivity."""
    try:
        async with async_session_maker() as session:
            result = await session.execute("SELECT 1")
            return {
                "status": "healthy",
                "message": "Database connection successful"
            }
    except Exception as e:
        return {
            "status": "unhealthy",
            "message": f"Database connection failed: {str(e)}"
        }

async def check_redis_health() -> dict:
    """Check Redis connectivity."""
    try:
        redis_conn = await get_redis()
        await redis_conn.ping()
        return {
            "status": "healthy",
            "message": "Redis connection successful"
        }
    except Exception as e:
        return {
            "status": "unhealthy",
            "message": f"Redis connection failed: {str(e)}"
        }