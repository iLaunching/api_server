-- Update header overlay colors for richer, darker appearance
UPDATE theme_configs tc
SET header_overlay_color = CASE 
    WHEN ov.value_name = 'sun' THEN '#00000035'
    WHEN ov.value_name = 'moon' THEN '#00000030'
    WHEN ov.value_name = 'space' THEN '#00000038'
    WHEN ov.value_name = 'star' THEN '#00000040'
    ELSE header_overlay_color
END
FROM option_values ov
WHERE tc.option_value_id = ov.id
AND ov.value_name IN ('sun', 'moon', 'space', 'star');
