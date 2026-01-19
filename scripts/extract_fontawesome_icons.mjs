#!/usr/bin/env node
/**
 * Font Awesome Icon Extraction Script
 * Extracts all Font Awesome icons and generates SQL seed data
 * following the option set architecture pattern
 */

import { fas } from '@fortawesome/free-solid-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fab } from '@fortawesome/free-brands-svg-icons';
import fs from 'fs';
import path from 'path';

// Icon category mapping
const categoryMapping = {
  // Core UI
  core: ['heart', 'star', 'home', 'user', 'search', 'cog', 'bell', 'circle', 'square', 'bookmark'],
  
  // Navigation
  navigation: ['arrow-left', 'arrow-right', 'arrow-up', 'arrow-down', 'chevron-left', 'chevron-right', 
               'chevron-up', 'chevron-down', 'bars', 'times', 'angle-left', 'angle-right', 'caret-down'],
  
  // Communication
  communication: ['comment', 'comments', 'envelope', 'paper-plane', 'phone', 'video', 'microphone', 
                  'inbox', 'mail-bulk', 'at', 'hashtag'],
  
  // Status & Alerts
  status: ['check', 'check-circle', 'times-circle', 'exclamation-triangle', 'exclamation-circle', 
           'info-circle', 'question-circle', 'minus-circle', 'plus-circle', 'ban'],
  
  // Business & Finance
  business: ['chart-bar', 'chart-line', 'chart-pie', 'dollar-sign', 'euro-sign', 'pound-sign', 
             'shopping-cart', 'credit-card', 'wallet', 'briefcase', 'building'],
  
  // Social
  social: ['thumbs-up', 'thumbs-down', 'share', 'share-alt', 'retweet', 'heart', 'eye', 
           'comment-dots', 'users', 'user-friends'],
  
  // Tools & Settings
  tools: ['wrench', 'screwdriver', 'hammer', 'cog', 'cogs', 'sliders-h', 'filter', 'key', 
          'lock', 'unlock', 'shield-alt', 'database'],
  
  // Location & Travel
  location: ['map-marker-alt', 'map-pin', 'globe', 'compass', 'location-arrow', 'map', 
             'plane', 'car', 'train', 'ship'],
  
  // Users & People
  users: ['user', 'user-circle', 'user-cog', 'user-edit', 'user-plus', 'user-minus', 
          'user-shield', 'users', 'user-friends', 'user-tie'],
  
  // Media & Files
  media: ['image', 'file', 'file-alt', 'file-pdf', 'file-word', 'file-excel', 'folder', 
          'folder-open', 'camera', 'video', 'music', 'play', 'pause', 'stop'],
  
  // Time & Calendar
  time: ['clock', 'calendar', 'calendar-alt', 'calendar-check', 'calendar-times', 
         'hourglass', 'stopwatch', 'history'],
  
  // Weather
  weather: ['sun', 'moon', 'cloud', 'cloud-rain', 'cloud-sun', 'snowflake', 'bolt', 'wind'],
  
  // Brands (special category)
  brands: [] // Will be populated from fab
};

function convertToKebabCase(camelCase) {
  return camelCase
    .replace(/^fa/, '')
    .replace(/([A-Z])/g, '-$1')
    .toLowerCase()
    .substring(1);
}

function determineCategory(iconName, prefix) {
  if (prefix === 'fab') return 'brands';
  
  for (const [category, keywords] of Object.entries(categoryMapping)) {
    if (keywords.some(keyword => iconName.includes(keyword))) {
      return category;
    }
  }
  
  return 'general';
}

function extractIcons() {
  const allIcons = [];
  let sortOrder = 0;

  // Extract Solid icons
  for (const [key, iconDef] of Object.entries(fas)) {
    const iconName = convertToKebabCase(key);
    const category = determineCategory(iconName, 'fas');
    
    allIcons.push({
      value_name: `icon_${iconName}_solid`,
      display_name: iconName.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase()),
      icon_name: iconName,
      icon_prefix: 'fas',
      icon_category: category,
      sort_order: sortOrder++,
      unicode: iconDef.icon[3] // Unicode code point
    });
  }

  // Extract Regular icons
  for (const [key, iconDef] of Object.entries(far)) {
    const iconName = convertToKebabCase(key);
    const category = determineCategory(iconName, 'far');
    
    allIcons.push({
      value_name: `icon_${iconName}_regular`,
      display_name: `${iconName.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase())} (Regular)`,
      icon_name: iconName,
      icon_prefix: 'far',
      icon_category: category,
      sort_order: sortOrder++,
      unicode: iconDef.icon[3]
    });
  }

  // Extract Brand icons
  for (const [key, iconDef] of Object.entries(fab)) {
    const iconName = convertToKebabCase(key);
    
    allIcons.push({
      value_name: `icon_${iconName}_brand`,
      display_name: iconName.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase()),
      icon_name: iconName,
      icon_prefix: 'fab',
      icon_category: 'brands',
      sort_order: sortOrder++,
      unicode: iconDef.icon[3]
    });
  }

  return allIcons;
}

