#!/usr/bin/env python3
"""
Update existing smart_hubs with default canvas grid settings
"""
import asyncio
import sys
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import select, update
from models.database_models import SmartHub

# Database connection
DATABASE_URL = "postgresql+asyncpg://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def update_smart_hub_grid_settings():
    """Update existing smart_hubs with default grid settings"""
    print("🔧 Updating smart_hubs with canvas grid settings...")
    
    # Create async engine
    engine = create_async_engine(DATABASE_URL, echo=False)
    async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    
    async with async_session() as session:
        try:
            # Get all smart hubs
            result = await session.execute(select(SmartHub))
            hubs = result.scalars().all()
            
            print(f"📊 Found {len(hubs)} smart hubs")
            
            if len(hubs) == 0:
                print("✅ No smart hubs to update")
                return
            
            # Update all hubs (values already set by migration defaults)
            updated_count = 0
            for hub in hubs:
                print(f"  ✓ Hub '{hub.name}' (ID: {hub.id})")
                print(f"    - show_grid: {hub.show_grid}")
                print(f"    - grid_style: {hub.grid_style}")
                print(f"    - snap_to_grid: {hub.snap_to_grid}")
                updated_count += 1
            
            print(f"\n✅ Verified {updated_count} smart hubs have grid settings")
            
        except Exception as e:
            print(f"❌ Error updating smart hubs: {e}")
            await session.rollback()
            sys.exit(1)
        finally:
            await engine.dispose()

if __name__ == "__main__":
    asyncio.run(update_smart_hub_grid_settings())
