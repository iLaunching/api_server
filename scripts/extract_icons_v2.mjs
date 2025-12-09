#!/usr/bin/env node
import { fas } from '@fortawesome/free-solid-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fab } from '@fortawesome/free-brands-svg-icons';
import { writeFileSync } from 'fs';

function extractIcons() {
  const allIcons = [];
  let sortOrder = 0;

  // Extract Solid icons
  for (const [key, iconDef] of Object.entries(fas)) {
    const iconName = key.replace(/([A-Z])/g, '-$1').toLowerCase().replace(/^-/, '');
    allIcons.push({
      iconName: key,
      prefix: 'fas',
      category: 'solid',
      unicode: iconDef.icon[3],
      sortOrder: sortOrder++
    });
  }

  // Extract Regular icons
  for (const [key, iconDef] of Object.entries(far)) {
    const iconName = key.replace(/([A-Z])/g, '-$1').toLowerCase().replace(/^-/, '');
    allIcons.push({
      iconName: key,
      prefix: 'far',
      category: 'regular',
      unicode: iconDef.icon[3],
      sortOrder: sortOrder++
    });
  }

  // Extract Brand icons
  for (const [key, iconDef] of Object.entries(fab)) {
    const iconName = key.replace(/([A-Z])/g, '-$1').toLowerCase().replace(/^-/, '');
    allIcons.push({
      iconName: key,
      prefix: 'fab',
      category: 'brands',
      unicode: iconDef.icon[3],
      sortOrder: sortOrder++
    });
  }

  return allIcons;
}

function generateSQL(icons) {
  let sql = `-- Font Awesome Icon Library Seed Data
-- Total icons: ${icons.length}

-- Create icon_library option set
INSERT INTO option_sets (name, description) VALUES
('icon_library', 'Font Awesome icon library')
ON CONFLICT (name) DO NOTHING;

-- Insert icons
DO $$
DECLARE
  icon_set_id INTEGER;
  new_option_id INTEGER;
BEGIN
  SELECT id INTO icon_set_id FROM option_sets WHERE name = 'icon_library';
  
`;

  icons.forEach((icon, index) => {
    const kebabName = icon.iconName.replace(/([A-Z])/g, '-$1').toLowerCase().replace(/^-/, '');
    const displayName = icon.iconName
      .replace(/([A-Z])/g, ' $1')
      .trim();
    
    sql += `  -- ${displayName}
  INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active)
  VALUES (icon_set_id, 'icon_${kebabName}', '${displayName}', ${index}, true)
  RETURNING id INTO new_option_id;
  
  INSERT INTO icon_metadata (option_value_id, icon_name, icon_prefix, icon_category, unicode)
  VALUES (new_option_id, '${kebabName}', '${icon.prefix}', '${icon.category}', '${icon.unicode}');
  
`;
  });

  sql += `END $$;\n`;
  return sql;
}

console.log('Extracting Font Awesome icons...');
const icons = extractIcons();
console.log(`✅ Extracted ${icons.length} icons`);

const sql = generateSQL(icons);
writeFileSync('/workspaces/Ilaunching-SERVERS/api-server/database/seed_icons_v2.sql', sql);
console.log('✅ Generated seed_icons_v2.sql');

// Generate JSON reference
const jsonData = {
  total: icons.length,
  by_category: {
    solid: icons.filter(i => i.prefix === 'fas').length,
    regular: icons.filter(i => i.prefix === 'far').length,
    brands: icons.filter(i => i.prefix === 'fab').length
  },
  icons: icons.slice(0, 10) // Sample
};

writeFileSync('/workspaces/Ilaunching-SERVERS/api-server/database/icons_v2.json', JSON.stringify(jsonData, null, 2));
console.log('✅ Generated icons_v2.json');
