"""
Add toneButton_border_color to all itheme theme configurations
"""
import asyncio
import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import text

# Use DATABASE_URL from environment or default
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/ilaunching")
# Convert to async URL
if DATABASE_URL.startswith("postgresql://"):
    DATABASE_URL = DATABASE_URL.replace("postgresql://", "postgresql+asyncpg://", 1)

# Theme configurations with border colors
# (value_name, border_color)
theme_configs = [
    ('ipurple', '#6B63DD'),       # Darker purple
    ('iblue', '#0D7BBF'),         # Darker blue
    ('ipink', '#D14A80'),         # Darker pink
    ('iviolet', '#702F8A'),       # Darker violet
    ('iindigo', '#3A42A0'),       # Darker indigo
    ('iorange', '#E38B29'),       # Darker orange
    ('iteal', '#14B5B5'),         # Darker teal
    ('imint', '#34C38F'),         # Darker mint
    ('ibronze', '#C77A54'),       # Darker bronze
    ('iolive', '#7C8A42'),        # Darker olive
    ('ilime_green', '#77B900'),   # Darker lime green
    ('itomato', '#D9534F'),       # Darker tomato (red)
    ('iblack', '#808080'),        # Gray for black theme
]

async def main():
    # Create async engine
    engine = create_async_engine(DATABASE_URL, echo=True)
    async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    
    async with async_session() as session:
        try:
            for value_name, border_color in theme_configs:
                print(f"\n{'='*60}")
                print(f"Processing: {value_name} -> border: {border_color}")
                print(f"{'='*60}")
                
                # Execute update statement directly
                await session.execute(
                    text(f"""
                        UPDATE theme_configs tc
                        SET theme_metadata = jsonb_set(
                            tc.theme_metadata,
                            '{{toneButton_border_color}}',
                            to_jsonb('{border_color}'::text),
                            true
                        )
                        FROM option_values ov
                        WHERE tc.option_value_id = ov.id
                        AND ov.value_name = '{value_name}'
                        AND tc.theme_metadata IS NOT NULL
                    """)
                )
                
                print(f"✅ Updated {value_name}")
                print(f"   Border Color: {border_color}")
            
            # Commit all changes
            await session.commit()
            print("\n" + "="*60)
            print("✅ All theme configurations updated successfully!")
            print("="*60)
            
        except Exception as e:
            print(f"\n❌ Error: {e}")
            await session.rollback()
            raise
        finally:
            await engine.dispose()

if __name__ == "__main__":
    asyncio.run(main())
