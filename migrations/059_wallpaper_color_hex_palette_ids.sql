-- Map legacy slug wallpaper_color_palette_id values to hex catalog ids.

UPDATE synaptic_expressive_experience
SET wallpaper_color_palette_id = CASE wallpaper_color_palette_id
  WHEN 'ocean-teal' THEN '1A535C'
  WHEN 'sunset-coral' THEN 'FF6B6B'
  WHEN 'lavender-mist' THEN 'B8A9C9'
  WHEN 'forest-green' THEN '2D6A4F'
  WHEN 'golden-hour' THEN 'FFB703'
  WHEN 'midnight' THEN '14213D'
  WHEN 'rose-quartz' THEN 'E5989B'
  WHEN 'slate' THEN '64748B'
  WHEN 'sky-blue' THEN '4CC9F0'
  WHEN 'plum' THEN '7209B7'
  WHEN 'sage' THEN '84A98C'
  WHEN 'sand' THEN 'E9C46A'
  WHEN 'charcoal' THEN '343A40'
  WHEN 'blush' THEN 'F4ACB7'
  WHEN 'indigo' THEN '4361EE'
  WHEN 'mint' THEN '06D6A0'
  ELSE wallpaper_color_palette_id
END
WHERE wallpaper_color_palette_id IS NOT NULL;
