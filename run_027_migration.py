import asyncio
import os
import structlog
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine

logger = structlog.get_logger()

# Use standard database URL or fallback to the one provided by user if needed
# But standard config usually works.
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql+asyncpg://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway")

async def run_migration():
    logger.info("Starting migration 027 (Seed Chat History)")
    
    engine = create_async_engine(DATABASE_URL, echo=True)
    
    async with engine.begin() as conn:
        with open("migrations/027_seed_chat_history.sql", "r") as f:
            sql = f.read()
            
        logger.info("Executing SQL...")
        await conn.execute(text(sql))
        
    await engine.dispose()
    logger.info("Migration 027 completed successfully")

if __name__ == "__main__":
    asyncio.run(run_migration())