function generateSQL(icons) {
  const lines = [];
  
  lines.push('-- Font Awesome Icon Library Seed Data');
  lines.push('-- Generated automatically from @fontawesome packages');
  lines.push('-- Total icons: ' + icons.length);
  lines.push('');
  
  lines.push('-- Step 1: Create icon_library option set');
  lines.push("INSERT INTO option_sets (name, description, is_cached) VALUES");
  lines.push("('icon_library', 'Font Awesome icon library for user avatars and UI elements', true);");
  lines.push('');
  
  lines.push('-- Step 2: Insert icon option values');
  lines.push('-- Note: This will create theme_configs entries automatically via trigger or manual insert');
  lines.push('');
  
  // Group by category for better organization
  const byCategory = {};
  icons.forEach(icon => {
    if (!byCategory[icon.icon_category]) {
      byCategory[icon.icon_category] = [];
    }
    byCategory[icon.icon_category].push(icon);
  });
  
  Object.entries(byCategory).forEach(([category, categoryIcons]) => {
    lines.push(`-- Category: ${category} (${categoryIcons.length} icons)`);
    
    categoryIcons.forEach((icon, index) => {
      const metadata = {
        icon_name: icon.icon_name,
        icon_prefix: icon.icon_prefix,
        icon_category: icon.icon_category,
        unicode: icon.unicode
      };
      
      lines.push(`INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)`);
      lines.push(`SELECT id, '${icon.value_name}', '${icon.display_name}', ${icon.sort_order}, true, '${JSON.stringify(metadata)}'::jsonb`);
      lines.push(`FROM option_sets WHERE name = 'icon_library';`);
      lines.push('');
    });
  });
  
  lines.push('-- Create indexes for fast icon lookups');
  lines.push("CREATE INDEX IF NOT EXISTS idx_option_values_icon_category ON option_values ((metadata->>'icon_category'));");
  lines.push("CREATE INDEX IF NOT EXISTS idx_option_values_icon_prefix ON option_values ((metadata->>'icon_prefix'));");
  lines.push('');
  
  return lines.join('\n');
}

function generateJSON(icons) {
  return JSON.stringify({
    total: icons.length,
    by_category: icons.reduce((acc, icon) => {
      if (!acc[icon.icon_category]) {
        acc[icon.icon_category] = [];
      }
      acc[icon.icon_category].push({
        name: icon.icon_name,
        prefix: icon.icon_prefix,
        display: icon.display_name,
        value: icon.value_name
      });
      return acc;
    }, {}),
    all_icons: icons
  }, null, 2);
}

// Main execution
console.log('🎨 Extracting Font Awesome Icons...\n');

const icons = extractIcons();

console.log(`✅ Extracted ${icons.length} total icons:`);
console.log(`   - Solid: ${icons.filter(i => i.icon_prefix === 'fas').length}`);
console.log(`   - Regular: ${icons.filter(i => i.icon_prefix === 'far').length}`);
console.log(`   - Brands: ${icons.filter(i => i.icon_prefix === 'fab').length}`);
console.log('');

// Generate SQL seed file
const sqlContent = generateSQL(icons);
const sqlPath = path.join(process.cwd(), 'database', 'seed_icons.sql');
fs.writeFileSync(sqlPath, sqlContent);
console.log(`✅ Generated SQL seed file: ${sqlPath}`);

// Generate JSON reference file
const jsonContent = generateJSON(icons);
const jsonPath = path.join(process.cwd(), 'database', 'icons_reference.json');
fs.writeFileSync(jsonPath, jsonContent);
console.log(`✅ Generated JSON reference: ${jsonPath}`);

console.log('\n✨ Done! Next steps:');
console.log('   1. Review: database/seed_icons.sql');
console.log('   2. Run: psql -f database/seed_icons.sql');
console.log('   3. Or use Railway CLI to execute the seed');
