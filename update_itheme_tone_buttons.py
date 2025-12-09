import asyncio
import asyncpg

DATABASE_URL = 'postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway'

# Tone button colors for each itheme
ITHEME_COLORS = {
    'ipurple': {'bk': '#7F77F166', 'text': '#6B63DD', 'border': '#7F77F1'},
    'iblue': {'bk': '#0F90E066', 'text': '#0F90E0', 'border': '#0F90E0'},
    'ipink': {'bk': '#EE5E9966', 'text': '#BE3E79', 'border': '#EE5E99'},
    'iviolet': {'bk': '#B660E066', 'text': '#8E40B0', 'border': '#B660E0'},
    'iindigo': {'bk': '#6985FF66', 'text': '#4763CC', 'border': '#6985FF'},
    'iorange': {'bk': '#E16B1666', 'text': '#B15300', 'border': '#E16B16'},
    'iteal': {'bk': '#109D9F66', 'text': '#0C7D7F', 'border': '#109D9F'},
    'imint': {'bk': '#3EB88B66', 'text': '#2D8B6D', 'border': '#3EB88B'},
    'ibronze': {'bk': '#AA8D8066', 'text': '#886B5E', 'border': '#AA8D80'},
    'iolive': {'bk': '#9F9F8066', 'text': '#7F7F60', 'border': '#9F9F80'},
    'ilime_green': {'bk': '#32CD3266', 'text': '#28A745', 'border': '#32CD32'},
    'itomato': {'bk': '#FF634766', 'text': '#E03C31', 'border': '#FF6347'},
    'iblack': {'bk': '#595C6666', 'text': '#3F424C', 'border': '#595C66'},
}

async def update_tone_buttons():
    conn = await asyncpg.connect(DATABASE_URL)
    try:
        for theme_name, colors in ITHEME_COLORS.items():
            # Update the theme_metadata JSONB to add tone button colors
            result = await conn.execute('''
                UPDATE theme_configs tc
                SET theme_metadata = theme_metadata || 
                    jsonb_build_object(
                        'toneButton_bk_color', $1::text,
                        'toneButton_text_color', $2::text,
                        'toneButton_boader_color', $3::text
                    )
                FROM option_values ov
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE tc.option_value_id = ov.id
                  AND os.name = 'itheme'
                  AND ov.value_name = $4::text
            ''', colors['bk'], colors['text'], colors['border'], theme_name)
            
            print(f"✅ Updated {theme_name}: {result}")
        
        print("\n🎉 All tone button colors updated successfully!")
        
        # Verify the update
        verify = await conn.fetch('''
            SELECT 
                ov.value_name,
                tc.theme_metadata->>'toneButton_bk_color' as bk_color,
                tc.theme_metadata->>'toneButton_text_color' as text_color
            FROM option_values ov
            JOIN theme_configs tc ON ov.id = tc.option_value_id
            JOIN option_sets os ON ov.option_set_id = os.id
            WHERE os.name = 'itheme'
            ORDER BY ov.sort_order
            LIMIT 3
        ''')
        
        print("\nVerification (first 3 themes):")
        for row in verify:
            print(f"  {row['value_name']}: bk={row['bk_color']}, text={row['text_color']}")
            
    finally:
        await conn.close()

asyncio.run(update_tone_buttons())
