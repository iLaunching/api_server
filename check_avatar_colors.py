"""Check avatar color metadata in database"""
import asyncio
from sqlalchemy import text
from config.database import init_db, get_db

async def main():
    await init_db()
    
    async for db in get_db():
        # Check smarthub colors
        query = text('''
            SELECT ov.id, ov.display_name, tc.theme_metadata, tc.id as tc_id
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            LEFT JOIN theme_configs tc ON ov.id = tc.option_value_id
            WHERE os.name = 'smarthub_color_scheme'
            ORDER BY ov.sort_order
            LIMIT 3
        ''')
        result = await db.execute(query)
        print('SmartHub Colors (working example):')
        for row in result:
            print(f'  ID: {row.id}, Name: {row.display_name}')
            print(f'    Theme Config ID: {row.tc_id}')
            print(f'    Metadata: {row.theme_metadata}')
        
        # Check avatar colors
        query2 = text('''
            SELECT ov.id, ov.display_name, tc.theme_metadata, tc.id as tc_id
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            LEFT JOIN theme_configs tc ON ov.id = tc.option_value_id
            WHERE os.name = 'avatar_color'
            ORDER BY ov.sort_order
        ''')
        result2 = await db.execute(query2)
        print('\nAvatar Colors:')
        for row in result2:
            print(f'  ID: {row.id}, Name: {row.display_name}')
            print(f'    Theme Config ID: {row.tc_id}')
            print(f'    Metadata: {row.theme_metadata}')
        break

if __name__ == "__main__":
    asyncio.run(main())
