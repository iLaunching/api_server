-- Font Awesome Icon Library Seed Data
-- Generated automatically from @fontawesome packages
-- Total icons: 2806

-- Step 1: Create icon_library option set
INSERT INTO option_sets (name, description) VALUES
('icon_library', 'Font Awesome icon library for user avatars and UI elements');

-- Step 2: Insert icon option values
-- Note: This will create theme_configs entries automatically via trigger or manual insert

-- Category: general (1376 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 0, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"30"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 1, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"31"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 2, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"32"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 3, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"33"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 4, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"34"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 5, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"35"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 6, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"36"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 7, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"37"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 8, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"38"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon__solid', '', 9, true, '{"icon_name":"","icon_prefix":"fas","icon_category":"general","unicode":"39"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dollar_solid', 'Dollar', 11, true, '{"icon_name":"dollar","icon_prefix":"fas","icon_category":"general","unicode":"24"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_usd_solid', 'Usd', 12, true, '{"icon_name":"usd","icon_prefix":"fas","icon_category":"general","unicode":"24"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dog_solid', 'Dog', 13, true, '{"icon_name":"dog","icon_prefix":"fas","icon_category":"general","unicode":"f6d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-moving_solid', 'Truck Moving', 14, true, '{"icon_name":"truck-moving","icon_prefix":"fas","icon_category":"general","unicode":"f4df"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sync-alt_solid', 'Sync Alt', 16, true, '{"icon_name":"sync-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_align-justify_solid', 'Align Justify', 19, true, '{"icon_name":"align-justify","icon_prefix":"fas","icon_category":"general","unicode":"f039"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-kiss_solid', 'Face Kiss', 21, true, '{"icon_name":"face-kiss","icon_prefix":"fas","icon_category":"general","unicode":"f596"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiss_solid', 'Kiss', 22, true, '{"icon_name":"kiss","icon_prefix":"fas","icon_category":"general","unicode":"f596"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kitchen-set_solid', 'Kitchen Set', 23, true, '{"icon_name":"kitchen-set","icon_prefix":"fas","icon_category":"general","unicode":"e51a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dna_solid', 'Dna', 24, true, '{"icon_name":"dna","icon_prefix":"fas","icon_category":"general","unicode":"f471"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_child-reaching_solid', 'Child Reaching', 25, true, '{"icon_name":"child-reaching","icon_prefix":"fas","icon_category":"general","unicode":"e59d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paste_solid', 'Paste', 26, true, '{"icon_name":"paste","icon_prefix":"fas","icon_category":"general","unicode":"f0ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meteor_solid', 'Meteor', 28, true, '{"icon_name":"meteor","icon_prefix":"fas","icon_category":"general","unicode":"f753"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gears_solid', 'Gears', 29, true, '{"icon_name":"gears","icon_prefix":"fas","icon_category":"general","unicode":"f085"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_icicles_solid', 'Icicles', 32, true, '{"icon_name":"icicles","icon_prefix":"fas","icon_category":"general","unicode":"f7ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-trend-up_solid', 'Arrow Trend Up', 33, true, '{"icon_name":"arrow-trend-up","icon_prefix":"fas","icon_category":"general","unicode":"e098"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_question_solid', 'Question', 35, true, '{"icon_name":"question","icon_prefix":"fas","icon_category":"general","unicode":"3f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-bound_solid', 'Hands Bound', 36, true, '{"icon_name":"hands-bound","icon_prefix":"fas","icon_category":"general","unicode":"e4f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-walking-luggage_solid', 'Person Walking Luggage', 37, true, '{"icon_name":"person-walking-luggage","icon_prefix":"fas","icon_category":"general","unicode":"e554"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-booth_solid', 'Person Booth', 40, true, '{"icon_name":"person-booth","icon_prefix":"fas","icon_category":"general","unicode":"f756"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_locust_solid', 'Locust', 41, true, '{"icon_name":"locust","icon_prefix":"fas","icon_category":"general","unicode":"e520"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_right-long_solid', 'Right Long', 42, true, '{"icon_name":"right-long","icon_prefix":"fas","icon_category":"general","unicode":"f30b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-alt-right_solid', 'Long Arrow Alt Right', 43, true, '{"icon_name":"long-arrow-alt-right","icon_prefix":"fas","icon_category":"general","unicode":"f30b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-droplet_solid', 'Truck Droplet', 44, true, '{"icon_name":"truck-droplet","icon_prefix":"fas","icon_category":"general","unicode":"e58c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-medical_solid', 'Hand Holding Medical', 45, true, '{"icon_name":"hand-holding-medical","icon_prefix":"fas","icon_category":"general","unicode":"e05c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-left_solid', 'Hand Point Left', 46, true, '{"icon_name":"hand-point-left","icon_prefix":"fas","icon_category":"general","unicode":"f0a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_minus_solid', 'Minus', 48, true, '{"icon_name":"minus","icon_prefix":"fas","icon_category":"general","unicode":"f068"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_subtract_solid', 'Subtract', 49, true, '{"icon_name":"subtract","icon_prefix":"fas","icon_category":"general","unicode":"f068"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-alpha-up-alt_solid', 'Sort Alpha Up Alt', 51, true, '{"icon_name":"sort-alpha-up-alt","icon_prefix":"fas","icon_category":"general","unicode":"f882"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-fist_solid', 'Hand Fist', 56, true, '{"icon_name":"hand-fist","icon_prefix":"fas","icon_category":"general","unicode":"f6de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fist-raised_solid', 'Fist Raised', 57, true, '{"icon_name":"fist-raised","icon_prefix":"fas","icon_category":"general","unicode":"f6de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sms_solid', 'Sms', 59, true, '{"icon_name":"sms","icon_prefix":"fas","icon_category":"general","unicode":"f7cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scale-balanced_solid', 'Scale Balanced', 61, true, '{"icon_name":"scale-balanced","icon_prefix":"fas","icon_category":"general","unicode":"f24e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_balance-scale_solid', 'Balance Scale', 62, true, '{"icon_name":"balance-scale","icon_prefix":"fas","icon_category":"general","unicode":"f24e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_automobile_solid', 'Automobile', 64, true, '{"icon_name":"automobile","icon_prefix":"fas","icon_category":"general","unicode":"f1b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crop-simple_solid', 'Crop Simple', 65, true, '{"icon_name":"crop-simple","icon_prefix":"fas","icon_category":"general","unicode":"f565"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crop-alt_solid', 'Crop Alt', 66, true, '{"icon_name":"crop-alt","icon_prefix":"fas","icon_category":"general","unicode":"f565"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_medal_solid', 'Medal', 67, true, '{"icon_name":"medal","icon_prefix":"fas","icon_category":"general","unicode":"f5a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scroll_solid', 'Scroll', 68, true, '{"icon_name":"scroll","icon_prefix":"fas","icon_category":"general","unicode":"f70e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drum_solid', 'Drum', 71, true, '{"icon_name":"drum","icon_prefix":"fas","icon_category":"general","unicode":"f569"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scale-unbalanced-flip_solid', 'Scale Unbalanced Flip', 73, true, '{"icon_name":"scale-unbalanced-flip","icon_prefix":"fas","icon_category":"general","unicode":"f516"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_balance-scale-right_solid', 'Balance Scale Right', 74, true, '{"icon_name":"balance-scale-right","icon_prefix":"fas","icon_category":"general","unicode":"f516"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_baby_solid', 'Baby', 77, true, '{"icon_name":"baby","icon_prefix":"fas","icon_category":"general","unicode":"f77c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tent_solid', 'Tent', 80, true, '{"icon_name":"tent","icon_prefix":"fas","icon_category":"general","unicode":"e57d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_a_solid', 'A', 81, true, '{"icon_name":"a","icon_prefix":"fas","icon_category":"general","unicode":"41"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_parachute-box_solid', 'Parachute Box', 82, true, '{"icon_name":"parachute-box","icon_prefix":"fas","icon_category":"general","unicode":"f4cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_indian-rupee-sign_solid', 'Indian Rupee Sign', 89, true, '{"icon_name":"indian-rupee-sign","icon_prefix":"fas","icon_category":"general","unicode":"e1bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_indian-rupee_solid', 'Indian Rupee', 90, true, '{"icon_name":"indian-rupee","icon_prefix":"fas","icon_category":"general","unicode":"e1bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_inr_solid', 'Inr', 91, true, '{"icon_name":"inr","icon_prefix":"fas","icon_category":"general","unicode":"e1bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck_solid', 'Truck', 92, true, '{"icon_name":"truck","icon_prefix":"fas","icon_category":"general","unicode":"f0d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chalkboard-teacher_solid', 'Chalkboard Teacher', 94, true, '{"icon_name":"chalkboard-teacher","icon_prefix":"fas","icon_category":"general","unicode":"f51c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plant-wilt_solid', 'Plant Wilt', 97, true, '{"icon_name":"plant-wilt","icon_prefix":"fas","icon_category":"general","unicode":"e5aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_weight-scale_solid', 'Weight Scale', 98, true, '{"icon_name":"weight-scale","icon_prefix":"fas","icon_category":"general","unicode":"f496"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_weight_solid', 'Weight', 99, true, '{"icon_name":"weight","icon_prefix":"fas","icon_category":"general","unicode":"f496"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_florin-sign_solid', 'Florin Sign', 101, true, '{"icon_name":"florin-sign","icon_prefix":"fas","icon_category":"general","unicode":"e184"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lari-sign_solid', 'Lari Sign', 103, true, '{"icon_name":"lari-sign","icon_prefix":"fas","icon_category":"general","unicode":"e1c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mill-sign_solid', 'Mill Sign', 104, true, '{"icon_name":"mill-sign","icon_prefix":"fas","icon_category":"general","unicode":"e1ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-snowboarding_solid', 'Person Snowboarding', 105, true, '{"icon_name":"person-snowboarding","icon_prefix":"fas","icon_category":"general","unicode":"f7ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snowboarding_solid', 'Snowboarding', 106, true, '{"icon_name":"snowboarding","icon_prefix":"fas","icon_category":"general","unicode":"f7ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tty_solid', 'Tty', 107, true, '{"icon_name":"tty","icon_prefix":"fas","icon_category":"general","unicode":"f1e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_teletype_solid', 'Teletype', 108, true, '{"icon_name":"teletype","icon_prefix":"fas","icon_category":"general","unicode":"f1e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile_solid', 'Mobile', 110, true, '{"icon_name":"mobile","icon_prefix":"fas","icon_category":"general","unicode":"f3ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-android_solid', 'Mobile Android', 111, true, '{"icon_name":"mobile-android","icon_prefix":"fas","icon_category":"general","unicode":"f3ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-turn-to-dots_solid', 'Arrows Turn To Dots', 113, true, '{"icon_name":"arrows-turn-to-dots","icon_prefix":"fas","icon_category":"general","unicode":"e4c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_church_solid', 'Church', 115, true, '{"icon_name":"church","icon_prefix":"fas","icon_category":"general","unicode":"f51d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toggle-off_solid', 'Toggle Off', 116, true, '{"icon_name":"toggle-off","icon_prefix":"fas","icon_category":"general","unicode":"f204"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shoe-prints_solid', 'Shoe Prints', 117, true, '{"icon_name":"shoe-prints","icon_prefix":"fas","icon_category":"general","unicode":"f54b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_message_solid', 'Message', 120, true, '{"icon_name":"message","icon_prefix":"fas","icon_category":"general","unicode":"f27a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trophy_solid', 'Trophy', 122, true, '{"icon_name":"trophy","icon_prefix":"fas","icon_category":"general","unicode":"f091"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-dizzy_solid', 'Face Dizzy', 123, true, '{"icon_name":"face-dizzy","icon_prefix":"fas","icon_category":"general","unicode":"f567"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dizzy_solid', 'Dizzy', 124, true, '{"icon_name":"dizzy","icon_prefix":"fas","icon_category":"general","unicode":"f567"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bacteria_solid', 'Bacteria', 125, true, '{"icon_name":"bacteria","icon_prefix":"fas","icon_category":"general","unicode":"e059"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ear-deaf_solid', 'Ear Deaf', 126, true, '{"icon_name":"ear-deaf","icon_prefix":"fas","icon_category":"general","unicode":"f2a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_deaf_solid', 'Deaf', 127, true, '{"icon_name":"deaf","icon_prefix":"fas","icon_category":"general","unicode":"f2a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_deafness_solid', 'Deafness', 128, true, '{"icon_name":"deafness","icon_prefix":"fas","icon_category":"general","unicode":"f2a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hard-of-hearing_solid', 'Hard Of Hearing', 129, true, '{"icon_name":"hard-of-hearing","icon_prefix":"fas","icon_category":"general","unicode":"f2a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-arrows_solid', 'People Arrows', 130, true, '{"icon_name":"people-arrows","icon_prefix":"fas","icon_category":"general","unicode":"e068"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-arrows-left-right_solid', 'People Arrows Left Right', 131, true, '{"icon_name":"people-arrows-left-right","icon_prefix":"fas","icon_category":"general","unicode":"e068"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-clapping_solid', 'Hands Clapping', 132, true, '{"icon_name":"hands-clapping","icon_prefix":"fas","icon_category":"general","unicode":"e1a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_virus-covid-slash_solid', 'Virus Covid Slash', 133, true, '{"icon_name":"virus-covid-slash","icon_prefix":"fas","icon_category":"general","unicode":"e4a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diamond-turn-right_solid', 'Diamond Turn Right', 136, true, '{"icon_name":"diamond-turn-right","icon_prefix":"fas","icon_category":"general","unicode":"f5eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_directions_solid', 'Directions', 137, true, '{"icon_name":"directions","icon_prefix":"fas","icon_category":"general","unicode":"f5eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-up_solid', 'Hand Point Up', 138, true, '{"icon_name":"hand-point-up","icon_prefix":"fas","icon_category":"general","unicode":"f0a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bezier-curve_solid', 'Bezier Curve', 139, true, '{"icon_name":"bezier-curve","icon_prefix":"fas","icon_category":"general","unicode":"f55b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-half-dress_solid', 'Person Half Dress', 140, true, '{"icon_name":"person-half-dress","icon_prefix":"fas","icon_category":"general","unicode":"e548"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_poll-h_solid', 'Poll H', 142, true, '{"icon_name":"poll-h","icon_prefix":"fas","icon_category":"general","unicode":"f682"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-lizard_solid', 'Hand Lizard', 144, true, '{"icon_name":"hand-lizard","icon_prefix":"fas","icon_category":"general","unicode":"f258"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chalkboard_solid', 'Chalkboard', 145, true, '{"icon_name":"chalkboard","icon_prefix":"fas","icon_category":"general","unicode":"f51b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blackboard_solid', 'Blackboard', 146, true, '{"icon_name":"blackboard","icon_prefix":"fas","icon_category":"general","unicode":"f51b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_external-link-alt_solid', 'External Link Alt', 148, true, '{"icon_name":"external-link-alt","icon_prefix":"fas","icon_category":"general","unicode":"f35d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clover_solid', 'Clover', 150, true, '{"icon_name":"clover","icon_prefix":"fas","icon_category":"general","unicode":"e139"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_teeth-open_solid', 'Teeth Open', 151, true, '{"icon_name":"teeth-open","icon_prefix":"fas","icon_category":"general","unicode":"f62f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reorder_solid', 'Reorder', 153, true, '{"icon_name":"reorder","icon_prefix":"fas","icon_category":"general","unicode":"f550"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stream_solid', 'Stream', 154, true, '{"icon_name":"stream","icon_prefix":"fas","icon_category":"general","unicode":"f550"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_warehouse_solid', 'Warehouse', 155, true, '{"icon_name":"warehouse","icon_prefix":"fas","icon_category":"general","unicode":"f494"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_campground_solid', 'Campground', 157, true, '{"icon_name":"campground","icon_prefix":"fas","icon_category":"general","unicode":"f6bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glasses_solid', 'Glasses', 159, true, '{"icon_name":"glasses","icon_prefix":"fas","icon_category":"general","unicode":"f530"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_memory_solid', 'Memory', 162, true, '{"icon_name":"memory","icon_prefix":"fas","icon_category":"general","unicode":"f538"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gift_solid', 'Gift', 163, true, '{"icon_name":"gift","icon_prefix":"fas","icon_category":"general","unicode":"f06b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dungeon_solid', 'Dungeon', 165, true, '{"icon_name":"dungeon","icon_prefix":"fas","icon_category":"general","unicode":"f6d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_suitcase-medical_solid', 'Suitcase Medical', 166, true, '{"icon_name":"suitcase-medical","icon_prefix":"fas","icon_category":"general","unicode":"f0fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_medkit_solid', 'Medkit', 167, true, '{"icon_name":"medkit","icon_prefix":"fas","icon_category":"general","unicode":"f0fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-cane_solid', 'Person Cane', 168, true, '{"icon_name":"person-cane","icon_prefix":"fas","icon_category":"general","unicode":"e53c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gauge_solid', 'Gauge', 169, true, '{"icon_name":"gauge","icon_prefix":"fas","icon_category":"general","unicode":"f624"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dashboard_solid', 'Dashboard', 170, true, '{"icon_name":"dashboard","icon_prefix":"fas","icon_category":"general","unicode":"f624"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gauge-med_solid', 'Gauge Med', 171, true, '{"icon_name":"gauge-med","icon_prefix":"fas","icon_category":"general","unicode":"f624"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toolbox_solid', 'Toolbox', 174, true, '{"icon_name":"toolbox","icon_prefix":"fas","icon_category":"general","unicode":"f552"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_power-off_solid', 'Power Off', 175, true, '{"icon_name":"power-off","icon_prefix":"fas","icon_category":"general","unicode":"f011"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signal_solid', 'Signal', 176, true, '{"icon_name":"signal","icon_prefix":"fas","icon_category":"general","unicode":"f012"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signal5_solid', 'Signal5', 177, true, '{"icon_name":"signal5","icon_prefix":"fas","icon_category":"general","unicode":"f012"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signal-perfect_solid', 'Signal Perfect', 178, true, '{"icon_name":"signal-perfect","icon_prefix":"fas","icon_category":"general","unicode":"f012"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-spin_solid', 'Arrows Spin', 179, true, '{"icon_name":"arrows-spin","icon_prefix":"fas","icon_category":"general","unicode":"e4bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_joint_solid', 'Joint', 180, true, '{"icon_name":"joint","icon_prefix":"fas","icon_category":"general","unicode":"f595"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_braille_solid', 'Braille', 181, true, '{"icon_name":"braille","icon_prefix":"fas","icon_category":"general","unicode":"f2a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_basket-shopping_solid', 'Basket Shopping', 182, true, '{"icon_name":"basket-shopping","icon_prefix":"fas","icon_category":"general","unicode":"f291"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shopping-basket_solid', 'Shopping Basket', 183, true, '{"icon_name":"shopping-basket","icon_prefix":"fas","icon_category":"general","unicode":"f291"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bridge_solid', 'Bridge', 184, true, '{"icon_name":"bridge","icon_prefix":"fas","icon_category":"general","unicode":"e4c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cash-register_solid', 'Cash Register', 186, true, '{"icon_name":"cash-register","icon_prefix":"fas","icon_category":"general","unicode":"f788"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ring_solid', 'Ring', 187, true, '{"icon_name":"ring","icon_prefix":"fas","icon_category":"general","unicode":"f70b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_binoculars_solid', 'Binoculars', 191, true, '{"icon_name":"binoculars","icon_prefix":"fas","icon_category":"general","unicode":"f1e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kip-sign_solid', 'Kip Sign', 192, true, '{"icon_name":"kip-sign","icon_prefix":"fas","icon_category":"general","unicode":"e1c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hard-drive_solid', 'Hard Drive', 193, true, '{"icon_name":"hard-drive","icon_prefix":"fas","icon_category":"general","unicode":"f0a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hdd_solid', 'Hdd', 194, true, '{"icon_name":"hdd","icon_prefix":"fas","icon_category":"general","unicode":"f0a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ellipsis_solid', 'Ellipsis', 197, true, '{"icon_name":"ellipsis","icon_prefix":"fas","icon_category":"general","unicode":"f141"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ellipsis-h_solid', 'Ellipsis H', 198, true, '{"icon_name":"ellipsis-h","icon_prefix":"fas","icon_category":"general","unicode":"f141"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_store-slash_solid', 'Store Slash', 199, true, '{"icon_name":"store-slash","icon_prefix":"fas","icon_category":"general","unicode":"e071"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_percent_solid', 'Percent', 200, true, '{"icon_name":"percent","icon_prefix":"fas","icon_category":"general","unicode":"25"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_percentage_solid', 'Percentage', 201, true, '{"icon_name":"percentage","icon_prefix":"fas","icon_category":"general","unicode":"25"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_icons_solid', 'Icons', 205, true, '{"icon_name":"icons","icon_prefix":"fas","icon_category":"general","unicode":"f86d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ruler-vertical_solid', 'Ruler Vertical', 207, true, '{"icon_name":"ruler-vertical","icon_prefix":"fas","icon_category":"general","unicode":"f548"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cow_solid', 'Cow', 212, true, '{"icon_name":"cow","icon_prefix":"fas","icon_category":"general","unicode":"f6c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rss_solid', 'Rss', 213, true, '{"icon_name":"rss","icon_prefix":"fas","icon_category":"general","unicode":"f09e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_feed_solid', 'Feed', 214, true, '{"icon_name":"feed","icon_prefix":"fas","icon_category":"general","unicode":"f09e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass_solid', 'Magnifying Glass', 215, true, '{"icon_name":"magnifying-glass","icon_prefix":"fas","icon_category":"general","unicode":"f002"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_boxes-stacked_solid', 'Boxes Stacked', 218, true, '{"icon_name":"boxes-stacked","icon_prefix":"fas","icon_category":"general","unicode":"f468"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_boxes_solid', 'Boxes', 219, true, '{"icon_name":"boxes","icon_prefix":"fas","icon_category":"general","unicode":"f468"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_boxes-alt_solid', 'Boxes Alt', 220, true, '{"icon_name":"boxes-alt","icon_prefix":"fas","icon_category":"general","unicode":"f468"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code-branch_solid', 'Code Branch', 221, true, '{"icon_name":"code-branch","icon_prefix":"fas","icon_category":"general","unicode":"f126"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cancel_solid', 'Cancel', 223, true, '{"icon_name":"cancel","icon_prefix":"fas","icon_category":"general","unicode":"f05e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jug-detergent_solid', 'Jug Detergent', 224, true, '{"icon_name":"jug-detergent","icon_prefix":"fas","icon_category":"general","unicode":"e519"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reply_solid', 'Reply', 225, true, '{"icon_name":"reply","icon_prefix":"fas","icon_category":"general","unicode":"f3e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mail-reply_solid', 'Mail Reply', 226, true, '{"icon_name":"mail-reply","icon_prefix":"fas","icon_category":"general","unicode":"f3e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bacterium_solid', 'Bacterium', 228, true, '{"icon_name":"bacterium","icon_prefix":"fas","icon_category":"general","unicode":"e05a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_record-vinyl_solid', 'Record Vinyl', 229, true, '{"icon_name":"record-vinyl","icon_prefix":"fas","icon_category":"general","unicode":"f8d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_floppy-disk_solid', 'Floppy Disk', 230, true, '{"icon_name":"floppy-disk","icon_prefix":"fas","icon_category":"general","unicode":"f0c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_save_solid', 'Save', 231, true, '{"icon_name":"save","icon_prefix":"fas","icon_category":"general","unicode":"f0c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilets-portable_solid', 'Toilets Portable', 232, true, '{"icon_name":"toilets-portable","icon_prefix":"fas","icon_category":"general","unicode":"e584"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_o_solid', 'O', 233, true, '{"icon_name":"o","icon_prefix":"fas","icon_category":"general","unicode":"4f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_palette_solid', 'Palette', 234, true, '{"icon_name":"palette","icon_prefix":"fas","icon_category":"general","unicode":"f53f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ear-listen_solid', 'Ear Listen', 236, true, '{"icon_name":"ear-listen","icon_prefix":"fas","icon_category":"general","unicode":"f2a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_assistive-listening-systems_solid', 'Assistive Listening Systems', 237, true, '{"icon_name":"assistive-listening-systems","icon_prefix":"fas","icon_category":"general","unicode":"f2a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code-pull-request_solid', 'Code Pull Request', 238, true, '{"icon_name":"code-pull-request","icon_prefix":"fas","icon_category":"general","unicode":"e13c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skull_solid', 'Skull', 240, true, '{"icon_name":"skull","icon_prefix":"fas","icon_category":"general","unicode":"f54c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-stroke-up_solid', 'Mars Stroke Up', 241, true, '{"icon_name":"mars-stroke-up","icon_prefix":"fas","icon_category":"general","unicode":"f22a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-stroke-v_solid', 'Mars Stroke V', 242, true, '{"icon_name":"mars-stroke-v","icon_prefix":"fas","icon_category":"general","unicode":"f22a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fire-flame-simple_solid', 'Fire Flame Simple', 243, true, '{"icon_name":"fire-flame-simple","icon_prefix":"fas","icon_category":"general","unicode":"f46a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_burn_solid', 'Burn', 244, true, '{"icon_name":"burn","icon_prefix":"fas","icon_category":"general","unicode":"f46a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tree_solid', 'Tree', 245, true, '{"icon_name":"tree","icon_prefix":"fas","icon_category":"general","unicode":"f1bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smog_solid', 'Smog', 246, true, '{"icon_name":"smog","icon_prefix":"fas","icon_category":"general","unicode":"f75f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_s_solid', 'S', 247, true, '{"icon_name":"s","icon_prefix":"fas","icon_category":"general","unicode":"53"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jedi_solid', 'Jedi', 248, true, '{"icon_name":"jedi","icon_prefix":"fas","icon_category":"general","unicode":"f669"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-hiking_solid', 'Person Hiking', 249, true, '{"icon_name":"person-hiking","icon_prefix":"fas","icon_category":"general","unicode":"f6ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hiking_solid', 'Hiking', 250, true, '{"icon_name":"hiking","icon_prefix":"fas","icon_category":"general","unicode":"f6ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-up-to-line_solid', 'Arrows Up To Line', 251, true, '{"icon_name":"arrows-up-to-line","icon_prefix":"fas","icon_category":"general","unicode":"e4c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-double_solid', 'Mars Double', 252, true, '{"icon_name":"mars-double","icon_prefix":"fas","icon_category":"general","unicode":"f227"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer_solid', 'Thermometer', 253, true, '{"icon_name":"thermometer","icon_prefix":"fas","icon_category":"general","unicode":"f491"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paintbrush_solid', 'Paintbrush', 254, true, '{"icon_name":"paintbrush","icon_prefix":"fas","icon_category":"general","unicode":"f1fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paint-brush_solid', 'Paint Brush', 255, true, '{"icon_name":"paint-brush","icon_prefix":"fas","icon_category":"general","unicode":"f1fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_neuter_solid', 'Neuter', 256, true, '{"icon_name":"neuter","icon_prefix":"fas","icon_category":"general","unicode":"f22c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tongue-squint_solid', 'Face Grin Tongue Squint', 259, true, '{"icon_name":"face-grin-tongue-squint","icon_prefix":"fas","icon_category":"general","unicode":"f58a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tongue-squint_solid', 'Grin Tongue Squint', 260, true, '{"icon_name":"grin-tongue-squint","icon_prefix":"fas","icon_category":"general","unicode":"f58a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hippo_solid', 'Hippo', 262, true, '{"icon_name":"hippo","icon_prefix":"fas","icon_category":"general","unicode":"f6ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bowl-food_solid', 'Bowl Food', 263, true, '{"icon_name":"bowl-food","icon_prefix":"fas","icon_category":"general","unicode":"e4c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_door-open_solid', 'Door Open', 270, true, '{"icon_name":"door-open","icon_prefix":"fas","icon_category":"general","unicode":"f52b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_align-left_solid', 'Align Left', 271, true, '{"icon_name":"align-left","icon_prefix":"fas","icon_category":"general","unicode":"f036"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rainbow_solid', 'Rainbow', 275, true, '{"icon_name":"rainbow","icon_prefix":"fas","icon_category":"general","unicode":"f75b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-up_solid', 'Sort Up', 279, true, '{"icon_name":"sort-up","icon_prefix":"fas","icon_category":"general","unicode":"f0de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-asc_solid', 'Sort Asc', 280, true, '{"icon_name":"sort-asc","icon_prefix":"fas","icon_category":"general","unicode":"f0de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_apple-whole_solid', 'Apple Whole', 283, true, '{"icon_name":"apple-whole","icon_prefix":"fas","icon_category":"general","unicode":"f5d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_apple-alt_solid', 'Apple Alt', 284, true, '{"icon_name":"apple-alt","icon_prefix":"fas","icon_category":"general","unicode":"f5d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scroll-torah_solid', 'Scroll Torah', 285, true, '{"icon_name":"scroll-torah","icon_prefix":"fas","icon_category":"general","unicode":"f6a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_torah_solid', 'Torah', 286, true, '{"icon_name":"torah","icon_prefix":"fas","icon_category":"general","unicode":"f6a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-left-right-to-line_solid', 'Arrows Left Right To Line', 288, true, '{"icon_name":"arrows-left-right-to-line","icon_prefix":"fas","icon_category":"general","unicode":"e4ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash_solid', 'Trash', 289, true, '{"icon_name":"trash","icon_prefix":"fas","icon_category":"general","unicode":"f1f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-sad-tear_solid', 'Face Sad Tear', 290, true, '{"icon_name":"face-sad-tear","icon_prefix":"fas","icon_category":"general","unicode":"f5b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sad-tear_solid', 'Sad Tear', 291, true, '{"icon_name":"sad-tear","icon_prefix":"fas","icon_category":"general","unicode":"f5b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fax_solid', 'Fax', 292, true, '{"icon_name":"fax","icon_prefix":"fas","icon_category":"general","unicode":"f1ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hamsa_solid', 'Hamsa', 294, true, '{"icon_name":"hamsa","icon_prefix":"fas","icon_category":"general","unicode":"f665"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_receipt_solid', 'Receipt', 299, true, '{"icon_name":"receipt","icon_prefix":"fas","icon_category":"general","unicode":"f543"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_equals_solid', 'Equals', 300, true, '{"icon_name":"equals","icon_prefix":"fas","icon_category":"general","unicode":"3d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_virus-slash_solid', 'Virus Slash', 302, true, '{"icon_name":"virus-slash","icon_prefix":"fas","icon_category":"general","unicode":"e075"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_slash_solid', 'Slash', 303, true, '{"icon_name":"slash","icon_prefix":"fas","icon_category":"general","unicode":"f715"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_expand_solid', 'Expand', 304, true, '{"icon_name":"expand","icon_prefix":"fas","icon_category":"general","unicode":"f065"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_note-sticky_solid', 'Note Sticky', 305, true, '{"icon_name":"note-sticky","icon_prefix":"fas","icon_category":"general","unicode":"f249"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sticky-note_solid', 'Sticky Note', 306, true, '{"icon_name":"sticky-note","icon_prefix":"fas","icon_category":"general","unicode":"f249"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-columns_solid', 'Table Columns', 307, true, '{"icon_name":"table-columns","icon_prefix":"fas","icon_category":"general","unicode":"f0db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_columns_solid', 'Columns', 308, true, '{"icon_name":"columns","icon_prefix":"fas","icon_category":"general","unicode":"f0db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-shelter_solid', 'Person Shelter', 309, true, '{"icon_name":"person-shelter","icon_prefix":"fas","icon_category":"general","unicode":"e54f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_delete-left_solid', 'Delete Left', 312, true, '{"icon_name":"delete-left","icon_prefix":"fas","icon_category":"general","unicode":"f55a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_backspace_solid', 'Backspace', 313, true, '{"icon_name":"backspace","icon_prefix":"fas","icon_category":"general","unicode":"f55a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_broom-ball_solid', 'Broom Ball', 314, true, '{"icon_name":"broom-ball","icon_prefix":"fas","icon_category":"general","unicode":"f458"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quidditch_solid', 'Quidditch', 315, true, '{"icon_name":"quidditch","icon_prefix":"fas","icon_category":"general","unicode":"f458"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quidditch-broom-ball_solid', 'Quidditch Broom Ball', 316, true, '{"icon_name":"quidditch-broom-ball","icon_prefix":"fas","icon_category":"general","unicode":"f458"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_j_solid', 'J', 317, true, '{"icon_name":"j","icon_prefix":"fas","icon_category":"general","unicode":"4a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shuttle-space_solid', 'Shuttle Space', 318, true, '{"icon_name":"shuttle-space","icon_prefix":"fas","icon_category":"general","unicode":"f197"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_space-shuttle_solid', 'Space Shuttle', 319, true, '{"icon_name":"space-shuttle","icon_prefix":"fas","icon_category":"general","unicode":"f197"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yin-yang_solid', 'Yin Yang', 320, true, '{"icon_name":"yin-yang","icon_prefix":"fas","icon_category":"general","unicode":"f6ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trowel_solid', 'Trowel', 322, true, '{"icon_name":"trowel","icon_prefix":"fas","icon_category":"general","unicode":"e589"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-back-fist_solid', 'Hand Back Fist', 323, true, '{"icon_name":"hand-back-fist","icon_prefix":"fas","icon_category":"general","unicode":"f255"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-rock_solid', 'Hand Rock', 324, true, '{"icon_name":"hand-rock","icon_prefix":"fas","icon_category":"general","unicode":"f255"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crutch_solid', 'Crutch', 327, true, '{"icon_name":"crutch","icon_prefix":"fas","icon_category":"general","unicode":"f7f7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_septagon_solid', 'Septagon', 328, true, '{"icon_name":"septagon","icon_prefix":"fas","icon_category":"general","unicode":"e820"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heptagon_solid', 'Heptagon', 329, true, '{"icon_name":"heptagon","icon_prefix":"fas","icon_category":"general","unicode":"e820"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_street-view_solid', 'Street View', 330, true, '{"icon_name":"street-view","icon_prefix":"fas","icon_category":"general","unicode":"f21d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tractor_solid', 'Tractor', 334, true, '{"icon_name":"tractor","icon_prefix":"fas","icon_category":"general","unicode":"f722"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vials_solid', 'Vials', 336, true, '{"icon_name":"vials","icon_prefix":"fas","icon_category":"general","unicode":"f493"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stethoscope_solid', 'Stethoscope', 337, true, '{"icon_name":"stethoscope","icon_prefix":"fas","icon_category":"general","unicode":"f0f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_podcast_solid', 'Podcast', 338, true, '{"icon_name":"podcast","icon_prefix":"fas","icon_category":"general","unicode":"f2ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-queen_solid', 'Chess Queen', 340, true, '{"icon_name":"chess-queen","icon_prefix":"fas","icon_category":"general","unicode":"f445"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ellipsis-vertical_solid', 'Ellipsis Vertical', 342, true, '{"icon_name":"ellipsis-vertical","icon_prefix":"fas","icon_category":"general","unicode":"f142"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ellipsis-v_solid', 'Ellipsis V', 343, true, '{"icon_name":"ellipsis-v","icon_prefix":"fas","icon_category":"general","unicode":"f142"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_not-equal_solid', 'Not Equal', 347, true, '{"icon_name":"not-equal","icon_prefix":"fas","icon_category":"general","unicode":"f53e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_right-to-bracket_solid', 'Right To Bracket', 350, true, '{"icon_name":"right-to-bracket","icon_prefix":"fas","icon_category":"general","unicode":"f2f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign-in-alt_solid', 'Sign In Alt', 351, true, '{"icon_name":"sign-in-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shekel-sign_solid', 'Shekel Sign', 354, true, '{"icon_name":"shekel-sign","icon_prefix":"fas","icon_category":"general","unicode":"f20b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ils_solid', 'Ils', 355, true, '{"icon_name":"ils","icon_prefix":"fas","icon_category":"general","unicode":"f20b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shekel_solid', 'Shekel', 356, true, '{"icon_name":"shekel","icon_prefix":"fas","icon_category":"general","unicode":"f20b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sheqel_solid', 'Sheqel', 357, true, '{"icon_name":"sheqel","icon_prefix":"fas","icon_category":"general","unicode":"f20b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sheqel-sign_solid', 'Sheqel Sign', 358, true, '{"icon_name":"sheqel-sign","icon_prefix":"fas","icon_category":"general","unicode":"f20b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_radio_solid', 'Radio', 359, true, '{"icon_name":"radio","icon_prefix":"fas","icon_category":"general","unicode":"f8d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-dots_solid', 'Hand Dots', 360, true, '{"icon_name":"hand-dots","icon_prefix":"fas","icon_category":"general","unicode":"f461"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_allergies_solid', 'Allergies', 361, true, '{"icon_name":"allergies","icon_prefix":"fas","icon_category":"general","unicode":"f461"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-skull_solid', 'Book Skull', 362, true, '{"icon_name":"book-skull","icon_prefix":"fas","icon_category":"general","unicode":"f6b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-dead_solid', 'Book Dead', 363, true, '{"icon_name":"book-dead","icon_prefix":"fas","icon_category":"general","unicode":"f6b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tears_solid', 'Face Grin Tears', 368, true, '{"icon_name":"face-grin-tears","icon_prefix":"fas","icon_category":"general","unicode":"f588"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tears_solid', 'Grin Tears', 369, true, '{"icon_name":"grin-tears","icon_prefix":"fas","icon_category":"general","unicode":"f588"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_edit_solid', 'Edit', 371, true, '{"icon_name":"edit","icon_prefix":"fas","icon_category":"general","unicode":"f044"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth-europe_solid', 'Earth Europe', 372, true, '{"icon_name":"earth-europe","icon_prefix":"fas","icon_category":"general","unicode":"f7a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_adjust_solid', 'Adjust', 377, true, '{"icon_name":"adjust","icon_prefix":"fas","icon_category":"general","unicode":"f042"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-military-to-person_solid', 'Person Military To Person', 378, true, '{"icon_name":"person-military-to-person","icon_prefix":"fas","icon_category":"general","unicode":"e54c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-field-un_solid', 'Truck Field Un', 380, true, '{"icon_name":"truck-field-un","icon_prefix":"fas","icon_category":"general","unicode":"e58e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book_solid', 'Book', 383, true, '{"icon_name":"book","icon_prefix":"fas","icon_category":"general","unicode":"f02d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh-wink_solid', 'Face Laugh Wink', 384, true, '{"icon_name":"face-laugh-wink","icon_prefix":"fas","icon_category":"general","unicode":"f59c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh-wink_solid', 'Laugh Wink', 385, true, '{"icon_name":"laugh-wink","icon_prefix":"fas","icon_category":"general","unicode":"f59c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-area_solid', 'Chart Area', 387, true, '{"icon_name":"chart-area","icon_prefix":"fas","icon_category":"general","unicode":"f1fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_area-chart_solid', 'Area Chart', 388, true, '{"icon_name":"area-chart","icon_prefix":"fas","icon_category":"general","unicode":"f1fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rupiah-sign_solid', 'Rupiah Sign', 389, true, '{"icon_name":"rupiah-sign","icon_prefix":"fas","icon_category":"general","unicode":"e23d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_text-width_solid', 'Text Width', 390, true, '{"icon_name":"text-width","icon_prefix":"fas","icon_category":"general","unicode":"f035"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass-minus_solid', 'Magnifying Glass Minus', 392, true, '{"icon_name":"magnifying-glass-minus","icon_prefix":"fas","icon_category":"general","unicode":"f010"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-group_solid', 'People Group', 394, true, '{"icon_name":"people-group","icon_prefix":"fas","icon_category":"general","unicode":"e533"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-asl-interpreting_solid', 'Hands Asl Interpreting', 399, true, '{"icon_name":"hands-asl-interpreting","icon_prefix":"fas","icon_category":"general","unicode":"f2a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_american-sign-language-interpreting_solid', 'American Sign Language Interpreting', 400, true, '{"icon_name":"american-sign-language-interpreting","icon_prefix":"fas","icon_category":"general","unicode":"f2a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_asl-interpreting_solid', 'Asl Interpreting', 401, true, '{"icon_name":"asl-interpreting","icon_prefix":"fas","icon_category":"general","unicode":"f2a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-american-sign-language-interpreting_solid', 'Hands American Sign Language Interpreting', 402, true, '{"icon_name":"hands-american-sign-language-interpreting","icon_prefix":"fas","icon_category":"general","unicode":"f2a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rocket_solid', 'Rocket', 404, true, '{"icon_name":"rocket","icon_prefix":"fas","icon_category":"general","unicode":"f135"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shrimp_solid', 'Shrimp', 405, true, '{"icon_name":"shrimp","icon_prefix":"fas","icon_category":"general","unicode":"e448"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tenge-sign_solid', 'Tenge Sign', 406, true, '{"icon_name":"tenge-sign","icon_prefix":"fas","icon_category":"general","unicode":"f7d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tenge_solid', 'Tenge', 407, true, '{"icon_name":"tenge","icon_prefix":"fas","icon_category":"general","unicode":"f7d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-chimney-medical_solid', 'House Chimney Medical', 408, true, '{"icon_name":"house-chimney-medical","icon_prefix":"fas","icon_category":"general","unicode":"f7f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clinic-medical_solid', 'Clinic Medical', 409, true, '{"icon_name":"clinic-medical","icon_prefix":"fas","icon_category":"general","unicode":"f7f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table_solid', 'Table', 414, true, '{"icon_name":"table","icon_prefix":"fas","icon_category":"general","unicode":"f0ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome_solid', 'Font Awesome', 420, true, '{"icon_name":"font-awesome","icon_prefix":"fas","icon_category":"general","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-flag_solid', 'Font Awesome Flag', 421, true, '{"icon_name":"font-awesome-flag","icon_prefix":"fas","icon_category":"general","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-logo-full_solid', 'Font Awesome Logo Full', 422, true, '{"icon_name":"font-awesome-logo-full","icon_prefix":"fas","icon_category":"general","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handcuffs_solid', 'Handcuffs', 423, true, '{"icon_name":"handcuffs","icon_prefix":"fas","icon_category":"general","unicode":"e4f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_industry_solid', 'Industry', 425, true, '{"icon_name":"industry","icon_prefix":"fas","icon_category":"general","unicode":"f275"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lines-leaning_solid', 'Lines Leaning', 426, true, '{"icon_name":"lines-leaning","icon_prefix":"fas","icon_category":"general","unicode":"e51e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_passport_solid', 'Passport', 427, true, '{"icon_name":"passport","icon_prefix":"fas","icon_category":"general","unicode":"f5ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_infinity_solid', 'Infinity', 428, true, '{"icon_name":"infinity","icon_prefix":"fas","icon_category":"general","unicode":"f534"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clone_solid', 'Clone', 429, true, '{"icon_name":"clone","icon_prefix":"fas","icon_category":"general","unicode":"f24d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_forward_solid', 'Forward', 430, true, '{"icon_name":"forward","icon_prefix":"fas","icon_category":"general","unicode":"f04e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_m_solid', 'M', 431, true, '{"icon_name":"m","icon_prefix":"fas","icon_category":"general","unicode":"4d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-spikes_solid', 'Road Spikes', 432, true, '{"icon_name":"road-spikes","icon_prefix":"fas","icon_category":"general","unicode":"e568"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mountain_solid', 'Mountain', 433, true, '{"icon_name":"mountain","icon_prefix":"fas","icon_category":"general","unicode":"f6fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess_solid', 'Chess', 434, true, '{"icon_name":"chess","icon_prefix":"fas","icon_category":"general","unicode":"f439"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer3_solid', 'Thermometer3', 437, true, '{"icon_name":"thermometer3","icon_prefix":"fas","icon_category":"general","unicode":"f2c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer-three-quarters_solid', 'Thermometer Three Quarters', 438, true, '{"icon_name":"thermometer-three-quarters","icon_prefix":"fas","icon_category":"general","unicode":"f2c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_b_solid', 'B', 439, true, '{"icon_name":"b","icon_prefix":"fas","icon_category":"general","unicode":"42"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-virus_solid', 'Shield Virus', 440, true, '{"icon_name":"shield-virus","icon_prefix":"fas","icon_category":"general","unicode":"e06c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_litecoin-sign_solid', 'Litecoin Sign', 441, true, '{"icon_name":"litecoin-sign","icon_prefix":"fas","icon_category":"general","unicode":"e1d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-d6_solid', 'Dice D6', 442, true, '{"icon_name":"dice-d6","icon_prefix":"fas","icon_category":"general","unicode":"f6d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grip-lines-vertical_solid', 'Grip Lines Vertical', 443, true, '{"icon_name":"grip-lines-vertical","icon_prefix":"fas","icon_category":"general","unicode":"f7a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_golf-ball-tee_solid', 'Golf Ball Tee', 444, true, '{"icon_name":"golf-ball-tee","icon_prefix":"fas","icon_category":"general","unicode":"f450"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_golf-ball_solid', 'Golf Ball', 445, true, '{"icon_name":"golf-ball","icon_prefix":"fas","icon_category":"general","unicode":"f450"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hexagon_solid', 'Hexagon', 446, true, '{"icon_name":"hexagon","icon_prefix":"fas","icon_category":"general","unicode":"f312"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kaaba_solid', 'Kaaba', 448, true, '{"icon_name":"kaaba","icon_prefix":"fas","icon_category":"general","unicode":"f66b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding_solid', 'Hand Holding', 449, true, '{"icon_name":"hand-holding","icon_prefix":"fas","icon_category":"general","unicode":"f4bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_single-quote-right_solid', 'Single Quote Right', 450, true, '{"icon_name":"single-quote-right","icon_prefix":"fas","icon_category":"general","unicode":"e81c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bottle-droplet_solid', 'Bottle Droplet', 451, true, '{"icon_name":"bottle-droplet","icon_prefix":"fas","icon_category":"general","unicode":"e4c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_egg_solid', 'Egg', 454, true, '{"icon_name":"egg","icon_prefix":"fas","icon_category":"general","unicode":"f7fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_landmark-dome_solid', 'Landmark Dome', 455, true, '{"icon_name":"landmark-dome","icon_prefix":"fas","icon_category":"general","unicode":"f752"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_landmark-alt_solid', 'Landmark Alt', 456, true, '{"icon_name":"landmark-alt","icon_prefix":"fas","icon_category":"general","unicode":"f752"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_worm_solid', 'Worm', 457, true, '{"icon_name":"worm","icon_prefix":"fas","icon_category":"general","unicode":"e599"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_strikethrough_solid', 'Strikethrough', 459, true, '{"icon_name":"strikethrough","icon_prefix":"fas","icon_category":"general","unicode":"f0cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blog_solid', 'Blog', 460, true, '{"icon_name":"blog","icon_prefix":"fas","icon_category":"general","unicode":"f781"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-pickup_solid', 'Truck Pickup', 462, true, '{"icon_name":"truck-pickup","icon_prefix":"fas","icon_category":"general","unicode":"f63c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_seedling_solid', 'Seedling', 463, true, '{"icon_name":"seedling","icon_prefix":"fas","icon_category":"general","unicode":"f4d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sprout_solid', 'Sprout', 464, true, '{"icon_name":"sprout","icon_prefix":"fas","icon_category":"general","unicode":"f4d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_transgender_solid', 'Transgender', 465, true, '{"icon_name":"transgender","icon_prefix":"fas","icon_category":"general","unicode":"f225"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_transgender-alt_solid', 'Transgender Alt', 466, true, '{"icon_name":"transgender-alt","icon_prefix":"fas","icon_category":"general","unicode":"f225"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_photo-film_solid', 'Photo Film', 468, true, '{"icon_name":"photo-film","icon_prefix":"fas","icon_category":"general","unicode":"f87c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pump-medical_solid', 'Pump Medical', 470, true, '{"icon_name":"pump-medical","icon_prefix":"fas","icon_category":"general","unicode":"e06a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fire_solid', 'Fire', 471, true, '{"icon_name":"fire","icon_prefix":"fas","icon_category":"general","unicode":"f06d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass-plus_solid', 'Magnifying Glass Plus', 472, true, '{"icon_name":"magnifying-glass-plus","icon_prefix":"fas","icon_category":"general","unicode":"f00e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flask_solid', 'Flask', 474, true, '{"icon_name":"flask","icon_prefix":"fas","icon_category":"general","unicode":"f0c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_align-right_solid', 'Align Right', 475, true, '{"icon_name":"align-right","icon_prefix":"fas","icon_category":"general","unicode":"f038"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tram_solid', 'Tram', 477, true, '{"icon_name":"tram","icon_prefix":"fas","icon_category":"general","unicode":"f7da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kit-medical_solid', 'Kit Medical', 478, true, '{"icon_name":"kit-medical","icon_prefix":"fas","icon_category":"general","unicode":"f479"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_first-aid_solid', 'First Aid', 479, true, '{"icon_name":"first-aid","icon_prefix":"fas","icon_category":"general","unicode":"f479"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grip-lines_solid', 'Grip Lines', 480, true, '{"icon_name":"grip-lines","icon_prefix":"fas","icon_category":"general","unicode":"f7a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_burger_solid', 'Burger', 481, true, '{"icon_name":"burger","icon_prefix":"fas","icon_category":"general","unicode":"f805"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hamburger_solid', 'Hamburger', 482, true, '{"icon_name":"hamburger","icon_prefix":"fas","icon_category":"general","unicode":"f805"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snowman_solid', 'Snowman', 483, true, '{"icon_name":"snowman","icon_prefix":"fas","icon_category":"general","unicode":"f7d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hotel_solid', 'Hotel', 484, true, '{"icon_name":"hotel","icon_prefix":"fas","icon_category":"general","unicode":"f594"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_print_solid', 'Print', 485, true, '{"icon_name":"print","icon_prefix":"fas","icon_category":"general","unicode":"f02f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volleyball_solid', 'Volleyball', 486, true, '{"icon_name":"volleyball","icon_prefix":"fas","icon_category":"general","unicode":"f45f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volleyball-ball_solid', 'Volleyball Ball', 487, true, '{"icon_name":"volleyball-ball","icon_prefix":"fas","icon_category":"general","unicode":"f45f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_traffic-light_solid', 'Traffic Light', 488, true, '{"icon_name":"traffic-light","icon_prefix":"fas","icon_category":"general","unicode":"f637"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_helicopter-symbol_solid', 'Helicopter Symbol', 493, true, '{"icon_name":"helicopter-symbol","icon_prefix":"fas","icon_category":"general","unicode":"e502"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-chimney-crack_solid', 'House Chimney Crack', 494, true, '{"icon_name":"house-chimney-crack","icon_prefix":"fas","icon_category":"general","unicode":"f6f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-damage_solid', 'House Damage', 495, true, '{"icon_name":"house-damage","icon_prefix":"fas","icon_category":"general","unicode":"f6f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-military-pointing_solid', 'Person Military Pointing', 496, true, '{"icon_name":"person-military-pointing","icon_prefix":"fas","icon_category":"general","unicode":"e54a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_newspaper_solid', 'Newspaper', 498, true, '{"icon_name":"newspaper","icon_prefix":"fas","icon_category":"general","unicode":"f1ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_maximize_solid', 'Maximize', 500, true, '{"icon_name":"maximize","icon_prefix":"fas","icon_category":"general","unicode":"f31e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_expand-arrows-alt_solid', 'Expand Arrows Alt', 501, true, '{"icon_name":"expand-arrows-alt","icon_prefix":"fas","icon_category":"general","unicode":"f31e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_city_solid', 'City', 503, true, '{"icon_name":"city","icon_prefix":"fas","icon_category":"general","unicode":"f64f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_x-ray_solid', 'X Ray', 504, true, '{"icon_name":"x-ray","icon_prefix":"fas","icon_category":"general","unicode":"f497"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_umbrella-beach_solid', 'Umbrella Beach', 505, true, '{"icon_name":"umbrella-beach","icon_prefix":"fas","icon_category":"general","unicode":"f5ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign-in_solid', 'Sign In', 507, true, '{"icon_name":"sign-in","icon_prefix":"fas","icon_category":"general","unicode":"f090"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headset_solid', 'Headset', 508, true, '{"icon_name":"headset","icon_prefix":"fas","icon_category":"general","unicode":"f590"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_splotch_solid', 'Splotch', 509, true, '{"icon_name":"splotch","icon_prefix":"fas","icon_category":"general","unicode":"f5bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_up-long_solid', 'Up Long', 510, true, '{"icon_name":"up-long","icon_prefix":"fas","icon_category":"general","unicode":"f30c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-alt-up_solid', 'Long Arrow Alt Up', 511, true, '{"icon_name":"long-arrow-alt-up","icon_prefix":"fas","icon_category":"general","unicode":"f30c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hexagon-nodes_solid', 'Hexagon Nodes', 512, true, '{"icon_name":"hexagon-nodes","icon_prefix":"fas","icon_category":"general","unicode":"e699"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital_solid', 'Hospital', 513, true, '{"icon_name":"hospital","icon_prefix":"fas","icon_category":"general","unicode":"f0f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital-alt_solid', 'Hospital Alt', 514, true, '{"icon_name":"hospital-alt","icon_prefix":"fas","icon_category":"general","unicode":"f0f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital-wide_solid', 'Hospital Wide', 515, true, '{"icon_name":"hospital-wide","icon_prefix":"fas","icon_category":"general","unicode":"f0f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-harassing_solid', 'Person Harassing', 516, true, '{"icon_name":"person-harassing","icon_prefix":"fas","icon_category":"general","unicode":"e549"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-trend-up_solid', 'Money Bill Trend Up', 517, true, '{"icon_name":"money-bill-trend-up","icon_prefix":"fas","icon_category":"general","unicode":"e529"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-ruler_solid', 'Pen Ruler', 518, true, '{"icon_name":"pen-ruler","icon_prefix":"fas","icon_category":"general","unicode":"f5ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pencil-ruler_solid', 'Pencil Ruler', 519, true, '{"icon_name":"pencil-ruler","icon_prefix":"fas","icon_category":"general","unicode":"f5ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bone_solid', 'Bone', 521, true, '{"icon_name":"bone","icon_prefix":"fas","icon_category":"general","unicode":"f5d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fire-flame-curved_solid', 'Fire Flame Curved', 522, true, '{"icon_name":"fire-flame-curved","icon_prefix":"fas","icon_category":"general","unicode":"f7e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fire-alt_solid', 'Fire Alt', 523, true, '{"icon_name":"fire-alt","icon_prefix":"fas","icon_category":"general","unicode":"f7e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bus-simple_solid', 'Bus Simple', 524, true, '{"icon_name":"bus-simple","icon_prefix":"fas","icon_category":"general","unicode":"f55e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bus-alt_solid', 'Bus Alt', 525, true, '{"icon_name":"bus-alt","icon_prefix":"fas","icon_category":"general","unicode":"f55e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_venus-mars_solid', 'Venus Mars', 526, true, '{"icon_name":"venus-mars","icon_prefix":"fas","icon_category":"general","unicode":"f228"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blender_solid', 'Blender', 527, true, '{"icon_name":"blender","icon_prefix":"fas","icon_category":"general","unicode":"f517"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_u_solid', 'U', 528, true, '{"icon_name":"u","icon_prefix":"fas","icon_category":"general","unicode":"55"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mail-forward_solid', 'Mail Forward', 530, true, '{"icon_name":"mail-forward","icon_prefix":"fas","icon_category":"general","unicode":"f064"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilet-portable_solid', 'Toilet Portable', 533, true, '{"icon_name":"toilet-portable","icon_prefix":"fas","icon_category":"general","unicode":"e583"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-pregnant_solid', 'Person Pregnant', 534, true, '{"icon_name":"person-pregnant","icon_prefix":"fas","icon_category":"general","unicode":"e31e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_less-than_solid', 'Less Than', 535, true, '{"icon_name":"less-than","icon_prefix":"fas","icon_category":"general","unicode":"3c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_superscript_solid', 'Superscript', 536, true, '{"icon_name":"superscript","icon_prefix":"fas","icon_category":"general","unicode":"f12b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-up-down_solid', 'Arrows Up Down', 539, true, '{"icon_name":"arrows-up-down","icon_prefix":"fas","icon_category":"general","unicode":"f07d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-v_solid', 'Arrows V', 540, true, '{"icon_name":"arrows-v","icon_prefix":"fas","icon_category":"general","unicode":"f07d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_poo-storm_solid', 'Poo Storm', 541, true, '{"icon_name":"poo-storm","icon_prefix":"fas","icon_category":"general","unicode":"f75a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-droplet_solid', 'Hand Holding Droplet', 547, true, '{"icon_name":"hand-holding-droplet","icon_prefix":"fas","icon_category":"general","unicode":"f4c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_won-sign_solid', 'Won Sign', 549, true, '{"icon_name":"won-sign","icon_prefix":"fas","icon_category":"general","unicode":"f159"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_krw_solid', 'Krw', 550, true, '{"icon_name":"krw","icon_prefix":"fas","icon_category":"general","unicode":"f159"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_won_solid', 'Won', 551, true, '{"icon_name":"won","icon_prefix":"fas","icon_category":"general","unicode":"f159"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_object-ungroup_solid', 'Object Ungroup', 552, true, '{"icon_name":"object-ungroup","icon_prefix":"fas","icon_category":"general","unicode":"f248"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hill-avalanche_solid', 'Hill Avalanche', 554, true, '{"icon_name":"hill-avalanche","icon_prefix":"fas","icon_category":"general","unicode":"e507"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snowplow_solid', 'Snowplow', 556, true, '{"icon_name":"snowplow","icon_prefix":"fas","icon_category":"general","unicode":"f7d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-gantt_solid', 'Chart Gantt', 557, true, '{"icon_name":"chart-gantt","icon_prefix":"fas","icon_category":"general","unicode":"e0e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-pawn_solid', 'Chess Pawn', 560, true, '{"icon_name":"chess-pawn","icon_prefix":"fas","icon_category":"general","unicode":"f443"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_synagogue_solid', 'Synagogue', 561, true, '{"icon_name":"synagogue","icon_prefix":"fas","icon_category":"general","unicode":"f69b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wheelchair-move_solid', 'Wheelchair Move', 564, true, '{"icon_name":"wheelchair-move","icon_prefix":"fas","icon_category":"general","unicode":"e2ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wheelchair-alt_solid', 'Wheelchair Alt', 565, true, '{"icon_name":"wheelchair-alt","icon_prefix":"fas","icon_category":"general","unicode":"e2ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bold_solid', 'Bold', 567, true, '{"icon_name":"bold","icon_prefix":"fas","icon_category":"general","unicode":"f032"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-bubbles_solid', 'Hands Bubbles', 572, true, '{"icon_name":"hands-bubbles","icon_prefix":"fas","icon_category":"general","unicode":"e05e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-wash_solid', 'Hands Wash', 573, true, '{"icon_name":"hands-wash","icon_prefix":"fas","icon_category":"general","unicode":"e05e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_marker_solid', 'Marker', 574, true, '{"icon_name":"marker","icon_prefix":"fas","icon_category":"general","unicode":"f5a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clipboard_solid', 'Clipboard', 575, true, '{"icon_name":"clipboard","icon_prefix":"fas","icon_category":"general","unicode":"f328"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cannabis_solid', 'Cannabis', 577, true, '{"icon_name":"cannabis","icon_prefix":"fas","icon_category":"general","unicode":"f55f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-roof_solid', 'People Roof', 578, true, '{"icon_name":"people-roof","icon_prefix":"fas","icon_category":"general","unicode":"e537"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_disease_solid', 'Disease', 579, true, '{"icon_name":"disease","icon_prefix":"fas","icon_category":"general","unicode":"f7fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-bible_solid', 'Book Bible', 580, true, '{"icon_name":"book-bible","icon_prefix":"fas","icon_category":"general","unicode":"f647"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bible_solid', 'Bible', 581, true, '{"icon_name":"bible","icon_prefix":"fas","icon_category":"general","unicode":"f647"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-board_solid', 'Chess Board', 582, true, '{"icon_name":"chess-board","icon_prefix":"fas","icon_category":"general","unicode":"f43c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars_solid', 'Mars', 583, true, '{"icon_name":"mars","icon_prefix":"fas","icon_category":"general","unicode":"f222"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laptop_solid', 'Laptop', 584, true, '{"icon_name":"laptop","icon_prefix":"fas","icon_category":"general","unicode":"f109"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flag-usa_solid', 'Flag Usa', 587, true, '{"icon_name":"flag-usa","icon_prefix":"fas","icon_category":"general","unicode":"f74d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-middle-finger_solid', 'Hand Middle Finger', 588, true, '{"icon_name":"hand-middle-finger","icon_prefix":"fas","icon_category":"general","unicode":"f806"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mortar-pestle_solid', 'Mortar Pestle', 589, true, '{"icon_name":"mortar-pestle","icon_prefix":"fas","icon_category":"general","unicode":"f5a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_head-side-cough_solid', 'Head Side Cough', 590, true, '{"icon_name":"head-side-cough","icon_prefix":"fas","icon_category":"general","unicode":"e061"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_franc-sign_solid', 'Franc Sign', 594, true, '{"icon_name":"franc-sign","icon_prefix":"fas","icon_category":"general","unicode":"e18f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_funnel-dollar_solid', 'Funnel Dollar', 596, true, '{"icon_name":"funnel-dollar","icon_prefix":"fas","icon_category":"general","unicode":"f662"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cheese_solid', 'Cheese', 597, true, '{"icon_name":"cheese","icon_prefix":"fas","icon_category":"general","unicode":"f7ef"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital-symbol_solid', 'Hospital Symbol', 599, true, '{"icon_name":"hospital-symbol","icon_prefix":"fas","icon_category":"general","unicode":"f47e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_school_solid', 'School', 600, true, '{"icon_name":"school","icon_prefix":"fas","icon_category":"general","unicode":"f549"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-five_solid', 'Dice Five', 601, true, '{"icon_name":"dice-five","icon_prefix":"fas","icon_category":"general","unicode":"f523"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tornado_solid', 'Tornado', 602, true, '{"icon_name":"tornado","icon_prefix":"fas","icon_category":"general","unicode":"f76f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jet-fighter_solid', 'Jet Fighter', 603, true, '{"icon_name":"jet-fighter","icon_prefix":"fas","icon_category":"general","unicode":"f0fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fighter-jet_solid', 'Fighter Jet', 604, true, '{"icon_name":"fighter-jet","icon_prefix":"fas","icon_category":"general","unicode":"f0fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_broom_solid', 'Broom', 606, true, '{"icon_name":"broom","icon_prefix":"fas","icon_category":"general","unicode":"f51a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_utensils_solid', 'Utensils', 609, true, '{"icon_name":"utensils","icon_prefix":"fas","icon_category":"general","unicode":"f2e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cutlery_solid', 'Cutlery', 610, true, '{"icon_name":"cutlery","icon_prefix":"fas","icon_category":"general","unicode":"f2e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_id-badge_solid', 'Id Badge', 611, true, '{"icon_name":"id-badge","icon_prefix":"fas","icon_category":"general","unicode":"f2c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spider_solid', 'Spider', 612, true, '{"icon_name":"spider","icon_prefix":"fas","icon_category":"general","unicode":"f717"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-retro_solid', 'Mobile Retro', 613, true, '{"icon_name":"mobile-retro","icon_prefix":"fas","icon_category":"general","unicode":"e527"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signs-post_solid', 'Signs Post', 614, true, '{"icon_name":"signs-post","icon_prefix":"fas","icon_category":"general","unicode":"f277"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-split-up-and-left_solid', 'Arrows Split Up And Left', 617, true, '{"icon_name":"arrows-split-up-and-left","icon_prefix":"fas","icon_category":"general","unicode":"e4bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fill-drip_solid', 'Fill Drip', 618, true, '{"icon_name":"fill-drip","icon_prefix":"fas","icon_category":"general","unicode":"f576"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-skiing-nordic_solid', 'Person Skiing Nordic', 620, true, '{"icon_name":"person-skiing-nordic","icon_prefix":"fas","icon_category":"general","unicode":"f7ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skiing-nordic_solid', 'Skiing Nordic', 621, true, '{"icon_name":"skiing-nordic","icon_prefix":"fas","icon_category":"general","unicode":"f7ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-bishop_solid', 'Chess Bishop', 626, true, '{"icon_name":"chess-bishop","icon_prefix":"fas","icon_category":"general","unicode":"f43a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_prescription-bottle-medical_solid', 'Prescription Bottle Medical', 627, true, '{"icon_name":"prescription-bottle-medical","icon_prefix":"fas","icon_category":"general","unicode":"f486"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_prescription-bottle-alt_solid', 'Prescription Bottle Alt', 628, true, '{"icon_name":"prescription-bottle-alt","icon_prefix":"fas","icon_category":"general","unicode":"f486"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_draw-polygon_solid', 'Draw Polygon', 629, true, '{"icon_name":"draw-polygon","icon_prefix":"fas","icon_category":"general","unicode":"f5ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vector-polygon_solid', 'Vector Polygon', 630, true, '{"icon_name":"vector-polygon","icon_prefix":"fas","icon_category":"general","unicode":"f5ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_i-cursor_solid', 'I Cursor', 631, true, '{"icon_name":"i-cursor","icon_prefix":"fas","icon_category":"general","unicode":"f246"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-dog_solid', 'Shield Dog', 633, true, '{"icon_name":"shield-dog","icon_prefix":"fas","icon_category":"general","unicode":"e573"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mound_solid', 'Mound', 636, true, '{"icon_name":"mound","icon_prefix":"fas","icon_category":"general","unicode":"e52d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_voicemail_solid', 'Voicemail', 637, true, '{"icon_name":"voicemail","icon_prefix":"fas","icon_category":"general","unicode":"f897"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vest_solid', 'Vest', 638, true, '{"icon_name":"vest","icon_prefix":"fas","icon_category":"general","unicode":"e085"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_audio-description_solid', 'Audio Description', 639, true, '{"icon_name":"audio-description","icon_prefix":"fas","icon_category":"general","unicode":"f29e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_w_solid', 'W', 640, true, '{"icon_name":"w","icon_prefix":"fas","icon_category":"general","unicode":"57"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trailer_solid', 'Trailer', 647, true, '{"icon_name":"trailer","icon_prefix":"fas","icon_category":"general","unicode":"e041"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_turkish-lira-sign_solid', 'Turkish Lira Sign', 648, true, '{"icon_name":"turkish-lira-sign","icon_prefix":"fas","icon_category":"general","unicode":"e2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_try_solid', 'Try', 649, true, '{"icon_name":"try","icon_prefix":"fas","icon_category":"general","unicode":"e2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_turkish-lira_solid', 'Turkish Lira', 650, true, '{"icon_name":"turkish-lira","icon_prefix":"fas","icon_category":"general","unicode":"e2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volcano_solid', 'Volcano', 651, true, '{"icon_name":"volcano","icon_prefix":"fas","icon_category":"general","unicode":"f770"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wand-sparkles_solid', 'Wand Sparkles', 652, true, '{"icon_name":"wand-sparkles","icon_prefix":"fas","icon_category":"general","unicode":"f72b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crown_solid', 'Crown', 654, true, '{"icon_name":"crown","icon_prefix":"fas","icon_category":"general","unicode":"f521"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tent-arrow-turn-left_solid', 'Tent Arrow Turn Left', 655, true, '{"icon_name":"tent-arrow-turn-left","icon_prefix":"fas","icon_category":"general","unicode":"e580"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-fast_solid', 'Truck Fast', 656, true, '{"icon_name":"truck-fast","icon_prefix":"fas","icon_category":"general","unicode":"f48b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shower_solid', 'Shower', 661, true, '{"icon_name":"shower","icon_prefix":"fas","icon_category":"general","unicode":"f2cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-fancy_solid', 'Pen Fancy', 666, true, '{"icon_name":"pen-fancy","icon_prefix":"fas","icon_category":"general","unicode":"f5ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eur_solid', 'Eur', 668, true, '{"icon_name":"eur","icon_prefix":"fas","icon_category":"general","unicode":"f153"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_euro_solid', 'Euro', 669, true, '{"icon_name":"euro","icon_prefix":"fas","icon_category":"general","unicode":"f153"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lira-sign_solid', 'Lira Sign', 671, true, '{"icon_name":"lira-sign","icon_prefix":"fas","icon_category":"general","unicode":"f195"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yen-sign_solid', 'Yen Sign', 672, true, '{"icon_name":"yen-sign","icon_prefix":"fas","icon_category":"general","unicode":"f157"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cny_solid', 'Cny', 673, true, '{"icon_name":"cny","icon_prefix":"fas","icon_category":"general","unicode":"f157"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jpy_solid', 'Jpy', 674, true, '{"icon_name":"jpy","icon_prefix":"fas","icon_category":"general","unicode":"f157"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rmb_solid', 'Rmb', 675, true, '{"icon_name":"rmb","icon_prefix":"fas","icon_category":"general","unicode":"f157"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yen_solid', 'Yen', 676, true, '{"icon_name":"yen","icon_prefix":"fas","icon_category":"general","unicode":"f157"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_box-open_solid', 'Box Open', 677, true, '{"icon_name":"box-open","icon_prefix":"fas","icon_category":"general","unicode":"f49e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-field_solid', 'Truck Field', 678, true, '{"icon_name":"truck-field","icon_prefix":"fas","icon_category":"general","unicode":"e58d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-praying_solid', 'Person Praying', 680, true, '{"icon_name":"person-praying","icon_prefix":"fas","icon_category":"general","unicode":"f683"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pray_solid', 'Pray', 681, true, '{"icon_name":"pray","icon_prefix":"fas","icon_category":"general","unicode":"f683"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clipboard-list_solid', 'Clipboard List', 682, true, '{"icon_name":"clipboard-list","icon_prefix":"fas","icon_category":"general","unicode":"f46d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sack-dollar_solid', 'Sack Dollar', 683, true, '{"icon_name":"sack-dollar","icon_prefix":"fas","icon_category":"general","unicode":"f81d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-amount-up_solid', 'Sort Amount Up', 686, true, '{"icon_name":"sort-amount-up","icon_prefix":"fas","icon_category":"general","unicode":"f161"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_notes-medical_solid', 'Notes Medical', 689, true, '{"icon_name":"notes-medical","icon_prefix":"fas","icon_category":"general","unicode":"f481"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_austral-sign_solid', 'Austral Sign', 690, true, '{"icon_name":"austral-sign","icon_prefix":"fas","icon_category":"general","unicode":"e0a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vial_solid', 'Vial', 695, true, '{"icon_name":"vial","icon_prefix":"fas","icon_category":"general","unicode":"f492"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_helicopter_solid', 'Helicopter', 696, true, '{"icon_name":"helicopter","icon_prefix":"fas","icon_category":"general","unicode":"f533"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mitten_solid', 'Mitten', 697, true, '{"icon_name":"mitten","icon_prefix":"fas","icon_category":"general","unicode":"f7b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gas-pump_solid', 'Gas Pump', 698, true, '{"icon_name":"gas-pump","icon_prefix":"fas","icon_category":"general","unicode":"f52f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_baseball_solid', 'Baseball', 703, true, '{"icon_name":"baseball","icon_prefix":"fas","icon_category":"general","unicode":"f433"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_baseball-ball_solid', 'Baseball Ball', 704, true, '{"icon_name":"baseball-ball","icon_prefix":"fas","icon_category":"general","unicode":"f433"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_notdef_solid', 'Notdef', 706, true, '{"icon_name":"notdef","icon_prefix":"fas","icon_category":"general","unicode":"e1fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_basketball_solid', 'Basketball', 707, true, '{"icon_name":"basketball","icon_prefix":"fas","icon_category":"general","unicode":"f434"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_basketball-ball_solid', 'Basketball Ball', 708, true, '{"icon_name":"basketball-ball","icon_prefix":"fas","icon_category":"general","unicode":"f434"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pencil_solid', 'Pencil', 709, true, '{"icon_name":"pencil","icon_prefix":"fas","icon_category":"general","unicode":"f303"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pencil-alt_solid', 'Pencil Alt', 710, true, '{"icon_name":"pencil-alt","icon_prefix":"fas","icon_category":"general","unicode":"f303"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-walking-arrow-loop-left_solid', 'Person Walking Arrow Loop Left', 711, true, '{"icon_name":"person-walking-arrow-loop-left","icon_prefix":"fas","icon_category":"general","unicode":"e551"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-six_solid', 'Dice Six', 712, true, '{"icon_name":"dice-six","icon_prefix":"fas","icon_category":"general","unicode":"f526"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angles-down_solid', 'Angles Down', 713, true, '{"icon_name":"angles-down","icon_prefix":"fas","icon_category":"general","unicode":"f103"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-double-down_solid', 'Angle Double Down', 714, true, '{"icon_name":"angle-double-down","icon_prefix":"fas","icon_category":"general","unicode":"f103"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_syringe_solid', 'Syringe', 715, true, '{"icon_name":"syringe","icon_prefix":"fas","icon_category":"general","unicode":"f48e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_align-center_solid', 'Align Center', 719, true, '{"icon_name":"align-center","icon_prefix":"fas","icon_category":"general","unicode":"f037"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_restroom_solid', 'Restroom', 724, true, '{"icon_name":"restroom","icon_prefix":"fas","icon_category":"general","unicode":"f7bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_timeline_solid', 'Timeline', 726, true, '{"icon_name":"timeline","icon_prefix":"fas","icon_category":"general","unicode":"e29c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lightbulb_solid', 'Lightbulb', 727, true, '{"icon_name":"lightbulb","icon_prefix":"fas","icon_category":"general","unicode":"f0eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-and-venus_solid', 'Mars And Venus', 730, true, '{"icon_name":"mars-and-venus","icon_prefix":"fas","icon_category":"general","unicode":"f224"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_network-wired_solid', 'Network Wired', 731, true, '{"icon_name":"network-wired","icon_prefix":"fas","icon_category":"general","unicode":"f6ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code_solid', 'Code', 733, true, '{"icon_name":"code","icon_prefix":"fas","icon_category":"general","unicode":"f121"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth-americas_solid', 'Earth Americas', 738, true, '{"icon_name":"earth-americas","icon_prefix":"fas","icon_category":"general","unicode":"f57d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth_solid', 'Earth', 739, true, '{"icon_name":"earth","icon_prefix":"fas","icon_category":"general","unicode":"f57d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth-america_solid', 'Earth America', 740, true, '{"icon_name":"earth-america","icon_prefix":"fas","icon_category":"general","unicode":"f57d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer4_solid', 'Thermometer4', 745, true, '{"icon_name":"thermometer4","icon_prefix":"fas","icon_category":"general","unicode":"f2c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer-full_solid', 'Thermometer Full', 746, true, '{"icon_name":"thermometer-full","icon_prefix":"fas","icon_category":"general","unicode":"f2c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-meh_solid', 'Face Meh', 756, true, '{"icon_name":"face-meh","icon_prefix":"fas","icon_category":"general","unicode":"f11a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meh_solid', 'Meh', 757, true, '{"icon_name":"meh","icon_prefix":"fas","icon_category":"general","unicode":"f11a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_venus_solid', 'Venus', 761, true, '{"icon_name":"venus","icon_prefix":"fas","icon_category":"general","unicode":"f221"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diagram-successor_solid', 'Diagram Successor', 762, true, '{"icon_name":"diagram-successor","icon_prefix":"fas","icon_category":"general","unicode":"e47a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_head-side-cough-slash_solid', 'Head Side Cough Slash', 763, true, '{"icon_name":"head-side-cough-slash","icon_prefix":"fas","icon_category":"general","unicode":"e062"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diagram-project_solid', 'Diagram Project', 764, true, '{"icon_name":"diagram-project","icon_prefix":"fas","icon_category":"general","unicode":"f542"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_project-diagram_solid', 'Project Diagram', 765, true, '{"icon_name":"project-diagram","icon_prefix":"fas","icon_category":"general","unicode":"f542"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_terminal_solid', 'Terminal', 766, true, '{"icon_name":"terminal","icon_prefix":"fas","icon_category":"general","unicode":"f120"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-fire_solid', 'House Fire', 767, true, '{"icon_name":"house-fire","icon_prefix":"fas","icon_category":"general","unicode":"e50c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mask_solid', 'Mask', 768, true, '{"icon_name":"mask","icon_prefix":"fas","icon_category":"general","unicode":"f6fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hurricane_solid', 'Hurricane', 769, true, '{"icon_name":"hurricane","icon_prefix":"fas","icon_category":"general","unicode":"f751"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth-africa_solid', 'Earth Africa', 770, true, '{"icon_name":"earth-africa","icon_prefix":"fas","icon_category":"general","unicode":"f57c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumbtack_solid', 'Thumbtack', 772, true, '{"icon_name":"thumbtack","icon_prefix":"fas","icon_category":"general","unicode":"f08d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumb-tack_solid', 'Thumb Tack', 773, true, '{"icon_name":"thumb-tack","icon_prefix":"fas","icon_category":"general","unicode":"f08d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-down_solid', 'Hand Point Down', 774, true, '{"icon_name":"hand-point-down","icon_prefix":"fas","icon_category":"general","unicode":"f0a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-meh-blank_solid', 'Face Meh Blank', 775, true, '{"icon_name":"face-meh-blank","icon_prefix":"fas","icon_category":"general","unicode":"f5a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meh-blank_solid', 'Meh Blank', 776, true, '{"icon_name":"meh-blank","icon_prefix":"fas","icon_category":"general","unicode":"f5a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer0_solid', 'Thermometer0', 779, true, '{"icon_name":"thermometer0","icon_prefix":"fas","icon_category":"general","unicode":"f2cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer-empty_solid', 'Thermometer Empty', 780, true, '{"icon_name":"thermometer-empty","icon_prefix":"fas","icon_category":"general","unicode":"f2cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_border-none_solid', 'Border None', 781, true, '{"icon_name":"border-none","icon_prefix":"fas","icon_category":"general","unicode":"f850"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_highlighter_solid', 'Highlighter', 782, true, '{"icon_name":"highlighter","icon_prefix":"fas","icon_category":"general","unicode":"f591"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-wave_solid', 'Money Bill Wave', 783, true, '{"icon_name":"money-bill-wave","icon_prefix":"fas","icon_category":"general","unicode":"f53a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilet-paper-slash_solid', 'Toilet Paper Slash', 784, true, '{"icon_name":"toilet-paper-slash","icon_prefix":"fas","icon_category":"general","unicode":"e072"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_text-height_solid', 'Text Height', 786, true, '{"icon_name":"text-height","icon_prefix":"fas","icon_category":"general","unicode":"f034"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tongue_solid', 'Face Grin Tongue', 787, true, '{"icon_name":"face-grin-tongue","icon_prefix":"fas","icon_category":"general","unicode":"f589"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tongue_solid', 'Grin Tongue', 788, true, '{"icon_name":"grin-tongue","icon_prefix":"fas","icon_category":"general","unicode":"f589"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_futbol_solid', 'Futbol', 792, true, '{"icon_name":"futbol","icon_prefix":"fas","icon_category":"general","unicode":"f1e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_futbol-ball_solid', 'Futbol Ball', 793, true, '{"icon_name":"futbol-ball","icon_prefix":"fas","icon_category":"general","unicode":"f1e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_soccer-ball_solid', 'Soccer Ball', 794, true, '{"icon_name":"soccer-ball","icon_prefix":"fas","icon_category":"general","unicode":"f1e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_brazilian-real-sign_solid', 'Brazilian Real Sign', 797, true, '{"icon_name":"brazilian-real-sign","icon_prefix":"fas","icon_category":"general","unicode":"e46c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-surprise_solid', 'Face Surprise', 799, true, '{"icon_name":"face-surprise","icon_prefix":"fas","icon_category":"general","unicode":"f5c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_surprise_solid', 'Surprise', 800, true, '{"icon_name":"surprise","icon_prefix":"fas","icon_category":"general","unicode":"f5c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_holly-berry_solid', 'Holly Berry', 805, true, '{"icon_name":"holly-berry","icon_prefix":"fas","icon_category":"general","unicode":"f7aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_venus-double_solid', 'Venus Double', 806, true, '{"icon_name":"venus-double","icon_prefix":"fas","icon_category":"general","unicode":"f226"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clipboard-question_solid', 'Clipboard Question', 807, true, '{"icon_name":"clipboard-question","icon_prefix":"fas","icon_category":"general","unicode":"e4e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hotdog_solid', 'Hotdog', 808, true, '{"icon_name":"hotdog","icon_prefix":"fas","icon_category":"general","unicode":"f80f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microscope_solid', 'Microscope', 810, true, '{"icon_name":"microscope","icon_prefix":"fas","icon_category":"general","unicode":"f610"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumbtack-slash_solid', 'Thumbtack Slash', 815, true, '{"icon_name":"thumbtack-slash","icon_prefix":"fas","icon_category":"general","unicode":"e68f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumb-tack-slash_solid', 'Thumb Tack Slash', 816, true, '{"icon_name":"thumb-tack-slash","icon_prefix":"fas","icon_category":"general","unicode":"e68f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plus-minus_solid', 'Plus Minus', 817, true, '{"icon_name":"plus-minus","icon_prefix":"fas","icon_category":"general","unicode":"e43c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-squint_solid', 'Face Grin Squint', 822, true, '{"icon_name":"face-grin-squint","icon_prefix":"fas","icon_category":"general","unicode":"f585"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-squint_solid', 'Grin Squint', 823, true, '{"icon_name":"grin-squint","icon_prefix":"fas","icon_category":"general","unicode":"f585"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-list_solid', 'Table List', 826, true, '{"icon_name":"table-list","icon_prefix":"fas","icon_category":"general","unicode":"f00b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_th-list_solid', 'Th List', 827, true, '{"icon_name":"th-list","icon_prefix":"fas","icon_category":"general","unicode":"f00b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flask-vial_solid', 'Flask Vial', 828, true, '{"icon_name":"flask-vial","icon_prefix":"fas","icon_category":"general","unicode":"e4f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_taxi_solid', 'Taxi', 831, true, '{"icon_name":"taxi","icon_prefix":"fas","icon_category":"general","unicode":"f1ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cab_solid', 'Cab', 832, true, '{"icon_name":"cab","icon_prefix":"fas","icon_category":"general","unicode":"f1ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_text-slash_solid', 'Text Slash', 833, true, '{"icon_name":"text-slash","icon_prefix":"fas","icon_category":"general","unicode":"f87d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-pulling_solid', 'People Pulling', 835, true, '{"icon_name":"people-pulling","icon_prefix":"fas","icon_category":"general","unicode":"e535"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_backward_solid', 'Backward', 836, true, '{"icon_name":"backward","icon_prefix":"fas","icon_category":"general","unicode":"f04a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_link_solid', 'Link', 839, true, '{"icon_name":"link","icon_prefix":"fas","icon_category":"general","unicode":"f0c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chain_solid', 'Chain', 840, true, '{"icon_name":"chain","icon_prefix":"fas","icon_category":"general","unicode":"f0c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_backward-step_solid', 'Backward Step', 841, true, '{"icon_name":"backward-step","icon_prefix":"fas","icon_category":"general","unicode":"f048"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_step-backward_solid', 'Step Backward', 842, true, '{"icon_name":"step-backward","icon_prefix":"fas","icon_category":"general","unicode":"f048"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_x_solid', 'X', 843, true, '{"icon_name":"x","icon_prefix":"fas","icon_category":"general","unicode":"58"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-list_solid', 'Rectangle List', 846, true, '{"icon_name":"rectangle-list","icon_prefix":"fas","icon_category":"general","unicode":"f022"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-alt_solid', 'List Alt', 847, true, '{"icon_name":"list-alt","icon_prefix":"fas","icon_category":"general","unicode":"f022"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand_solid', 'Hand', 848, true, '{"icon_name":"hand","icon_prefix":"fas","icon_category":"general","unicode":"f256"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-paper_solid', 'Hand Paper', 849, true, '{"icon_name":"hand-paper","icon_prefix":"fas","icon_category":"general","unicode":"f256"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_van-shuttle_solid', 'Van Shuttle', 850, true, '{"icon_name":"van-shuttle","icon_prefix":"fas","icon_category":"general","unicode":"f5b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shuttle-van_solid', 'Shuttle Van', 851, true, '{"icon_name":"shuttle-van","icon_prefix":"fas","icon_category":"general","unicode":"f5b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stairs_solid', 'Stairs', 852, true, '{"icon_name":"stairs","icon_prefix":"fas","icon_category":"general","unicode":"e289"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_horse-head_solid', 'Horse Head', 853, true, '{"icon_name":"horse-head","icon_prefix":"fas","icon_category":"general","unicode":"f7ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vault_solid', 'Vault', 854, true, '{"icon_name":"vault","icon_prefix":"fas","icon_category":"general","unicode":"e2c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drum-steelpan_solid', 'Drum Steelpan', 855, true, '{"icon_name":"drum-steelpan","icon_prefix":"fas","icon_category":"general","unicode":"f56a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stamp_solid', 'Stamp', 857, true, '{"icon_name":"stamp","icon_prefix":"fas","icon_category":"general","unicode":"f5bf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_menorah_solid', 'Menorah', 858, true, '{"icon_name":"menorah","icon_prefix":"fas","icon_category":"general","unicode":"f676"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_children_solid', 'Children', 859, true, '{"icon_name":"children","icon_prefix":"fas","icon_category":"general","unicode":"e4e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_line-chart_solid', 'Line Chart', 861, true, '{"icon_name":"line-chart","icon_prefix":"fas","icon_category":"general","unicode":"f201"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-front_solid', 'Truck Front', 866, true, '{"icon_name":"truck-front","icon_prefix":"fas","icon_category":"general","unicode":"e2b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-rook_solid', 'Chess Rook', 871, true, '{"icon_name":"chess-rook","icon_prefix":"fas","icon_category":"general","unicode":"f447"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-turn-up_solid', 'Arrow Turn Up', 873, true, '{"icon_name":"arrow-turn-up","icon_prefix":"fas","icon_category":"general","unicode":"f148"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_level-up_solid', 'Level Up', 874, true, '{"icon_name":"level-up","icon_prefix":"fas","icon_category":"general","unicode":"f148"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bicycle_solid', 'Bicycle', 875, true, '{"icon_name":"bicycle","icon_prefix":"fas","icon_category":"general","unicode":"f206"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gear_solid', 'Gear', 878, true, '{"icon_name":"gear","icon_prefix":"fas","icon_category":"general","unicode":"f013"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-and-venus-burst_solid', 'Mars And Venus Burst', 880, true, '{"icon_name":"mars-and-venus-burst","icon_prefix":"fas","icon_category":"general","unicode":"e523"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_otter_solid', 'Otter', 881, true, '{"icon_name":"otter","icon_prefix":"fas","icon_category":"general","unicode":"f700"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_walkie-talkie_solid', 'Walkie Talkie', 886, true, '{"icon_name":"walkie-talkie","icon_prefix":"fas","icon_category":"general","unicode":"f8ef"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-chimney_solid', 'House Chimney', 889, true, '{"icon_name":"house-chimney","icon_prefix":"fas","icon_category":"general","unicode":"e3af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_right-from-bracket_solid', 'Right From Bracket', 891, true, '{"icon_name":"right-from-bracket","icon_prefix":"fas","icon_category":"general","unicode":"f2f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign-out-alt_solid', 'Sign Out Alt', 892, true, '{"icon_name":"sign-out-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-falling_solid', 'Person Falling', 896, true, '{"icon_name":"person-falling","icon_prefix":"fas","icon_category":"general","unicode":"e546"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_turn-down_solid', 'Turn Down', 897, true, '{"icon_name":"turn-down","icon_prefix":"fas","icon_category":"general","unicode":"f3be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_level-down-alt_solid', 'Level Down Alt', 898, true, '{"icon_name":"level-down-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_up-right-and-down-left-from-center_solid', 'Up Right And Down Left From Center', 899, true, '{"icon_name":"up-right-and-down-left-from-center","icon_prefix":"fas","icon_category":"general","unicode":"f424"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_expand-alt_solid', 'Expand Alt', 900, true, '{"icon_name":"expand-alt","icon_prefix":"fas","icon_category":"general","unicode":"f424"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-sparkles_solid', 'Hand Sparkles', 902, true, '{"icon_name":"hand-sparkles","icon_prefix":"fas","icon_category":"general","unicode":"e05d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-to-dot_solid', 'Arrows To Dot', 903, true, '{"icon_name":"arrows-to-dot","icon_prefix":"fas","icon_category":"general","unicode":"e4be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-sad-cry_solid', 'Face Sad Cry', 904, true, '{"icon_name":"face-sad-cry","icon_prefix":"fas","icon_category":"general","unicode":"f5b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sad-cry_solid', 'Sad Cry', 905, true, '{"icon_name":"sad-cry","icon_prefix":"fas","icon_category":"general","unicode":"f5b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dong-sign_solid', 'Dong Sign', 906, true, '{"icon_name":"dong-sign","icon_prefix":"fas","icon_category":"general","unicode":"e169"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-line_solid', 'People Line', 907, true, '{"icon_name":"people-line","icon_prefix":"fas","icon_category":"general","unicode":"e534"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-diagram_solid', 'Chart Diagram', 911, true, '{"icon_name":"chart-diagram","icon_prefix":"fas","icon_category":"general","unicode":"e695"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-tired_solid', 'Face Tired', 912, true, '{"icon_name":"face-tired","icon_prefix":"fas","icon_category":"general","unicode":"f5c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tired_solid', 'Tired', 913, true, '{"icon_name":"tired","icon_prefix":"fas","icon_category":"general","unicode":"f5c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-right_solid', 'Hand Point Right', 914, true, '{"icon_name":"hand-point-right","icon_prefix":"fas","icon_category":"general","unicode":"f0a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cubes-stacked_solid', 'Cubes Stacked', 916, true, '{"icon_name":"cubes-stacked","icon_prefix":"fas","icon_category":"general","unicode":"e4e6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_child-rifle_solid', 'Child Rifle', 918, true, '{"icon_name":"child-rifle","icon_prefix":"fas","icon_category":"general","unicode":"e4e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_martini-glass-empty_solid', 'Martini Glass Empty', 920, true, '{"icon_name":"martini-glass-empty","icon_prefix":"fas","icon_category":"general","unicode":"f000"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glass-martini_solid', 'Glass Martini', 921, true, '{"icon_name":"glass-martini","icon_prefix":"fas","icon_category":"general","unicode":"f000"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnet_solid', 'Magnet', 922, true, '{"icon_name":"magnet","icon_prefix":"fas","icon_category":"general","unicode":"f076"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-barrier_solid', 'Road Barrier', 923, true, '{"icon_name":"road-barrier","icon_prefix":"fas","icon_category":"general","unicode":"e562"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign-hanging_solid', 'Sign Hanging', 928, true, '{"icon_name":"sign-hanging","icon_prefix":"fas","icon_category":"general","unicode":"f4d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign_solid', 'Sign', 929, true, '{"icon_name":"sign","icon_prefix":"fas","icon_category":"general","unicode":"f4d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shirt_solid', 'Shirt', 932, true, '{"icon_name":"shirt","icon_prefix":"fas","icon_category":"general","unicode":"f553"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_t-shirt_solid', 'T Shirt', 933, true, '{"icon_name":"t-shirt","icon_prefix":"fas","icon_category":"general","unicode":"f553"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tshirt_solid', 'Tshirt', 934, true, '{"icon_name":"tshirt","icon_prefix":"fas","icon_category":"general","unicode":"f553"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paragraph_solid', 'Paragraph', 935, true, '{"icon_name":"paragraph","icon_prefix":"fas","icon_category":"general","unicode":"f1dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_guitar_solid', 'Guitar', 938, true, '{"icon_name":"guitar","icon_prefix":"fas","icon_category":"general","unicode":"f7a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_suitcase_solid', 'Suitcase', 939, true, '{"icon_name":"suitcase","icon_prefix":"fas","icon_category":"general","unicode":"f0f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_f_solid', 'F', 942, true, '{"icon_name":"f","icon_prefix":"fas","icon_category":"general","unicode":"46"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xmarks-lines_solid', 'Xmarks Lines', 943, true, '{"icon_name":"xmarks-lines","icon_prefix":"fas","icon_category":"general","unicode":"e59a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth-oceania_solid', 'Earth Oceania', 944, true, '{"icon_name":"earth-oceania","icon_prefix":"fas","icon_category":"general","unicode":"e47b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cedi-sign_solid', 'Cedi Sign', 950, true, '{"icon_name":"cedi-sign","icon_prefix":"fas","icon_category":"general","unicode":"e0df"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_puzzle-piece_solid', 'Puzzle Piece', 951, true, '{"icon_name":"puzzle-piece","icon_prefix":"fas","icon_category":"general","unicode":"f12e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_helmet-un_solid', 'Helmet Un', 952, true, '{"icon_name":"helmet-un","icon_prefix":"fas","icon_category":"general","unicode":"e503"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pump-soap_solid', 'Pump Soap', 955, true, '{"icon_name":"pump-soap","icon_prefix":"fas","icon_category":"general","unicode":"e06b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-scissors_solid', 'Hand Scissors', 956, true, '{"icon_name":"hand-scissors","icon_prefix":"fas","icon_category":"general","unicode":"f257"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dolly_solid', 'Dolly', 957, true, '{"icon_name":"dolly","icon_prefix":"fas","icon_category":"general","unicode":"f472"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dolly-box_solid', 'Dolly Box', 958, true, '{"icon_name":"dolly-box","icon_prefix":"fas","icon_category":"general","unicode":"f472"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paperclip_solid', 'Paperclip', 959, true, '{"icon_name":"paperclip","icon_prefix":"fas","icon_category":"general","unicode":"f0c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ferry_solid', 'Ferry', 963, true, '{"icon_name":"ferry","icon_prefix":"fas","icon_category":"general","unicode":"e4ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mosquito_solid', 'Mosquito', 964, true, '{"icon_name":"mosquito","icon_prefix":"fas","icon_category":"general","unicode":"e52b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_left-right_solid', 'Left Right', 966, true, '{"icon_name":"left-right","icon_prefix":"fas","icon_category":"general","unicode":"f337"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-alt-h_solid', 'Arrows Alt H', 967, true, '{"icon_name":"arrows-alt-h","icon_prefix":"fas","icon_category":"general","unicode":"f337"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_virus_solid', 'Virus', 968, true, '{"icon_name":"virus","icon_prefix":"fas","icon_category":"general","unicode":"e074"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gem_solid', 'Gem', 969, true, '{"icon_name":"gem","icon_prefix":"fas","icon_category":"general","unicode":"f3a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilet_solid', 'Toilet', 970, true, '{"icon_name":"toilet","icon_prefix":"fas","icon_category":"general","unicode":"f7d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_single-quote-left_solid', 'Single Quote Left', 971, true, '{"icon_name":"single-quote-left","icon_prefix":"fas","icon_category":"general","unicode":"e81b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bills_solid', 'Money Bills', 972, true, '{"icon_name":"money-bills","icon_prefix":"fas","icon_category":"general","unicode":"e1f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tablet-button_solid', 'Tablet Button', 973, true, '{"icon_name":"tablet-button","icon_prefix":"fas","icon_category":"general","unicode":"f10a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-xmark_solid', 'Rectangle Xmark', 974, true, '{"icon_name":"rectangle-xmark","icon_prefix":"fas","icon_category":"general","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-can_solid', 'Trash Can', 979, true, '{"icon_name":"trash-can","icon_prefix":"fas","icon_category":"general","unicode":"f2ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-alt_solid', 'Trash Alt', 980, true, '{"icon_name":"trash-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-cells_solid', 'Table Cells', 981, true, '{"icon_name":"table-cells","icon_prefix":"fas","icon_category":"general","unicode":"f00a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_th_solid', 'Th', 982, true, '{"icon_name":"th","icon_prefix":"fas","icon_category":"general","unicode":"f00a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ribbon_solid', 'Ribbon', 983, true, '{"icon_name":"ribbon","icon_prefix":"fas","icon_category":"general","unicode":"f4d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_landmark-flag_solid', 'Landmark Flag', 984, true, '{"icon_name":"landmark-flag","icon_prefix":"fas","icon_category":"general","unicode":"e51c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_up-down-left-right_solid', 'Up Down Left Right', 985, true, '{"icon_name":"up-down-left-right","icon_prefix":"fas","icon_category":"general","unicode":"f0b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-alt_solid', 'Arrows Alt', 986, true, '{"icon_name":"arrows-alt","icon_prefix":"fas","icon_category":"general","unicode":"f0b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-restore_solid', 'Trash Restore', 989, true, '{"icon_name":"trash-restore","icon_prefix":"fas","icon_category":"general","unicode":"f829"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_life-ring_solid', 'Life Ring', 990, true, '{"icon_name":"life-ring","icon_prefix":"fas","icon_category":"general","unicode":"f1cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_copyright_solid', 'Copyright', 991, true, '{"icon_name":"copyright","icon_prefix":"fas","icon_category":"general","unicode":"f1f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eraser_solid', 'Eraser', 993, true, '{"icon_name":"eraser","icon_prefix":"fas","icon_category":"general","unicode":"f12d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cruzeiro-sign_solid', 'Cruzeiro Sign', 998, true, '{"icon_name":"cruzeiro-sign","icon_prefix":"fas","icon_category":"general","unicode":"e152"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smoking_solid', 'Smoking', 999, true, '{"icon_name":"smoking","icon_prefix":"fas","icon_category":"general","unicode":"f48d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_poll_solid', 'Poll', 1001, true, '{"icon_name":"poll","icon_prefix":"fas","icon_category":"general","unicode":"f681"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_biohazard_solid', 'Biohazard', 1003, true, '{"icon_name":"biohazard","icon_prefix":"fas","icon_category":"general","unicode":"f780"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ruler-horizontal_solid', 'Ruler Horizontal', 1006, true, '{"icon_name":"ruler-horizontal","icon_prefix":"fas","icon_category":"general","unicode":"f547"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_horse_solid', 'Horse', 1007, true, '{"icon_name":"horse","icon_prefix":"fas","icon_category":"general","unicode":"f6f0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-holding-child_solid', 'Hands Holding Child', 1009, true, '{"icon_name":"hands-holding-child","icon_prefix":"fas","icon_category":"general","unicode":"e4fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_italic_solid', 'Italic', 1010, true, '{"icon_name":"italic","icon_prefix":"fas","icon_category":"general","unicode":"f033"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_khanda_solid', 'Khanda', 1011, true, '{"icon_name":"khanda","icon_prefix":"fas","icon_category":"general","unicode":"f66d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-frown-open_solid', 'Face Frown Open', 1012, true, '{"icon_name":"face-frown-open","icon_prefix":"fas","icon_category":"general","unicode":"f57a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_frown-open_solid', 'Frown Open', 1013, true, '{"icon_name":"frown-open","icon_prefix":"fas","icon_category":"general","unicode":"f57a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fingerprint_solid', 'Fingerprint', 1015, true, '{"icon_name":"fingerprint","icon_prefix":"fas","icon_category":"general","unicode":"f577"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-screen-button_solid', 'Mobile Screen Button', 1018, true, '{"icon_name":"mobile-screen-button","icon_prefix":"fas","icon_category":"general","unicode":"f3cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-alt_solid', 'Mobile Alt', 1019, true, '{"icon_name":"mobile-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-walking-with-cane_solid', 'Person Walking With Cane', 1021, true, '{"icon_name":"person-walking-with-cane","icon_prefix":"fas","icon_category":"general","unicode":"f29d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blind_solid', 'Blind', 1022, true, '{"icon_name":"blind","icon_prefix":"fas","icon_category":"general","unicode":"f29d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-crack_solid', 'House Crack', 1025, true, '{"icon_name":"house-crack","icon_prefix":"fas","icon_category":"general","unicode":"e3b1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bar-chart_solid', 'Bar Chart', 1030, true, '{"icon_name":"bar-chart","icon_prefix":"fas","icon_category":"general","unicode":"f080"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spray-can-sparkles_solid', 'Spray Can Sparkles', 1031, true, '{"icon_name":"spray-can-sparkles","icon_prefix":"fas","icon_category":"general","unicode":"f5d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_air-freshener_solid', 'Air Freshener', 1032, true, '{"icon_name":"air-freshener","icon_prefix":"fas","icon_category":"general","unicode":"f5d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_baht-sign_solid', 'Baht Sign', 1033, true, '{"icon_name":"baht-sign","icon_prefix":"fas","icon_category":"general","unicode":"e0ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_web-awesome_solid', 'Web Awesome', 1036, true, '{"icon_name":"web-awesome","icon_prefix":"fas","icon_category":"general","unicode":"e682"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_non-binary_solid', 'Non Binary', 1037, true, '{"icon_name":"non-binary","icon_prefix":"fas","icon_category":"general","unicode":"e807"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_n_solid', 'N', 1038, true, '{"icon_name":"n","icon_prefix":"fas","icon_category":"general","unicode":"4e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-up-down-left-right_solid', 'Arrows Up Down Left Right', 1039, true, '{"icon_name":"arrows-up-down-left-right","icon_prefix":"fas","icon_category":"general","unicode":"f047"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows_solid', 'Arrows', 1040, true, '{"icon_name":"arrows","icon_prefix":"fas","icon_category":"general","unicode":"f047"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house_solid', 'House', 1041, true, '{"icon_name":"house","icon_prefix":"fas","icon_category":"general","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spinner_solid', 'Spinner', 1045, true, '{"icon_name":"spinner","icon_prefix":"fas","icon_category":"general","unicode":"f110"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gavel_solid', 'Gavel', 1046, true, '{"icon_name":"gavel","icon_prefix":"fas","icon_category":"general","unicode":"f0e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_legal_solid', 'Legal', 1047, true, '{"icon_name":"legal","icon_prefix":"fas","icon_category":"general","unicode":"f0e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ticket-simple_solid', 'Ticket Simple', 1048, true, '{"icon_name":"ticket-simple","icon_prefix":"fas","icon_category":"general","unicode":"f3ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ticket-alt_solid', 'Ticket Alt', 1049, true, '{"icon_name":"ticket-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dove_solid', 'Dove', 1050, true, '{"icon_name":"dove","icon_prefix":"fas","icon_category":"general","unicode":"f4ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tarp-droplet_solid', 'Tarp Droplet', 1051, true, '{"icon_name":"tarp-droplet","icon_prefix":"fas","icon_category":"general","unicode":"e57c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tree-city_solid', 'Tree City', 1052, true, '{"icon_name":"tree-city","icon_prefix":"fas","icon_category":"general","unicode":"e587"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_turn-up_solid', 'Turn Up', 1053, true, '{"icon_name":"turn-up","icon_prefix":"fas","icon_category":"general","unicode":"f3bf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_level-up-alt_solid', 'Level Up Alt', 1054, true, '{"icon_name":"level-up-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3bf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer1_solid', 'Thermometer1', 1057, true, '{"icon_name":"thermometer1","icon_prefix":"fas","icon_category":"general","unicode":"f2ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer-quarter_solid', 'Thermometer Quarter', 1058, true, '{"icon_name":"thermometer-quarter","icon_prefix":"fas","icon_category":"general","unicode":"f2ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sliders_solid', 'Sliders', 1059, true, '{"icon_name":"sliders","icon_prefix":"fas","icon_category":"general","unicode":"f1de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mosque_solid', 'Mosque', 1061, true, '{"icon_name":"mosque","icon_prefix":"fas","icon_category":"general","unicode":"f678"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_h_solid', 'H', 1062, true, '{"icon_name":"h","icon_prefix":"fas","icon_category":"general","unicode":"48"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_info_solid', 'Info', 1063, true, '{"icon_name":"info","icon_prefix":"fas","icon_category":"general","unicode":"f129"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-walking_solid', 'Person Walking', 1064, true, '{"icon_name":"person-walking","icon_prefix":"fas","icon_category":"general","unicode":"f554"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_walking_solid', 'Walking', 1065, true, '{"icon_name":"walking","icon_prefix":"fas","icon_category":"general","unicode":"f554"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-turn-down_solid', 'Arrow Turn Down', 1066, true, '{"icon_name":"arrow-turn-down","icon_prefix":"fas","icon_category":"general","unicode":"f149"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_level-down_solid', 'Level Down', 1067, true, '{"icon_name":"level-down","icon_prefix":"fas","icon_category":"general","unicode":"f149"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road_solid', 'Road', 1068, true, '{"icon_name":"road","icon_prefix":"fas","icon_category":"general","unicode":"f018"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spiral_solid', 'Spiral', 1069, true, '{"icon_name":"spiral","icon_prefix":"fas","icon_category":"general","unicode":"e80a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-frown_solid', 'Face Frown', 1070, true, '{"icon_name":"face-frown","icon_prefix":"fas","icon_category":"general","unicode":"f119"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_frown_solid', 'Frown', 1071, true, '{"icon_name":"frown","icon_prefix":"fas","icon_category":"general","unicode":"f119"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wine-glass-empty_solid', 'Wine Glass Empty', 1072, true, '{"icon_name":"wine-glass-empty","icon_prefix":"fas","icon_category":"general","unicode":"f5ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wine-glass-alt_solid', 'Wine Glass Alt', 1073, true, '{"icon_name":"wine-glass-alt","icon_prefix":"fas","icon_category":"general","unicode":"f5ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clapperboard_solid', 'Clapperboard', 1074, true, '{"icon_name":"clapperboard","icon_prefix":"fas","icon_category":"general","unicode":"e131"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_forward-step_solid', 'Forward Step', 1075, true, '{"icon_name":"forward-step","icon_prefix":"fas","icon_category":"general","unicode":"f051"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_step-forward_solid', 'Step Forward', 1076, true, '{"icon_name":"step-forward","icon_prefix":"fas","icon_category":"general","unicode":"f051"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-journal-whills_solid', 'Book Journal Whills', 1079, true, '{"icon_name":"book-journal-whills","icon_prefix":"fas","icon_category":"general","unicode":"f66a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_journal-whills_solid', 'Journal Whills', 1080, true, '{"icon_name":"journal-whills","icon_prefix":"fas","icon_category":"general","unicode":"f66a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_champagne-glasses_solid', 'Champagne Glasses', 1081, true, '{"icon_name":"champagne-glasses","icon_prefix":"fas","icon_category":"general","unicode":"f79f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glass-cheers_solid', 'Glass Cheers', 1082, true, '{"icon_name":"glass-cheers","icon_prefix":"fas","icon_category":"general","unicode":"f79f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dumpster_solid', 'Dumpster', 1083, true, '{"icon_name":"dumpster","icon_prefix":"fas","icon_category":"general","unicode":"f793"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_computer_solid', 'Computer', 1085, true, '{"icon_name":"computer","icon_prefix":"fas","icon_category":"general","unicode":"e4e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wand-magic_solid', 'Wand Magic', 1086, true, '{"icon_name":"wand-magic","icon_prefix":"fas","icon_category":"general","unicode":"f0d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magic_solid', 'Magic', 1087, true, '{"icon_name":"magic","icon_prefix":"fas","icon_category":"general","unicode":"f0d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_brain_solid', 'Brain', 1088, true, '{"icon_name":"brain","icon_prefix":"fas","icon_category":"general","unicode":"f5dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code-commit_solid', 'Code Commit', 1091, true, '{"icon_name":"code-commit","icon_prefix":"fas","icon_category":"general","unicode":"f386"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-breastfeeding_solid', 'Person Breastfeeding', 1092, true, '{"icon_name":"person-breastfeeding","icon_prefix":"fas","icon_category":"general","unicode":"e53a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-rays_solid', 'Person Rays', 1093, true, '{"icon_name":"person-rays","icon_prefix":"fas","icon_category":"general","unicode":"e54d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort_solid', 'Sort', 1095, true, '{"icon_name":"sort","icon_prefix":"fas","icon_category":"general","unicode":"f0dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unsorted_solid', 'Unsorted', 1096, true, '{"icon_name":"unsorted","icon_prefix":"fas","icon_category":"general","unicode":"f0dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laptop-code_solid', 'Laptop Code', 1099, true, '{"icon_name":"laptop-code","icon_prefix":"fas","icon_category":"general","unicode":"f5fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sink_solid', 'Sink', 1100, true, '{"icon_name":"sink","icon_prefix":"fas","icon_category":"general","unicode":"e06d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_server_solid', 'Server', 1104, true, '{"icon_name":"server","icon_prefix":"fas","icon_category":"general","unicode":"f233"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skull-crossbones_solid', 'Skull Crossbones', 1109, true, '{"icon_name":"skull-crossbones","icon_prefix":"fas","icon_category":"general","unicode":"f714"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_peso-sign_solid', 'Peso Sign', 1110, true, '{"icon_name":"peso-sign","icon_prefix":"fas","icon_category":"general","unicode":"e222"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wine-glass_solid', 'Wine Glass', 1111, true, '{"icon_name":"wine-glass","icon_prefix":"fas","icon_category":"general","unicode":"f4e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer2_solid', 'Thermometer2', 1114, true, '{"icon_name":"thermometer2","icon_prefix":"fas","icon_category":"general","unicode":"f2c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thermometer-half_solid', 'Thermometer Half', 1115, true, '{"icon_name":"thermometer-half","icon_prefix":"fas","icon_category":"general","unicode":"f2c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ticket_solid', 'Ticket', 1116, true, '{"icon_name":"ticket","icon_prefix":"fas","icon_category":"general","unicode":"f145"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-turn-right_solid', 'Arrows Turn Right', 1118, true, '{"icon_name":"arrows-turn-right","icon_prefix":"fas","icon_category":"general","unicode":"e4c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_candy-cane_solid', 'Candy Cane', 1119, true, '{"icon_name":"candy-cane","icon_prefix":"fas","icon_category":"general","unicode":"f786"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wheelchair_solid', 'Wheelchair', 1120, true, '{"icon_name":"wheelchair","icon_prefix":"fas","icon_category":"general","unicode":"f193"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-off_solid', 'Volume Off', 1122, true, '{"icon_name":"volume-off","icon_prefix":"fas","icon_category":"general","unicode":"f026"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lungs_solid', 'Lungs', 1123, true, '{"icon_name":"lungs","icon_prefix":"fas","icon_category":"general","unicode":"f604"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_barcode_solid', 'Barcode', 1125, true, '{"icon_name":"barcode","icon_prefix":"fas","icon_category":"general","unicode":"f02a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-ol_solid', 'List Ol', 1126, true, '{"icon_name":"list-ol","icon_prefix":"fas","icon_category":"general","unicode":"f0cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list12_solid', 'List12', 1127, true, '{"icon_name":"list12","icon_prefix":"fas","icon_category":"general","unicode":"f0cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-numeric_solid', 'List Numeric', 1128, true, '{"icon_name":"list-numeric","icon_prefix":"fas","icon_category":"general","unicode":"f0cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cube_solid', 'Cube', 1130, true, '{"icon_name":"cube","icon_prefix":"fas","icon_category":"general","unicode":"f1b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tape_solid', 'Tape', 1131, true, '{"icon_name":"tape","icon_prefix":"fas","icon_category":"general","unicode":"f4db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bomb_solid', 'Bomb', 1132, true, '{"icon_name":"bomb","icon_prefix":"fas","icon_category":"general","unicode":"f1e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scale-unbalanced_solid', 'Scale Unbalanced', 1133, true, '{"icon_name":"scale-unbalanced","icon_prefix":"fas","icon_category":"general","unicode":"f515"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_balance-scale-left_solid', 'Balance Scale Left', 1134, true, '{"icon_name":"balance-scale-left","icon_prefix":"fas","icon_category":"general","unicode":"f515"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ruler_solid', 'Ruler', 1137, true, '{"icon_name":"ruler","icon_prefix":"fas","icon_category":"general","unicode":"f545"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_i_solid', 'I', 1138, true, '{"icon_name":"i","icon_prefix":"fas","icon_category":"general","unicode":"49"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-xmark_solid', 'Volume Xmark', 1139, true, '{"icon_name":"volume-xmark","icon_prefix":"fas","icon_category":"general","unicode":"f6a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-mute_solid', 'Volume Mute', 1140, true, '{"icon_name":"volume-mute","icon_prefix":"fas","icon_category":"general","unicode":"f6a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_archway_solid', 'Archway', 1142, true, '{"icon_name":"archway","icon_prefix":"fas","icon_category":"general","unicode":"f557"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-digging_solid', 'Person Digging', 1143, true, '{"icon_name":"person-digging","icon_prefix":"fas","icon_category":"general","unicode":"f85e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_digging_solid', 'Digging', 1144, true, '{"icon_name":"digging","icon_prefix":"fas","icon_category":"general","unicode":"f85e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gauge-high_solid', 'Gauge High', 1145, true, '{"icon_name":"gauge-high","icon_prefix":"fas","icon_category":"general","unicode":"f625"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_genderless_solid', 'Genderless', 1148, true, '{"icon_name":"genderless","icon_prefix":"fas","icon_category":"general","unicode":"f22d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake_solid', 'Handshake', 1151, true, '{"icon_name":"handshake","icon_prefix":"fas","icon_category":"general","unicode":"f2b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-alt_solid', 'Handshake Alt', 1152, true, '{"icon_name":"handshake-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-simple_solid', 'Handshake Simple', 1153, true, '{"icon_name":"handshake-simple","icon_prefix":"fas","icon_category":"general","unicode":"f2b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-skiing_solid', 'Person Skiing', 1154, true, '{"icon_name":"person-skiing","icon_prefix":"fas","icon_category":"general","unicode":"f7c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skiing_solid', 'Skiing', 1155, true, '{"icon_name":"skiing","icon_prefix":"fas","icon_category":"general","unicode":"f7c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_igloo_solid', 'Igloo', 1158, true, '{"icon_name":"igloo","icon_prefix":"fas","icon_category":"general","unicode":"f7ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_y_solid', 'Y', 1161, true, '{"icon_name":"y","icon_prefix":"fas","icon_category":"general","unicode":"59"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-smile-wink_solid', 'Face Smile Wink', 1162, true, '{"icon_name":"face-smile-wink","icon_prefix":"fas","icon_category":"general","unicode":"f4da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smile-wink_solid', 'Smile Wink', 1163, true, '{"icon_name":"smile-wink","icon_prefix":"fas","icon_category":"general","unicode":"f4da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-four_solid', 'Dice Four', 1164, true, '{"icon_name":"dice-four","icon_prefix":"fas","icon_category":"general","unicode":"f524"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-squint-tears_solid', 'Face Grin Squint Tears', 1165, true, '{"icon_name":"face-grin-squint-tears","icon_prefix":"fas","icon_category":"general","unicode":"f586"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-squint-tears_solid', 'Grin Squint Tears', 1166, true, '{"icon_name":"grin-squint-tears","icon_prefix":"fas","icon_category":"general","unicode":"f586"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-down-to-line_solid', 'Arrows Down To Line', 1168, true, '{"icon_name":"arrows-down-to-line","icon_prefix":"fas","icon_category":"general","unicode":"e4b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_g_solid', 'G', 1169, true, '{"icon_name":"g","icon_prefix":"fas","icon_category":"general","unicode":"47"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vihara_solid', 'Vihara', 1170, true, '{"icon_name":"vihara","icon_prefix":"fas","icon_category":"general","unicode":"f6a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gauge-simple_solid', 'Gauge Simple', 1172, true, '{"icon_name":"gauge-simple","icon_prefix":"fas","icon_category":"general","unicode":"f629"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gauge-simple-med_solid', 'Gauge Simple Med', 1173, true, '{"icon_name":"gauge-simple-med","icon_prefix":"fas","icon_category":"general","unicode":"f629"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_right-left_solid', 'Right Left', 1175, true, '{"icon_name":"right-left","icon_prefix":"fas","icon_category":"general","unicode":"f362"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_exchange-alt_solid', 'Exchange Alt', 1176, true, '{"icon_name":"exchange-alt","icon_prefix":"fas","icon_category":"general","unicode":"f362"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pills_solid', 'Pills', 1177, true, '{"icon_name":"pills","icon_prefix":"fas","icon_category":"general","unicode":"f484"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_explosion_solid', 'Explosion', 1178, true, '{"icon_name":"explosion","icon_prefix":"fas","icon_category":"general","unicode":"e4e9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-down-to-people_solid', 'Arrows Down To People', 1179, true, '{"icon_name":"arrows-down-to-people","icon_prefix":"fas","icon_category":"general","unicode":"e4b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sleigh_solid', 'Sleigh', 1182, true, '{"icon_name":"sleigh","icon_prefix":"fas","icon_category":"general","unicode":"f7cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiwi-bird_solid', 'Kiwi Bird', 1186, true, '{"icon_name":"kiwi-bird","icon_prefix":"fas","icon_category":"general","unicode":"f535"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xmark_solid', 'Xmark', 1192, true, '{"icon_name":"xmark","icon_prefix":"fas","icon_category":"general","unicode":"f00d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_close_solid', 'Close', 1193, true, '{"icon_name":"close","icon_prefix":"fas","icon_category":"general","unicode":"f00d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_multiply_solid', 'Multiply', 1194, true, '{"icon_name":"multiply","icon_prefix":"fas","icon_category":"general","unicode":"f00d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_remove_solid', 'Remove', 1195, true, '{"icon_name":"remove","icon_prefix":"fas","icon_category":"general","unicode":"f00d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shapes_solid', 'Shapes', 1197, true, '{"icon_name":"shapes","icon_prefix":"fas","icon_category":"general","unicode":"f61f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-one_solid', 'Dice One', 1199, true, '{"icon_name":"dice-one","icon_prefix":"fas","icon_category":"general","unicode":"f525"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pepper-hot_solid', 'Pepper Hot', 1201, true, '{"icon_name":"pepper-hot","icon_prefix":"fas","icon_category":"general","unicode":"f816"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_droplet-slash_solid', 'Droplet Slash', 1202, true, '{"icon_name":"droplet-slash","icon_prefix":"fas","icon_category":"general","unicode":"f5c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tint-slash_solid', 'Tint Slash', 1203, true, '{"icon_name":"tint-slash","icon_prefix":"fas","icon_category":"general","unicode":"f5c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_droplet_solid', 'Droplet', 1204, true, '{"icon_name":"droplet","icon_prefix":"fas","icon_category":"general","unicode":"f043"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tint_solid', 'Tint', 1205, true, '{"icon_name":"tint","icon_prefix":"fas","icon_category":"general","unicode":"f043"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pentagon_solid', 'Pentagon', 1213, true, '{"icon_name":"pentagon","icon_prefix":"fas","icon_category":"general","unicode":"e790"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_republican_solid', 'Republican', 1214, true, '{"icon_name":"republican","icon_prefix":"fas","icon_category":"general","unicode":"f75e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shop_solid', 'Shop', 1215, true, '{"icon_name":"shop","icon_prefix":"fas","icon_category":"general","unicode":"f54f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_store-alt_solid', 'Store Alt', 1216, true, '{"icon_name":"store-alt","icon_prefix":"fas","icon_category":"general","unicode":"f54f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_film_solid', 'Film', 1217, true, '{"icon_name":"film","icon_prefix":"fas","icon_category":"general","unicode":"f008"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_film-alt_solid', 'Film Alt', 1218, true, '{"icon_name":"film-alt","icon_prefix":"fas","icon_category":"general","unicode":"f008"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_film-simple_solid', 'Film Simple', 1219, true, '{"icon_name":"film-simple","icon_prefix":"fas","icon_category":"general","unicode":"f008"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tags_solid', 'Tags', 1222, true, '{"icon_name":"tags","icon_prefix":"fas","icon_category":"general","unicode":"f02c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gun_solid', 'Gun', 1223, true, '{"icon_name":"gun","icon_prefix":"fas","icon_category":"general","unicode":"e19b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_oil-well_solid', 'Oil Well', 1229, true, '{"icon_name":"oil-well","icon_prefix":"fas","icon_category":"general","unicode":"e532"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachograph-digital_solid', 'Tachograph Digital', 1230, true, '{"icon_name":"tachograph-digital","icon_prefix":"fas","icon_category":"general","unicode":"f566"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_digital-tachograph_solid', 'Digital Tachograph', 1231, true, '{"icon_name":"digital-tachograph","icon_prefix":"fas","icon_category":"general","unicode":"f566"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tablet_solid', 'Tablet', 1232, true, '{"icon_name":"tablet","icon_prefix":"fas","icon_category":"general","unicode":"f3fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tablet-android_solid', 'Tablet Android', 1233, true, '{"icon_name":"tablet-android","icon_prefix":"fas","icon_category":"general","unicode":"f3fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ruble-sign_solid', 'Ruble Sign', 1234, true, '{"icon_name":"ruble-sign","icon_prefix":"fas","icon_category":"general","unicode":"f158"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rouble_solid', 'Rouble', 1235, true, '{"icon_name":"rouble","icon_prefix":"fas","icon_category":"general","unicode":"f158"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rub_solid', 'Rub', 1236, true, '{"icon_name":"rub","icon_prefix":"fas","icon_category":"general","unicode":"f158"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ruble_solid', 'Ruble', 1237, true, '{"icon_name":"ruble","icon_prefix":"fas","icon_category":"general","unicode":"f158"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_closed-captioning_solid', 'Closed Captioning', 1238, true, '{"icon_name":"closed-captioning","icon_prefix":"fas","icon_category":"general","unicode":"f20a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen_solid', 'Pen', 1239, true, '{"icon_name":"pen","icon_prefix":"fas","icon_category":"general","unicode":"f304"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-screen_solid', 'Mobile Screen', 1242, true, '{"icon_name":"mobile-screen","icon_prefix":"fas","icon_category":"general","unicode":"f3cf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-android-alt_solid', 'Mobile Android Alt', 1243, true, '{"icon_name":"mobile-android-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3cf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_guarani-sign_solid', 'Guarani Sign', 1244, true, '{"icon_name":"guarani-sign","icon_prefix":"fas","icon_category":"general","unicode":"e19a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bag-shopping_solid', 'Bag Shopping', 1245, true, '{"icon_name":"bag-shopping","icon_prefix":"fas","icon_category":"general","unicode":"f290"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shopping-bag_solid', 'Shopping Bag', 1246, true, '{"icon_name":"shopping-bag","icon_prefix":"fas","icon_category":"general","unicode":"f290"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cubes_solid', 'Cubes', 1251, true, '{"icon_name":"cubes","icon_prefix":"fas","icon_category":"general","unicode":"f1b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bacon_solid', 'Bacon', 1254, true, '{"icon_name":"bacon","icon_prefix":"fas","icon_category":"general","unicode":"f7e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-falling-burst_solid', 'Person Falling Burst', 1255, true, '{"icon_name":"person-falling-burst","icon_prefix":"fas","icon_category":"general","unicode":"e547"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quote-right_solid', 'Quote Right', 1256, true, '{"icon_name":"quote-right","icon_prefix":"fas","icon_category":"general","unicode":"f10e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quote-right-alt_solid', 'Quote Right Alt', 1257, true, '{"icon_name":"quote-right-alt","icon_prefix":"fas","icon_category":"general","unicode":"f10e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-medical-flag_solid', 'House Medical Flag', 1258, true, '{"icon_name":"house-medical-flag","icon_prefix":"fas","icon_category":"general","unicode":"e514"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_prescription_solid', 'Prescription', 1259, true, '{"icon_name":"prescription","icon_prefix":"fas","icon_category":"general","unicode":"f5b1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-three_solid', 'Dice Three', 1260, true, '{"icon_name":"dice-three","icon_prefix":"fas","icon_category":"general","unicode":"f527"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drivers-license_solid', 'Drivers License', 1263, true, '{"icon_name":"drivers-license","icon_prefix":"fas","icon_category":"general","unicode":"f2c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh-beam_solid', 'Face Laugh Beam', 1266, true, '{"icon_name":"face-laugh-beam","icon_prefix":"fas","icon_category":"general","unicode":"f59a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh-beam_solid', 'Laugh Beam', 1267, true, '{"icon_name":"laugh-beam","icon_prefix":"fas","icon_category":"general","unicode":"f59a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_leaf_solid', 'Leaf', 1268, true, '{"icon_name":"leaf","icon_prefix":"fas","icon_category":"general","unicode":"f06c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_redo-alt_solid', 'Redo Alt', 1271, true, '{"icon_name":"redo-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tooth_solid', 'Tooth', 1273, true, '{"icon_name":"tooth","icon_prefix":"fas","icon_category":"general","unicode":"f5c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_motorcycle_solid', 'Motorcycle', 1275, true, '{"icon_name":"motorcycle","icon_prefix":"fas","icon_category":"general","unicode":"f21c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_backward-fast_solid', 'Backward Fast', 1276, true, '{"icon_name":"backward-fast","icon_prefix":"fas","icon_category":"general","unicode":"f049"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fast-backward_solid', 'Fast Backward', 1277, true, '{"icon_name":"fast-backward","icon_prefix":"fas","icon_category":"general","unicode":"f049"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_address-book_solid', 'Address Book', 1278, true, '{"icon_name":"address-book","icon_prefix":"fas","icon_category":"general","unicode":"f2b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_contact-book_solid', 'Contact Book', 1279, true, '{"icon_name":"contact-book","icon_prefix":"fas","icon_category":"general","unicode":"f2b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reply-all_solid', 'Reply All', 1285, true, '{"icon_name":"reply-all","icon_prefix":"fas","icon_category":"general","unicode":"f122"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mail-reply-all_solid', 'Mail Reply All', 1286, true, '{"icon_name":"mail-reply-all","icon_prefix":"fas","icon_category":"general","unicode":"f122"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_universal-access_solid', 'Universal Access', 1287, true, '{"icon_name":"universal-access","icon_prefix":"fas","icon_category":"general","unicode":"f29a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilet-paper_solid', 'Toilet Paper', 1288, true, '{"icon_name":"toilet-paper","icon_prefix":"fas","icon_category":"general","unicode":"f71e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilet-paper-alt_solid', 'Toilet Paper Alt', 1289, true, '{"icon_name":"toilet-paper-alt","icon_prefix":"fas","icon_category":"general","unicode":"f71e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toilet-paper-blank_solid', 'Toilet Paper Blank', 1290, true, '{"icon_name":"toilet-paper-blank","icon_prefix":"fas","icon_category":"general","unicode":"f71e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pizza-slice_solid', 'Pizza Slice', 1292, true, '{"icon_name":"pizza-slice","icon_prefix":"fas","icon_category":"general","unicode":"f818"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spray-can_solid', 'Spray Can', 1293, true, '{"icon_name":"spray-can","icon_prefix":"fas","icon_category":"general","unicode":"f5bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-low_solid', 'Volume Low', 1294, true, '{"icon_name":"volume-low","icon_prefix":"fas","icon_category":"general","unicode":"f027"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-down_solid', 'Volume Down', 1295, true, '{"icon_name":"volume-down","icon_prefix":"fas","icon_category":"general","unicode":"f027"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cross_solid', 'Cross', 1296, true, '{"icon_name":"cross","icon_prefix":"fas","icon_category":"general","unicode":"f654"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person_solid', 'Person', 1297, true, '{"icon_name":"person","icon_prefix":"fas","icon_category":"general","unicode":"f183"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_male_solid', 'Male', 1298, true, '{"icon_name":"male","icon_prefix":"fas","icon_category":"general","unicode":"f183"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fish_solid', 'Fish', 1301, true, '{"icon_name":"fish","icon_prefix":"fas","icon_category":"general","unicode":"f578"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drumstick-bite_solid', 'Drumstick Bite', 1302, true, '{"icon_name":"drumstick-bite","icon_prefix":"fas","icon_category":"general","unicode":"f6d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-simple_solid', 'Chart Simple', 1303, true, '{"icon_name":"chart-simple","icon_prefix":"fas","icon_category":"general","unicode":"e473"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_p_solid', 'P', 1305, true, '{"icon_name":"p","icon_prefix":"fas","icon_category":"general","unicode":"50"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jet-fighter-up_solid', 'Jet Fighter Up', 1306, true, '{"icon_name":"jet-fighter-up","icon_prefix":"fas","icon_category":"general","unicode":"e518"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sheet-plastic_solid', 'Sheet Plastic', 1308, true, '{"icon_name":"sheet-plastic","icon_prefix":"fas","icon_category":"general","unicode":"e571"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_v_solid', 'V', 1309, true, '{"icon_name":"v","icon_prefix":"fas","icon_category":"general","unicode":"56"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list_solid', 'List', 1310, true, '{"icon_name":"list","icon_prefix":"fas","icon_category":"general","unicode":"f03a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_solar-panel_solid', 'Solar Panel', 1312, true, '{"icon_name":"solar-panel","icon_prefix":"fas","icon_category":"general","unicode":"f5ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_land-mine-on_solid', 'Land Mine On', 1313, true, '{"icon_name":"land-mine-on","icon_prefix":"fas","icon_category":"general","unicode":"e51b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bus_solid', 'Bus', 1317, true, '{"icon_name":"bus","icon_prefix":"fas","icon_category":"general","unicode":"f207"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quote-left_solid', 'Quote Left', 1319, true, '{"icon_name":"quote-left","icon_prefix":"fas","icon_category":"general","unicode":"f10d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quote-left-alt_solid', 'Quote Left Alt', 1320, true, '{"icon_name":"quote-left-alt","icon_prefix":"fas","icon_category":"general","unicode":"f10d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earth-asia_solid', 'Earth Asia', 1322, true, '{"icon_name":"earth-asia","icon_prefix":"fas","icon_category":"general","unicode":"f57e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cent-sign_solid', 'Cent Sign', 1324, true, '{"icon_name":"cent-sign","icon_prefix":"fas","icon_category":"general","unicode":"e3f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_martini-glass_solid', 'Martini Glass', 1327, true, '{"icon_name":"martini-glass","icon_prefix":"fas","icon_category":"general","unicode":"f57b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glass-martini-alt_solid', 'Glass Martini Alt', 1328, true, '{"icon_name":"glass-martini-alt","icon_prefix":"fas","icon_category":"general","unicode":"f57b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug_solid', 'Plug', 1329, true, '{"icon_name":"plug","icon_prefix":"fas","icon_category":"general","unicode":"f1e6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_panorama_solid', 'Panorama', 1330, true, '{"icon_name":"panorama","icon_prefix":"fas","icon_category":"general","unicode":"e209"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-ramp-box_solid', 'Truck Ramp Box', 1337, true, '{"icon_name":"truck-ramp-box","icon_prefix":"fas","icon_category":"general","unicode":"f4de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-loading_solid', 'Truck Loading', 1338, true, '{"icon_name":"truck-loading","icon_prefix":"fas","icon_category":"general","unicode":"f4de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-down_solid', 'Angle Down', 1339, true, '{"icon_name":"angle-down","icon_prefix":"fas","icon_category":"general","unicode":"f107"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bowling-ball_solid', 'Bowling Ball', 1345, true, '{"icon_name":"bowling-ball","icon_prefix":"fas","icon_category":"general","unicode":"f436"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ghost_solid', 'Ghost', 1350, true, '{"icon_name":"ghost","icon_prefix":"fas","icon_category":"general","unicode":"f6e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-swimming_solid', 'Person Swimming', 1354, true, '{"icon_name":"person-swimming","icon_prefix":"fas","icon_category":"general","unicode":"f5c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_swimmer_solid', 'Swimmer', 1355, true, '{"icon_name":"swimmer","icon_prefix":"fas","icon_category":"general","unicode":"f5c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pie-chart_solid', 'Pie Chart', 1359, true, '{"icon_name":"pie-chart","icon_prefix":"fas","icon_category":"general","unicode":"f200"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_frog_solid', 'Frog', 1360, true, '{"icon_name":"frog","icon_prefix":"fas","icon_category":"general","unicode":"f52e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wine-bottle_solid', 'Wine Bottle', 1361, true, '{"icon_name":"wine-bottle","icon_prefix":"fas","icon_category":"general","unicode":"f72f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-medical_solid', 'House Medical', 1365, true, '{"icon_name":"house-medical","icon_prefix":"fas","icon_category":"general","unicode":"e3b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tongue-wink_solid', 'Face Grin Tongue Wink', 1370, true, '{"icon_name":"face-grin-tongue-wink","icon_prefix":"fas","icon_category":"general","unicode":"f58b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tongue-wink_solid', 'Grin Tongue Wink', 1371, true, '{"icon_name":"grin-tongue-wink","icon_prefix":"fas","icon_category":"general","unicode":"f58b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_l_solid', 'L', 1372, true, '{"icon_name":"l","icon_prefix":"fas","icon_category":"general","unicode":"4c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-amount-desc_solid', 'Sort Amount Desc', 1374, true, '{"icon_name":"sort-amount-desc","icon_prefix":"fas","icon_category":"general","unicode":"f884"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-amount-down-alt_solid', 'Sort Amount Down Alt', 1375, true, '{"icon_name":"sort-amount-down-alt","icon_prefix":"fas","icon_category":"general","unicode":"f884"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spoon_solid', 'Spoon', 1378, true, '{"icon_name":"spoon","icon_prefix":"fas","icon_category":"general","unicode":"f2e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_utensil-spoon_solid', 'Utensil Spoon', 1379, true, '{"icon_name":"utensil-spoon","icon_prefix":"fas","icon_category":"general","unicode":"f2e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spaghetti-monster-flying_solid', 'Spaghetti Monster Flying', 1383, true, '{"icon_name":"spaghetti-monster-flying","icon_prefix":"fas","icon_category":"general","unicode":"f67b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pastafarianism_solid', 'Pastafarianism', 1384, true, '{"icon_name":"pastafarianism","icon_prefix":"fas","icon_category":"general","unicode":"f67b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_martini-glass-citrus_solid', 'Martini Glass Citrus', 1385, true, '{"icon_name":"martini-glass-citrus","icon_prefix":"fas","icon_category":"general","unicode":"f561"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cocktail_solid', 'Cocktail', 1386, true, '{"icon_name":"cocktail","icon_prefix":"fas","icon_category":"general","unicode":"f561"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bullhorn_solid', 'Bullhorn', 1387, true, '{"icon_name":"bullhorn","icon_prefix":"fas","icon_category":"general","unicode":"f0a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_box-tissue_solid', 'Box Tissue', 1388, true, '{"icon_name":"box-tissue","icon_prefix":"fas","icon_category":"general","unicode":"e05b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-numeric-asc_solid', 'Sort Numeric Asc', 1393, true, '{"icon_name":"sort-numeric-asc","icon_prefix":"fas","icon_category":"general","unicode":"f162"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-numeric-down_solid', 'Sort Numeric Down', 1394, true, '{"icon_name":"sort-numeric-down","icon_prefix":"fas","icon_category":"general","unicode":"f162"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-spock_solid', 'Hand Spock', 1395, true, '{"icon_name":"hand-spock","icon_prefix":"fas","icon_category":"general","unicode":"f259"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wand-magic-sparkles_solid', 'Wand Magic Sparkles', 1396, true, '{"icon_name":"wand-magic-sparkles","icon_prefix":"fas","icon_category":"general","unicode":"e2ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magic-wand-sparkles_solid', 'Magic Wand Sparkles', 1397, true, '{"icon_name":"magic-wand-sparkles","icon_prefix":"fas","icon_category":"general","unicode":"e2ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-slash_solid', 'Handshake Slash', 1400, true, '{"icon_name":"handshake-slash","icon_prefix":"fas","icon_category":"general","unicode":"e060"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-alt-slash_solid', 'Handshake Alt Slash', 1401, true, '{"icon_name":"handshake-alt-slash","icon_prefix":"fas","icon_category":"general","unicode":"e060"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-simple-slash_solid', 'Handshake Simple Slash', 1402, true, '{"icon_name":"handshake-simple-slash","icon_prefix":"fas","icon_category":"general","unicode":"e060"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-d20_solid', 'Dice D20', 1404, true, '{"icon_name":"dice-d20","icon_prefix":"fas","icon_category":"general","unicode":"f6cf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-alpha-desc_solid', 'Sort Alpha Desc', 1406, true, '{"icon_name":"sort-alpha-desc","icon_prefix":"fas","icon_category":"general","unicode":"f881"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-alpha-down-alt_solid', 'Sort Alpha Down Alt', 1407, true, '{"icon_name":"sort-alpha-down-alt","icon_prefix":"fas","icon_category":"general","unicode":"f881"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_brush_solid', 'Brush', 1408, true, '{"icon_name":"brush","icon_prefix":"fas","icon_category":"general","unicode":"f55d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-amount-up-alt_solid', 'Sort Amount Up Alt', 1411, true, '{"icon_name":"sort-amount-up-alt","icon_prefix":"fas","icon_category":"general","unicode":"f885"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grip-vertical_solid', 'Grip Vertical', 1412, true, '{"icon_name":"grip-vertical","icon_prefix":"fas","icon_category":"general","unicode":"f58e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grid-vertical_solid', 'Grid Vertical', 1413, true, '{"icon_name":"grid-vertical","icon_prefix":"fas","icon_category":"general","unicode":"f58e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-column_solid', 'Chart Column', 1415, true, '{"icon_name":"chart-column","icon_prefix":"fas","icon_category":"general","unicode":"e0e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tv_solid', 'Tv', 1417, true, '{"icon_name":"tv","icon_prefix":"fas","icon_category":"general","unicode":"f26c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_television_solid', 'Television', 1418, true, '{"icon_name":"television","icon_prefix":"fas","icon_category":"general","unicode":"f26c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tv-alt_solid', 'Tv Alt', 1419, true, '{"icon_name":"tv-alt","icon_prefix":"fas","icon_category":"general","unicode":"f26c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_section_solid', 'Section', 1420, true, '{"icon_name":"section","icon_prefix":"fas","icon_category":"general","unicode":"e447"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_peace_solid', 'Peace', 1421, true, '{"icon_name":"peace","icon_prefix":"fas","icon_category":"general","unicode":"f67c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flag_solid', 'Flag', 1423, true, '{"icon_name":"flag","icon_prefix":"fas","icon_category":"general","unicode":"f024"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_warning_solid', 'Warning', 1426, true, '{"icon_name":"warning","icon_prefix":"fas","icon_category":"general","unicode":"f071"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mortar-board_solid', 'Mortar Board', 1429, true, '{"icon_name":"mortar-board","icon_prefix":"fas","icon_category":"general","unicode":"f19d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_store_solid', 'Store', 1430, true, '{"icon_name":"store","icon_prefix":"fas","icon_category":"general","unicode":"f54e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mug-saucer_solid', 'Mug Saucer', 1433, true, '{"icon_name":"mug-saucer","icon_prefix":"fas","icon_category":"general","unicode":"f0f4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_coffee_solid', 'Coffee', 1434, true, '{"icon_name":"coffee","icon_prefix":"fas","icon_category":"general","unicode":"f0f4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lemon_solid', 'Lemon', 1435, true, '{"icon_name":"lemon","icon_prefix":"fas","icon_category":"general","unicode":"f094"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_q_solid', 'Q', 1437, true, '{"icon_name":"q","icon_prefix":"fas","icon_category":"general","unicode":"51"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paint-roller_solid', 'Paint Roller', 1439, true, '{"icon_name":"paint-roller","icon_prefix":"fas","icon_category":"general","unicode":"f5aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-high_solid', 'Volume High', 1440, true, '{"icon_name":"volume-high","icon_prefix":"fas","icon_category":"general","unicode":"f028"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-up_solid', 'Volume Up', 1441, true, '{"icon_name":"volume-up","icon_prefix":"fas","icon_category":"general","unicode":"f028"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mercury_solid', 'Mercury', 1443, true, '{"icon_name":"mercury","icon_prefix":"fas","icon_category":"general","unicode":"f223"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_anchor_solid', 'Anchor', 1444, true, '{"icon_name":"anchor","icon_prefix":"fas","icon_category":"general","unicode":"f13d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_parking_solid', 'Parking', 1446, true, '{"icon_name":"parking","icon_prefix":"fas","icon_category":"general","unicode":"f540"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hanukiah_solid', 'Hanukiah', 1447, true, '{"icon_name":"hanukiah","icon_prefix":"fas","icon_category":"general","unicode":"f6e6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_undo-alt_solid', 'Undo Alt', 1451, true, '{"icon_name":"undo-alt","icon_prefix":"fas","icon_category":"general","unicode":"f2ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heading_solid', 'Heading', 1452, true, '{"icon_name":"heading","icon_prefix":"fas","icon_category":"general","unicode":"f1dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_header_solid', 'Header', 1453, true, '{"icon_name":"header","icon_prefix":"fas","icon_category":"general","unicode":"f1dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crosshairs_solid', 'Crosshairs', 1454, true, '{"icon_name":"crosshairs","icon_prefix":"fas","icon_category":"general","unicode":"f05b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_r_solid', 'R', 1457, true, '{"icon_name":"r","icon_prefix":"fas","icon_category":"general","unicode":"52"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gopuram_solid', 'Gopuram', 1459, true, '{"icon_name":"gopuram","icon_prefix":"fas","icon_category":"general","unicode":"f664"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_business-time_solid', 'Business Time', 1462, true, '{"icon_name":"business-time","icon_prefix":"fas","icon_category":"general","unicode":"f64a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fire-extinguisher_solid', 'Fire Extinguisher', 1464, true, '{"icon_name":"fire-extinguisher","icon_prefix":"fas","icon_category":"general","unicode":"f134"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-laptop_solid', 'House Laptop', 1469, true, '{"icon_name":"house-laptop","icon_prefix":"fas","icon_category":"general","unicode":"e066"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laptop-house_solid', 'Laptop House', 1470, true, '{"icon_name":"laptop-house","icon_prefix":"fas","icon_category":"general","unicode":"e066"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_download_solid', 'Download', 1471, true, '{"icon_name":"download","icon_prefix":"fas","icon_category":"general","unicode":"f019"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_couch_solid', 'Couch', 1472, true, '{"icon_name":"couch","icon_prefix":"fas","icon_category":"general","unicode":"f4b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scissors_solid', 'Scissors', 1474, true, '{"icon_name":"scissors","icon_prefix":"fas","icon_category":"general","unicode":"f0c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cut_solid', 'Cut', 1475, true, '{"icon_name":"cut","icon_prefix":"fas","icon_category":"general","unicode":"f0c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bug_solid', 'Bug', 1476, true, '{"icon_name":"bug","icon_prefix":"fas","icon_category":"general","unicode":"f188"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign-out_solid', 'Sign Out', 1478, true, '{"icon_name":"sign-out","icon_prefix":"fas","icon_category":"general","unicode":"f08b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-hand_solid', 'Hand Holding Hand', 1479, true, '{"icon_name":"hand-holding-hand","icon_prefix":"fas","icon_category":"general","unicode":"e4f7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stroopwafel_solid', 'Stroopwafel', 1480, true, '{"icon_name":"stroopwafel","icon_prefix":"fas","icon_category":"general","unicode":"f551"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_child_solid', 'Child', 1481, true, '{"icon_name":"child","icon_prefix":"fas","icon_category":"general","unicode":"f1ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ice-cream_solid', 'Ice Cream', 1482, true, '{"icon_name":"ice-cream","icon_prefix":"fas","icon_category":"general","unicode":"f810"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_computer-mouse_solid', 'Computer Mouse', 1483, true, '{"icon_name":"computer-mouse","icon_prefix":"fas","icon_category":"general","unicode":"f8cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mouse_solid', 'Mouse', 1484, true, '{"icon_name":"mouse","icon_prefix":"fas","icon_category":"general","unicode":"f8cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_faucet_solid', 'Faucet', 1485, true, '{"icon_name":"faucet","icon_prefix":"fas","icon_category":"general","unicode":"e005"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_award_solid', 'Award', 1486, true, '{"icon_name":"award","icon_prefix":"fas","icon_category":"general","unicode":"f559"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-drowning_solid', 'Person Drowning', 1487, true, '{"icon_name":"person-drowning","icon_prefix":"fas","icon_category":"general","unicode":"e545"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-military-rifle_solid', 'Person Military Rifle', 1492, true, '{"icon_name":"person-military-rifle","icon_prefix":"fas","icon_category":"general","unicode":"e54b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_toggle-on_solid', 'Toggle On', 1493, true, '{"icon_name":"toggle-on","icon_prefix":"fas","icon_category":"general","unicode":"f205"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lungs-virus_solid', 'Lungs Virus', 1494, true, '{"icon_name":"lungs-virus","icon_prefix":"fas","icon_category":"general","unicode":"e067"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-tennis-paddle-ball_solid', 'Table Tennis Paddle Ball', 1495, true, '{"icon_name":"table-tennis-paddle-ball","icon_prefix":"fas","icon_category":"general","unicode":"f45d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ping-pong-paddle-ball_solid', 'Ping Pong Paddle Ball', 1496, true, '{"icon_name":"ping-pong-paddle-ball","icon_prefix":"fas","icon_category":"general","unicode":"f45d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-tennis_solid', 'Table Tennis', 1497, true, '{"icon_name":"table-tennis","icon_prefix":"fas","icon_category":"general","unicode":"f45d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_boxes-packing_solid', 'Boxes Packing', 1498, true, '{"icon_name":"boxes-packing","icon_prefix":"fas","icon_category":"general","unicode":"e4c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-chalkboard_solid', 'Person Chalkboard', 1499, true, '{"icon_name":"person-chalkboard","icon_prefix":"fas","icon_category":"general","unicode":"e53d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice-two_solid', 'Dice Two', 1500, true, '{"icon_name":"dice-two","icon_prefix":"fas","icon_category":"general","unicode":"f528"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_exchange_solid', 'Exchange', 1502, true, '{"icon_name":"exchange","icon_prefix":"fas","icon_category":"general","unicode":"f0ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_football_solid', 'Football', 1503, true, '{"icon_name":"football","icon_prefix":"fas","icon_category":"general","unicode":"f44e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_football-ball_solid', 'Football Ball', 1504, true, '{"icon_name":"football-ball","icon_prefix":"fas","icon_category":"general","unicode":"f44e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-monster_solid', 'Truck Monster', 1505, true, '{"icon_name":"truck-monster","icon_prefix":"fas","icon_category":"general","unicode":"f63b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_asterisk_solid', 'Asterisk', 1506, true, '{"icon_name":"asterisk","icon_prefix":"fas","icon_category":"general","unicode":"2a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_child-dress_solid', 'Child Dress', 1510, true, '{"icon_name":"child-dress","icon_prefix":"fas","icon_category":"general","unicode":"e59c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-kiss-beam_solid', 'Face Kiss Beam', 1511, true, '{"icon_name":"face-kiss-beam","icon_prefix":"fas","icon_category":"general","unicode":"f597"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiss-beam_solid', 'Kiss Beam', 1512, true, '{"icon_name":"kiss-beam","icon_prefix":"fas","icon_category":"general","unicode":"f597"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-restore-alt_solid', 'Trash Restore Alt', 1514, true, '{"icon_name":"trash-restore-alt","icon_prefix":"fas","icon_category":"general","unicode":"f82a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font_solid', 'Font', 1515, true, '{"icon_name":"font","icon_prefix":"fas","icon_category":"general","unicode":"f031"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bore-hole_solid', 'Bore Hole', 1516, true, '{"icon_name":"bore-hole","icon_prefix":"fas","icon_category":"general","unicode":"e4c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_virus-covid_solid', 'Virus Covid', 1517, true, '{"icon_name":"virus-covid","icon_prefix":"fas","icon_category":"general","unicode":"e4a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_language_solid', 'Language', 1519, true, '{"icon_name":"language","icon_prefix":"fas","icon_category":"general","unicode":"f1ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-halved_solid', 'Shield Halved', 1520, true, '{"icon_name":"shield-halved","icon_prefix":"fas","icon_category":"general","unicode":"f3ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-biking_solid', 'Person Biking', 1525, true, '{"icon_name":"person-biking","icon_prefix":"fas","icon_category":"general","unicode":"f84a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_biking_solid', 'Biking', 1526, true, '{"icon_name":"biking","icon_prefix":"fas","icon_category":"general","unicode":"f84a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-open-reader_solid', 'Book Open Reader', 1527, true, '{"icon_name":"book-open-reader","icon_prefix":"fas","icon_category":"general","unicode":"f5da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-reader_solid', 'Book Reader', 1528, true, '{"icon_name":"book-reader","icon_prefix":"fas","icon_category":"general","unicode":"f5da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tower-broadcast_solid', 'Tower Broadcast', 1530, true, '{"icon_name":"tower-broadcast","icon_prefix":"fas","icon_category":"general","unicode":"f519"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_broadcast-tower_solid', 'Broadcast Tower', 1531, true, '{"icon_name":"broadcast-tower","icon_prefix":"fas","icon_category":"general","unicode":"f519"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_minimize_solid', 'Minimize', 1532, true, '{"icon_name":"minimize","icon_prefix":"fas","icon_category":"general","unicode":"f78c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compress-arrows-alt_solid', 'Compress Arrows Alt', 1533, true, '{"icon_name":"compress-arrows-alt","icon_prefix":"fas","icon_category":"general","unicode":"f78c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laptop-medical_solid', 'Laptop Medical', 1535, true, '{"icon_name":"laptop-medical","icon_prefix":"fas","icon_category":"general","unicode":"f812"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bread-slice_solid', 'Bread Slice', 1536, true, '{"icon_name":"bread-slice","icon_prefix":"fas","icon_category":"general","unicode":"f7ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mask-face_solid', 'Mask Face', 1539, true, '{"icon_name":"mask-face","icon_prefix":"fas","icon_category":"general","unicode":"e1d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bong_solid', 'Bong', 1540, true, '{"icon_name":"bong","icon_prefix":"fas","icon_category":"general","unicode":"f55c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-bridge_solid', 'Road Bridge', 1541, true, '{"icon_name":"road-bridge","icon_prefix":"fas","icon_category":"general","unicode":"e563"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-numeric-up-alt_solid', 'Sort Numeric Up Alt', 1543, true, '{"icon_name":"sort-numeric-up-alt","icon_prefix":"fas","icon_category":"general","unicode":"f887"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mountain-city_solid', 'Mountain City', 1544, true, '{"icon_name":"mountain-city","icon_prefix":"fas","icon_category":"general","unicode":"e52e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-numeric-desc_solid', 'Sort Numeric Desc', 1546, true, '{"icon_name":"sort-numeric-desc","icon_prefix":"fas","icon_category":"general","unicode":"f886"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-numeric-down-alt_solid', 'Sort Numeric Down Alt', 1547, true, '{"icon_name":"sort-numeric-down-alt","icon_prefix":"fas","icon_category":"general","unicode":"f886"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-wide_solid', 'Face Grin Wide', 1548, true, '{"icon_name":"face-grin-wide","icon_prefix":"fas","icon_category":"general","unicode":"f581"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-alt_solid', 'Grin Alt', 1549, true, '{"icon_name":"grin-alt","icon_prefix":"fas","icon_category":"general","unicode":"f581"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_poop_solid', 'Poop', 1550, true, '{"icon_name":"poop","icon_prefix":"fas","icon_category":"general","unicode":"f619"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dharmachakra_solid', 'Dharmachakra', 1551, true, '{"icon_name":"dharmachakra","icon_prefix":"fas","icon_category":"general","unicode":"f655"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ankh_solid', 'Ankh', 1554, true, '{"icon_name":"ankh","icon_prefix":"fas","icon_category":"general","unicode":"f644"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diamond_solid', 'Diamond', 1555, true, '{"icon_name":"diamond","icon_prefix":"fas","icon_category":"general","unicode":"f219"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_subscript_solid', 'Subscript', 1556, true, '{"icon_name":"subscript","icon_prefix":"fas","icon_category":"general","unicode":"f12c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rupee-sign_solid', 'Rupee Sign', 1557, true, '{"icon_name":"rupee-sign","icon_prefix":"fas","icon_category":"general","unicode":"f156"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rupee_solid', 'Rupee', 1558, true, '{"icon_name":"rupee","icon_prefix":"fas","icon_category":"general","unicode":"f156"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-rifle_solid', 'Person Rifle', 1559, true, '{"icon_name":"person-rifle","icon_prefix":"fas","icon_category":"general","unicode":"e54e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_d_solid', 'D', 1560, true, '{"icon_name":"d","icon_prefix":"fas","icon_category":"general","unicode":"44"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_teeth_solid', 'Teeth', 1562, true, '{"icon_name":"teeth","icon_prefix":"fas","icon_category":"general","unicode":"f62e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass-dollar_solid', 'Magnifying Glass Dollar', 1563, true, '{"icon_name":"magnifying-glass-dollar","icon_prefix":"fas","icon_category":"general","unicode":"f688"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dumpster-fire_solid', 'Dumpster Fire', 1565, true, '{"icon_name":"dumpster-fire","icon_prefix":"fas","icon_category":"general","unicode":"f794"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_upload_solid', 'Upload', 1566, true, '{"icon_name":"upload","icon_prefix":"fas","icon_category":"general","unicode":"f093"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vial-virus_solid', 'Vial Virus', 1571, true, '{"icon_name":"vial-virus","icon_prefix":"fas","icon_category":"general","unicode":"e597"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paw_solid', 'Paw', 1573, true, '{"icon_name":"paw","icon_prefix":"fas","icon_category":"general","unicode":"f1b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_helmet-safety_solid', 'Helmet Safety', 1574, true, '{"icon_name":"helmet-safety","icon_prefix":"fas","icon_category":"general","unicode":"f807"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_e_solid', 'E', 1577, true, '{"icon_name":"e","icon_prefix":"fas","icon_category":"general","unicode":"45"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh-squint_solid', 'Face Laugh Squint', 1578, true, '{"icon_name":"face-laugh-squint","icon_prefix":"fas","icon_category":"general","unicode":"f59b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh-squint_solid', 'Laugh Squint', 1579, true, '{"icon_name":"laugh-squint","icon_prefix":"fas","icon_category":"general","unicode":"f59b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_down-left-and-up-right-to-center_solid', 'Down Left And Up Right To Center', 1580, true, '{"icon_name":"down-left-and-up-right-to-center","icon_prefix":"fas","icon_category":"general","unicode":"f422"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compress-alt_solid', 'Compress Alt', 1581, true, '{"icon_name":"compress-alt","icon_prefix":"fas","icon_category":"general","unicode":"f422"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gifts_solid', 'Gifts', 1582, true, '{"icon_name":"gifts","icon_prefix":"fas","icon_category":"general","unicode":"f79c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bed_solid', 'Bed', 1583, true, '{"icon_name":"bed","icon_prefix":"fas","icon_category":"general","unicode":"f236"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-transfer_solid', 'Money Bill Transfer', 1584, true, '{"icon_name":"money-bill-transfer","icon_prefix":"fas","icon_category":"general","unicode":"e528"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-running_solid', 'Person Running', 1585, true, '{"icon_name":"person-running","icon_prefix":"fas","icon_category":"general","unicode":"f70c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_running_solid', 'Running', 1586, true, '{"icon_name":"running","icon_prefix":"fas","icon_category":"general","unicode":"f70c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fill_solid', 'Fill', 1592, true, '{"icon_name":"fill","icon_prefix":"fas","icon_category":"general","unicode":"f575"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill1-wave_solid', 'Money Bill1 Wave', 1593, true, '{"icon_name":"money-bill1-wave","icon_prefix":"fas","icon_category":"general","unicode":"f53b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-wave-alt_solid', 'Money Bill Wave Alt', 1594, true, '{"icon_name":"money-bill-wave-alt","icon_prefix":"fas","icon_category":"general","unicode":"f53b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_landmark_solid', 'Landmark', 1595, true, '{"icon_name":"landmark","icon_prefix":"fas","icon_category":"general","unicode":"f66f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-medical_solid', 'Book Medical', 1597, true, '{"icon_name":"book-medical","icon_prefix":"fas","icon_category":"general","unicode":"f7e6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shuffle_solid', 'Shuffle', 1598, true, '{"icon_name":"shuffle","icon_prefix":"fas","icon_category":"general","unicode":"f074"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_random_solid', 'Random', 1599, true, '{"icon_name":"random","icon_prefix":"fas","icon_category":"general","unicode":"f074"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_underline_solid', 'Underline', 1600, true, '{"icon_name":"underline","icon_prefix":"fas","icon_category":"general","unicode":"f0cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_robot_solid', 'Robot', 1602, true, '{"icon_name":"robot","icon_prefix":"fas","icon_category":"general","unicode":"f544"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plus_solid', 'Plus', 1603, true, '{"icon_name":"plus","icon_prefix":"fas","icon_category":"general","unicode":"2b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_add_solid', 'Add', 1604, true, '{"icon_name":"add","icon_prefix":"fas","icon_category":"general","unicode":"2b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_copy_solid', 'Copy', 1605, true, '{"icon_name":"copy","icon_prefix":"fas","icon_category":"general","unicode":"f0c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-king_solid', 'Chess King', 1606, true, '{"icon_name":"chess-king","icon_prefix":"fas","icon_category":"general","unicode":"f43f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bitcoin-sign_solid', 'Bitcoin Sign', 1608, true, '{"icon_name":"bitcoin-sign","icon_prefix":"fas","icon_category":"general","unicode":"e0b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_box_solid', 'Box', 1609, true, '{"icon_name":"box","icon_prefix":"fas","icon_category":"general","unicode":"f466"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-left-right_solid', 'Arrows Left Right', 1612, true, '{"icon_name":"arrows-left-right","icon_prefix":"fas","icon_category":"general","unicode":"f07e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-h_solid', 'Arrows H', 1613, true, '{"icon_name":"arrows-h","icon_prefix":"fas","icon_category":"general","unicode":"f07e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fan_solid', 'Fan', 1614, true, '{"icon_name":"fan","icon_prefix":"fas","icon_category":"general","unicode":"f863"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crow_solid', 'Crow', 1615, true, '{"icon_name":"crow","icon_prefix":"fas","icon_category":"general","unicode":"f520"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_link-slash_solid', 'Link Slash', 1617, true, '{"icon_name":"link-slash","icon_prefix":"fas","icon_category":"general","unicode":"f127"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chain-broken_solid', 'Chain Broken', 1618, true, '{"icon_name":"chain-broken","icon_prefix":"fas","icon_category":"general","unicode":"f127"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chain-slash_solid', 'Chain Slash', 1619, true, '{"icon_name":"chain-slash","icon_prefix":"fas","icon_category":"general","unicode":"f127"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unlink_solid', 'Unlink', 1620, true, '{"icon_name":"unlink","icon_prefix":"fas","icon_category":"general","unicode":"f127"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_redo_solid', 'Redo', 1624, true, '{"icon_name":"redo","icon_prefix":"fas","icon_category":"general","unicode":"f01e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-clip_solid', 'Pen Clip', 1625, true, '{"icon_name":"pen-clip","icon_prefix":"fas","icon_category":"general","unicode":"f305"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-alt_solid', 'Pen Alt', 1626, true, '{"icon_name":"pen-alt","icon_prefix":"fas","icon_category":"general","unicode":"f305"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_door-closed_solid', 'Door Closed', 1627, true, '{"icon_name":"door-closed","icon_prefix":"fas","icon_category":"general","unicode":"f52a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-amount-asc_solid', 'Sort Amount Asc', 1629, true, '{"icon_name":"sort-amount-asc","icon_prefix":"fas","icon_category":"general","unicode":"f160"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-amount-down_solid', 'Sort Amount Down', 1630, true, '{"icon_name":"sort-amount-down","icon_prefix":"fas","icon_category":"general","unicode":"f160"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_k_solid', 'K', 1632, true, '{"icon_name":"k","icon_prefix":"fas","icon_category":"general","unicode":"4b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vote-yea_solid', 'Vote Yea', 1634, true, '{"icon_name":"vote-yea","icon_prefix":"fas","icon_category":"general","unicode":"f772"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fish-fins_solid', 'Fish Fins', 1635, true, '{"icon_name":"fish-fins","icon_prefix":"fas","icon_category":"general","unicode":"e4f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compress_solid', 'Compress', 1636, true, '{"icon_name":"compress","icon_prefix":"fas","icon_category":"general","unicode":"f066"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-alpha-up_solid', 'Sort Alpha Up', 1638, true, '{"icon_name":"sort-alpha-up","icon_prefix":"fas","icon_category":"general","unicode":"f15e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_soap_solid', 'Soap', 1641, true, '{"icon_name":"soap","icon_prefix":"fas","icon_category":"general","unicode":"e06e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_recycle_solid', 'Recycle', 1642, true, '{"icon_name":"recycle","icon_prefix":"fas","icon_category":"general","unicode":"f1b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-wink_solid', 'Face Grin Wink', 1643, true, '{"icon_name":"face-grin-wink","icon_prefix":"fas","icon_category":"general","unicode":"f58c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-wink_solid', 'Grin Wink', 1644, true, '{"icon_name":"grin-wink","icon_prefix":"fas","icon_category":"general","unicode":"f58c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_swimming-pool_solid', 'Swimming Pool', 1647, true, '{"icon_name":"swimming-pool","icon_prefix":"fas","icon_category":"general","unicode":"f5c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tower-cell_solid', 'Tower Cell', 1648, true, '{"icon_name":"tower-cell","icon_prefix":"fas","icon_category":"general","unicode":"e585"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_colon-sign_solid', 'Colon Sign', 1649, true, '{"icon_name":"colon-sign","icon_prefix":"fas","icon_category":"general","unicode":"e140"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bahai_solid', 'Bahai', 1651, true, '{"icon_name":"bahai","icon_prefix":"fas","icon_category":"general","unicode":"f666"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_haykal_solid', 'Haykal', 1652, true, '{"icon_name":"haykal","icon_prefix":"fas","icon_category":"general","unicode":"f666"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill1_solid', 'Money Bill1', 1653, true, '{"icon_name":"money-bill1","icon_prefix":"fas","icon_category":"general","unicode":"f3d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-alt_solid', 'Money Bill Alt', 1654, true, '{"icon_name":"money-bill-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thunderstorm_solid', 'Thunderstorm', 1656, true, '{"icon_name":"thunderstorm","icon_prefix":"fas","icon_category":"general","unicode":"f76c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ethernet_solid', 'Ethernet', 1657, true, '{"icon_name":"ethernet","icon_prefix":"fas","icon_category":"general","unicode":"f796"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hryvnia-sign_solid', 'Hryvnia Sign', 1658, true, '{"icon_name":"hryvnia-sign","icon_prefix":"fas","icon_category":"general","unicode":"f6f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hryvnia_solid', 'Hryvnia', 1659, true, '{"icon_name":"hryvnia","icon_prefix":"fas","icon_category":"general","unicode":"f6f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bed-pulse_solid', 'Bed Pulse', 1665, true, '{"icon_name":"bed-pulse","icon_prefix":"fas","icon_category":"general","unicode":"f487"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_procedures_solid', 'Procedures', 1666, true, '{"icon_name":"procedures","icon_prefix":"fas","icon_category":"general","unicode":"f487"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tents_solid', 'Tents', 1667, true, '{"icon_name":"tents","icon_prefix":"fas","icon_category":"general","unicode":"e582"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mug-hot_solid', 'Mug Hot', 1668, true, '{"icon_name":"mug-hot","icon_prefix":"fas","icon_category":"general","unicode":"f7b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_zap_solid', 'Zap', 1670, true, '{"icon_name":"zap","icon_prefix":"fas","icon_category":"general","unicode":"f0e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jar_solid', 'Jar', 1671, true, '{"icon_name":"jar","icon_prefix":"fas","icon_category":"general","unicode":"e516"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_undo_solid', 'Undo', 1678, true, '{"icon_name":"undo","icon_prefix":"fas","icon_category":"general","unicode":"f0e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-angry_solid', 'Face Angry', 1679, true, '{"icon_name":"face-angry","icon_prefix":"fas","icon_category":"general","unicode":"f556"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angry_solid', 'Angry', 1680, true, '{"icon_name":"angry","icon_prefix":"fas","icon_category":"general","unicode":"f556"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_burst_solid', 'Burst', 1681, true, '{"icon_name":"burst","icon_prefix":"fas","icon_category":"general","unicode":"e4dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_z_solid', 'Z', 1682, true, '{"icon_name":"z","icon_prefix":"fas","icon_category":"general","unicode":"5a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bus-side_solid', 'Bus Side', 1686, true, '{"icon_name":"bus-side","icon_prefix":"fas","icon_category":"general","unicode":"e81d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bugs_solid', 'Bugs', 1687, true, '{"icon_name":"bugs","icon_prefix":"fas","icon_category":"general","unicode":"e4d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_beer-mug-empty_solid', 'Beer Mug Empty', 1688, true, '{"icon_name":"beer-mug-empty","icon_prefix":"fas","icon_category":"general","unicode":"f0fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_beer_solid', 'Beer', 1689, true, '{"icon_name":"beer","icon_prefix":"fas","icon_category":"general","unicode":"f0fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stapler_solid', 'Stapler', 1691, true, '{"icon_name":"stapler","icon_prefix":"fas","icon_category":"general","unicode":"e5af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_naira-sign_solid', 'Naira Sign', 1693, true, '{"icon_name":"naira-sign","icon_prefix":"fas","icon_category":"general","unicode":"e1f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wifi_solid', 'Wifi', 1694, true, '{"icon_name":"wifi","icon_prefix":"fas","icon_category":"general","unicode":"f1eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wifi3_solid', 'Wifi3', 1695, true, '{"icon_name":"wifi3","icon_prefix":"fas","icon_category":"general","unicode":"f1eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wifi-strong_solid', 'Wifi Strong', 1696, true, '{"icon_name":"wifi-strong","icon_prefix":"fas","icon_category":"general","unicode":"f1eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_low-vision_solid', 'Low Vision', 1700, true, '{"icon_name":"low-vision","icon_prefix":"fas","icon_category":"general","unicode":"f2a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_capsules_solid', 'Capsules', 1704, true, '{"icon_name":"capsules","icon_prefix":"fas","icon_category":"general","unicode":"f46b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_poo_solid', 'Poo', 1705, true, '{"icon_name":"poo","icon_prefix":"fas","icon_category":"general","unicode":"f2fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tag_solid', 'Tag', 1707, true, '{"icon_name":"tag","icon_prefix":"fas","icon_category":"general","unicode":"f02b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_down-long_solid', 'Down Long', 1709, true, '{"icon_name":"down-long","icon_prefix":"fas","icon_category":"general","unicode":"f309"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-alt-down_solid', 'Long Arrow Alt Down', 1710, true, '{"icon_name":"long-arrow-alt-down","icon_prefix":"fas","icon_category":"general","unicode":"f309"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compact-disc_solid', 'Compact Disc', 1711, true, '{"icon_name":"compact-disc","icon_prefix":"fas","icon_category":"general","unicode":"f51f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_suitcase-rolling_solid', 'Suitcase Rolling', 1712, true, '{"icon_name":"suitcase-rolling","icon_prefix":"fas","icon_category":"general","unicode":"f5c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-quran_solid', 'Book Quran', 1713, true, '{"icon_name":"book-quran","icon_prefix":"fas","icon_category":"general","unicode":"f687"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quran_solid', 'Quran', 1714, true, '{"icon_name":"quran","icon_prefix":"fas","icon_category":"general","unicode":"f687"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_portrait_solid', 'Portrait', 1719, true, '{"icon_name":"portrait","icon_prefix":"fas","icon_category":"general","unicode":"f3e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-numeric-up_solid', 'Sort Numeric Up', 1723, true, '{"icon_name":"sort-numeric-up","icon_prefix":"fas","icon_category":"general","unicode":"f163"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-knight_solid', 'Chess Knight', 1724, true, '{"icon_name":"chess-knight","icon_prefix":"fas","icon_category":"general","unicode":"f441"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_external-link_solid', 'External Link', 1727, true, '{"icon_name":"external-link","icon_prefix":"fas","icon_category":"general","unicode":"f08e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-beam_solid', 'Face Grin Beam', 1729, true, '{"icon_name":"face-grin-beam","icon_prefix":"fas","icon_category":"general","unicode":"f582"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-beam_solid', 'Grin Beam', 1730, true, '{"icon_name":"grin-beam","icon_prefix":"fas","icon_category":"general","unicode":"f582"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-ad_solid', 'Rectangle Ad', 1731, true, '{"icon_name":"rectangle-ad","icon_prefix":"fas","icon_category":"general","unicode":"f641"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ad_solid', 'Ad', 1732, true, '{"icon_name":"ad","icon_prefix":"fas","icon_category":"general","unicode":"f641"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-tanakh_solid', 'Book Tanakh', 1733, true, '{"icon_name":"book-tanakh","icon_prefix":"fas","icon_category":"general","unicode":"f827"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tanakh_solid', 'Tanakh', 1734, true, '{"icon_name":"tanakh","icon_prefix":"fas","icon_category":"general","unicode":"f827"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hot-tub-person_solid', 'Hot Tub Person', 1735, true, '{"icon_name":"hot-tub-person","icon_prefix":"fas","icon_category":"general","unicode":"f593"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hot-tub_solid', 'Hot Tub', 1736, true, '{"icon_name":"hot-tub","icon_prefix":"fas","icon_category":"general","unicode":"f593"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_outdent_solid', 'Outdent', 1738, true, '{"icon_name":"outdent","icon_prefix":"fas","icon_category":"general","unicode":"f03b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dedent_solid', 'Dedent', 1739, true, '{"icon_name":"dedent","icon_prefix":"fas","icon_category":"general","unicode":"f03b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-peace_solid', 'Hand Peace', 1740, true, '{"icon_name":"hand-peace","icon_prefix":"fas","icon_category":"general","unicode":"f25b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_head-side-virus_solid', 'Head Side Virus', 1741, true, '{"icon_name":"head-side-virus","icon_prefix":"fas","icon_category":"general","unicode":"e064"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-nib_solid', 'Pen Nib', 1743, true, '{"icon_name":"pen-nib","icon_prefix":"fas","icon_category":"general","unicode":"f5ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tent-arrows-down_solid', 'Tent Arrows Down', 1744, true, '{"icon_name":"tent-arrows-down","icon_prefix":"fas","icon_category":"general","unicode":"e581"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_forward-fast_solid', 'Forward Fast', 1745, true, '{"icon_name":"forward-fast","icon_prefix":"fas","icon_category":"general","unicode":"f050"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fast-forward_solid', 'Fast Forward', 1746, true, '{"icon_name":"fast-forward","icon_prefix":"fas","icon_category":"general","unicode":"f050"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_crop_solid', 'Crop', 1747, true, '{"icon_name":"crop","icon_prefix":"fas","icon_category":"general","unicode":"f125"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin_solid', 'Face Grin', 1751, true, '{"icon_name":"face-grin","icon_prefix":"fas","icon_category":"general","unicode":"f580"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin_solid', 'Grin', 1752, true, '{"icon_name":"grin","icon_prefix":"fas","icon_category":"general","unicode":"f580"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-up_solid', 'Angle Up', 1754, true, '{"icon_name":"angle-up","icon_prefix":"fas","icon_category":"general","unicode":"f106"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-smile_solid', 'Face Smile', 1755, true, '{"icon_name":"face-smile","icon_prefix":"fas","icon_category":"general","unicode":"f118"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smile_solid', 'Smile', 1756, true, '{"icon_name":"smile","icon_prefix":"fas","icon_category":"general","unicode":"f118"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-dress-burst_solid', 'Person Dress Burst', 1757, true, '{"icon_name":"person-dress-burst","icon_prefix":"fas","icon_category":"general","unicode":"e544"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_divide_solid', 'Divide', 1758, true, '{"icon_name":"divide","icon_prefix":"fas","icon_category":"general","unicode":"f529"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code-fork_solid', 'Code Fork', 1759, true, '{"icon_name":"code-fork","icon_prefix":"fas","icon_category":"general","unicode":"e13b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-flag_solid', 'House Flag', 1760, true, '{"icon_name":"house-flag","icon_prefix":"fas","icon_category":"general","unicode":"e50d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_institution_solid', 'Institution', 1763, true, '{"icon_name":"institution","icon_prefix":"fas","icon_category":"general","unicode":"f19c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_museum_solid', 'Museum', 1764, true, '{"icon_name":"museum","icon_prefix":"fas","icon_category":"general","unicode":"f19c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_university_solid', 'University', 1765, true, '{"icon_name":"university","icon_prefix":"fas","icon_category":"general","unicode":"f19c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rug_solid', 'Rug', 1766, true, '{"icon_name":"rug","icon_prefix":"fas","icon_category":"general","unicode":"e569"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code-merge_solid', 'Code Merge', 1767, true, '{"icon_name":"code-merge","icon_prefix":"fas","icon_category":"general","unicode":"f387"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass-chart_solid', 'Magnifying Glass Chart', 1769, true, '{"icon_name":"magnifying-glass-chart","icon_prefix":"fas","icon_category":"general","unicode":"e522"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_umbrella_solid', 'Umbrella', 1770, true, '{"icon_name":"umbrella","icon_prefix":"fas","icon_category":"general","unicode":"f0e9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hill-rockslide_solid', 'Hill Rockslide', 1771, true, '{"icon_name":"hill-rockslide","icon_prefix":"fas","icon_category":"general","unicode":"e508"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pager_solid', 'Pager', 1773, true, '{"icon_name":"pager","icon_prefix":"fas","icon_category":"general","unicode":"f815"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trowel-bricks_solid', 'Trowel Bricks', 1775, true, '{"icon_name":"trowel-bricks","icon_prefix":"fas","icon_category":"general","unicode":"e58a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_socks_solid', 'Socks', 1776, true, '{"icon_name":"socks","icon_prefix":"fas","icon_category":"general","unicode":"f696"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_t_solid', 'T', 1777, true, '{"icon_name":"t","icon_prefix":"fas","icon_category":"general","unicode":"54"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microchip_solid', 'Microchip', 1778, true, '{"icon_name":"microchip","icon_prefix":"fas","icon_category":"general","unicode":"f2db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-medical_solid', 'Truck Medical', 1779, true, '{"icon_name":"truck-medical","icon_prefix":"fas","icon_category":"general","unicode":"f0f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ambulance_solid', 'Ambulance', 1780, true, '{"icon_name":"ambulance","icon_prefix":"fas","icon_category":"general","unicode":"f0f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_om_solid', 'Om', 1781, true, '{"icon_name":"om","icon_prefix":"fas","icon_category":"general","unicode":"f679"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mosquito-net_solid', 'Mosquito Net', 1782, true, '{"icon_name":"mosquito-net","icon_prefix":"fas","icon_category":"general","unicode":"e52c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_prescription-bottle_solid', 'Prescription Bottle', 1783, true, '{"icon_name":"prescription-bottle","icon_prefix":"fas","icon_category":"general","unicode":"f485"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_staff-snake_solid', 'Staff Snake', 1788, true, '{"icon_name":"staff-snake","icon_prefix":"fas","icon_category":"general","unicode":"e579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rod-asclepius_solid', 'Rod Asclepius', 1789, true, '{"icon_name":"rod-asclepius","icon_prefix":"fas","icon_category":"general","unicode":"e579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rod-snake_solid', 'Rod Snake', 1790, true, '{"icon_name":"rod-snake","icon_prefix":"fas","icon_category":"general","unicode":"e579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_staff-aesculapius_solid', 'Staff Aesculapius', 1791, true, '{"icon_name":"staff-aesculapius","icon_prefix":"fas","icon_category":"general","unicode":"e579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_monument_solid', 'Monument', 1793, true, '{"icon_name":"monument","icon_prefix":"fas","icon_category":"general","unicode":"f5a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angles-right_solid', 'Angles Right', 1794, true, '{"icon_name":"angles-right","icon_prefix":"fas","icon_category":"general","unicode":"f101"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-double-right_solid', 'Angle Double Right', 1795, true, '{"icon_name":"angle-double-right","icon_prefix":"fas","icon_category":"general","unicode":"f101"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_desktop_solid', 'Desktop', 1796, true, '{"icon_name":"desktop","icon_prefix":"fas","icon_category":"general","unicode":"f390"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_desktop-alt_solid', 'Desktop Alt', 1797, true, '{"icon_name":"desktop-alt","icon_prefix":"fas","icon_category":"general","unicode":"f390"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_border-all_solid', 'Border All', 1802, true, '{"icon_name":"border-all","icon_prefix":"fas","icon_category":"general","unicode":"f84c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_coins_solid', 'Coins', 1803, true, '{"icon_name":"coins","icon_prefix":"fas","icon_category":"general","unicode":"f51e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-stroke_solid', 'Mars Stroke', 1804, true, '{"icon_name":"mars-stroke","icon_prefix":"fas","icon_category":"general","unicode":"f229"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-angle_solid', 'Handshake Angle', 1805, true, '{"icon_name":"handshake-angle","icon_prefix":"fas","icon_category":"general","unicode":"f4c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-helping_solid', 'Hands Helping', 1806, true, '{"icon_name":"hands-helping","icon_prefix":"fas","icon_category":"general","unicode":"f4c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cookie-bite_solid', 'Cookie Bite', 1811, true, '{"icon_name":"cookie-bite","icon_prefix":"fas","icon_category":"general","unicode":"f564"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tools_solid', 'Tools', 1813, true, '{"icon_name":"tools","icon_prefix":"fas","icon_category":"general","unicode":"f7d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_indent_solid', 'Indent', 1814, true, '{"icon_name":"indent","icon_prefix":"fas","icon_category":"general","unicode":"f03c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_navicon_solid', 'Navicon', 1816, true, '{"icon_name":"navicon","icon_prefix":"fas","icon_category":"general","unicode":"f0c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-praying_solid', 'Hands Praying', 1817, true, '{"icon_name":"hands-praying","icon_prefix":"fas","icon_category":"general","unicode":"f684"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_praying-hands_solid', 'Praying Hands', 1818, true, '{"icon_name":"praying-hands","icon_prefix":"fas","icon_category":"general","unicode":"f684"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_viruses_solid', 'Viruses', 1819, true, '{"icon_name":"viruses","icon_prefix":"fas","icon_category":"general","unicode":"e076"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_school-flag_solid', 'School Flag', 1820, true, '{"icon_name":"school-flag","icon_prefix":"fas","icon_category":"general","unicode":"e56e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trademark_solid', 'Trademark', 1821, true, '{"icon_name":"trademark","icon_prefix":"fas","icon_category":"general","unicode":"f25c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fire-burner_solid', 'Fire Burner', 1822, true, '{"icon_name":"fire-burner","icon_prefix":"fas","icon_category":"general","unicode":"e4f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-smile-beam_solid', 'Face Smile Beam', 1823, true, '{"icon_name":"face-smile-beam","icon_prefix":"fas","icon_category":"general","unicode":"f5b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smile-beam_solid', 'Smile Beam', 1824, true, '{"icon_name":"smile-beam","icon_prefix":"fas","icon_category":"general","unicode":"f5b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_route_solid', 'Route', 1826, true, '{"icon_name":"route","icon_prefix":"fas","icon_category":"general","unicode":"f4d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angles-up_solid', 'Angles Up', 1827, true, '{"icon_name":"angles-up","icon_prefix":"fas","icon_category":"general","unicode":"f102"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-double-up_solid', 'Angle Double Up', 1828, true, '{"icon_name":"angle-double-up","icon_prefix":"fas","icon_category":"general","unicode":"f102"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bucket_solid', 'Bucket', 1829, true, '{"icon_name":"bucket","icon_prefix":"fas","icon_category":"general","unicode":"e4cf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_less-than-equal_solid', 'Less Than Equal', 1830, true, '{"icon_name":"less-than-equal","icon_prefix":"fas","icon_category":"general","unicode":"f537"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-burst_solid', 'Person Burst', 1834, true, '{"icon_name":"person-burst","icon_prefix":"fas","icon_category":"general","unicode":"e53b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_left-long_solid', 'Left Long', 1835, true, '{"icon_name":"left-long","icon_prefix":"fas","icon_category":"general","unicode":"f30a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-alt-left_solid', 'Long Arrow Alt Left', 1836, true, '{"icon_name":"long-arrow-alt-left","icon_prefix":"fas","icon_category":"general","unicode":"f30a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-dots-from-line_solid', 'Person Dots From Line', 1839, true, '{"icon_name":"person-dots-from-line","icon_prefix":"fas","icon_category":"general","unicode":"f470"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diagnoses_solid', 'Diagnoses', 1840, true, '{"icon_name":"diagnoses","icon_prefix":"fas","icon_category":"general","unicode":"f470"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gauge-simple-high_solid', 'Gauge Simple High', 1841, true, '{"icon_name":"gauge-simple-high","icon_prefix":"fas","icon_category":"general","unicode":"f62a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angles-left_solid', 'Angles Left', 1844, true, '{"icon_name":"angles-left","icon_prefix":"fas","icon_category":"general","unicode":"f100"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-double-left_solid', 'Angle Double Left', 1845, true, '{"icon_name":"angle-double-left","icon_prefix":"fas","icon_category":"general","unicode":"f100"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_up-down_solid', 'Up Down', 1846, true, '{"icon_name":"up-down","icon_prefix":"fas","icon_category":"general","unicode":"f338"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-alt-v_solid', 'Arrows Alt V', 1847, true, '{"icon_name":"arrows-alt-v","icon_prefix":"fas","icon_category":"general","unicode":"f338"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cookie_solid', 'Cookie', 1851, true, '{"icon_name":"cookie","icon_prefix":"fas","icon_category":"general","unicode":"f563"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eject_solid', 'Eject', 1853, true, '{"icon_name":"eject","icon_prefix":"fas","icon_category":"general","unicode":"f052"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tasks_solid', 'Tasks', 1858, true, '{"icon_name":"tasks","icon_prefix":"fas","icon_category":"general","unicode":"f0ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sack-xmark_solid', 'Sack Xmark', 1859, true, '{"icon_name":"sack-xmark","icon_prefix":"fas","icon_category":"general","unicode":"e56a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gamepad_solid', 'Gamepad', 1862, true, '{"icon_name":"gamepad","icon_prefix":"fas","icon_category":"general","unicode":"f11b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grimace_solid', 'Face Grimace', 1865, true, '{"icon_name":"face-grimace","icon_prefix":"fas","icon_category":"general","unicode":"f57f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grimace_solid', 'Grimace', 1866, true, '{"icon_name":"grimace","icon_prefix":"fas","icon_category":"general","unicode":"f57f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_subway_solid', 'Subway', 1868, true, '{"icon_name":"subway","icon_prefix":"fas","icon_category":"general","unicode":"f239"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_object-group_solid', 'Object Group', 1871, true, '{"icon_name":"object-group","icon_prefix":"fas","icon_category":"general","unicode":"f247"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_c_solid', 'C', 1873, true, '{"icon_name":"c","icon_prefix":"fas","icon_category":"general","unicode":"43"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ruler-combined_solid', 'Ruler Combined', 1876, true, '{"icon_name":"ruler-combined","icon_prefix":"fas","icon_category":"general","unicode":"f546"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_refresh_solid', 'Refresh', 1878, true, '{"icon_name":"refresh","icon_prefix":"fas","icon_category":"general","unicode":"f021"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sync_solid', 'Sync', 1879, true, '{"icon_name":"sync","icon_prefix":"fas","icon_category":"general","unicode":"f021"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-dress_solid', 'Person Dress', 1880, true, '{"icon_name":"person-dress","icon_prefix":"fas","icon_category":"general","unicode":"f182"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_female_solid', 'Female', 1881, true, '{"icon_name":"female","icon_prefix":"fas","icon_category":"general","unicode":"f182"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-open_solid', 'Book Open', 1882, true, '{"icon_name":"book-open","icon_prefix":"fas","icon_category":"general","unicode":"f518"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_box-archive_solid', 'Box Archive', 1884, true, '{"icon_name":"box-archive","icon_prefix":"fas","icon_category":"general","unicode":"f187"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_archive_solid', 'Archive', 1885, true, '{"icon_name":"archive","icon_prefix":"fas","icon_category":"general","unicode":"f187"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_qrcode_solid', 'Qrcode', 1887, true, '{"icon_name":"qrcode","icon_prefix":"fas","icon_category":"general","unicode":"f029"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dragon_solid', 'Dragon', 1888, true, '{"icon_name":"dragon","icon_prefix":"fas","icon_category":"general","unicode":"f6d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grip_solid', 'Grip', 1891, true, '{"icon_name":"grip","icon_prefix":"fas","icon_category":"general","unicode":"f58d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grid-horizontal_solid', 'Grid Horizontal', 1892, true, '{"icon_name":"grid-horizontal","icon_prefix":"fas","icon_category":"general","unicode":"f58d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grip-horizontal_solid', 'Grip Horizontal', 1893, true, '{"icon_name":"grip-horizontal","icon_prefix":"fas","icon_category":"general","unicode":"f58d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_border-top-left_solid', 'Border Top Left', 1894, true, '{"icon_name":"border-top-left","icon_prefix":"fas","icon_category":"general","unicode":"f853"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_border-style_solid', 'Border Style', 1895, true, '{"icon_name":"border-style","icon_prefix":"fas","icon_category":"general","unicode":"f853"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-ul_solid', 'List Ul', 1896, true, '{"icon_name":"list-ul","icon_prefix":"fas","icon_category":"general","unicode":"f0ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-dots_solid', 'List Dots', 1897, true, '{"icon_name":"list-dots","icon_prefix":"fas","icon_category":"general","unicode":"f0ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-robbery_solid', 'People Robbery', 1898, true, '{"icon_name":"people-robbery","icon_prefix":"fas","icon_category":"general","unicode":"e536"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-button_solid', 'Mobile Button', 1899, true, '{"icon_name":"mobile-button","icon_prefix":"fas","icon_category":"general","unicode":"f10b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-alpha-asc_solid', 'Sort Alpha Asc', 1901, true, '{"icon_name":"sort-alpha-asc","icon_prefix":"fas","icon_category":"general","unicode":"f15d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-alpha-down_solid', 'Sort Alpha Down', 1902, true, '{"icon_name":"sort-alpha-down","icon_prefix":"fas","icon_category":"general","unicode":"f15d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill_solid', 'Money Bill', 1903, true, '{"icon_name":"money-bill","icon_prefix":"fas","icon_category":"general","unicode":"f0d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-pointer_solid', 'Arrow Pointer', 1906, true, '{"icon_name":"arrow-pointer","icon_prefix":"fas","icon_category":"general","unicode":"f245"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mouse-pointer_solid', 'Mouse Pointer', 1907, true, '{"icon_name":"mouse-pointer","icon_prefix":"fas","icon_category":"general","unicode":"f245"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-cells-large_solid', 'Table Cells Large', 1910, true, '{"icon_name":"table-cells-large","icon_prefix":"fas","icon_category":"general","unicode":"f009"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_th-large_solid', 'Th Large', 1911, true, '{"icon_name":"th-large","icon_prefix":"fas","icon_category":"general","unicode":"f009"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_code-compare_solid', 'Code Compare', 1914, true, '{"icon_name":"code-compare","icon_prefix":"fas","icon_category":"general","unicode":"e13a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pallet_solid', 'Pallet', 1916, true, '{"icon_name":"pallet","icon_prefix":"fas","icon_category":"general","unicode":"f482"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cake-candles_solid', 'Cake Candles', 1917, true, '{"icon_name":"cake-candles","icon_prefix":"fas","icon_category":"general","unicode":"f1fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_birthday-cake_solid', 'Birthday Cake', 1918, true, '{"icon_name":"birthday-cake","icon_prefix":"fas","icon_category":"general","unicode":"f1fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cake_solid', 'Cake', 1919, true, '{"icon_name":"cake","icon_prefix":"fas","icon_category":"general","unicode":"f1fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bug-slash_solid', 'Bug Slash', 1920, true, '{"icon_name":"bug-slash","icon_prefix":"fas","icon_category":"general","unicode":"e490"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tarp_solid', 'Tarp', 1921, true, '{"icon_name":"tarp","icon_prefix":"fas","icon_category":"general","unicode":"e57b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diagram-predecessor_solid', 'Diagram Predecessor', 1922, true, '{"icon_name":"diagram-predecessor","icon_prefix":"fas","icon_category":"general","unicode":"e477"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-flushed_solid', 'Face Flushed', 1923, true, '{"icon_name":"face-flushed","icon_prefix":"fas","icon_category":"general","unicode":"f579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flushed_solid', 'Flushed', 1924, true, '{"icon_name":"flushed","icon_prefix":"fas","icon_category":"general","unicode":"f579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diagram-next_solid', 'Diagram Next', 1925, true, '{"icon_name":"diagram-next","icon_prefix":"fas","icon_category":"general","unicode":"e476"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spa_solid', 'Spa', 1928, true, '{"icon_name":"spa","icon_prefix":"fas","icon_category":"general","unicode":"f5bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tasks-alt_solid', 'Tasks Alt', 1930, true, '{"icon_name":"tasks-alt","icon_prefix":"fas","icon_category":"general","unicode":"f828"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-stroke-right_solid', 'Mars Stroke Right', 1932, true, '{"icon_name":"mars-stroke-right","icon_prefix":"fas","icon_category":"general","unicode":"f22b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mars-stroke-h_solid', 'Mars Stroke H', 1933, true, '{"icon_name":"mars-stroke-h","icon_prefix":"fas","icon_category":"general","unicode":"f22b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sterling-sign_solid', 'Sterling Sign', 1935, true, '{"icon_name":"sterling-sign","icon_prefix":"fas","icon_category":"general","unicode":"f154"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gbp_solid', 'Gbp', 1936, true, '{"icon_name":"gbp","icon_prefix":"fas","icon_category":"general","unicode":"f154"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_faucet-drip_solid', 'Faucet Drip', 1938, true, '{"icon_name":"faucet-drip","icon_prefix":"fas","icon_category":"general","unicode":"e006"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bowl-rice_solid', 'Bowl Rice', 1942, true, '{"icon_name":"bowl-rice","icon_prefix":"fas","icon_category":"general","unicode":"e2eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-trend-down_solid', 'Arrow Trend Down', 1949, true, '{"icon_name":"arrow-trend-down","icon_prefix":"fas","icon_category":"general","unicode":"e097"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_oil-can_solid', 'Oil Can', 1950, true, '{"icon_name":"oil-can","icon_prefix":"fas","icon_category":"general","unicode":"f613"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chair_solid', 'Chair', 1953, true, '{"icon_name":"chair","icon_prefix":"fas","icon_category":"general","unicode":"f6c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_layer-group_solid', 'Layer Group', 1955, true, '{"icon_name":"layer-group","icon_prefix":"fas","icon_category":"general","unicode":"f5fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_head-side-mask_solid', 'Head Side Mask', 1956, true, '{"icon_name":"head-side-mask","icon_prefix":"fas","icon_category":"general","unicode":"e063"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands_solid', 'Hands', 1957, true, '{"icon_name":"hands","icon_prefix":"fas","icon_category":"general","unicode":"f2a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sign-language_solid', 'Sign Language', 1958, true, '{"icon_name":"sign-language","icon_prefix":"fas","icon_category":"general","unicode":"f2a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signing_solid', 'Signing', 1959, true, '{"icon_name":"signing","icon_prefix":"fas","icon_category":"general","unicode":"f2a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tablets_solid', 'Tablets', 1960, true, '{"icon_name":"tablets","icon_prefix":"fas","icon_category":"general","unicode":"f490"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_weight-hanging_solid', 'Weight Hanging', 1961, true, '{"icon_name":"weight-hanging","icon_prefix":"fas","icon_category":"general","unicode":"f5cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dice_solid', 'Dice', 1962, true, '{"icon_name":"dice","icon_prefix":"fas","icon_category":"general","unicode":"f522"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shop-slash_solid', 'Shop Slash', 1963, true, '{"icon_name":"shop-slash","icon_prefix":"fas","icon_category":"general","unicode":"e070"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_store-alt-slash_solid', 'Store Alt Slash', 1964, true, '{"icon_name":"store-alt-slash","icon_prefix":"fas","icon_category":"general","unicode":"e070"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-down_solid', 'Sort Down', 1965, true, '{"icon_name":"sort-down","icon_prefix":"fas","icon_category":"general","unicode":"f0dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sort-desc_solid', 'Sort Desc', 1966, true, '{"icon_name":"sort-desc","icon_prefix":"fas","icon_category":"general","unicode":"f0dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_peseta-sign_solid', 'Peseta Sign', 1967, true, '{"icon_name":"peseta-sign","icon_prefix":"fas","icon_category":"general","unicode":"e221"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tablet-screen-button_solid', 'Tablet Screen Button', 1968, true, '{"icon_name":"tablet-screen-button","icon_prefix":"fas","icon_category":"general","unicode":"f3fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tablet-alt_solid', 'Tablet Alt', 1969, true, '{"icon_name":"tablet-alt","icon_prefix":"fas","icon_category":"general","unicode":"f3fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-dollar_solid', 'Hand Holding Dollar', 1970, true, '{"icon_name":"hand-holding-dollar","icon_prefix":"fas","icon_category":"general","unicode":"f4c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-usd_solid', 'Hand Holding Usd', 1971, true, '{"icon_name":"hand-holding-usd","icon_prefix":"fas","icon_category":"general","unicode":"f4c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield_solid', 'Shield', 1972, true, '{"icon_name":"shield","icon_prefix":"fas","icon_category":"general","unicode":"f132"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-blank_solid', 'Shield Blank', 1973, true, '{"icon_name":"shield-blank","icon_prefix":"fas","icon_category":"general","unicode":"f132"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh_solid', 'Face Laugh', 1974, true, '{"icon_name":"face-laugh","icon_prefix":"fas","icon_category":"general","unicode":"f599"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh_solid', 'Laugh', 1975, true, '{"icon_name":"laugh","icon_prefix":"fas","icon_category":"general","unicode":"f599"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-holding_solid', 'Hands Holding', 1976, true, '{"icon_name":"hands-holding","icon_prefix":"fas","icon_category":"general","unicode":"f4c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_octagon_solid', 'Octagon', 1979, true, '{"icon_name":"octagon","icon_prefix":"fas","icon_category":"general","unicode":"f306"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-pointer_solid', 'Hand Pointer', 1980, true, '{"icon_name":"hand-pointer","icon_prefix":"fas","icon_category":"general","unicode":"f25a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_registered_solid', 'Registered', 1981, true, '{"icon_name":"registered","icon_prefix":"fas","icon_category":"general","unicode":"f25d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-signal_solid', 'House Signal', 1982, true, '{"icon_name":"house-signal","icon_prefix":"fas","icon_category":"general","unicode":"e012"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-kiss_regular', 'Face Kiss (Regular)', 1987, true, '{"icon_name":"face-kiss","icon_prefix":"far","icon_category":"general","unicode":"f596"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiss_regular', 'Kiss (Regular)', 1988, true, '{"icon_name":"kiss","icon_prefix":"far","icon_category":"general","unicode":"f596"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paste_regular', 'Paste (Regular)', 1989, true, '{"icon_name":"paste","icon_prefix":"far","icon_category":"general","unicode":"f0ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-left_regular', 'Hand Point Left (Regular)', 1991, true, '{"icon_name":"hand-point-left","icon_prefix":"far","icon_category":"general","unicode":"f0a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck_regular', 'Truck (Regular)', 1996, true, '{"icon_name":"truck","icon_prefix":"far","icon_category":"general","unicode":"f0d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_message_regular', 'Message (Regular)', 1998, true, '{"icon_name":"message","icon_prefix":"far","icon_category":"general","unicode":"f27a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-dizzy_regular', 'Face Dizzy (Regular)', 2000, true, '{"icon_name":"face-dizzy","icon_prefix":"far","icon_category":"general","unicode":"f567"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dizzy_regular', 'Dizzy (Regular)', 2001, true, '{"icon_name":"dizzy","icon_prefix":"far","icon_category":"general","unicode":"f567"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-up_regular', 'Hand Point Up (Regular)', 2004, true, '{"icon_name":"hand-point-up","icon_prefix":"far","icon_category":"general","unicode":"f0a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-lizard_regular', 'Hand Lizard (Regular)', 2005, true, '{"icon_name":"hand-lizard","icon_prefix":"far","icon_category":"general","unicode":"f258"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hard-drive_regular', 'Hard Drive (Regular)', 2009, true, '{"icon_name":"hard-drive","icon_prefix":"far","icon_category":"general","unicode":"f0a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hdd_regular', 'Hdd (Regular)', 2010, true, '{"icon_name":"hdd","icon_prefix":"far","icon_category":"general","unicode":"f0a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_floppy-disk_regular', 'Floppy Disk (Regular)', 2013, true, '{"icon_name":"floppy-disk","icon_prefix":"far","icon_category":"general","unicode":"f0c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_save_regular', 'Save (Regular)', 2014, true, '{"icon_name":"save","icon_prefix":"far","icon_category":"general","unicode":"f0c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tongue-squint_regular', 'Face Grin Tongue Squint (Regular)', 2015, true, '{"icon_name":"face-grin-tongue-squint","icon_prefix":"far","icon_category":"general","unicode":"f58a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tongue-squint_regular', 'Grin Tongue Squint (Regular)', 2016, true, '{"icon_name":"grin-tongue-squint","icon_prefix":"far","icon_category":"general","unicode":"f58a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-sad-tear_regular', 'Face Sad Tear (Regular)', 2022, true, '{"icon_name":"face-sad-tear","icon_prefix":"far","icon_category":"general","unicode":"f5b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sad-tear_regular', 'Sad Tear (Regular)', 2023, true, '{"icon_name":"sad-tear","icon_prefix":"far","icon_category":"general","unicode":"f5b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_note-sticky_regular', 'Note Sticky (Regular)', 2026, true, '{"icon_name":"note-sticky","icon_prefix":"far","icon_category":"general","unicode":"f249"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sticky-note_regular', 'Sticky Note (Regular)', 2027, true, '{"icon_name":"sticky-note","icon_prefix":"far","icon_category":"general","unicode":"f249"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-back-fist_regular', 'Hand Back Fist (Regular)', 2028, true, '{"icon_name":"hand-back-fist","icon_prefix":"far","icon_category":"general","unicode":"f255"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-rock_regular', 'Hand Rock (Regular)', 2029, true, '{"icon_name":"hand-rock","icon_prefix":"far","icon_category":"general","unicode":"f255"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-queen_regular', 'Chess Queen (Regular)', 2030, true, '{"icon_name":"chess-queen","icon_prefix":"far","icon_category":"general","unicode":"f445"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tears_regular', 'Face Grin Tears (Regular)', 2031, true, '{"icon_name":"face-grin-tears","icon_prefix":"far","icon_category":"general","unicode":"f588"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tears_regular', 'Grin Tears (Regular)', 2032, true, '{"icon_name":"grin-tears","icon_prefix":"far","icon_category":"general","unicode":"f588"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_edit_regular', 'Edit (Regular)', 2034, true, '{"icon_name":"edit","icon_prefix":"far","icon_category":"general","unicode":"f044"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh-wink_regular', 'Face Laugh Wink (Regular)', 2039, true, '{"icon_name":"face-laugh-wink","icon_prefix":"far","icon_category":"general","unicode":"f59c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh-wink_regular', 'Laugh Wink (Regular)', 2040, true, '{"icon_name":"laugh-wink","icon_prefix":"far","icon_category":"general","unicode":"f59c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome_regular', 'Font Awesome (Regular)', 2043, true, '{"icon_name":"font-awesome","icon_prefix":"far","icon_category":"general","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-flag_regular', 'Font Awesome Flag (Regular)', 2044, true, '{"icon_name":"font-awesome-flag","icon_prefix":"far","icon_category":"general","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-logo-full_regular', 'Font Awesome Logo Full (Regular)', 2045, true, '{"icon_name":"font-awesome-logo-full","icon_prefix":"far","icon_category":"general","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clone_regular', 'Clone (Regular)', 2046, true, '{"icon_name":"clone","icon_prefix":"far","icon_category":"general","unicode":"f24d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_newspaper_regular', 'Newspaper (Regular)', 2051, true, '{"icon_name":"newspaper","icon_prefix":"far","icon_category":"general","unicode":"f1ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital_regular', 'Hospital (Regular)', 2052, true, '{"icon_name":"hospital","icon_prefix":"far","icon_category":"general","unicode":"f0f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital-alt_regular', 'Hospital Alt (Regular)', 2053, true, '{"icon_name":"hospital-alt","icon_prefix":"far","icon_category":"general","unicode":"f0f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital-wide_regular', 'Hospital Wide (Regular)', 2054, true, '{"icon_name":"hospital-wide","icon_prefix":"far","icon_category":"general","unicode":"f0f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_object-ungroup_regular', 'Object Ungroup (Regular)', 2057, true, '{"icon_name":"object-ungroup","icon_prefix":"far","icon_category":"general","unicode":"f248"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-pawn_regular', 'Chess Pawn (Regular)', 2059, true, '{"icon_name":"chess-pawn","icon_prefix":"far","icon_category":"general","unicode":"f443"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clipboard_regular', 'Clipboard (Regular)', 2061, true, '{"icon_name":"clipboard","icon_prefix":"far","icon_category":"general","unicode":"f328"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_id-badge_regular', 'Id Badge (Regular)', 2063, true, '{"icon_name":"id-badge","icon_prefix":"far","icon_category":"general","unicode":"f2c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-bishop_regular', 'Chess Bishop (Regular)', 2066, true, '{"icon_name":"chess-bishop","icon_prefix":"far","icon_category":"general","unicode":"f43a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lightbulb_regular', 'Lightbulb (Regular)', 2078, true, '{"icon_name":"lightbulb","icon_prefix":"far","icon_category":"general","unicode":"f0eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-meh_regular', 'Face Meh (Regular)', 2082, true, '{"icon_name":"face-meh","icon_prefix":"far","icon_category":"general","unicode":"f11a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meh_regular', 'Meh (Regular)', 2083, true, '{"icon_name":"meh","icon_prefix":"far","icon_category":"general","unicode":"f11a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-down_regular', 'Hand Point Down (Regular)', 2085, true, '{"icon_name":"hand-point-down","icon_prefix":"far","icon_category":"general","unicode":"f0a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-meh-blank_regular', 'Face Meh Blank (Regular)', 2086, true, '{"icon_name":"face-meh-blank","icon_prefix":"far","icon_category":"general","unicode":"f5a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meh-blank_regular', 'Meh Blank (Regular)', 2087, true, '{"icon_name":"meh-blank","icon_prefix":"far","icon_category":"general","unicode":"f5a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tongue_regular', 'Face Grin Tongue (Regular)', 2088, true, '{"icon_name":"face-grin-tongue","icon_prefix":"far","icon_category":"general","unicode":"f589"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tongue_regular', 'Grin Tongue (Regular)', 2089, true, '{"icon_name":"grin-tongue","icon_prefix":"far","icon_category":"general","unicode":"f589"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_futbol_regular', 'Futbol (Regular)', 2090, true, '{"icon_name":"futbol","icon_prefix":"far","icon_category":"general","unicode":"f1e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_futbol-ball_regular', 'Futbol Ball (Regular)', 2091, true, '{"icon_name":"futbol-ball","icon_prefix":"far","icon_category":"general","unicode":"f1e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_soccer-ball_regular', 'Soccer Ball (Regular)', 2092, true, '{"icon_name":"soccer-ball","icon_prefix":"far","icon_category":"general","unicode":"f1e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-surprise_regular', 'Face Surprise (Regular)', 2093, true, '{"icon_name":"face-surprise","icon_prefix":"far","icon_category":"general","unicode":"f5c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_surprise_regular', 'Surprise (Regular)', 2094, true, '{"icon_name":"surprise","icon_prefix":"far","icon_category":"general","unicode":"f5c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-squint_regular', 'Face Grin Squint (Regular)', 2099, true, '{"icon_name":"face-grin-squint","icon_prefix":"far","icon_category":"general","unicode":"f585"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-squint_regular', 'Grin Squint (Regular)', 2100, true, '{"icon_name":"grin-squint","icon_prefix":"far","icon_category":"general","unicode":"f585"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-list_regular', 'Rectangle List (Regular)', 2103, true, '{"icon_name":"rectangle-list","icon_prefix":"far","icon_category":"general","unicode":"f022"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-alt_regular', 'List Alt (Regular)', 2104, true, '{"icon_name":"list-alt","icon_prefix":"far","icon_category":"general","unicode":"f022"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand_regular', 'Hand (Regular)', 2105, true, '{"icon_name":"hand","icon_prefix":"far","icon_category":"general","unicode":"f256"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-paper_regular', 'Hand Paper (Regular)', 2106, true, '{"icon_name":"hand-paper","icon_prefix":"far","icon_category":"general","unicode":"f256"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-rook_regular', 'Chess Rook (Regular)', 2109, true, '{"icon_name":"chess-rook","icon_prefix":"far","icon_category":"general","unicode":"f447"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-sad-cry_regular', 'Face Sad Cry (Regular)', 2113, true, '{"icon_name":"face-sad-cry","icon_prefix":"far","icon_category":"general","unicode":"f5b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sad-cry_regular', 'Sad Cry (Regular)', 2114, true, '{"icon_name":"sad-cry","icon_prefix":"far","icon_category":"general","unicode":"f5b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-tired_regular', 'Face Tired (Regular)', 2116, true, '{"icon_name":"face-tired","icon_prefix":"far","icon_category":"general","unicode":"f5c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tired_regular', 'Tired (Regular)', 2117, true, '{"icon_name":"tired","icon_prefix":"far","icon_category":"general","unicode":"f5c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-point-right_regular', 'Hand Point Right (Regular)', 2118, true, '{"icon_name":"hand-point-right","icon_prefix":"far","icon_category":"general","unicode":"f0a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-scissors_regular', 'Hand Scissors (Regular)', 2121, true, '{"icon_name":"hand-scissors","icon_prefix":"far","icon_category":"general","unicode":"f257"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gem_regular', 'Gem (Regular)', 2122, true, '{"icon_name":"gem","icon_prefix":"far","icon_category":"general","unicode":"f3a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-xmark_regular', 'Rectangle Xmark (Regular)', 2123, true, '{"icon_name":"rectangle-xmark","icon_prefix":"far","icon_category":"general","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-can_regular', 'Trash Can (Regular)', 2127, true, '{"icon_name":"trash-can","icon_prefix":"far","icon_category":"general","unicode":"f2ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-alt_regular', 'Trash Alt (Regular)', 2128, true, '{"icon_name":"trash-alt","icon_prefix":"far","icon_category":"general","unicode":"f2ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_life-ring_regular', 'Life Ring (Regular)', 2129, true, '{"icon_name":"life-ring","icon_prefix":"far","icon_category":"general","unicode":"f1cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_copyright_regular', 'Copyright (Regular)', 2130, true, '{"icon_name":"copyright","icon_prefix":"far","icon_category":"general","unicode":"f1f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-frown-open_regular', 'Face Frown Open (Regular)', 2134, true, '{"icon_name":"face-frown-open","icon_prefix":"far","icon_category":"general","unicode":"f57a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_frown-open_regular', 'Frown Open (Regular)', 2135, true, '{"icon_name":"frown-open","icon_prefix":"far","icon_category":"general","unicode":"f57a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bar-chart_regular', 'Bar Chart (Regular)', 2137, true, '{"icon_name":"bar-chart","icon_prefix":"far","icon_category":"general","unicode":"f080"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house_regular', 'House (Regular)', 2138, true, '{"icon_name":"house","icon_prefix":"far","icon_category":"general","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-frown_regular', 'Face Frown (Regular)', 2142, true, '{"icon_name":"face-frown","icon_prefix":"far","icon_category":"general","unicode":"f119"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_frown_regular', 'Frown (Regular)', 2143, true, '{"icon_name":"frown","icon_prefix":"far","icon_category":"general","unicode":"f119"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake_regular', 'Handshake (Regular)', 2151, true, '{"icon_name":"handshake","icon_prefix":"far","icon_category":"general","unicode":"f2b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-alt_regular', 'Handshake Alt (Regular)', 2152, true, '{"icon_name":"handshake-alt","icon_prefix":"far","icon_category":"general","unicode":"f2b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_handshake-simple_regular', 'Handshake Simple (Regular)', 2153, true, '{"icon_name":"handshake-simple","icon_prefix":"far","icon_category":"general","unicode":"f2b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-smile-wink_regular', 'Face Smile Wink (Regular)', 2154, true, '{"icon_name":"face-smile-wink","icon_prefix":"far","icon_category":"general","unicode":"f4da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smile-wink_regular', 'Smile Wink (Regular)', 2155, true, '{"icon_name":"smile-wink","icon_prefix":"far","icon_category":"general","unicode":"f4da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-squint-tears_regular', 'Face Grin Squint Tears (Regular)', 2156, true, '{"icon_name":"face-grin-squint-tears","icon_prefix":"far","icon_category":"general","unicode":"f586"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-squint-tears_regular', 'Grin Squint Tears (Regular)', 2157, true, '{"icon_name":"grin-squint-tears","icon_prefix":"far","icon_category":"general","unicode":"f586"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_closed-captioning_regular', 'Closed Captioning (Regular)', 2170, true, '{"icon_name":"closed-captioning","icon_prefix":"far","icon_category":"general","unicode":"f20a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drivers-license_regular', 'Drivers License (Regular)', 2175, true, '{"icon_name":"drivers-license","icon_prefix":"far","icon_category":"general","unicode":"f2c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh-beam_regular', 'Face Laugh Beam (Regular)', 2178, true, '{"icon_name":"face-laugh-beam","icon_prefix":"far","icon_category":"general","unicode":"f59a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh-beam_regular', 'Laugh Beam (Regular)', 2179, true, '{"icon_name":"laugh-beam","icon_prefix":"far","icon_category":"general","unicode":"f59a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_address-book_regular', 'Address Book (Regular)', 2180, true, '{"icon_name":"address-book","icon_prefix":"far","icon_category":"general","unicode":"f2b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_contact-book_regular', 'Contact Book (Regular)', 2181, true, '{"icon_name":"contact-book","icon_prefix":"far","icon_category":"general","unicode":"f2b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-tongue-wink_regular', 'Face Grin Tongue Wink (Regular)', 2191, true, '{"icon_name":"face-grin-tongue-wink","icon_prefix":"far","icon_category":"general","unicode":"f58b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-tongue-wink_regular', 'Grin Tongue Wink (Regular)', 2192, true, '{"icon_name":"grin-tongue-wink","icon_prefix":"far","icon_category":"general","unicode":"f58b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-spock_regular', 'Hand Spock (Regular)', 2197, true, '{"icon_name":"hand-spock","icon_prefix":"far","icon_category":"general","unicode":"f259"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flag_regular', 'Flag (Regular)', 2200, true, '{"icon_name":"flag","icon_prefix":"far","icon_category":"general","unicode":"f024"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lemon_regular', 'Lemon (Regular)', 2201, true, '{"icon_name":"lemon","icon_prefix":"far","icon_category":"general","unicode":"f094"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-kiss-beam_regular', 'Face Kiss Beam (Regular)', 2205, true, '{"icon_name":"face-kiss-beam","icon_prefix":"far","icon_category":"general","unicode":"f597"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiss-beam_regular', 'Kiss Beam (Regular)', 2206, true, '{"icon_name":"kiss-beam","icon_prefix":"far","icon_category":"general","unicode":"f597"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-wide_regular', 'Face Grin Wide (Regular)', 2208, true, '{"icon_name":"face-grin-wide","icon_prefix":"far","icon_category":"general","unicode":"f581"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-alt_regular', 'Grin Alt (Regular)', 2209, true, '{"icon_name":"grin-alt","icon_prefix":"far","icon_category":"general","unicode":"f581"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh-squint_regular', 'Face Laugh Squint (Regular)', 2210, true, '{"icon_name":"face-laugh-squint","icon_prefix":"far","icon_category":"general","unicode":"f59b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh-squint_regular', 'Laugh Squint (Regular)', 2211, true, '{"icon_name":"laugh-squint","icon_prefix":"far","icon_category":"general","unicode":"f59b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_copy_regular', 'Copy (Regular)', 2214, true, '{"icon_name":"copy","icon_prefix":"far","icon_category":"general","unicode":"f0c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-king_regular', 'Chess King (Regular)', 2215, true, '{"icon_name":"chess-king","icon_prefix":"far","icon_category":"general","unicode":"f43f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-wink_regular', 'Face Grin Wink (Regular)', 2219, true, '{"icon_name":"face-grin-wink","icon_prefix":"far","icon_category":"general","unicode":"f58c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-wink_regular', 'Grin Wink (Regular)', 2220, true, '{"icon_name":"grin-wink","icon_prefix":"far","icon_category":"general","unicode":"f58c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill1_regular', 'Money Bill1 (Regular)', 2221, true, '{"icon_name":"money-bill1","icon_prefix":"far","icon_category":"general","unicode":"f3d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-alt_regular', 'Money Bill Alt (Regular)', 2222, true, '{"icon_name":"money-bill-alt","icon_prefix":"far","icon_category":"general","unicode":"f3d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-angry_regular', 'Face Angry (Regular)', 2225, true, '{"icon_name":"face-angry","icon_prefix":"far","icon_category":"general","unicode":"f556"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angry_regular', 'Angry (Regular)', 2226, true, '{"icon_name":"angry","icon_prefix":"far","icon_category":"general","unicode":"f556"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chess-knight_regular', 'Chess Knight (Regular)', 2227, true, '{"icon_name":"chess-knight","icon_prefix":"far","icon_category":"general","unicode":"f441"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-beam_regular', 'Face Grin Beam (Regular)', 2228, true, '{"icon_name":"face-grin-beam","icon_prefix":"far","icon_category":"general","unicode":"f582"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-beam_regular', 'Grin Beam (Regular)', 2229, true, '{"icon_name":"grin-beam","icon_prefix":"far","icon_category":"general","unicode":"f582"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-peace_regular', 'Hand Peace (Regular)', 2230, true, '{"icon_name":"hand-peace","icon_prefix":"far","icon_category":"general","unicode":"f25b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin_regular', 'Face Grin (Regular)', 2233, true, '{"icon_name":"face-grin","icon_prefix":"far","icon_category":"general","unicode":"f580"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin_regular', 'Grin (Regular)', 2234, true, '{"icon_name":"grin","icon_prefix":"far","icon_category":"general","unicode":"f580"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-smile_regular', 'Face Smile (Regular)', 2235, true, '{"icon_name":"face-smile","icon_prefix":"far","icon_category":"general","unicode":"f118"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smile_regular', 'Smile (Regular)', 2236, true, '{"icon_name":"smile","icon_prefix":"far","icon_category":"general","unicode":"f118"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-smile-beam_regular', 'Face Smile Beam (Regular)', 2237, true, '{"icon_name":"face-smile-beam","icon_prefix":"far","icon_category":"general","unicode":"f5b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smile-beam_regular', 'Smile Beam (Regular)', 2238, true, '{"icon_name":"smile-beam","icon_prefix":"far","icon_category":"general","unicode":"f5b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grimace_regular', 'Face Grimace (Regular)', 2243, true, '{"icon_name":"face-grimace","icon_prefix":"far","icon_category":"general","unicode":"f57f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grimace_regular', 'Grimace (Regular)', 2244, true, '{"icon_name":"grimace","icon_prefix":"far","icon_category":"general","unicode":"f57f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_object-group_regular', 'Object Group (Regular)', 2247, true, '{"icon_name":"object-group","icon_prefix":"far","icon_category":"general","unicode":"f247"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-flushed_regular', 'Face Flushed (Regular)', 2248, true, '{"icon_name":"face-flushed","icon_prefix":"far","icon_category":"general","unicode":"f579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flushed_regular', 'Flushed (Regular)', 2249, true, '{"icon_name":"flushed","icon_prefix":"far","icon_category":"general","unicode":"f579"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-laugh_regular', 'Face Laugh (Regular)', 2253, true, '{"icon_name":"face-laugh","icon_prefix":"far","icon_category":"general","unicode":"f599"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laugh_regular', 'Laugh (Regular)', 2254, true, '{"icon_name":"laugh","icon_prefix":"far","icon_category":"general","unicode":"f599"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-pointer_regular', 'Hand Pointer (Regular)', 2255, true, '{"icon_name":"hand-pointer","icon_prefix":"far","icon_category":"general","unicode":"f25a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_registered_regular', 'Registered (Regular)', 2256, true, '{"icon_name":"registered","icon_prefix":"far","icon_category":"general","unicode":"f25d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: business (24 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dollar-sign_solid', 'Dollar Sign', 10, true, '{"icon_name":"dollar-sign","icon_prefix":"fas","icon_category":"business","unicode":"24"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wallet_solid', 'Wallet', 119, true, '{"icon_name":"wallet","icon_prefix":"fas","icon_category":"business","unicode":"f555"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-un_solid', 'Building Un', 268, true, '{"icon_name":"building-un","icon_prefix":"fas","icon_category":"business","unicode":"e4d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_euro-sign_solid', 'Euro Sign', 667, true, '{"icon_name":"euro-sign","icon_prefix":"fas","icon_category":"business","unicode":"f153"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-shield_solid', 'Building Shield', 732, true, '{"icon_name":"building-shield","icon_prefix":"fas","icon_category":"business","unicode":"e4d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-line_solid', 'Chart Line', 860, true, '{"icon_name":"chart-line","icon_prefix":"fas","icon_category":"business","unicode":"f201"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building_solid', 'Building', 867, true, '{"icon_name":"building","icon_prefix":"fas","icon_category":"business","unicode":"f1ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-bar_solid', 'Chart Bar', 1029, true, '{"icon_name":"chart-bar","icon_prefix":"fas","icon_category":"business","unicode":"f080"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_briefcase-medical_solid', 'Briefcase Medical', 1089, true, '{"icon_name":"briefcase-medical","icon_prefix":"fas","icon_category":"business","unicode":"f469"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-ngo_solid', 'Building Ngo', 1157, true, '{"icon_name":"building-ngo","icon_prefix":"fas","icon_category":"business","unicode":"e4d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-lock_solid', 'Building Lock', 1261, true, '{"icon_name":"building-lock","icon_prefix":"fas","icon_category":"business","unicode":"e4d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-pie_solid', 'Chart Pie', 1358, true, '{"icon_name":"chart-pie","icon_prefix":"fas","icon_category":"business","unicode":"f200"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_credit-card_solid', 'Credit Card', 1380, true, '{"icon_name":"credit-card","icon_prefix":"fas","icon_category":"business","unicode":"f09d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_credit-card-alt_solid', 'Credit Card Alt', 1381, true, '{"icon_name":"credit-card-alt","icon_prefix":"fas","icon_category":"business","unicode":"f09d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-flag_solid', 'Building Flag', 1432, true, '{"icon_name":"building-flag","icon_prefix":"fas","icon_category":"business","unicode":"e4d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_briefcase-clock_solid', 'Briefcase Clock', 1463, true, '{"icon_name":"briefcase-clock","icon_prefix":"fas","icon_category":"business","unicode":"f64a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-columns_solid', 'Building Columns', 1761, true, '{"icon_name":"building-columns","icon_prefix":"fas","icon_category":"business","unicode":"f19c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_briefcase_solid', 'Briefcase', 1774, true, '{"icon_name":"briefcase","icon_prefix":"fas","icon_category":"business","unicode":"f0b1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pound-sign_solid', 'Pound Sign', 1937, true, '{"icon_name":"pound-sign","icon_prefix":"fas","icon_category":"business","unicode":"f154"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shopping-cart_solid', 'Shopping Cart', 1978, true, '{"icon_name":"shopping-cart","icon_prefix":"fas","icon_category":"business","unicode":"f07a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building_regular', 'Building (Regular)', 2108, true, '{"icon_name":"building","icon_prefix":"far","icon_category":"business","unicode":"f1ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chart-bar_regular', 'Chart Bar (Regular)', 2136, true, '{"icon_name":"chart-bar","icon_prefix":"far","icon_category":"business","unicode":"f080"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_credit-card_regular', 'Credit Card (Regular)', 2195, true, '{"icon_name":"credit-card","icon_prefix":"far","icon_category":"business","unicode":"f09d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_credit-card-alt_regular', 'Credit Card Alt (Regular)', 2196, true, '{"icon_name":"credit-card-alt","icon_prefix":"far","icon_category":"business","unicode":"f09d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: communication (182 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rotate_solid', 'Rotate', 15, true, '{"icon_name":"rotate","icon_prefix":"fas","icon_category":"communication","unicode":"f2f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calculator_solid', 'Calculator', 47, true, '{"icon_name":"calculator","icon_prefix":"fas","icon_category":"communication","unicode":"f1ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microphone-slash_solid', 'Microphone Slash', 52, true, '{"icon_name":"microphone-slash","icon_prefix":"fas","icon_category":"communication","unicode":"f131"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-sms_solid', 'Comment Sms', 58, true, '{"icon_name":"comment-sms","icon_prefix":"fas","icon_category":"communication","unicode":"f7cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope_solid', 'Envelope', 76, true, '{"icon_name":"envelope","icon_prefix":"fas","icon_category":"communication","unicode":"f0e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_at_solid', 'At', 88, true, '{"icon_name":"at","icon_prefix":"fas","icon_category":"communication","unicode":"40"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-phone_solid', 'Mobile Phone', 112, true, '{"icon_name":"mobile-phone","icon_prefix":"fas","icon_category":"communication","unicode":"f3ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_exclamation_solid', 'Exclamation', 114, true, '{"icon_name":"exclamation","icon_prefix":"fas","icon_category":"communication","unicode":"21"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-alt_solid', 'Comment Alt', 121, true, '{"icon_name":"comment-alt","icon_prefix":"fas","icon_category":"communication","unicode":"f27a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_swatchbook_solid', 'Swatchbook', 156, true, '{"icon_name":"swatchbook","icon_prefix":"fas","icon_category":"communication","unicode":"f5c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-bill-wheat_solid', 'Money Bill Wheat', 164, true, '{"icon_name":"money-bill-wheat","icon_prefix":"fas","icon_category":"communication","unicode":"e52a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope-open-text_solid', 'Envelope Open Text', 173, true, '{"icon_name":"envelope-open-text","icon_prefix":"fas","icon_category":"communication","unicode":"f658"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-location-dot_solid', 'Map Location Dot', 208, true, '{"icon_name":"map-location-dot","icon_prefix":"fas","icon_category":"communication","unicode":"f5a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-dollar_solid', 'Comment Dollar', 261, true, '{"icon_name":"comment-dollar","icon_prefix":"fas","icon_category":"communication","unicode":"f651"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-low_solid', 'Temperature Low', 269, true, '{"icon_name":"temperature-low","icon_prefix":"fas","icon_category":"communication","unicode":"f76b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_water_solid', 'Water', 311, true, '{"icon_name":"water","icon_prefix":"fas","icon_category":"communication","unicode":"f773"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-high_solid', 'Temperature High', 325, true, '{"icon_name":"temperature-high","icon_prefix":"fas","icon_category":"communication","unicode":"f769"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_greater-than_solid', 'Greater Than', 326, true, '{"icon_name":"greater-than","icon_prefix":"fas","icon_category":"communication","unicode":"3e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-beam-sweat_solid', 'Face Grin Beam Sweat', 374, true, '{"icon_name":"face-grin-beam-sweat","icon_prefix":"fas","icon_category":"communication","unicode":"f583"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-beam-sweat_solid', 'Grin Beam Sweat', 375, true, '{"icon_name":"grin-beam-sweat","icon_prefix":"fas","icon_category":"communication","unicode":"f583"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-meatball_solid', 'Cloud Meatball', 386, true, '{"icon_name":"cloud-meatball","icon_prefix":"fas","icon_category":"communication","unicode":"f73b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_satellite_solid', 'Satellite', 391, true, '{"icon_name":"satellite","icon_prefix":"fas","icon_category":"communication","unicode":"f7bf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_masks-theater_solid', 'Masks Theater', 396, true, '{"icon_name":"masks-theater","icon_prefix":"fas","icon_category":"communication","unicode":"f630"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_theater-masks_solid', 'Theater Masks', 397, true, '{"icon_name":"theater-masks","icon_prefix":"fas","icon_category":"communication","unicode":"f630"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paper-plane_solid', 'Paper Plane', 411, true, '{"icon_name":"paper-plane","icon_prefix":"fas","icon_category":"communication","unicode":"f1d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-atlas_solid', 'Book Atlas', 412, true, '{"icon_name":"book-atlas","icon_prefix":"fas","icon_category":"communication","unicode":"f558"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_atlas_solid', 'Atlas', 413, true, '{"icon_name":"atlas","icon_prefix":"fas","icon_category":"communication","unicode":"f558"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery-half_solid', 'Battery Half', 418, true, '{"icon_name":"battery-half","icon_prefix":"fas","icon_category":"communication","unicode":"f242"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery3_solid', 'Battery3', 419, true, '{"icon_name":"battery3","icon_prefix":"fas","icon_category":"communication","unicode":"f242"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hat-cowboy-side_solid', 'Hat Cowboy Side', 424, true, '{"icon_name":"hat-cowboy-side","icon_prefix":"fas","icon_category":"communication","unicode":"f8c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-three-quarters_solid', 'Temperature Three Quarters', 435, true, '{"icon_name":"temperature-three-quarters","icon_prefix":"fas","icon_category":"communication","unicode":"f2c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature3_solid', 'Temperature3', 436, true, '{"icon_name":"temperature3","icon_prefix":"fas","icon_category":"communication","unicode":"f2c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stopwatch20_solid', 'Stopwatch20', 461, true, '{"icon_name":"stopwatch20","icon_prefix":"fas","icon_category":"communication","unicode":"e06f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_photo-video_solid', 'Photo Video', 469, true, '{"icon_name":"photo-video","icon_prefix":"fas","icon_category":"communication","unicode":"f87c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_certificate_solid', 'Certificate', 491, true, '{"icon_name":"certificate","icon_prefix":"fas","icon_category":"communication","unicode":"f0a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_database_solid', 'Database', 497, true, '{"icon_name":"database","icon_prefix":"fas","icon_category":"communication","unicode":"f1c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_location-arrow_solid', 'Location Arrow', 502, true, '{"icon_name":"location-arrow","icon_prefix":"fas","icon_category":"communication","unicode":"f124"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_repeat_solid', 'Repeat', 520, true, '{"icon_name":"repeat","icon_prefix":"fas","icon_category":"communication","unicode":"f363"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone-flip_solid', 'Phone Flip', 531, true, '{"icon_name":"phone-flip","icon_prefix":"fas","icon_category":"communication","unicode":"f879"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone-alt_solid', 'Phone Alt', 532, true, '{"icon_name":"phone-alt","icon_prefix":"fas","icon_category":"communication","unicode":"f879"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_video-slash_solid', 'Video Slash', 543, true, '{"icon_name":"video-slash","icon_prefix":"fas","icon_category":"communication","unicode":"f4e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-water_solid', 'Hand Holding Water', 548, true, '{"icon_name":"hand-holding-water","icon_prefix":"fas","icon_category":"communication","unicode":"f4c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment_solid', 'Comment', 553, true, '{"icon_name":"comment","icon_prefix":"fas","icon_category":"communication","unicode":"f075"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_video_solid', 'Video', 558, true, '{"icon_name":"video","icon_prefix":"fas","icon_category":"communication","unicode":"f03d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_video-camera_solid', 'Video Camera', 559, true, '{"icon_name":"video-camera","icon_prefix":"fas","icon_category":"communication","unicode":"f03d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery-three-quarters_solid', 'Battery Three Quarters', 592, true, '{"icon_name":"battery-three-quarters","icon_prefix":"fas","icon_category":"communication","unicode":"f241"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery4_solid', 'Battery4', 593, true, '{"icon_name":"battery4","icon_prefix":"fas","icon_category":"communication","unicode":"f241"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_group-arrows-rotate_solid', 'Group Arrows Rotate', 616, true, '{"icon_name":"group-arrows-rotate","icon_prefix":"fas","icon_category":"communication","unicode":"e4f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bath_solid', 'Bath', 624, true, '{"icon_name":"bath","icon_prefix":"fas","icon_category":"communication","unicode":"f2cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bathtub_solid', 'Bathtub', 625, true, '{"icon_name":"bathtub","icon_prefix":"fas","icon_category":"communication","unicode":"f2cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_greater-than-equal_solid', 'Greater Than Equal', 634, true, '{"icon_name":"greater-than-equal","icon_prefix":"fas","icon_category":"communication","unicode":"f532"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope-open_solid', 'Envelope Open', 635, true, '{"icon_name":"envelope-open","icon_prefix":"fas","icon_category":"communication","unicode":"f2b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microphone_solid', 'Microphone', 653, true, '{"icon_name":"microphone","icon_prefix":"fas","icon_category":"communication","unicode":"f130"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-location_solid', 'Map Location', 664, true, '{"icon_name":"map-location","icon_prefix":"fas","icon_category":"communication","unicode":"f59f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_location-pin-lock_solid', 'Location Pin Lock', 679, true, '{"icon_name":"location-pin-lock","icon_prefix":"fas","icon_category":"communication","unicode":"e51f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-skating_solid', 'Person Skating', 700, true, '{"icon_name":"person-skating","icon_prefix":"fas","icon_category":"communication","unicode":"f7c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skating_solid', 'Skating', 701, true, '{"icon_name":"skating","icon_prefix":"fas","icon_category":"communication","unicode":"f7c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wheat-awn_solid', 'Wheat Awn', 716, true, '{"icon_name":"wheat-awn","icon_prefix":"fas","icon_category":"communication","unicode":"e2cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wheat-alt_solid', 'Wheat Alt', 717, true, '{"icon_name":"wheat-alt","icon_prefix":"fas","icon_category":"communication","unicode":"e2cd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_feather-pointed_solid', 'Feather Pointed', 734, true, '{"icon_name":"feather-pointed","icon_prefix":"fas","icon_category":"communication","unicode":"f56b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_feather-alt_solid', 'Feather Alt', 735, true, '{"icon_name":"feather-alt","icon_prefix":"fas","icon_category":"communication","unicode":"f56b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signature_solid', 'Signature', 737, true, '{"icon_name":"signature","icon_prefix":"fas","icon_category":"communication","unicode":"f5b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-full_solid', 'Temperature Full', 743, true, '{"icon_name":"temperature-full","icon_prefix":"fas","icon_category":"communication","unicode":"f2c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature4_solid', 'Temperature4', 744, true, '{"icon_name":"temperature4","icon_prefix":"fas","icon_category":"communication","unicode":"f2c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-showers-water_solid', 'Cloud Showers Water', 749, true, '{"icon_name":"cloud-showers-water","icon_prefix":"fas","icon_category":"communication","unicode":"e4e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-empty_solid', 'Temperature Empty', 777, true, '{"icon_name":"temperature-empty","icon_prefix":"fas","icon_category":"communication","unicode":"f2cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature0_solid', 'Temperature0', 778, true, '{"icon_name":"temperature0","icon_prefix":"fas","icon_category":"communication","unicode":"f2cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-signature_solid', 'File Signature', 789, true, '{"icon_name":"file-signature","icon_prefix":"fas","icon_category":"communication","unicode":"f573"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-wheat_solid', 'Building Wheat', 790, true, '{"icon_name":"building-wheat","icon_prefix":"fas","icon_category":"communication","unicode":"e4db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_baseball-bat-ball_solid', 'Baseball Bat Ball', 812, true, '{"icon_name":"baseball-bat-ball","icon_prefix":"fas","icon_category":"communication","unicode":"f432"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mobile-vibrate_solid', 'Mobile Vibrate', 821, true, '{"icon_name":"mobile-vibrate","icon_prefix":"fas","icon_category":"communication","unicode":"e816"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_remove-format_solid', 'Remove Format', 834, true, '{"icon_name":"remove-format","icon_prefix":"fas","icon_category":"communication","unicode":"f87d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blender-phone_solid', 'Blender Phone', 872, true, '{"icon_name":"blender-phone","icon_prefix":"fas","icon_category":"communication","unicode":"f6b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_child-combatant_solid', 'Child Combatant', 917, true, '{"icon_name":"child-combatant","icon_prefix":"fas","icon_category":"communication","unicode":"e4e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vest-patches_solid', 'Vest Patches', 919, true, '{"icon_name":"vest-patches","icon_prefix":"fas","icon_category":"communication","unicode":"e086"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plate-wheat_solid', 'Plate Wheat', 927, true, '{"icon_name":"plate-wheat","icon_prefix":"fas","icon_category":"communication","unicode":"e55a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-battery_solid', 'Car Battery', 930, true, '{"icon_name":"car-battery","icon_prefix":"fas","icon_category":"communication","unicode":"f5df"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery-car_solid', 'Battery Car', 931, true, '{"icon_name":"battery-car","icon_prefix":"fas","icon_category":"communication","unicode":"f5df"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelopes-bulk_solid', 'Envelopes Bulk', 936, true, '{"icon_name":"envelopes-bulk","icon_prefix":"fas","icon_category":"communication","unicode":"f674"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mail-bulk_solid', 'Mail Bulk', 937, true, '{"icon_name":"mail-bulk","icon_prefix":"fas","icon_category":"communication","unicode":"f674"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-slash_solid', 'Comment Slash', 946, true, '{"icon_name":"comment-slash","icon_prefix":"fas","icon_category":"communication","unicode":"f4b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glass-water_solid', 'Glass Water', 953, true, '{"icon_name":"glass-water","icon_prefix":"fas","icon_category":"communication","unicode":"e4f4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_democrat_solid', 'Democrat', 960, true, '{"icon_name":"democrat","icon_prefix":"fas","icon_category":"communication","unicode":"f747"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_charging-station_solid', 'Charging Station', 1016, true, '{"icon_name":"charging-station","icon_prefix":"fas","icon_category":"communication","unicode":"f5e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hat-wizard_solid', 'Hat Wizard', 1026, true, '{"icon_name":"hat-wizard","icon_prefix":"fas","icon_category":"communication","unicode":"f6e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-up_solid', 'Temperature Up', 1035, true, '{"icon_name":"temperature-up","icon_prefix":"fas","icon_category":"communication","unicode":"e040"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-quarter_solid', 'Temperature Quarter', 1055, true, '{"icon_name":"temperature-quarter","icon_prefix":"fas","icon_category":"communication","unicode":"f2ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature1_solid', 'Temperature1', 1056, true, '{"icon_name":"temperature1","icon_prefix":"fas","icon_category":"communication","unicode":"f2ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_manat-sign_solid', 'Manat Sign', 1094, true, '{"icon_name":"manat-sign","icon_prefix":"fas","icon_category":"communication","unicode":"e1d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_radiation-alt_solid', 'Radiation Alt', 1098, true, '{"icon_name":"radiation-alt","icon_prefix":"fas","icon_category":"communication","unicode":"f7ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microphone-lines-slash_solid', 'Microphone Lines Slash', 1102, true, '{"icon_name":"microphone-lines-slash","icon_prefix":"fas","icon_category":"communication","unicode":"f539"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microphone-alt-slash_solid', 'Microphone Alt Slash', 1103, true, '{"icon_name":"microphone-alt-slash","icon_prefix":"fas","icon_category":"communication","unicode":"f539"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-half_solid', 'Temperature Half', 1112, true, '{"icon_name":"temperature-half","icon_prefix":"fas","icon_category":"communication","unicode":"f2c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature2_solid', 'Temperature2', 1113, true, '{"icon_name":"temperature2","icon_prefix":"fas","icon_category":"communication","unicode":"f2c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bridge-water_solid', 'Bridge Water', 1156, true, '{"icon_name":"bridge-water","icon_prefix":"fas","icon_category":"communication","unicode":"e4ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_donate_solid', 'Donate', 1160, true, '{"icon_name":"donate","icon_prefix":"fas","icon_category":"communication","unicode":"f4b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comments-dollar_solid', 'Comments Dollar', 1209, true, '{"icon_name":"comments-dollar","icon_prefix":"fas","icon_category":"communication","unicode":"f653"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass-location_solid', 'Magnifying Glass Location', 1210, true, '{"icon_name":"magnifying-glass-location","icon_prefix":"fas","icon_category":"communication","unicode":"f689"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comments_solid', 'Comments', 1221, true, '{"icon_name":"comments","icon_prefix":"fas","icon_category":"communication","unicode":"f086"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone-volume_solid', 'Phone Volume', 1249, true, '{"icon_name":"phone-volume","icon_prefix":"fas","icon_category":"communication","unicode":"f2a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-control-phone_solid', 'Volume Control Phone', 1250, true, '{"icon_name":"volume-control-phone","icon_prefix":"fas","icon_category":"communication","unicode":"f2a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone_solid', 'Phone', 1252, true, '{"icon_name":"phone","icon_prefix":"fas","icon_category":"communication","unicode":"f095"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_torii-gate_solid', 'Torii Gate', 1253, true, '{"icon_name":"torii-gate","icon_prefix":"fas","icon_category":"communication","unicode":"f6a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rotate-right_solid', 'Rotate Right', 1270, true, '{"icon_name":"rotate-right","icon_prefix":"fas","icon_category":"communication","unicode":"f2f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rotate-forward_solid', 'Rotate Forward', 1272, true, '{"icon_name":"rotate-forward","icon_prefix":"fas","icon_category":"communication","unicode":"f2f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sailboat_solid', 'Sailboat', 1280, true, '{"icon_name":"sailboat","icon_prefix":"fas","icon_category":"communication","unicode":"e445"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microphone-lines_solid', 'Microphone Lines', 1283, true, '{"icon_name":"microphone-lines","icon_prefix":"fas","icon_category":"communication","unicode":"f3c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microphone-alt_solid', 'Microphone Alt', 1284, true, '{"icon_name":"microphone-alt","icon_prefix":"fas","icon_category":"communication","unicode":"f3c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_atom_solid', 'Atom', 1304, true, '{"icon_name":"atom","icon_prefix":"fas","icon_category":"communication","unicode":"f5d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headphones_solid', 'Headphones', 1314, true, '{"icon_name":"headphones","icon_prefix":"fas","icon_category":"communication","unicode":"f025"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headphones-alt_solid', 'Headphones Alt', 1315, true, '{"icon_name":"headphones-alt","icon_prefix":"fas","icon_category":"communication","unicode":"f025"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headphones-simple_solid', 'Headphones Simple', 1316, true, '{"icon_name":"headphones-simple","icon_prefix":"fas","icon_category":"communication","unicode":"f025"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-cat_solid', 'Shield Cat', 1325, true, '{"icon_name":"shield-cat","icon_prefix":"fas","icon_category":"communication","unicode":"e572"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clock-rotate-left_solid', 'Clock Rotate Left', 1331, true, '{"icon_name":"clock-rotate-left","icon_prefix":"fas","icon_category":"communication","unicode":"f1da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jar-wheat_solid', 'Jar Wheat', 1333, true, '{"icon_name":"jar-wheat","icon_prefix":"fas","icon_category":"communication","unicode":"e517"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_location-pin_solid', 'Location Pin', 1343, true, '{"icon_name":"location-pin","icon_prefix":"fas","icon_category":"communication","unicode":"f041"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cart-flatbed_solid', 'Cart Flatbed', 1346, true, '{"icon_name":"cart-flatbed","icon_prefix":"fas","icon_category":"communication","unicode":"f474"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dolly-flatbed_solid', 'Dolly Flatbed', 1347, true, '{"icon_name":"dolly-flatbed","icon_prefix":"fas","icon_category":"communication","unicode":"f474"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-nodes_solid', 'Comment Nodes', 1351, true, '{"icon_name":"comment-nodes","icon_prefix":"fas","icon_category":"communication","unicode":"e696"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-dots_solid', 'Comment Dots', 1356, true, '{"icon_name":"comment-dots","icon_prefix":"fas","icon_category":"communication","unicode":"f4ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_commenting_solid', 'Commenting', 1357, true, '{"icon_name":"commenting","icon_prefix":"fas","icon_category":"communication","unicode":"f4ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_inbox_solid', 'Inbox', 1362, true, '{"icon_name":"inbox","icon_prefix":"fas","icon_category":"communication","unicode":"f01c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hat-cowboy_solid', 'Hat Cowboy', 1369, true, '{"icon_name":"hat-cowboy","icon_prefix":"fas","icon_category":"communication","unicode":"f8c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mattress-pillow_solid', 'Mattress Pillow', 1389, true, '{"icon_name":"mattress-pillow","icon_prefix":"fas","icon_category":"communication","unicode":"e525"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-medical_solid', 'Comment Medical', 1398, true, '{"icon_name":"comment-medical","icon_prefix":"fas","icon_category":"communication","unicode":"f7f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bottle-water_solid', 'Bottle Water', 1403, true, '{"icon_name":"bottle-water","icon_prefix":"fas","icon_category":"communication","unicode":"e4c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_triangle-exclamation_solid', 'Triangle Exclamation', 1424, true, '{"icon_name":"triangle-exclamation","icon_prefix":"fas","icon_category":"communication","unicode":"f071"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_exclamation-triangle_solid', 'Exclamation Triangle', 1425, true, '{"icon_name":"exclamation-triangle","icon_prefix":"fas","icon_category":"communication","unicode":"f071"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_graduation-cap_solid', 'Graduation Cap', 1428, true, '{"icon_name":"graduation-cap","icon_prefix":"fas","icon_category":"communication","unicode":"f19d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rotate-left_solid', 'Rotate Left', 1448, true, '{"icon_name":"rotate-left","icon_prefix":"fas","icon_category":"communication","unicode":"f2ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rotate-back_solid', 'Rotate Back', 1449, true, '{"icon_name":"rotate-back","icon_prefix":"fas","icon_category":"communication","unicode":"f2ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rotate-backward_solid', 'Rotate Backward', 1450, true, '{"icon_name":"rotate-backward","icon_prefix":"fas","icon_category":"communication","unicode":"f2ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_camera-rotate_solid', 'Camera Rotate', 1488, true, '{"icon_name":"camera-rotate","icon_prefix":"fas","icon_category":"communication","unicode":"e0d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery-full_solid', 'Battery Full', 1507, true, '{"icon_name":"battery-full","icon_prefix":"fas","icon_category":"communication","unicode":"f240"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery_solid', 'Battery', 1508, true, '{"icon_name":"battery","icon_prefix":"fas","icon_category":"communication","unicode":"f240"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery5_solid', 'Battery5', 1509, true, '{"icon_name":"battery5","icon_prefix":"fas","icon_category":"communication","unicode":"f240"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glass-water-droplet_solid', 'Glass Water Droplet', 1529, true, '{"icon_name":"glass-water-droplet","icon_prefix":"fas","icon_category":"communication","unicode":"e4f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery-quarter_solid', 'Battery Quarter', 1552, true, '{"icon_name":"battery-quarter","icon_prefix":"fas","icon_category":"communication","unicode":"f243"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery2_solid', 'Battery2', 1553, true, '{"icon_name":"battery2","icon_prefix":"fas","icon_category":"communication","unicode":"f243"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hard-hat_solid', 'Hard Hat', 1575, true, '{"icon_name":"hard-hat","icon_prefix":"fas","icon_category":"communication","unicode":"f807"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hat-hard_solid', 'Hat Hard', 1576, true, '{"icon_name":"hat-hard","icon_prefix":"fas","icon_category":"communication","unicode":"f807"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-flood-water_solid', 'House Flood Water', 1607, true, '{"icon_name":"house-flood-water","icon_prefix":"fas","icon_category":"communication","unicode":"e50e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-rotate-right_solid', 'Arrow Rotate Right', 1621, true, '{"icon_name":"arrow-rotate-right","icon_prefix":"fas","icon_category":"communication","unicode":"f01e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-rotate-forward_solid', 'Arrow Rotate Forward', 1623, true, '{"icon_name":"arrow-rotate-forward","icon_prefix":"fas","icon_category":"communication","unicode":"f01e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_water-ladder_solid', 'Water Ladder', 1645, true, '{"icon_name":"water-ladder","icon_prefix":"fas","icon_category":"communication","unicode":"f5c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ladder-water_solid', 'Ladder Water', 1646, true, '{"icon_name":"ladder-water","icon_prefix":"fas","icon_category":"communication","unicode":"f5c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cart-flatbed-suitcase_solid', 'Cart Flatbed Suitcase', 1661, true, '{"icon_name":"cart-flatbed-suitcase","icon_prefix":"fas","icon_category":"communication","unicode":"f59d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_radiation_solid', 'Radiation', 1663, true, '{"icon_name":"radiation","icon_prefix":"fas","icon_category":"communication","unicode":"f7b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-rotate-left_solid', 'Arrow Rotate Left', 1674, true, '{"icon_name":"arrow-rotate-left","icon_prefix":"fas","icon_category":"communication","unicode":"f0e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-rotate-back_solid', 'Arrow Rotate Back', 1676, true, '{"icon_name":"arrow-rotate-back","icon_prefix":"fas","icon_category":"communication","unicode":"f0e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-rotate-backward_solid', 'Arrow Rotate Backward', 1677, true, '{"icon_name":"arrow-rotate-backward","icon_prefix":"fas","icon_category":"communication","unicode":"f0e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_elevator_solid', 'Elevator', 1706, true, '{"icon_name":"elevator","icon_prefix":"fas","icon_category":"communication","unicode":"e16d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone-slash_solid', 'Phone Slash', 1715, true, '{"icon_name":"phone-slash","icon_prefix":"fas","icon_category":"communication","unicode":"f3dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_location-dot_solid', 'Location Dot', 1808, true, '{"icon_name":"location-dot","icon_prefix":"fas","icon_category":"communication","unicode":"f3c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_location-crosshairs_solid', 'Location Crosshairs', 1837, true, '{"icon_name":"location-crosshairs","icon_prefix":"fas","icon_category":"communication","unicode":"f601"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_location_solid', 'Location', 1838, true, '{"icon_name":"location","icon_prefix":"fas","icon_category":"communication","unicode":"f601"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery-empty_solid', 'Battery Empty', 1848, true, '{"icon_name":"battery-empty","icon_prefix":"fas","icon_category":"communication","unicode":"f244"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battery0_solid', 'Battery0', 1849, true, '{"icon_name":"battery0","icon_prefix":"fas","icon_category":"communication","unicode":"f244"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stopwatch_solid', 'Stopwatch', 1852, true, '{"icon_name":"stopwatch","icon_prefix":"fas","icon_category":"communication","unicode":"f2f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_satellite-dish_solid', 'Satellite Dish', 1854, true, '{"icon_name":"satellite-dish","icon_prefix":"fas","icon_category":"communication","unicode":"f7c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hashtag_solid', 'Hashtag', 1860, true, '{"icon_name":"hashtag","icon_prefix":"fas","icon_category":"communication","unicode":"23"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-rotate_solid', 'Arrows Rotate', 1877, true, '{"icon_name":"arrows-rotate","icon_prefix":"fas","icon_category":"communication","unicode":"f021"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cat_solid', 'Cat', 1912, true, '{"icon_name":"cat","icon_prefix":"fas","icon_category":"communication","unicode":"f6be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tower-observation_solid', 'Tower Observation', 1934, true, '{"icon_name":"tower-observation","icon_prefix":"fas","icon_category":"communication","unicode":"e586"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_feather_solid', 'Feather', 1941, true, '{"icon_name":"feather","icon_prefix":"fas","icon_category":"communication","unicode":"f52d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-down_solid', 'Temperature Down', 1946, true, '{"icon_name":"temperature-down","icon_prefix":"fas","icon_category":"communication","unicode":"e03f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mask-ventilator_solid', 'Mask Ventilator', 1947, true, '{"icon_name":"mask-ventilator","icon_prefix":"fas","icon_category":"communication","unicode":"e524"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-video_solid', 'File Video', 1948, true, '{"icon_name":"file-video","icon_prefix":"fas","icon_category":"communication","unicode":"f1c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope_regular', 'Envelope (Regular)', 1993, true, '{"icon_name":"envelope","icon_prefix":"far","icon_category":"communication","unicode":"f0e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-alt_regular', 'Comment Alt (Regular)', 1999, true, '{"icon_name":"comment-alt","icon_prefix":"far","icon_category":"communication","unicode":"f27a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-beam-sweat_regular', 'Face Grin Beam Sweat (Regular)', 2035, true, '{"icon_name":"face-grin-beam-sweat","icon_prefix":"far","icon_category":"communication","unicode":"f583"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-beam-sweat_regular', 'Grin Beam Sweat (Regular)', 2036, true, '{"icon_name":"grin-beam-sweat","icon_prefix":"far","icon_category":"communication","unicode":"f583"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paper-plane_regular', 'Paper Plane (Regular)', 2041, true, '{"icon_name":"paper-plane","icon_prefix":"far","icon_category":"communication","unicode":"f1d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment_regular', 'Comment (Regular)', 2058, true, '{"icon_name":"comment","icon_prefix":"far","icon_category":"communication","unicode":"f075"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope-open_regular', 'Envelope Open (Regular)', 2067, true, '{"icon_name":"envelope-open","icon_prefix":"far","icon_category":"communication","unicode":"f2b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comments_regular', 'Comments (Regular)', 2166, true, '{"icon_name":"comments","icon_prefix":"far","icon_category":"communication","unicode":"f086"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headphones_regular', 'Headphones (Regular)', 2184, true, '{"icon_name":"headphones","icon_prefix":"far","icon_category":"communication","unicode":"f025"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headphones-alt_regular', 'Headphones Alt (Regular)', 2185, true, '{"icon_name":"headphones-alt","icon_prefix":"far","icon_category":"communication","unicode":"f025"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_headphones-simple_regular', 'Headphones Simple (Regular)', 2186, true, '{"icon_name":"headphones-simple","icon_prefix":"far","icon_category":"communication","unicode":"f025"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_comment-dots_regular', 'Comment Dots (Regular)', 2189, true, '{"icon_name":"comment-dots","icon_prefix":"far","icon_category":"communication","unicode":"f4ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_commenting_regular', 'Commenting (Regular)', 2190, true, '{"icon_name":"commenting","icon_prefix":"far","icon_category":"communication","unicode":"f4ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-video_regular', 'File Video (Regular)', 2252, true, '{"icon_name":"file-video","icon_prefix":"far","icon_category":"communication","unicode":"f1c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: core (326 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-minus_solid', 'Square Minus', 17, true, '{"icon_name":"square-minus","icon_prefix":"fas","icon_category":"core","unicode":"f146"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_minus-square_solid', 'Minus Square', 18, true, '{"icon_name":"minus-square","icon_prefix":"fas","icon_category":"core","unicode":"f146"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cogs_solid', 'Cogs', 30, true, '{"icon_name":"cogs","icon_prefix":"fas","icon_category":"core","unicode":"f085"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-circle-plus_solid', 'File Circle Plus', 31, true, '{"icon_name":"file-circle-plus","icon_prefix":"fas","icon_category":"core","unicode":"e494"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-pen_solid', 'Square Pen', 53, true, '{"icon_name":"square-pen","icon_prefix":"fas","icon_category":"core","unicode":"f14b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-square_solid', 'Pen Square', 54, true, '{"icon_name":"pen-square","icon_prefix":"fas","icon_category":"core","unicode":"f14b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pencil-square_solid', 'Pencil Square', 55, true, '{"icon_name":"pencil-square","icon_prefix":"fas","icon_category":"core","unicode":"f14b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-to-circle_solid', 'Arrows To Circle', 75, true, '{"icon_name":"arrows-to-circle","icon_prefix":"fas","icon_category":"core","unicode":"e4bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-down_solid', 'Square Caret Down', 78, true, '{"icon_name":"square-caret-down","icon_prefix":"fas","icon_category":"core","unicode":"f150"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-down_solid', 'Caret Square Down', 79, true, '{"icon_name":"caret-square-down","icon_prefix":"fas","icon_category":"core","unicode":"f150"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bridge-circle-exclamation_solid', 'Bridge Circle Exclamation', 84, true, '{"icon_name":"bridge-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e4ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chalkboard-user_solid', 'Chalkboard User', 93, true, '{"icon_name":"chalkboard-user","icon_prefix":"fas","icon_category":"core","unicode":"f51c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-check_solid', 'User Check', 95, true, '{"icon_name":"user-check","icon_prefix":"fas","icon_category":"core","unicode":"f4fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-ninja_solid', 'User Ninja', 96, true, '{"icon_name":"user-ninja","icon_prefix":"fas","icon_category":"core","unicode":"f504"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bell_solid', 'Bell', 102, true, '{"icon_name":"bell","icon_prefix":"fas","icon_category":"core","unicode":"f0f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-rectangle_solid', 'Users Rectangle', 109, true, '{"icon_name":"users-rectangle","icon_prefix":"fas","icon_category":"core","unicode":"e594"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-circle-exclamation_solid', 'File Circle Exclamation', 118, true, '{"icon_name":"file-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e4eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-poll-horizontal_solid', 'Square Poll Horizontal', 141, true, '{"icon_name":"square-poll-horizontal","icon_prefix":"fas","icon_category":"core","unicode":"f682"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_school-circle-xmark_solid', 'School Circle Xmark', 143, true, '{"icon_name":"school-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e56d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_up-right-from-square_solid', 'Up Right From Square', 147, true, '{"icon_name":"up-right-from-square","icon_prefix":"fas","icon_category":"core","unicode":"f35d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-full_solid', 'Square Full', 149, true, '{"icon_name":"square-full","icon_prefix":"fas","icon_category":"core","unicode":"f45c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-pause_solid', 'Circle Pause', 160, true, '{"icon_name":"circle-pause","icon_prefix":"fas","icon_category":"core","unicode":"f28b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pause-circle_solid', 'Pause Circle', 161, true, '{"icon_name":"pause-circle","icon_prefix":"fas","icon_category":"core","unicode":"f28b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachometer-alt-average_solid', 'Tachometer Alt Average', 172, true, '{"icon_name":"tachometer-alt-average","icon_prefix":"fas","icon_category":"core","unicode":"f624"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-circle-exclamation_solid', 'Person Circle Exclamation', 190, true, '{"icon_name":"person-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e53f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ranking-star_solid', 'Ranking Star', 195, true, '{"icon_name":"ranking-star","icon_prefix":"fas","icon_category":"core","unicode":"e561"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-tie_solid', 'User Tie', 196, true, '{"icon_name":"user-tie","icon_prefix":"fas","icon_category":"core","unicode":"f508"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-music-camera-bolt_solid', 'Heart Music Camera Bolt', 206, true, '{"icon_name":"heart-music-camera-bolt","icon_prefix":"fas","icon_category":"core","unicode":"f86d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-crack_solid', 'Heart Crack', 210, true, '{"icon_name":"heart-crack","icon_prefix":"fas","icon_category":"core","unicode":"f7a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-broken_solid', 'Heart Broken', 211, true, '{"icon_name":"heart-broken","icon_prefix":"fas","icon_category":"core","unicode":"f7a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_search_solid', 'Search', 216, true, '{"icon_name":"search","icon_prefix":"fas","icon_category":"core","unicode":"f002"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-phone-flip_solid', 'Square Phone Flip', 257, true, '{"icon_name":"square-phone-flip","icon_prefix":"fas","icon_category":"core","unicode":"f87b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone-square-alt_solid', 'Phone Square Alt', 258, true, '{"icon_name":"phone-square-alt","icon_prefix":"fas","icon_category":"core","unicode":"f87b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-virus_solid', 'Square Virus', 264, true, '{"icon_name":"square-virus","icon_prefix":"fas","icon_category":"core","unicode":"e578"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-rays_solid', 'Users Rays', 274, true, '{"icon_name":"users-rays","icon_prefix":"fas","icon_category":"core","unicode":"e593"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-stars_solid', 'Face Grin Stars', 277, true, '{"icon_name":"face-grin-stars","icon_prefix":"fas","icon_category":"core","unicode":"f587"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-stars_solid', 'Grin Stars', 278, true, '{"icon_name":"grin-stars","icon_prefix":"fas","icon_category":"core","unicode":"f587"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-circle-plus_solid', 'Person Circle Plus', 293, true, '{"icon_name":"person-circle-plus","icon_prefix":"fas","icon_category":"core","unicode":"e541"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-circle-question_solid', 'Person Circle Question', 295, true, '{"icon_name":"person-circle-question","icon_prefix":"fas","icon_category":"core","unicode":"e542"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-from-square_solid', 'Share From Square', 297, true, '{"icon_name":"share-from-square","icon_prefix":"fas","icon_category":"core","unicode":"f14d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-square_solid', 'Share Square', 298, true, '{"icon_name":"share-square","icon_prefix":"fas","icon_category":"core","unicode":"f14d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-notch_solid', 'Circle Notch', 310, true, '{"icon_name":"circle-notch","icon_prefix":"fas","icon_category":"core","unicode":"f1ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wave-square_solid', 'Wave Square', 331, true, '{"icon_name":"wave-square","icon_prefix":"fas","icon_category":"core","unicode":"f83e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bridge-circle-xmark_solid', 'Bridge Circle Xmark', 335, true, '{"icon_name":"bridge-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e4cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_anchor-circle-exclamation_solid', 'Anchor Circle Exclamation', 341, true, '{"icon_name":"anchor-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e4ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-circle-exclamation_solid', 'Heart Circle Exclamation', 344, true, '{"icon_name":"heart-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e4fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-circle-exclamation_solid', 'Building Circle Exclamation', 345, true, '{"icon_name":"building-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e4d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-circle-exclamation_solid', 'House Circle Exclamation', 353, true, '{"icon_name":"house-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e50a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-to-square_solid', 'Pen To Square', 370, true, '{"icon_name":"pen-to-square","icon_prefix":"fas","icon_category":"core","unicode":"f044"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-half-stroke_solid', 'Circle Half Stroke', 376, true, '{"icon_name":"circle-half-stroke","icon_prefix":"fas","icon_category":"core","unicode":"f042"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_search-minus_solid', 'Search Minus', 393, true, '{"icon_name":"search-minus","icon_prefix":"fas","icon_category":"core","unicode":"f010"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-binary_solid', 'Square Binary', 395, true, '{"icon_name":"square-binary","icon_prefix":"fas","icon_category":"core","unicode":"e69b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-slash_solid', 'Users Slash', 410, true, '{"icon_name":"users-slash","icon_prefix":"fas","icon_category":"core","unicode":"e073"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart_solid', 'Heart', 415, true, '{"icon_name":"heart","icon_prefix":"fas","icon_category":"core","unicode":"f004"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-chevron-up_solid', 'Circle Chevron Up', 416, true, '{"icon_name":"circle-chevron-up","icon_prefix":"fas","icon_category":"core","unicode":"f139"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-circle-up_solid', 'Chevron Circle Up', 417, true, '{"icon_name":"chevron-circle-up","icon_prefix":"fas","icon_category":"core","unicode":"f139"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-injured_solid', 'User Injured', 458, true, '{"icon_name":"user-injured","icon_prefix":"fas","icon_category":"core","unicode":"f728"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-half_solid', 'Star Half', 467, true, '{"icon_name":"star-half","icon_prefix":"fas","icon_category":"core","unicode":"f089"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_search-plus_solid', 'Search Plus', 473, true, '{"icon_name":"search-plus","icon_prefix":"fas","icon_category":"core","unicode":"f00e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-circle-check_solid', 'Plane Circle Check', 489, true, '{"icon_name":"plane-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e555"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users_solid', 'Users', 490, true, '{"icon_name":"users","icon_prefix":"fas","icon_category":"core","unicode":"f0c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-stop_solid', 'Circle Stop', 537, true, '{"icon_name":"circle-stop","icon_prefix":"fas","icon_category":"core","unicode":"f28d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stop-circle_solid', 'Stop Circle', 538, true, '{"icon_name":"stop-circle","icon_prefix":"fas","icon_category":"core","unicode":"f28d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-xmark_solid', 'Square Xmark', 544, true, '{"icon_name":"square-xmark","icon_prefix":"fas","icon_category":"core","unicode":"f2d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_times-square_solid', 'Times Square', 545, true, '{"icon_name":"times-square","icon_prefix":"fas","icon_category":"core","unicode":"f2d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xmark-square_solid', 'Xmark Square', 546, true, '{"icon_name":"xmark-square","icon_prefix":"fas","icon_category":"core","unicode":"f2d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-circle-check_solid', 'Building Circle Check', 562, true, '{"icon_name":"building-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e4d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-shield_solid', 'User Shield', 566, true, '{"icon_name":"user-shield","icon_prefix":"fas","icon_category":"core","unicode":"f505"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-pulse_solid', 'Heart Pulse', 568, true, '{"icon_name":"heart-pulse","icon_prefix":"fas","icon_category":"core","unicode":"f21e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heartbeat_solid', 'Heartbeat', 569, true, '{"icon_name":"heartbeat","icon_prefix":"fas","icon_category":"core","unicode":"f21e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-root-variable_solid', 'Square Root Variable', 570, true, '{"icon_name":"square-root-variable","icon_prefix":"fas","icon_category":"core","unicode":"f698"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-root-alt_solid', 'Square Root Alt', 571, true, '{"icon_name":"square-root-alt","icon_prefix":"fas","icon_category":"core","unicode":"f698"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-xmark_solid', 'User Xmark', 585, true, '{"icon_name":"user-xmark","icon_prefix":"fas","icon_category":"core","unicode":"f235"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-times_solid', 'User Times', 586, true, '{"icon_name":"user-times","icon_prefix":"fas","icon_category":"core","unicode":"f235"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_filter-circle-dollar_solid', 'Filter Circle Dollar', 595, true, '{"icon_name":"filter-circle-dollar","icon_prefix":"fas","icon_category":"core","unicode":"f662"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-h_solid', 'Circle H', 598, true, '{"icon_name":"circle-h","icon_prefix":"fas","icon_category":"core","unicode":"f47e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-heart_solid', 'Shield Heart', 619, true, '{"icon_name":"shield-heart","icon_prefix":"fas","icon_category":"core","unicode":"e574"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-check_solid', 'Square Check', 622, true, '{"icon_name":"square-check","icon_prefix":"fas","icon_category":"core","unicode":"f14a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check-square_solid', 'Check Square', 623, true, '{"icon_name":"check-square","icon_prefix":"fas","icon_category":"core","unicode":"f14a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-circle-plus_solid', 'Heart Circle Plus', 632, true, '{"icon_name":"heart-circle-plus","icon_prefix":"fas","icon_category":"core","unicode":"e500"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-xmark_solid', 'Circle Xmark', 644, true, '{"icon_name":"circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"f057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_times-circle_solid', 'Times Circle', 645, true, '{"icon_name":"times-circle","icon_prefix":"fas","icon_category":"core","unicode":"f057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xmark-circle_solid', 'Xmark Circle', 646, true, '{"icon_name":"xmark-circle","icon_prefix":"fas","icon_category":"core","unicode":"f057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-pen_solid', 'User Pen', 658, true, '{"icon_name":"user-pen","icon_prefix":"fas","icon_category":"core","unicode":"f4ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-edit_solid', 'User Edit', 659, true, '{"icon_name":"user-edit","icon_prefix":"fas","icon_category":"core","unicode":"f4ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-clock_solid', 'User Clock', 660, true, '{"icon_name":"user-clock","icon_prefix":"fas","icon_category":"core","unicode":"f4fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-up_solid', 'Square Caret Up', 662, true, '{"icon_name":"square-caret-up","icon_prefix":"fas","icon_category":"core","unicode":"f151"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-up_solid', 'Caret Square Up', 663, true, '{"icon_name":"caret-square-up","icon_prefix":"fas","icon_category":"core","unicode":"f151"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-circle-xmark_solid', 'House Circle Xmark', 670, true, '{"icon_name":"house-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e50b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-line_solid', 'Users Line', 687, true, '{"icon_name":"users-line","icon_prefix":"fas","icon_category":"core","unicode":"e592"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-of-david_solid', 'Star Of David', 688, true, '{"icon_name":"star-of-david","icon_prefix":"fas","icon_category":"core","unicode":"f69a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clipboard-user_solid', 'Clipboard User', 691, true, '{"icon_name":"clipboard-user","icon_prefix":"fas","icon_category":"core","unicode":"f7f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-right_solid', 'Square Caret Right', 693, true, '{"icon_name":"square-caret-right","icon_prefix":"fas","icon_category":"core","unicode":"f152"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-right_solid', 'Caret Square Right', 694, true, '{"icon_name":"caret-square-right","icon_prefix":"fas","icon_category":"core","unicode":"f152"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope-circle-check_solid', 'Envelope Circle Check', 699, true, '{"icon_name":"envelope-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e4e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-arrow-left_solid', 'Circle Arrow Left', 721, true, '{"icon_name":"circle-arrow-left","icon_prefix":"fas","icon_category":"core","unicode":"f0a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-circle-left_solid', 'Arrow Circle Left', 722, true, '{"icon_name":"arrow-circle-left","icon_prefix":"fas","icon_category":"core","unicode":"f0a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug-circle-bolt_solid', 'Plug Circle Bolt', 723, true, '{"icon_name":"plug-circle-bolt","icon_prefix":"fas","icon_category":"core","unicode":"e55b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-arrow-right_solid', 'Circle Arrow Right', 728, true, '{"icon_name":"circle-arrow-right","icon_prefix":"fas","icon_category":"core","unicode":"f0a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-circle-right_solid', 'Arrow Circle Right', 729, true, '{"icon_name":"arrow-circle-right","icon_prefix":"fas","icon_category":"core","unicode":"f0a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-circle-question_solid', 'File Circle Question', 736, true, '{"icon_name":"file-circle-question","icon_prefix":"fas","icon_category":"core","unicode":"e4ef"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-plus_solid', 'User Plus', 760, true, '{"icon_name":"user-plus","icon_prefix":"fas","icon_category":"core","unicode":"f234"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug-circle-minus_solid', 'Plug Circle Minus', 791, true, '{"icon_name":"plug-circle-minus","icon_prefix":"fas","icon_category":"core","unicode":"e55e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-plus_solid', 'Circle Plus', 795, true, '{"icon_name":"circle-plus","icon_prefix":"fas","icon_category":"core","unicode":"f055"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plus-circle_solid', 'Plus Circle', 796, true, '{"icon_name":"plus-circle","icon_prefix":"fas","icon_category":"core","unicode":"f055"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-and-crescent_solid', 'Star And Crescent', 798, true, '{"icon_name":"star-and-crescent","icon_prefix":"fas","icon_category":"core","unicode":"f699"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hospital-user_solid', 'Hospital User', 801, true, '{"icon_name":"hospital-user","icon_prefix":"fas","icon_category":"core","unicode":"f80d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-circle-check_solid', 'House Circle Check', 818, true, '{"icon_name":"house-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e509"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle_solid', 'Circle', 820, true, '{"icon_name":"circle","icon_prefix":"fas","icon_category":"core","unicode":"f111"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-between-lines_solid', 'Users Between Lines', 824, true, '{"icon_name":"users-between-lines","icon_prefix":"fas","icon_category":"core","unicode":"e591"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-medical-circle-xmark_solid', 'House Medical Circle Xmark', 825, true, '{"icon_name":"house-medical-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e513"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-exclamation_solid', 'Circle Exclamation', 829, true, '{"icon_name":"circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"f06a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_exclamation-circle_solid', 'Exclamation Circle', 830, true, '{"icon_name":"exclamation-circle","icon_prefix":"fas","icon_category":"core","unicode":"f06a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-user_solid', 'Circle User', 844, true, '{"icon_name":"circle-user","icon_prefix":"fas","icon_category":"core","unicode":"f2bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-circle_solid', 'User Circle', 845, true, '{"icon_name":"user-circle","icon_prefix":"fas","icon_category":"core","unicode":"f2bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-envelope_solid', 'Square Envelope', 862, true, '{"icon_name":"square-envelope","icon_prefix":"fas","icon_category":"core","unicode":"f199"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envelope-square_solid', 'Envelope Square', 863, true, '{"icon_name":"envelope-square","icon_prefix":"fas","icon_category":"core","unicode":"f199"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-arrow-down_solid', 'Circle Arrow Down', 876, true, '{"icon_name":"circle-arrow-down","icon_prefix":"fas","icon_category":"core","unicode":"f0ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-circle-down_solid', 'Arrow Circle Down', 877, true, '{"icon_name":"arrow-circle-down","icon_prefix":"fas","icon_category":"core","unicode":"f0ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cog_solid', 'Cog', 879, true, '{"icon_name":"cog","icon_prefix":"fas","icon_category":"core","unicode":"f013"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-chevron-left_solid', 'Circle Chevron Left', 882, true, '{"icon_name":"circle-chevron-left","icon_prefix":"fas","icon_category":"core","unicode":"f137"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-circle-left_solid', 'Chevron Circle Left', 883, true, '{"icon_name":"chevron-circle-left","icon_prefix":"fas","icon_category":"core","unicode":"f137"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-question_solid', 'Circle Question', 884, true, '{"icon_name":"circle-question","icon_prefix":"fas","icon_category":"core","unicode":"f059"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_question-circle_solid', 'Question Circle', 885, true, '{"icon_name":"question-circle","icon_prefix":"fas","icon_category":"core","unicode":"f059"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-group_solid', 'User Group', 887, true, '{"icon_name":"user-group","icon_prefix":"fas","icon_category":"core","unicode":"f500"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-friends_solid', 'User Friends', 888, true, '{"icon_name":"user-friends","icon_prefix":"fas","icon_category":"core","unicode":"f500"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home-lg_solid', 'Home Lg', 890, true, '{"icon_name":"home-lg","icon_prefix":"fas","icon_category":"core","unicode":"e3af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-tag_solid', 'User Tag', 901, true, '{"icon_name":"user-tag","icon_prefix":"fas","icon_category":"core","unicode":"f507"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-rss_solid', 'Square Rss', 908, true, '{"icon_name":"square-rss","icon_prefix":"fas","icon_category":"core","unicode":"f143"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rss-square_solid', 'Rss Square', 909, true, '{"icon_name":"rss-square","icon_prefix":"fas","icon_category":"core","unicode":"f143"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-person-confined_solid', 'Square Person Confined', 926, true, '{"icon_name":"square-person-confined","icon_prefix":"fas","icon_category":"core","unicode":"e577"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-up_solid', 'Circle Up', 940, true, '{"icon_name":"circle-up","icon_prefix":"fas","icon_category":"core","unicode":"f35b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-up_solid', 'Arrow Alt Circle Up', 941, true, '{"icon_name":"arrow-alt-circle-up","icon_prefix":"fas","icon_category":"core","unicode":"f35b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vial-circle-check_solid', 'Vial Circle Check', 948, true, '{"icon_name":"vial-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e596"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bridge-circle-check_solid', 'Bridge Circle Check', 949, true, '{"icon_name":"bridge-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e4c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-circle-bolt_solid', 'Heart Circle Bolt', 954, true, '{"icon_name":"heart-circle-bolt","icon_prefix":"fas","icon_category":"core","unicode":"e4fc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-arrow-up-right_solid', 'Square Arrow Up Right', 961, true, '{"icon_name":"square-arrow-up-right","icon_prefix":"fas","icon_category":"core","unicode":"f14c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_external-link-square_solid', 'External Link Square', 962, true, '{"icon_name":"external-link-square","icon_prefix":"fas","icon_category":"core","unicode":"f14c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-circle-arrow-right_solid', 'Building Circle Arrow Right', 965, true, '{"icon_name":"building-circle-arrow-right","icon_prefix":"fas","icon_category":"core","unicode":"e4d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass-start_solid', 'Hourglass Start', 994, true, '{"icon_name":"hourglass-start","icon_prefix":"fas","icon_category":"core","unicode":"f251"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-left_solid', 'Circle Left', 996, true, '{"icon_name":"circle-left","icon_prefix":"fas","icon_category":"core","unicode":"f359"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-left_solid', 'Arrow Alt Circle Left', 997, true, '{"icon_name":"arrow-alt-circle-left","icon_prefix":"fas","icon_category":"core","unicode":"f359"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-poll-vertical_solid', 'Square Poll Vertical', 1000, true, '{"icon_name":"square-poll-vertical","icon_prefix":"fas","icon_category":"core","unicode":"f681"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-circle-minus_solid', 'Person Circle Minus', 1002, true, '{"icon_name":"person-circle-minus","icon_prefix":"fas","icon_category":"core","unicode":"e540"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bell-concierge_solid', 'Bell Concierge', 1004, true, '{"icon_name":"bell-concierge","icon_prefix":"fas","icon_category":"core","unicode":"f562"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_concierge-bell_solid', 'Concierge Bell', 1005, true, '{"icon_name":"concierge-bell","icon_prefix":"fas","icon_category":"core","unicode":"f562"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-lock_solid', 'User Lock', 1017, true, '{"icon_name":"user-lock","icon_prefix":"fas","icon_category":"core","unicode":"f502"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_anchor-circle-check_solid', 'Anchor Circle Check', 1020, true, '{"icon_name":"anchor-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e4aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-doctor_solid', 'User Doctor', 1027, true, '{"icon_name":"user-doctor","icon_prefix":"fas","icon_category":"core","unicode":"f0f0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-md_solid', 'User Md', 1028, true, '{"icon_name":"user-md","icon_prefix":"fas","icon_category":"core","unicode":"f0f0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home_solid', 'Home', 1042, true, '{"icon_name":"home","icon_prefix":"fas","icon_category":"core","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home-alt_solid', 'Home Alt', 1043, true, '{"icon_name":"home-alt","icon_prefix":"fas","icon_category":"core","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home-lg-alt_solid', 'Home Lg Alt', 1044, true, '{"icon_name":"home-lg-alt","icon_prefix":"fas","icon_category":"core","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-up-right_solid', 'Square Up Right', 1077, true, '{"icon_name":"square-up-right","icon_prefix":"fas","icon_category":"core","unicode":"f360"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_external-link-square-alt_solid', 'External Link Square Alt', 1078, true, '{"icon_name":"external-link-square-alt","icon_prefix":"fas","icon_category":"core","unicode":"f360"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-circle-xmark_solid', 'Heart Circle Xmark', 1084, true, '{"icon_name":"heart-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e501"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-medical-circle-exclamation_solid', 'House Medical Circle Exclamation', 1090, true, '{"icon_name":"house-medical-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e512"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-radiation_solid', 'Circle Radiation', 1097, true, '{"icon_name":"circle-radiation","icon_prefix":"fas","icon_category":"core","unicode":"f7ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user_solid', 'User', 1105, true, '{"icon_name":"user","icon_prefix":"fas","icon_category":"core","unicode":"f007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-alt_solid', 'User Alt', 1106, true, '{"icon_name":"user-alt","icon_prefix":"fas","icon_category":"core","unicode":"f007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-large_solid', 'User Large', 1107, true, '{"icon_name":"user-large","icon_prefix":"fas","icon_category":"core","unicode":"f007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wheat-awn-circle-exclamation_solid', 'Wheat Awn Circle Exclamation', 1117, true, '{"icon_name":"wheat-awn-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e598"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bookmark_solid', 'Bookmark', 1124, true, '{"icon_name":"bookmark","icon_prefix":"fas","icon_category":"core","unicode":"f02e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-circle-xmark_solid', 'File Circle Xmark', 1129, true, '{"icon_name":"file-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e5a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-left_solid', 'Square Caret Left', 1135, true, '{"icon_name":"square-caret-left","icon_prefix":"fas","icon_category":"core","unicode":"f191"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-left_solid', 'Caret Square Left', 1136, true, '{"icon_name":"caret-square-left","icon_prefix":"fas","icon_category":"core","unicode":"f191"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachometer-alt_solid', 'Tachometer Alt', 1146, true, '{"icon_name":"tachometer-alt","icon_prefix":"fas","icon_category":"core","unicode":"f625"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachometer-alt-fast_solid', 'Tachometer Alt Fast', 1147, true, '{"icon_name":"tachometer-alt-fast","icon_prefix":"fas","icon_category":"core","unicode":"f625"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-dollar-to-slot_solid', 'Circle Dollar To Slot', 1159, true, '{"icon_name":"circle-dollar-to-slot","icon_prefix":"fas","icon_category":"core","unicode":"f4b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachometer-average_solid', 'Tachometer Average', 1174, true, '{"icon_name":"tachometer-average","icon_prefix":"fas","icon_category":"core","unicode":"f629"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-viewfinder_solid', 'Users Viewfinder', 1180, true, '{"icon_name":"users-viewfinder","icon_prefix":"fas","icon_category":"core","unicode":"e595"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dumbbell_solid', 'Dumbbell', 1183, true, '{"icon_name":"dumbbell","icon_prefix":"fas","icon_category":"core","unicode":"f44b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-down_solid', 'Circle Down', 1189, true, '{"icon_name":"circle-down","icon_prefix":"fas","icon_category":"core","unicode":"f358"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-down_solid', 'Arrow Alt Circle Down', 1190, true, '{"icon_name":"arrow-alt-circle-down","icon_prefix":"fas","icon_category":"core","unicode":"f358"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_triangle-circle-square_solid', 'Triangle Circle Square', 1198, true, '{"icon_name":"triangle-circle-square","icon_prefix":"fas","icon_category":"core","unicode":"f61f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_search-location_solid', 'Search Location', 1211, true, '{"icon_name":"search-location","icon_prefix":"fas","icon_category":"core","unicode":"f689"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-circle-xmark_solid', 'Building Circle Xmark', 1220, true, '{"icon_name":"building-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e4d4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-check_solid', 'Circle Check', 1224, true, '{"icon_name":"circle-check","icon_prefix":"fas","icon_category":"core","unicode":"f058"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check-circle_solid', 'Check Circle', 1225, true, '{"icon_name":"check-circle","icon_prefix":"fas","icon_category":"core","unicode":"f058"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-right_solid', 'Circle Right', 1247, true, '{"icon_name":"circle-right","icon_prefix":"fas","icon_category":"core","unicode":"f35a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-right_solid', 'Arrow Alt Circle Right', 1248, true, '{"icon_name":"arrow-alt-circle-right","icon_prefix":"fas","icon_category":"core","unicode":"f35a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-play_solid', 'Circle Play', 1264, true, '{"icon_name":"circle-play","icon_prefix":"fas","icon_category":"core","unicode":"f144"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_play-circle_solid', 'Play Circle', 1265, true, '{"icon_name":"play-circle","icon_prefix":"fas","icon_category":"core","unicode":"f144"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-chimney-user_solid', 'House Chimney User', 1269, true, '{"icon_name":"house-chimney-user","icon_prefix":"fas","icon_category":"core","unicode":"e065"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_book-bookmark_solid', 'Book Bookmark', 1281, true, '{"icon_name":"book-bookmark","icon_prefix":"fas","icon_category":"core","unicode":"e0bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug-circle-xmark_solid', 'Plug Circle Xmark', 1307, true, '{"icon_name":"plug-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e560"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-squares_solid', 'List Squares', 1311, true, '{"icon_name":"list-squares","icon_prefix":"fas","icon_category":"core","unicode":"f03a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_school-circle-check_solid', 'School Circle Check', 1326, true, '{"icon_name":"school-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e56b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug-circle-check_solid', 'Plug Circle Check', 1340, true, '{"icon_name":"plug-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e55c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hands-holding-circle_solid', 'Hands Holding Circle', 1342, true, '{"icon_name":"hands-holding-circle","icon_prefix":"fas","icon_category":"core","unicode":"e4fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-user_solid', 'House User', 1348, true, '{"icon_name":"house-user","icon_prefix":"fas","icon_category":"core","unicode":"e1b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home-user_solid', 'Home User', 1349, true, '{"icon_name":"home-user","icon_prefix":"fas","icon_category":"core","unicode":"e1b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug-circle-plus_solid', 'Plug Circle Plus', 1353, true, '{"icon_name":"plug-circle-plus","icon_prefix":"fas","icon_category":"core","unicode":"e55f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-h_solid', 'Square H', 1363, true, '{"icon_name":"square-h","icon_prefix":"fas","icon_category":"core","unicode":"f0fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_h-square_solid', 'H Square', 1364, true, '{"icon_name":"h-square","icon_prefix":"fas","icon_category":"core","unicode":"f0fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-chevron-right_solid', 'Circle Chevron Right', 1366, true, '{"icon_name":"circle-chevron-right","icon_prefix":"fas","icon_category":"core","unicode":"f138"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-circle-right_solid', 'Chevron Circle Right', 1367, true, '{"icon_name":"chevron-circle-right","icon_prefix":"fas","icon_category":"core","unicode":"f138"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bell-slash_solid', 'Bell Slash', 1399, true, '{"icon_name":"bell-slash","icon_prefix":"fas","icon_category":"core","unicode":"f1f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star_solid', 'Star', 1422, true, '{"icon_name":"star","icon_prefix":"fas","icon_category":"core","unicode":"f005"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_school-circle-exclamation_solid', 'School Circle Exclamation', 1427, true, '{"icon_name":"school-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e56c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-astronaut_solid', 'User Astronaut', 1431, true, '{"icon_name":"user-astronaut","icon_prefix":"fas","icon_category":"core","unicode":"f4fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-parking_solid', 'Square Parking', 1445, true, '{"icon_name":"square-parking","icon_prefix":"fas","icon_category":"core","unicode":"f540"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-nodes_solid', 'Circle Nodes', 1455, true, '{"icon_name":"circle-nodes","icon_prefix":"fas","icon_category":"core","unicode":"e4e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_filter-circle-xmark_solid', 'Filter Circle Xmark', 1458, true, '{"icon_name":"filter-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e17b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-circle-minus_solid', 'Heart Circle Minus', 1460, true, '{"icon_name":"heart-circle-minus","icon_prefix":"fas","icon_category":"core","unicode":"e4ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-of-life_solid', 'Star Of Life', 1461, true, '{"icon_name":"star-of-life","icon_prefix":"fas","icon_category":"core","unicode":"f621"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-minus_solid', 'User Minus', 1467, true, '{"icon_name":"user-minus","icon_prefix":"fas","icon_category":"core","unicode":"f503"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-hearts_solid', 'Face Grin Hearts', 1489, true, '{"icon_name":"face-grin-hearts","icon_prefix":"fas","icon_category":"core","unicode":"f584"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-hearts_solid', 'Grin Hearts', 1490, true, '{"icon_name":"grin-hearts","icon_prefix":"fas","icon_category":"core","unicode":"f584"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-nfi_solid', 'Square Nfi', 1561, true, '{"icon_name":"square-nfi","icon_prefix":"fas","icon_category":"core","unicode":"e576"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_search-dollar_solid', 'Search Dollar', 1564, true, '{"icon_name":"search-dollar","icon_prefix":"fas","icon_category":"core","unicode":"f688"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-slash_solid', 'User Slash', 1567, true, '{"icon_name":"user-slash","icon_prefix":"fas","icon_category":"core","unicode":"f506"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-alt-slash_solid', 'User Alt Slash', 1568, true, '{"icon_name":"user-alt-slash","icon_prefix":"fas","icon_category":"core","unicode":"f506"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-large-slash_solid', 'User Large Slash', 1569, true, '{"icon_name":"user-large-slash","icon_prefix":"fas","icon_category":"core","unicode":"f506"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-chevron-down_solid', 'Circle Chevron Down', 1587, true, '{"icon_name":"circle-chevron-down","icon_prefix":"fas","icon_category":"core","unicode":"f13a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-circle-down_solid', 'Chevron Circle Down', 1588, true, '{"icon_name":"chevron-circle-down","icon_prefix":"fas","icon_category":"core","unicode":"f13a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-nurse_solid', 'User Nurse', 1589, true, '{"icon_name":"user-nurse","icon_prefix":"fas","icon_category":"core","unicode":"f82f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-kiss-wink-heart_solid', 'Face Kiss Wink Heart', 1590, true, '{"icon_name":"face-kiss-wink-heart","icon_prefix":"fas","icon_category":"core","unicode":"f598"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiss-wink-heart_solid', 'Kiss Wink Heart', 1591, true, '{"icon_name":"kiss-wink-heart","icon_prefix":"fas","icon_category":"core","unicode":"f598"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_building-user_solid', 'Building User', 1601, true, '{"icon_name":"building-user","icon_prefix":"fas","icon_category":"core","unicode":"e4da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-plus_solid', 'Square Plus', 1610, true, '{"icon_name":"square-plus","icon_prefix":"fas","icon_category":"core","unicode":"f0fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plus-square_solid', 'Plus Square', 1611, true, '{"icon_name":"plus-square","icon_prefix":"fas","icon_category":"core","unicode":"f0fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-circle-check_solid', 'File Circle Check', 1616, true, '{"icon_name":"file-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e5a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-graduate_solid', 'User Graduate', 1639, true, '{"icon_name":"user-graduate","icon_prefix":"fas","icon_category":"core","unicode":"f501"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hand-holding-heart_solid', 'Hand Holding Heart', 1673, true, '{"icon_name":"hand-holding-heart","icon_prefix":"fas","icon_category":"core","unicode":"f4be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-circle-exclamation_solid', 'Plane Circle Exclamation', 1685, true, '{"icon_name":"plane-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e556"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-circle-check_solid', 'Person Circle Check', 1690, true, '{"icon_name":"person-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e53e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-medical-circle-check_solid', 'House Medical Circle Check', 1692, true, '{"icon_name":"house-medical-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e511"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-arrow-up_solid', 'Circle Arrow Up', 1701, true, '{"icon_name":"circle-arrow-up","icon_prefix":"fas","icon_category":"core","unicode":"f0aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-circle-up_solid', 'Arrow Circle Up', 1702, true, '{"icon_name":"arrow-circle-up","icon_prefix":"fas","icon_category":"core","unicode":"f0aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-circle-minus_solid', 'File Circle Minus', 1708, true, '{"icon_name":"file-circle-minus","icon_prefix":"fas","icon_category":"core","unicode":"e4ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-circle-check_solid', 'Road Circle Check', 1716, true, '{"icon_name":"road-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e564"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-flood-water-circle-arrow-right_solid', 'House Flood Water Circle Arrow Right', 1725, true, '{"icon_name":"house-flood-water-circle-arrow-right","icon_prefix":"fas","icon_category":"core","unicode":"e50f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-right-from-square_solid', 'Arrow Up Right From Square', 1726, true, '{"icon_name":"arrow-up-right-from-square","icon_prefix":"fas","icon_category":"core","unicode":"f08e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square_solid', 'Square', 1750, true, '{"icon_name":"square","icon_prefix":"fas","icon_category":"core","unicode":"f0c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-secret_solid', 'User Secret', 1772, true, '{"icon_name":"user-secret","icon_prefix":"fas","icon_category":"core","unicode":"f21b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-gear_solid', 'Users Gear', 1784, true, '{"icon_name":"users-gear","icon_prefix":"fas","icon_category":"core","unicode":"f509"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_users-cog_solid', 'Users Cog', 1785, true, '{"icon_name":"users-cog","icon_prefix":"fas","icon_category":"core","unicode":"f509"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-circle-exclamation_solid', 'Road Circle Exclamation', 1786, true, '{"icon_name":"road-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e565"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-circle-xmark_solid', 'Plane Circle Xmark', 1798, true, '{"icon_name":"plane-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e557"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-gear_solid', 'User Gear', 1800, true, '{"icon_name":"user-gear","icon_prefix":"fas","icon_category":"core","unicode":"f4fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-cog_solid', 'User Cog', 1801, true, '{"icon_name":"user-cog","icon_prefix":"fas","icon_category":"core","unicode":"f4fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plug-circle-exclamation_solid', 'Plug Circle Exclamation', 1810, true, '{"icon_name":"plug-circle-exclamation","icon_prefix":"fas","icon_category":"core","unicode":"e55d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachometer_solid', 'Tachometer', 1842, true, '{"icon_name":"tachometer","icon_prefix":"fas","icon_category":"core","unicode":"f62a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tachometer-fast_solid', 'Tachometer Fast', 1843, true, '{"icon_name":"tachometer-fast","icon_prefix":"fas","icon_category":"core","unicode":"f62a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-dot_solid', 'Circle Dot', 1869, true, '{"icon_name":"circle-dot","icon_prefix":"fas","icon_category":"core","unicode":"f192"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dot-circle_solid', 'Dot Circle', 1870, true, '{"icon_name":"dot-circle","icon_prefix":"fas","icon_category":"core","unicode":"f192"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-phone_solid', 'Square Phone', 1874, true, '{"icon_name":"square-phone","icon_prefix":"fas","icon_category":"core","unicode":"f098"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phone-square_solid', 'Phone Square', 1875, true, '{"icon_name":"phone-square","icon_prefix":"fas","icon_category":"core","unicode":"f098"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-minus_solid', 'Circle Minus', 1904, true, '{"icon_name":"circle-minus","icon_prefix":"fas","icon_category":"core","unicode":"f056"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_minus-circle_solid', 'Minus Circle', 1905, true, '{"icon_name":"minus-circle","icon_prefix":"fas","icon_category":"core","unicode":"f056"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-share-nodes_solid', 'Square Share Nodes', 1908, true, '{"icon_name":"square-share-nodes","icon_prefix":"fas","icon_category":"core","unicode":"f1e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-alt-square_solid', 'Share Alt Square', 1909, true, '{"icon_name":"share-alt-square","icon_prefix":"fas","icon_category":"core","unicode":"f1e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-circle-xmark_solid', 'Road Circle Xmark', 1915, true, '{"icon_name":"road-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e566"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_anchor-circle-xmark_solid', 'Anchor Circle Xmark', 1926, true, '{"icon_name":"anchor-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e4ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-circle-xmark_solid', 'Person Circle Xmark', 1927, true, '{"icon_name":"person-circle-xmark","icon_prefix":"fas","icon_category":"core","unicode":"e543"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart-circle-check_solid', 'Heart Circle Check', 1931, true, '{"icon_name":"heart-circle-check","icon_prefix":"fas","icon_category":"core","unicode":"e4fd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-info_solid', 'Circle Info', 1939, true, '{"icon_name":"circle-info","icon_prefix":"fas","icon_category":"core","unicode":"f05a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_info-circle_solid', 'Info Circle', 1940, true, '{"icon_name":"info-circle","icon_prefix":"fas","icon_category":"core","unicode":"f05a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-half-stroke_solid', 'Star Half Stroke', 1943, true, '{"icon_name":"star-half-stroke","icon_prefix":"fas","icon_category":"core","unicode":"f5c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-half-alt_solid', 'Star Half Alt', 1944, true, '{"icon_name":"star-half-alt","icon_prefix":"fas","icon_category":"core","unicode":"f5c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-minus_regular', 'Square Minus (Regular)', 1984, true, '{"icon_name":"square-minus","icon_prefix":"far","icon_category":"core","unicode":"f146"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_minus-square_regular', 'Minus Square (Regular)', 1985, true, '{"icon_name":"minus-square","icon_prefix":"far","icon_category":"core","unicode":"f146"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-down_regular', 'Square Caret Down (Regular)', 1994, true, '{"icon_name":"square-caret-down","icon_prefix":"far","icon_category":"core","unicode":"f150"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-down_regular', 'Caret Square Down (Regular)', 1995, true, '{"icon_name":"caret-square-down","icon_prefix":"far","icon_category":"core","unicode":"f150"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bell_regular', 'Bell (Regular)', 1997, true, '{"icon_name":"bell","icon_prefix":"far","icon_category":"core","unicode":"f0f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-full_regular', 'Square Full (Regular)', 2006, true, '{"icon_name":"square-full","icon_prefix":"far","icon_category":"core","unicode":"f45c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-pause_regular', 'Circle Pause (Regular)', 2007, true, '{"icon_name":"circle-pause","icon_prefix":"far","icon_category":"core","unicode":"f28b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pause-circle_regular', 'Pause Circle (Regular)', 2008, true, '{"icon_name":"pause-circle","icon_prefix":"far","icon_category":"core","unicode":"f28b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-stars_regular', 'Face Grin Stars (Regular)', 2019, true, '{"icon_name":"face-grin-stars","icon_prefix":"far","icon_category":"core","unicode":"f587"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-stars_regular', 'Grin Stars (Regular)', 2020, true, '{"icon_name":"grin-stars","icon_prefix":"far","icon_category":"core","unicode":"f587"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-from-square_regular', 'Share From Square (Regular)', 2024, true, '{"icon_name":"share-from-square","icon_prefix":"far","icon_category":"core","unicode":"f14d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-square_regular', 'Share Square (Regular)', 2025, true, '{"icon_name":"share-square","icon_prefix":"far","icon_category":"core","unicode":"f14d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pen-to-square_regular', 'Pen To Square (Regular)', 2033, true, '{"icon_name":"pen-to-square","icon_prefix":"far","icon_category":"core","unicode":"f044"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_heart_regular', 'Heart (Regular)', 2042, true, '{"icon_name":"heart","icon_prefix":"far","icon_category":"core","unicode":"f004"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-half_regular', 'Star Half (Regular)', 2049, true, '{"icon_name":"star-half","icon_prefix":"far","icon_category":"core","unicode":"f089"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-stop_regular', 'Circle Stop (Regular)', 2055, true, '{"icon_name":"circle-stop","icon_prefix":"far","icon_category":"core","unicode":"f28d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stop-circle_regular', 'Stop Circle (Regular)', 2056, true, '{"icon_name":"stop-circle","icon_prefix":"far","icon_category":"core","unicode":"f28d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-check_regular', 'Square Check (Regular)', 2064, true, '{"icon_name":"square-check","icon_prefix":"far","icon_category":"core","unicode":"f14a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check-square_regular', 'Check Square (Regular)', 2065, true, '{"icon_name":"check-square","icon_prefix":"far","icon_category":"core","unicode":"f14a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-xmark_regular', 'Circle Xmark (Regular)', 2068, true, '{"icon_name":"circle-xmark","icon_prefix":"far","icon_category":"core","unicode":"f057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_times-circle_regular', 'Times Circle (Regular)', 2069, true, '{"icon_name":"times-circle","icon_prefix":"far","icon_category":"core","unicode":"f057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xmark-circle_regular', 'Xmark Circle (Regular)', 2070, true, '{"icon_name":"xmark-circle","icon_prefix":"far","icon_category":"core","unicode":"f057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-up_regular', 'Square Caret Up (Regular)', 2071, true, '{"icon_name":"square-caret-up","icon_prefix":"far","icon_category":"core","unicode":"f151"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-up_regular', 'Caret Square Up (Regular)', 2072, true, '{"icon_name":"caret-square-up","icon_prefix":"far","icon_category":"core","unicode":"f151"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-right_regular', 'Square Caret Right (Regular)', 2074, true, '{"icon_name":"square-caret-right","icon_prefix":"far","icon_category":"core","unicode":"f152"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-right_regular', 'Caret Square Right (Regular)', 2075, true, '{"icon_name":"caret-square-right","icon_prefix":"far","icon_category":"core","unicode":"f152"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle_regular', 'Circle (Regular)', 2098, true, '{"icon_name":"circle","icon_prefix":"far","icon_category":"core","unicode":"f111"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-user_regular', 'Circle User (Regular)', 2101, true, '{"icon_name":"circle-user","icon_prefix":"far","icon_category":"core","unicode":"f2bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-circle_regular', 'User Circle (Regular)', 2102, true, '{"icon_name":"user-circle","icon_prefix":"far","icon_category":"core","unicode":"f2bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-question_regular', 'Circle Question (Regular)', 2110, true, '{"icon_name":"circle-question","icon_prefix":"far","icon_category":"core","unicode":"f059"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_question-circle_regular', 'Question Circle (Regular)', 2111, true, '{"icon_name":"question-circle","icon_prefix":"far","icon_category":"core","unicode":"f059"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-up_regular', 'Circle Up (Regular)', 2119, true, '{"icon_name":"circle-up","icon_prefix":"far","icon_category":"core","unicode":"f35b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-up_regular', 'Arrow Alt Circle Up (Regular)', 2120, true, '{"icon_name":"arrow-alt-circle-up","icon_prefix":"far","icon_category":"core","unicode":"f35b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-left_regular', 'Circle Left (Regular)', 2131, true, '{"icon_name":"circle-left","icon_prefix":"far","icon_category":"core","unicode":"f359"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-left_regular', 'Arrow Alt Circle Left (Regular)', 2132, true, '{"icon_name":"arrow-alt-circle-left","icon_prefix":"far","icon_category":"core","unicode":"f359"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home_regular', 'Home (Regular)', 2139, true, '{"icon_name":"home","icon_prefix":"far","icon_category":"core","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home-alt_regular', 'Home Alt (Regular)', 2140, true, '{"icon_name":"home-alt","icon_prefix":"far","icon_category":"core","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_home-lg-alt_regular', 'Home Lg Alt (Regular)', 2141, true, '{"icon_name":"home-lg-alt","icon_prefix":"far","icon_category":"core","unicode":"f015"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user_regular', 'User (Regular)', 2144, true, '{"icon_name":"user","icon_prefix":"far","icon_category":"core","unicode":"f007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-alt_regular', 'User Alt (Regular)', 2145, true, '{"icon_name":"user-alt","icon_prefix":"far","icon_category":"core","unicode":"f007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_user-large_regular', 'User Large (Regular)', 2146, true, '{"icon_name":"user-large","icon_prefix":"far","icon_category":"core","unicode":"f007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bookmark_regular', 'Bookmark (Regular)', 2148, true, '{"icon_name":"bookmark","icon_prefix":"far","icon_category":"core","unicode":"f02e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-caret-left_regular', 'Square Caret Left (Regular)', 2149, true, '{"icon_name":"square-caret-left","icon_prefix":"far","icon_category":"core","unicode":"f191"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-square-left_regular', 'Caret Square Left (Regular)', 2150, true, '{"icon_name":"caret-square-left","icon_prefix":"far","icon_category":"core","unicode":"f191"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-down_regular', 'Circle Down (Regular)', 2161, true, '{"icon_name":"circle-down","icon_prefix":"far","icon_category":"core","unicode":"f358"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-down_regular', 'Arrow Alt Circle Down (Regular)', 2162, true, '{"icon_name":"arrow-alt-circle-down","icon_prefix":"far","icon_category":"core","unicode":"f358"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-check_regular', 'Circle Check (Regular)', 2167, true, '{"icon_name":"circle-check","icon_prefix":"far","icon_category":"core","unicode":"f058"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check-circle_regular', 'Check Circle (Regular)', 2168, true, '{"icon_name":"check-circle","icon_prefix":"far","icon_category":"core","unicode":"f058"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-right_regular', 'Circle Right (Regular)', 2172, true, '{"icon_name":"circle-right","icon_prefix":"far","icon_category":"core","unicode":"f35a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-alt-circle-right_regular', 'Arrow Alt Circle Right (Regular)', 2173, true, '{"icon_name":"arrow-alt-circle-right","icon_prefix":"far","icon_category":"core","unicode":"f35a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-play_regular', 'Circle Play (Regular)', 2176, true, '{"icon_name":"circle-play","icon_prefix":"far","icon_category":"core","unicode":"f144"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_play-circle_regular', 'Play Circle (Regular)', 2177, true, '{"icon_name":"play-circle","icon_prefix":"far","icon_category":"core","unicode":"f144"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bell-slash_regular', 'Bell Slash (Regular)', 2198, true, '{"icon_name":"bell-slash","icon_prefix":"far","icon_category":"core","unicode":"f1f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star_regular', 'Star (Regular)', 2199, true, '{"icon_name":"star","icon_prefix":"far","icon_category":"core","unicode":"f005"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-grin-hearts_regular', 'Face Grin Hearts (Regular)', 2203, true, '{"icon_name":"face-grin-hearts","icon_prefix":"far","icon_category":"core","unicode":"f584"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grin-hearts_regular', 'Grin Hearts (Regular)', 2204, true, '{"icon_name":"grin-hearts","icon_prefix":"far","icon_category":"core","unicode":"f584"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-kiss-wink-heart_regular', 'Face Kiss Wink Heart (Regular)', 2212, true, '{"icon_name":"face-kiss-wink-heart","icon_prefix":"far","icon_category":"core","unicode":"f598"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kiss-wink-heart_regular', 'Kiss Wink Heart (Regular)', 2213, true, '{"icon_name":"kiss-wink-heart","icon_prefix":"far","icon_category":"core","unicode":"f598"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-plus_regular', 'Square Plus (Regular)', 2216, true, '{"icon_name":"square-plus","icon_prefix":"far","icon_category":"core","unicode":"f0fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plus-square_regular', 'Plus Square (Regular)', 2217, true, '{"icon_name":"plus-square","icon_prefix":"far","icon_category":"core","unicode":"f0fe"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square_regular', 'Square (Regular)', 2232, true, '{"icon_name":"square","icon_prefix":"far","icon_category":"core","unicode":"f0c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_circle-dot_regular', 'Circle Dot (Regular)', 2245, true, '{"icon_name":"circle-dot","icon_prefix":"far","icon_category":"core","unicode":"f192"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dot-circle_regular', 'Dot Circle (Regular)', 2246, true, '{"icon_name":"dot-circle","icon_prefix":"far","icon_category":"core","unicode":"f192"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-half-stroke_regular', 'Star Half Stroke (Regular)', 2250, true, '{"icon_name":"star-half-stroke","icon_prefix":"far","icon_category":"core","unicode":"f5c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_star-half-alt_regular', 'Star Half Alt (Regular)', 2251, true, '{"icon_name":"star-half-alt","icon_prefix":"far","icon_category":"core","unicode":"f5c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: status (20 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-check_solid', 'Calendar Check', 20, true, '{"icon_name":"calendar-check","icon_prefix":"fas","icon_category":"status","unicode":"f274"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ban_solid', 'Ban', 222, true, '{"icon_name":"ban","icon_prefix":"fas","icon_category":"status","unicode":"f05e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clipboard-check_solid', 'Clipboard Check', 296, true, '{"icon_name":"clipboard-check","icon_prefix":"fas","icon_category":"status","unicode":"f46c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ban-smoking_solid', 'Ban Smoking', 864, true, '{"icon_name":"ban-smoking","icon_prefix":"fas","icon_category":"status","unicode":"f54d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_smoking-ban_solid', 'Smoking Ban', 865, true, '{"icon_name":"smoking-ban","icon_prefix":"fas","icon_category":"status","unicode":"f54d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check_solid', 'Check', 1014, true, '{"icon_name":"check","icon_prefix":"fas","icon_category":"status","unicode":"f00c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spell-check_solid', 'Spell Check', 1121, true, '{"icon_name":"spell-check","icon_prefix":"fas","icon_category":"status","unicode":"f891"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flag-checkered_solid', 'Flag Checkered', 1171, true, '{"icon_name":"flag-checkered","icon_prefix":"fas","icon_category":"status","unicode":"f11e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-check_solid', 'Money Check', 1468, true, '{"icon_name":"money-check","icon_prefix":"fas","icon_category":"status","unicode":"f53c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check-double_solid', 'Check Double', 1572, true, '{"icon_name":"check-double","icon_prefix":"fas","icon_category":"status","unicode":"f560"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_check-to-slot_solid', 'Check To Slot', 1633, true, '{"icon_name":"check-to-slot","icon_prefix":"fas","icon_category":"status","unicode":"f772"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bandage_solid', 'Bandage', 1683, true, '{"icon_name":"bandage","icon_prefix":"fas","icon_category":"status","unicode":"f462"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_band-aid_solid', 'Band Aid', 1684, true, '{"icon_name":"band-aid","icon_prefix":"fas","icon_category":"status","unicode":"f462"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-check-dollar_solid', 'Money Check Dollar', 1697, true, '{"icon_name":"money-check-dollar","icon_prefix":"fas","icon_category":"status","unicode":"f53d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_money-check-alt_solid', 'Money Check Alt', 1698, true, '{"icon_name":"money-check-alt","icon_prefix":"fas","icon_category":"status","unicode":"f53d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bank_solid', 'Bank', 1762, true, '{"icon_name":"bank","icon_prefix":"fas","icon_category":"status","unicode":"f19c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_piggy-bank_solid', 'Piggy Bank', 1792, true, '{"icon_name":"piggy-bank","icon_prefix":"fas","icon_category":"status","unicode":"f4d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_list-check_solid', 'List Check', 1857, true, '{"icon_name":"list-check","icon_prefix":"fas","icon_category":"status","unicode":"f0ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bangladeshi-taka-sign_solid', 'Bangladeshi Taka Sign', 1983, true, '{"icon_name":"bangladeshi-taka-sign","icon_prefix":"fas","icon_category":"status","unicode":"e2e6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-check_regular', 'Calendar Check (Regular)', 1986, true, '{"icon_name":"calendar-check","icon_prefix":"far","icon_category":"status","unicode":"f274"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: media (72 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-clipboard_solid', 'File Clipboard', 27, true, '{"icon_name":"file-clipboard","icon_prefix":"fas","icon_category":"media","unicode":"f0ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-download_solid', 'File Download', 39, true, '{"icon_name":"file-download","icon_prefix":"fas","icon_category":"media","unicode":"f56d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-excel_solid', 'File Excel', 69, true, '{"icon_name":"file-excel","icon_prefix":"fas","icon_category":"media","unicode":"f1c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-zipper_solid', 'File Zipper', 202, true, '{"icon_name":"file-zipper","icon_prefix":"fas","icon_category":"media","unicode":"f1c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-archive_solid', 'File Archive', 203, true, '{"icon_name":"file-archive","icon_prefix":"fas","icon_category":"media","unicode":"f1c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_display_solid', 'Display', 204, true, '{"icon_name":"display","icon_prefix":"fas","icon_category":"media","unicode":"e163"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_camera_solid', 'Camera', 272, true, '{"icon_name":"camera","icon_prefix":"fas","icon_category":"media","unicode":"f030"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_camera-alt_solid', 'Camera Alt', 273, true, '{"icon_name":"camera-alt","icon_prefix":"fas","icon_category":"media","unicode":"f030"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stop_solid', 'Stop', 321, true, '{"icon_name":"stop","icon_prefix":"fas","icon_category":"media","unicode":"f04d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-upload_solid', 'File Upload', 367, true, '{"icon_name":"file-upload","icon_prefix":"fas","icon_category":"media","unicode":"f574"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-open_solid', 'Folder Open', 447, true, '{"icon_name":"folder-open","icon_prefix":"fas","icon_category":"media","unicode":"f07c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-import_solid', 'File Import', 607, true, '{"icon_name":"file-import","icon_prefix":"fas","icon_category":"media","unicode":"f56f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-image_solid', 'File Image', 692, true, '{"icon_name":"file-image","icon_prefix":"fas","icon_category":"media","unicode":"f1c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_image_solid', 'Image', 705, true, '{"icon_name":"image","icon_prefix":"fas","icon_category":"media","unicode":"f03e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-shield_solid', 'File Shield', 785, true, '{"icon_name":"file-shield","icon_prefix":"fas","icon_category":"media","unicode":"e4f0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder_solid', 'Folder', 803, true, '{"icon_name":"folder","icon_prefix":"fas","icon_category":"media","unicode":"f07b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-blank_solid', 'Folder Blank', 804, true, '{"icon_name":"folder-blank","icon_prefix":"fas","icon_category":"media","unicode":"f07b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file_solid', 'File', 893, true, '{"icon_name":"file","icon_prefix":"fas","icon_category":"media","unicode":"f15b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_play_solid', 'Play', 947, true, '{"icon_name":"play","icon_prefix":"fas","icon_category":"media","unicode":"f04b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-prescription_solid', 'File Prescription', 992, true, '{"icon_name":"file-prescription","icon_prefix":"fas","icon_category":"media","unicode":"f572"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-waveform_solid', 'File Waveform', 1023, true, '{"icon_name":"file-waveform","icon_prefix":"fas","icon_category":"media","unicode":"f478"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-medical-alt_solid', 'File Medical Alt', 1024, true, '{"icon_name":"file-medical-alt","icon_prefix":"fas","icon_category":"media","unicode":"f478"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-audio_solid', 'File Audio', 1167, true, '{"icon_name":"file-audio","icon_prefix":"fas","icon_category":"media","unicode":"f1c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-medical_solid', 'File Medical', 1191, true, '{"icon_name":"file-medical","icon_prefix":"fas","icon_category":"media","unicode":"f477"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-lines_solid', 'File Lines', 1206, true, '{"icon_name":"file-lines","icon_prefix":"fas","icon_category":"media","unicode":"f15c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-alt_solid', 'File Alt', 1207, true, '{"icon_name":"file-alt","icon_prefix":"fas","icon_category":"media","unicode":"f15c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-text_solid', 'File Text', 1208, true, '{"icon_name":"file-text","icon_prefix":"fas","icon_category":"media","unicode":"f15c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-invoice_solid', 'File Invoice', 1212, true, '{"icon_name":"file-invoice","icon_prefix":"fas","icon_category":"media","unicode":"f570"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_images_solid', 'Images', 1241, true, '{"icon_name":"images","icon_prefix":"fas","icon_category":"media","unicode":"f302"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-powerpoint_solid', 'File Powerpoint', 1318, true, '{"icon_name":"file-powerpoint","icon_prefix":"fas","icon_category":"media","unicode":"f1c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-csv_solid', 'File Csv', 1368, true, '{"icon_name":"file-csv","icon_prefix":"fas","icon_category":"media","unicode":"f6dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-invoice-dollar_solid', 'File Invoice Dollar', 1382, true, '{"icon_name":"file-invoice-dollar","icon_prefix":"fas","icon_category":"media","unicode":"f571"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-plus_solid', 'Folder Plus', 1442, true, '{"icon_name":"folder-plus","icon_prefix":"fas","icon_category":"media","unicode":"f65e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-fragment_solid', 'File Fragment', 1491, true, '{"icon_name":"file-fragment","icon_prefix":"fas","icon_category":"media","unicode":"e697"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-pdf_solid', 'File Pdf', 1518, true, '{"icon_name":"file-pdf","icon_prefix":"fas","icon_category":"media","unicode":"f1c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-pen_solid', 'File Pen', 1523, true, '{"icon_name":"file-pen","icon_prefix":"fas","icon_category":"media","unicode":"f31c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-edit_solid', 'File Edit', 1524, true, '{"icon_name":"file-edit","icon_prefix":"fas","icon_category":"media","unicode":"f31c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-minus_solid', 'Folder Minus', 1538, true, '{"icon_name":"folder-minus","icon_prefix":"fas","icon_category":"media","unicode":"f65d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_music_solid', 'Music', 1596, true, '{"icon_name":"music","icon_prefix":"fas","icon_category":"media","unicode":"f001"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-code_solid', 'File Code', 1640, true, '{"icon_name":"file-code","icon_prefix":"fas","icon_category":"media","unicode":"f1c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laptop-file_solid', 'Laptop File', 1650, true, '{"icon_name":"laptop-file","icon_prefix":"fas","icon_category":"media","unicode":"e51d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-word_solid', 'File Word', 1664, true, '{"icon_name":"file-word","icon_prefix":"fas","icon_category":"media","unicode":"f1c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_camera-retro_solid', 'Camera Retro', 1703, true, '{"icon_name":"camera-retro","icon_prefix":"fas","icon_category":"media","unicode":"f083"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_image-portrait_solid', 'Image Portrait', 1718, true, '{"icon_name":"image-portrait","icon_prefix":"fas","icon_category":"media","unicode":"f3e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-half-dashed_solid', 'File Half Dashed', 1737, true, '{"icon_name":"file-half-dashed","icon_prefix":"fas","icon_category":"media","unicode":"e698"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-contract_solid', 'File Contract', 1753, true, '{"icon_name":"file-contract","icon_prefix":"fas","icon_category":"media","unicode":"f56c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pause_solid', 'Pause', 1787, true, '{"icon_name":"pause","icon_prefix":"fas","icon_category":"media","unicode":"f04c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-closed_solid', 'Folder Closed', 1831, true, '{"icon_name":"folder-closed","icon_prefix":"fas","icon_category":"media","unicode":"e185"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-export_solid', 'File Export', 1863, true, '{"icon_name":"file-export","icon_prefix":"fas","icon_category":"media","unicode":"f56e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-tree_solid', 'Folder Tree', 1883, true, '{"icon_name":"folder-tree","icon_prefix":"fas","icon_category":"media","unicode":"f802"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-clipboard_regular', 'File Clipboard (Regular)', 1990, true, '{"icon_name":"file-clipboard","icon_prefix":"far","icon_category":"media","unicode":"f0ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-excel_regular', 'File Excel (Regular)', 1992, true, '{"icon_name":"file-excel","icon_prefix":"far","icon_category":"media","unicode":"f1c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-zipper_regular', 'File Zipper (Regular)', 2011, true, '{"icon_name":"file-zipper","icon_prefix":"far","icon_category":"media","unicode":"f1c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-archive_regular', 'File Archive (Regular)', 2012, true, '{"icon_name":"file-archive","icon_prefix":"far","icon_category":"media","unicode":"f1c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_camera_regular', 'Camera (Regular)', 2017, true, '{"icon_name":"camera","icon_prefix":"far","icon_category":"media","unicode":"f030"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_camera-alt_regular', 'Camera Alt (Regular)', 2018, true, '{"icon_name":"camera-alt","icon_prefix":"far","icon_category":"media","unicode":"f030"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-open_regular', 'Folder Open (Regular)', 2047, true, '{"icon_name":"folder-open","icon_prefix":"far","icon_category":"media","unicode":"f07c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-image_regular', 'File Image (Regular)', 2073, true, '{"icon_name":"file-image","icon_prefix":"far","icon_category":"media","unicode":"f1c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_image_regular', 'Image (Regular)', 2077, true, '{"icon_name":"image","icon_prefix":"far","icon_category":"media","unicode":"f03e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder_regular', 'Folder (Regular)', 2095, true, '{"icon_name":"folder","icon_prefix":"far","icon_category":"media","unicode":"f07b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-blank_regular', 'Folder Blank (Regular)', 2096, true, '{"icon_name":"folder-blank","icon_prefix":"far","icon_category":"media","unicode":"f07b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file_regular', 'File (Regular)', 2112, true, '{"icon_name":"file","icon_prefix":"far","icon_category":"media","unicode":"f15b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-audio_regular', 'File Audio (Regular)', 2158, true, '{"icon_name":"file-audio","icon_prefix":"far","icon_category":"media","unicode":"f1c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-lines_regular', 'File Lines (Regular)', 2163, true, '{"icon_name":"file-lines","icon_prefix":"far","icon_category":"media","unicode":"f15c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-alt_regular', 'File Alt (Regular)', 2164, true, '{"icon_name":"file-alt","icon_prefix":"far","icon_category":"media","unicode":"f15c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-text_regular', 'File Text (Regular)', 2165, true, '{"icon_name":"file-text","icon_prefix":"far","icon_category":"media","unicode":"f15c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_images_regular', 'Images (Regular)', 2171, true, '{"icon_name":"images","icon_prefix":"far","icon_category":"media","unicode":"f302"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-powerpoint_regular', 'File Powerpoint (Regular)', 2187, true, '{"icon_name":"file-powerpoint","icon_prefix":"far","icon_category":"media","unicode":"f1c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-pdf_regular', 'File Pdf (Regular)', 2207, true, '{"icon_name":"file-pdf","icon_prefix":"far","icon_category":"media","unicode":"f1c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-code_regular', 'File Code (Regular)', 2218, true, '{"icon_name":"file-code","icon_prefix":"far","icon_category":"media","unicode":"f1c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-word_regular', 'File Word (Regular)', 2224, true, '{"icon_name":"file-word","icon_prefix":"far","icon_category":"media","unicode":"f1c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_folder-closed_regular', 'Folder Closed (Regular)', 2239, true, '{"icon_name":"folder-closed","icon_prefix":"far","icon_category":"media","unicode":"e185"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: weather (37 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hexagon-nodes-bolt_solid', 'Hexagon Nodes Bolt', 34, true, '{"icon_name":"hexagon-nodes-bolt","icon_prefix":"fas","icon_category":"weather","unicode":"e69a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-upload_solid', 'Cloud Upload', 86, true, '{"icon_name":"cloud-upload","icon_prefix":"fas","icon_category":"weather","unicode":"f0ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-upload-alt_solid', 'Cloud Upload Alt', 87, true, '{"icon_name":"cloud-upload-alt","icon_prefix":"fas","icon_category":"weather","unicode":"f0ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-moon_solid', 'Cloud Moon', 217, true, '{"icon_name":"cloud-moon","icon_prefix":"fas","icon_category":"weather","unicode":"f6c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sun-plant-wilt_solid', 'Sun Plant Wilt', 227, true, '{"icon_name":"sun-plant-wilt","icon_prefix":"fas","icon_category":"weather","unicode":"e57a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-sun-rain_solid', 'Cloud Sun Rain', 265, true, '{"icon_name":"cloud-sun-rain","icon_prefix":"fas","icon_category":"weather","unicode":"f743"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-minimize_solid', 'Window Minimize', 452, true, '{"icon_name":"window-minimize","icon_prefix":"fas","icon_category":"weather","unicode":"f2d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-rain_solid', 'Cloud Rain', 499, true, '{"icon_name":"cloud-rain","icon_prefix":"fas","icon_category":"weather","unicode":"f73d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_poo-bolt_solid', 'Poo Bolt', 542, true, '{"icon_name":"poo-bolt","icon_prefix":"fas","icon_category":"weather","unicode":"f75a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mountain-sun_solid', 'Mountain Sun', 684, true, '{"icon_name":"mountain-sun","icon_prefix":"fas","icon_category":"weather","unicode":"e52f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sun_solid', 'Sun', 702, true, '{"icon_name":"sun","icon_prefix":"fas","icon_category":"weather","unicode":"f185"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bolt-lightning_solid', 'Bolt Lightning', 748, true, '{"icon_name":"bolt-lightning","icon_prefix":"fas","icon_category":"weather","unicode":"e0b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud_solid', 'Cloud', 811, true, '{"icon_name":"cloud","icon_prefix":"fas","icon_category":"weather","unicode":"f0c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-showers-heavy_solid', 'Cloud Showers Heavy', 895, true, '{"icon_name":"cloud-showers-heavy","icon_prefix":"fas","icon_category":"weather","unicode":"f740"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-close_solid', 'Window Close', 977, true, '{"icon_name":"window-close","icon_prefix":"fas","icon_category":"weather","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snowflake_solid', 'Snowflake', 1108, true, '{"icon_name":"snowflake","icon_prefix":"fas","icon_category":"weather","unicode":"f2dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-sun_solid', 'Cloud Sun', 1149, true, '{"icon_name":"cloud-sun","icon_prefix":"fas","icon_category":"weather","unicode":"f6c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_moon_solid', 'Moon', 1228, true, '{"icon_name":"moon","icon_prefix":"fas","icon_category":"weather","unicode":"f186"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-chimney-window_solid', 'House Chimney Window', 1274, true, '{"icon_name":"house-chimney-window","icon_prefix":"fas","icon_category":"weather","unicode":"e00d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-download_solid', 'Cloud Download', 1335, true, '{"icon_name":"cloud-download","icon_prefix":"fas","icon_category":"weather","unicode":"f0ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-download-alt_solid', 'Cloud Download Alt', 1336, true, '{"icon_name":"cloud-download-alt","icon_prefix":"fas","icon_category":"weather","unicode":"f0ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-maximize_solid', 'Window Maximize', 1341, true, '{"icon_name":"window-maximize","icon_prefix":"fas","icon_category":"weather","unicode":"f2d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-moon-rain_solid', 'Cloud Moon Rain', 1391, true, '{"icon_name":"cloud-moon-rain","icon_prefix":"fas","icon_category":"weather","unicode":"f73c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-restore_solid', 'Window Restore', 1456, true, '{"icon_name":"window-restore","icon_prefix":"fas","icon_category":"weather","unicode":"f2d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-bolt_solid', 'Cloud Bolt', 1655, true, '{"icon_name":"cloud-bolt","icon_prefix":"fas","icon_category":"weather","unicode":"f76c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bolt_solid', 'Bolt', 1669, true, '{"icon_name":"bolt","icon_prefix":"fas","icon_category":"weather","unicode":"f0e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-tsunami_solid', 'House Tsunami', 1768, true, '{"icon_name":"house-tsunami","icon_prefix":"fas","icon_category":"weather","unicode":"e515"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-through-window_solid', 'Person Through Window', 1832, true, '{"icon_name":"person-through-window","icon_prefix":"fas","icon_category":"weather","unicode":"e5a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wind_solid', 'Wind', 1954, true, '{"icon_name":"wind","icon_prefix":"fas","icon_category":"weather","unicode":"f72e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-minimize_regular', 'Window Minimize (Regular)', 2048, true, '{"icon_name":"window-minimize","icon_prefix":"far","icon_category":"weather","unicode":"f2d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sun_regular', 'Sun (Regular)', 2076, true, '{"icon_name":"sun","icon_prefix":"far","icon_category":"weather","unicode":"f185"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud_regular', 'Cloud (Regular)', 2097, true, '{"icon_name":"cloud","icon_prefix":"far","icon_category":"weather","unicode":"f0c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-close_regular', 'Window Close (Regular)', 2126, true, '{"icon_name":"window-close","icon_prefix":"far","icon_category":"weather","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snowflake_regular', 'Snowflake (Regular)', 2147, true, '{"icon_name":"snowflake","icon_prefix":"far","icon_category":"weather","unicode":"f2dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_moon_regular', 'Moon (Regular)', 2169, true, '{"icon_name":"moon","icon_prefix":"far","icon_category":"weather","unicode":"f186"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-maximize_regular', 'Window Maximize (Regular)', 2188, true, '{"icon_name":"window-maximize","icon_prefix":"far","icon_category":"weather","unicode":"f2d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_window-restore_regular', 'Window Restore (Regular)', 2202, true, '{"icon_name":"window-restore","icon_prefix":"far","icon_category":"weather","unicode":"f2d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: navigation (73 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-arrow-down_solid', 'File Arrow Down', 38, true, '{"icon_name":"file-arrow-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f56d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-z-a_solid', 'Arrow Up Z A', 50, true, '{"icon_name":"arrow-up-z-a","icon_prefix":"fas","icon_category":"navigation","unicode":"f882"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cart-arrow-down_solid', 'Cart Arrow Down', 83, true, '{"icon_name":"cart-arrow-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f218"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-arrow-up_solid', 'Cloud Arrow Up', 85, true, '{"icon_name":"cloud-arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f0ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bars-staggered_solid', 'Bars Staggered', 152, true, '{"icon_name":"bars-staggered","icon_prefix":"fas","icon_category":"navigation","unicode":"f550"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-walking-arrow-right_solid', 'Person Walking Arrow Right', 158, true, '{"icon_name":"person-walking-arrow-right","icon_prefix":"fas","icon_category":"navigation","unicode":"e552"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-long_solid', 'Arrow Right Long', 266, true, '{"icon_name":"arrow-right-long","icon_prefix":"fas","icon_category":"navigation","unicode":"f178"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-right_solid', 'Long Arrow Right', 267, true, '{"icon_name":"long-arrow-right","icon_prefix":"fas","icon_category":"navigation","unicode":"f178"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-up_solid', 'Chevron Up', 301, true, '{"icon_name":"chevron-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f077"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-left_solid', 'Angle Left', 332, true, '{"icon_name":"angle-left","icon_prefix":"fas","icon_category":"navigation","unicode":"f104"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-right-dots_solid', 'Arrow Up Right Dots', 339, true, '{"icon_name":"arrow-up-right-dots","icon_prefix":"fas","icon_category":"navigation","unicode":"e4b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-arrow-up-from-line_solid', 'Person Arrow Up From Line', 346, true, '{"icon_name":"person-arrow-up-from-line","icon_prefix":"fas","icon_category":"navigation","unicode":"e539"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_file-arrow-up_solid', 'File Arrow Up', 366, true, '{"icon_name":"file-arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f574"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-right_solid', 'Chevron Right', 453, true, '{"icon_name":"chevron-right","icon_prefix":"fas","icon_category":"navigation","unicode":"f054"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-to-bracket_solid', 'Arrow Right To Bracket', 506, true, '{"icon_name":"arrow-right-to-bracket","icon_prefix":"fas","icon_category":"navigation","unicode":"f090"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-to-file_solid', 'Arrow Right To File', 608, true, '{"icon_name":"arrow-right-to-file","icon_prefix":"fas","icon_category":"navigation","unicode":"f56f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-wide-short_solid', 'Arrow Up Wide Short', 685, true, '{"icon_name":"arrow-up-wide-short","icon_prefix":"fas","icon_category":"navigation","unicode":"f161"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-long_solid', 'Arrow Up Long', 750, true, '{"icon_name":"arrow-up-long","icon_prefix":"fas","icon_category":"navigation","unicode":"f176"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-up_solid', 'Long Arrow Up', 751, true, '{"icon_name":"long-arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f176"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angle-right_solid', 'Angle Right', 755, true, '{"icon_name":"angle-right","icon_prefix":"fas","icon_category":"navigation","unicode":"f105"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-from-ground-water_solid', 'Arrow Up From Ground Water', 758, true, '{"icon_name":"arrow-up-from-ground-water","icon_prefix":"fas","icon_category":"navigation","unicode":"e4b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-up-lock_solid', 'Arrow Down Up Lock', 802, true, '{"icon_name":"arrow-down-up-lock","icon_prefix":"fas","icon_category":"navigation","unicode":"e4b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-from-bracket_solid', 'Arrow Up From Bracket', 809, true, '{"icon_name":"arrow-up-from-bracket","icon_prefix":"fas","icon_category":"navigation","unicode":"e09a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-left-long_solid', 'Arrow Left Long', 869, true, '{"icon_name":"arrow-left-long","icon_prefix":"fas","icon_category":"navigation","unicode":"f177"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-left_solid', 'Long Arrow Left', 870, true, '{"icon_name":"long-arrow-left","icon_prefix":"fas","icon_category":"navigation","unicode":"f177"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up_solid', 'Arrow Up', 915, true, '{"icon_name":"arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f062"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-times_solid', 'Rectangle Times', 975, true, '{"icon_name":"rectangle-times","icon_prefix":"fas","icon_category":"navigation","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_times-rectangle_solid', 'Times Rectangle', 976, true, '{"icon_name":"times-rectangle","icon_prefix":"fas","icon_category":"navigation","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-arrow-up_solid', 'Trash Arrow Up', 988, true, '{"icon_name":"trash-arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f829"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-arrow-up_solid', 'Temperature Arrow Up', 1034, true, '{"icon_name":"temperature-arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"e040"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-from-water-pump_solid', 'Arrow Up From Water Pump', 1101, true, '{"icon_name":"arrow-up-from-water-pump","icon_prefix":"fas","icon_category":"navigation","unicode":"e4b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_volume-times_solid', 'Volume Times', 1141, true, '{"icon_name":"volume-times","icon_prefix":"fas","icon_category":"navigation","unicode":"f6a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right_solid', 'Arrow Right', 1150, true, '{"icon_name":"arrow-right","icon_prefix":"fas","icon_category":"navigation","unicode":"f061"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-times_solid', 'Calendar Times', 1188, true, '{"icon_name":"calendar-times","icon_prefix":"fas","icon_category":"navigation","unicode":"f273"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_times_solid', 'Times', 1196, true, '{"icon_name":"times","icon_prefix":"fas","icon_category":"navigation","unicode":"f00d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magnifying-glass-arrow-right_solid', 'Magnifying Glass Arrow Right', 1282, true, '{"icon_name":"magnifying-glass-arrow-right","icon_prefix":"fas","icon_category":"navigation","unicode":"e521"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-down_solid', 'Chevron Down', 1321, true, '{"icon_name":"chevron-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f078"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloud-arrow-down_solid', 'Cloud Arrow Down', 1334, true, '{"icon_name":"cloud-arrow-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f0ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-arrow-down-to-line_solid', 'Person Arrow Down To Line', 1352, true, '{"icon_name":"person-arrow-down-to-line","icon_prefix":"fas","icon_category":"navigation","unicode":"e538"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-short-wide_solid', 'Arrow Down Short Wide', 1373, true, '{"icon_name":"arrow-down-short-wide","icon_prefix":"fas","icon_category":"navigation","unicode":"f884"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chevron-left_solid', 'Chevron Left', 1390, true, '{"icon_name":"chevron-left","icon_prefix":"fas","icon_category":"navigation","unicode":"f053"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down19_solid', 'Arrow Down19', 1392, true, '{"icon_name":"arrow-down19","icon_prefix":"fas","icon_category":"navigation","unicode":"f162"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-z-a_solid', 'Arrow Down Z A', 1405, true, '{"icon_name":"arrow-down-z-a","icon_prefix":"fas","icon_category":"navigation","unicode":"f881"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_person-walking-dashed-line-arrow-right_solid', 'Person Walking Dashed Line Arrow Right', 1409, true, '{"icon_name":"person-walking-dashed-line-arrow-right","icon_prefix":"fas","icon_category":"navigation","unicode":"e553"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-short-wide_solid', 'Arrow Up Short Wide', 1410, true, '{"icon_name":"arrow-up-short-wide","icon_prefix":"fas","icon_category":"navigation","unicode":"f885"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-arrow-right_solid', 'Truck Arrow Right', 1416, true, '{"icon_name":"truck-arrow-right","icon_prefix":"fas","icon_category":"navigation","unicode":"e58b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-long_solid', 'Arrow Down Long', 1465, true, '{"icon_name":"arrow-down-long","icon_prefix":"fas","icon_category":"navigation","unicode":"f175"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_long-arrow-down_solid', 'Long Arrow Down', 1466, true, '{"icon_name":"long-arrow-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f175"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-from-bracket_solid', 'Arrow Right From Bracket', 1477, true, '{"icon_name":"arrow-right-from-bracket","icon_prefix":"fas","icon_category":"navigation","unicode":"f08b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-arrow-left_solid', 'Arrow Right Arrow Left', 1501, true, '{"icon_name":"arrow-right-arrow-left","icon_prefix":"fas","icon_category":"navigation","unicode":"f0ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trash-can-arrow-up_solid', 'Trash Can Arrow Up', 1513, true, '{"icon_name":"trash-can-arrow-up","icon_prefix":"fas","icon_category":"navigation","unicode":"f82a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-to-city_solid', 'Arrow Right To City', 1534, true, '{"icon_name":"arrow-right-to-city","icon_prefix":"fas","icon_category":"navigation","unicode":"e4b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up91_solid', 'Arrow Up91', 1542, true, '{"icon_name":"arrow-up91","icon_prefix":"fas","icon_category":"navigation","unicode":"f887"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down91_solid', 'Arrow Down91', 1545, true, '{"icon_name":"arrow-down91","icon_prefix":"fas","icon_category":"navigation","unicode":"f886"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-left_solid', 'Arrow Left', 1570, true, '{"icon_name":"arrow-left","icon_prefix":"fas","icon_category":"navigation","unicode":"f060"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-rotate_solid', 'Arrow Right Rotate', 1622, true, '{"icon_name":"arrow-right-rotate","icon_prefix":"fas","icon_category":"navigation","unicode":"f01e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-wide-short_solid', 'Arrow Down Wide Short', 1628, true, '{"icon_name":"arrow-down-wide-short","icon_prefix":"fas","icon_category":"navigation","unicode":"f160"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-down_solid', 'Caret Down', 1631, true, '{"icon_name":"caret-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f0d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up-a-z_solid', 'Arrow Up A Z', 1637, true, '{"icon_name":"arrow-up-a-z","icon_prefix":"fas","icon_category":"navigation","unicode":"f15e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-left-rotate_solid', 'Arrow Left Rotate', 1675, true, '{"icon_name":"arrow-left-rotate","icon_prefix":"fas","icon_category":"navigation","unicode":"f0e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-up19_solid', 'Arrow Up19', 1722, true, '{"icon_name":"arrow-up19","icon_prefix":"fas","icon_category":"navigation","unicode":"f163"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-up-across-line_solid', 'Arrow Down Up Across Line', 1728, true, '{"icon_name":"arrow-down-up-across-line","icon_prefix":"fas","icon_category":"navigation","unicode":"e4af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down_solid', 'Arrow Down', 1807, true, '{"icon_name":"arrow-down","icon_prefix":"fas","icon_category":"navigation","unicode":"f063"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bars_solid', 'Bars', 1815, true, '{"icon_name":"bars","icon_prefix":"fas","icon_category":"navigation","unicode":"f0c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tent-arrow-left-right_solid', 'Tent Arrow Left Right', 1825, true, '{"icon_name":"tent-arrow-left-right","icon_prefix":"fas","icon_category":"navigation","unicode":"e57f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-right-from-file_solid', 'Arrow Right From File', 1864, true, '{"icon_name":"arrow-right-from-file","icon_prefix":"fas","icon_category":"navigation","unicode":"f56e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tent-arrow-down-to-line_solid', 'Tent Arrow Down To Line', 1886, true, '{"icon_name":"tent-arrow-down-to-line","icon_prefix":"fas","icon_category":"navigation","unicode":"e57e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrow-down-a-z_solid', 'Arrow Down A Z', 1900, true, '{"icon_name":"arrow-down-a-z","icon_prefix":"fas","icon_category":"navigation","unicode":"f15d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bars-progress_solid', 'Bars Progress', 1929, true, '{"icon_name":"bars-progress","icon_prefix":"fas","icon_category":"navigation","unicode":"f828"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_temperature-arrow-down_solid', 'Temperature Arrow Down', 1945, true, '{"icon_name":"temperature-arrow-down","icon_prefix":"fas","icon_category":"navigation","unicode":"e03f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rectangle-times_regular', 'Rectangle Times (Regular)', 2124, true, '{"icon_name":"rectangle-times","icon_prefix":"far","icon_category":"navigation","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_times-rectangle_regular', 'Times Rectangle (Regular)', 2125, true, '{"icon_name":"times-rectangle","icon_prefix":"far","icon_category":"navigation","unicode":"f410"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-times_regular', 'Calendar Times (Regular)', 2160, true, '{"icon_name":"calendar-times","icon_prefix":"far","icon_category":"navigation","unicode":"f273"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: location (65 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sim-card_solid', 'Sim Card', 60, true, '{"icon_name":"sim-card","icon_prefix":"fas","icon_category":"location","unicode":"f7c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car_solid', 'Car', 63, true, '{"icon_name":"car","icon_prefix":"fas","icon_category":"location","unicode":"f1b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-pin_solid', 'Map Pin', 72, true, '{"icon_name":"map-pin","icon_prefix":"fas","icon_category":"location","unicode":"f276"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-right_solid', 'Caret Right', 100, true, '{"icon_name":"caret-right","icon_prefix":"fas","icon_category":"location","unicode":"f0da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-arrival_solid', 'Plane Arrival', 185, true, '{"icon_name":"plane-arrival","icon_prefix":"fas","icon_category":"location","unicode":"f5af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-marked-alt_solid', 'Map Marked Alt', 209, true, '{"icon_name":"map-marked-alt","icon_prefix":"fas","icon_category":"location","unicode":"f5a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sitemap_solid', 'Sitemap', 276, true, '{"icon_name":"sitemap","icon_prefix":"fas","icon_category":"location","unicode":"f0e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-left_solid', 'Caret Left', 282, true, '{"icon_name":"caret-left","icon_prefix":"fas","icon_category":"location","unicode":"f0d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_train-tram_solid', 'Train Tram', 348, true, '{"icon_name":"train-tram","icon_prefix":"fas","icon_category":"location","unicode":"e5b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-departure_solid', 'Plane Departure', 349, true, '{"icon_name":"plane-departure","icon_prefix":"fas","icon_category":"location","unicode":"f5b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sd-card_solid', 'Sd Card', 352, true, '{"icon_name":"sd-card","icon_prefix":"fas","icon_category":"location","unicode":"f7c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_globe-europe_solid', 'Globe Europe', 373, true, '{"icon_name":"globe-europe","icon_prefix":"fas","icon_category":"location","unicode":"f7a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cart-plus_solid', 'Cart Plus', 398, true, '{"icon_name":"cart-plus","icon_prefix":"fas","icon_category":"location","unicode":"f217"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cable-car_solid', 'Cable Car', 476, true, '{"icon_name":"cable-car","icon_prefix":"fas","icon_category":"location","unicode":"f7da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_place-of-worship_solid', 'Place Of Worship', 576, true, '{"icon_name":"place-of-worship","icon_prefix":"fas","icon_category":"location","unicode":"f67f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-signs_solid', 'Map Signs', 615, true, '{"icon_name":"map-signs","icon_prefix":"fas","icon_category":"location","unicode":"f277"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shipping-fast_solid', 'Shipping Fast', 657, true, '{"icon_name":"shipping-fast","icon_prefix":"fas","icon_category":"location","unicode":"f48b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-marked_solid', 'Map Marked', 665, true, '{"icon_name":"map-marked","icon_prefix":"fas","icon_category":"location","unicode":"f59f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-up_solid', 'Plane Up', 718, true, '{"icon_name":"plane-up","icon_prefix":"fas","icon_category":"location","unicode":"e22d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_globe-americas_solid', 'Globe Americas', 741, true, '{"icon_name":"globe-americas","icon_prefix":"fas","icon_category":"location","unicode":"f57d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_carrot_solid', 'Carrot', 742, true, '{"icon_name":"carrot","icon_prefix":"fas","icon_category":"location","unicode":"f787"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_address-card_solid', 'Address Card', 752, true, '{"icon_name":"address-card","icon_prefix":"fas","icon_category":"location","unicode":"f2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_contact-card_solid', 'Contact Card', 753, true, '{"icon_name":"contact-card","icon_prefix":"fas","icon_category":"location","unicode":"f2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vcard_solid', 'Vcard', 754, true, '{"icon_name":"vcard","icon_prefix":"fas","icon_category":"location","unicode":"f2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map_solid', 'Map', 759, true, '{"icon_name":"map","icon_prefix":"fas","icon_category":"location","unicode":"f279"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_globe-africa_solid', 'Globe Africa', 771, true, '{"icon_name":"globe-africa","icon_prefix":"fas","icon_category":"location","unicode":"f57c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-rear_solid', 'Car Rear', 813, true, '{"icon_name":"car-rear","icon_prefix":"fas","icon_category":"location","unicode":"f5de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-alt_solid', 'Car Alt', 814, true, '{"icon_name":"car-alt","icon_prefix":"fas","icon_category":"location","unicode":"f5de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-burst_solid', 'Car Burst', 837, true, '{"icon_name":"car-burst","icon_prefix":"fas","icon_category":"location","unicode":"f5e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-crash_solid', 'Car Crash', 838, true, '{"icon_name":"car-crash","icon_prefix":"fas","icon_category":"location","unicode":"f5e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-slash_solid', 'Plane Slash', 894, true, '{"icon_name":"plane-slash","icon_prefix":"fas","icon_category":"location","unicode":"e069"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compass-drafting_solid', 'Compass Drafting', 924, true, '{"icon_name":"compass-drafting","icon_prefix":"fas","icon_category":"location","unicode":"f568"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drafting-compass_solid', 'Drafting Compass', 925, true, '{"icon_name":"drafting-compass","icon_prefix":"fas","icon_category":"location","unicode":"f568"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_globe-oceania_solid', 'Globe Oceania', 945, true, '{"icon_name":"globe-oceania","icon_prefix":"fas","icon_category":"location","unicode":"e47b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-side_solid', 'Car Side', 987, true, '{"icon_name":"car-side","icon_prefix":"fas","icon_category":"location","unicode":"f5e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-on_solid', 'Car On', 1181, true, '{"icon_name":"car-on","icon_prefix":"fas","icon_category":"location","unicode":"e4dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_baby-carriage_solid', 'Baby Carriage', 1184, true, '{"icon_name":"baby-carriage","icon_prefix":"fas","icon_category":"location","unicode":"f77d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_carriage-baby_solid', 'Carriage Baby', 1185, true, '{"icon_name":"carriage-baby","icon_prefix":"fas","icon_category":"location","unicode":"f77d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_id-card-clip_solid', 'Id Card Clip', 1226, true, '{"icon_name":"id-card-clip","icon_prefix":"fas","icon_category":"location","unicode":"f47f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_id-card-alt_solid', 'Id Card Alt', 1227, true, '{"icon_name":"id-card-alt","icon_prefix":"fas","icon_category":"location","unicode":"f47f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane_solid', 'Plane', 1240, true, '{"icon_name":"plane","icon_prefix":"fas","icon_category":"location","unicode":"f072"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_id-card_solid', 'Id Card', 1262, true, '{"icon_name":"id-card","icon_prefix":"fas","icon_category":"location","unicode":"f2c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vr-cardboard_solid', 'Vr Cardboard', 1291, true, '{"icon_name":"vr-cardboard","icon_prefix":"fas","icon_category":"location","unicode":"f729"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_globe-asia_solid', 'Globe Asia', 1323, true, '{"icon_name":"globe-asia","icon_prefix":"fas","icon_category":"location","unicode":"f57e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-marker_solid', 'Map Marker', 1344, true, '{"icon_name":"map-marker","icon_prefix":"fas","icon_category":"location","unicode":"f041"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_car-tunnel_solid', 'Car Tunnel', 1414, true, '{"icon_name":"car-tunnel","icon_prefix":"fas","icon_category":"location","unicode":"e4de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caravan_solid', 'Caravan', 1436, true, '{"icon_name":"caravan","icon_prefix":"fas","icon_category":"location","unicode":"f8ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_caret-up_solid', 'Caret Up', 1522, true, '{"icon_name":"caret-up","icon_prefix":"fas","icon_category":"location","unicode":"f0d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_globe_solid', 'Globe', 1537, true, '{"icon_name":"globe","icon_prefix":"fas","icon_category":"location","unicode":"f0ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_luggage-cart_solid', 'Luggage Cart', 1662, true, '{"icon_name":"luggage-cart","icon_prefix":"fas","icon_category":"location","unicode":"f59d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_truck-plane_solid', 'Truck Plane', 1672, true, '{"icon_name":"truck-plane","icon_prefix":"fas","icon_category":"location","unicode":"e58f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compass_solid', 'Compass', 1742, true, '{"icon_name":"compass","icon_prefix":"fas","icon_category":"location","unicode":"f14e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map-marker-alt_solid', 'Map Marker Alt', 1809, true, '{"icon_name":"map-marker-alt","icon_prefix":"fas","icon_category":"location","unicode":"f3c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_train_solid', 'Train', 1861, true, '{"icon_name":"train","icon_prefix":"fas","icon_category":"location","unicode":"f238"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_train-subway_solid', 'Train Subway', 1867, true, '{"icon_name":"train-subway","icon_prefix":"fas","icon_category":"location","unicode":"f239"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ship_solid', 'Ship', 1872, true, '{"icon_name":"ship","icon_prefix":"fas","icon_category":"location","unicode":"f21a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-carry-box_solid', 'People Carry Box', 1951, true, '{"icon_name":"people-carry-box","icon_prefix":"fas","icon_category":"location","unicode":"f4ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_people-carry_solid', 'People Carry', 1952, true, '{"icon_name":"people-carry","icon_prefix":"fas","icon_category":"location","unicode":"f4ce"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cart-shopping_solid', 'Cart Shopping', 1977, true, '{"icon_name":"cart-shopping","icon_prefix":"fas","icon_category":"location","unicode":"f07a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_address-card_regular', 'Address Card (Regular)', 2079, true, '{"icon_name":"address-card","icon_prefix":"far","icon_category":"location","unicode":"f2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_contact-card_regular', 'Contact Card (Regular)', 2080, true, '{"icon_name":"contact-card","icon_prefix":"far","icon_category":"location","unicode":"f2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vcard_regular', 'Vcard (Regular)', 2081, true, '{"icon_name":"vcard","icon_prefix":"far","icon_category":"location","unicode":"f2bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_map_regular', 'Map (Regular)', 2084, true, '{"icon_name":"map","icon_prefix":"far","icon_category":"location","unicode":"f279"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_id-card_regular', 'Id Card (Regular)', 2174, true, '{"icon_name":"id-card","icon_prefix":"far","icon_category":"location","unicode":"f2c2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_compass_regular', 'Compass (Regular)', 2231, true, '{"icon_name":"compass","icon_prefix":"far","icon_category":"location","unicode":"f14e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: tools (34 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_filter_solid', 'Filter', 70, true, '{"icon_name":"filter","icon_prefix":"fas","icon_category":"tools","unicode":"f0b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unlock_solid', 'Unlock', 235, true, '{"icon_name":"unlock","icon_prefix":"fas","icon_category":"tools","unicode":"f09c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_key_solid', 'Key', 239, true, '{"icon_name":"key","icon_prefix":"fas","icon_category":"tools","unicode":"f084"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_house-lock_solid', 'House Lock', 287, true, '{"icon_name":"house-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e510"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_screwdriver_solid', 'Screwdriver', 333, true, '{"icon_name":"screwdriver","icon_prefix":"fas","icon_category":"tools","unicode":"f54a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unlock-keyhole_solid', 'Unlock Keyhole', 364, true, '{"icon_name":"unlock-keyhole","icon_prefix":"fas","icon_category":"tools","unicode":"f13e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unlock-alt_solid', 'Unlock Alt', 365, true, '{"icon_name":"unlock-alt","icon_prefix":"fas","icon_category":"tools","unicode":"f13e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-cells-column-lock_solid', 'Table Cells Column Lock', 379, true, '{"icon_name":"table-cells-column-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e678"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clock_solid', 'Clock', 381, true, '{"icon_name":"clock","icon_prefix":"fas","icon_category":"tools","unicode":"f017"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clock-four_solid', 'Clock Four', 382, true, '{"icon_name":"clock-four","icon_prefix":"fas","icon_category":"tools","unicode":"f017"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-cells-row-unlock_solid', 'Table Cells Row Unlock', 403, true, '{"icon_name":"table-cells-row-unlock","icon_prefix":"fas","icon_category":"tools","unicode":"e691"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_alarm-clock_solid', 'Alarm Clock', 492, true, '{"icon_name":"alarm-clock","icon_prefix":"fas","icon_category":"tools","unicode":"f34e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_plane-lock_solid', 'Plane Lock', 591, true, '{"icon_name":"plane-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e558"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hockey-puck_solid', 'Hockey Puck', 720, true, '{"icon_name":"hockey-puck","icon_prefix":"fas","icon_category":"tools","unicode":"f453"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_anchor-lock_solid', 'Anchor Lock', 725, true, '{"icon_name":"anchor-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e4ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_table-cells-row-lock_solid', 'Table Cells Row Lock', 747, true, '{"icon_name":"table-cells-row-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e67a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wrench_solid', 'Wrench', 978, true, '{"icon_name":"wrench","icon_prefix":"fas","icon_category":"tools","unicode":"f0ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sliders-h_solid', 'Sliders H', 1060, true, '{"icon_name":"sliders-h","icon_prefix":"fas","icon_category":"tools","unicode":"f1de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lock-open_solid', 'Lock Open', 1200, true, '{"icon_name":"lock-open","icon_prefix":"fas","icon_category":"tools","unicode":"f3c1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lock_solid', 'Lock', 1438, true, '{"icon_name":"lock","icon_prefix":"fas","icon_category":"tools","unicode":"f023"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_road-lock_solid', 'Road Lock', 1473, true, '{"icon_name":"road-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e567"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shield-alt_solid', 'Shield Alt', 1521, true, '{"icon_name":"shield-alt","icon_prefix":"fas","icon_category":"tools","unicode":"f3ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shop-lock_solid', 'Shop Lock', 1717, true, '{"icon_name":"shop-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e4a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bridge-lock_solid', 'Bridge Lock', 1720, true, '{"icon_name":"bridge-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e4cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hammer_solid', 'Hammer', 1721, true, '{"icon_name":"hammer","icon_prefix":"fas","icon_category":"tools","unicode":"f6e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_whiskey-glass_solid', 'Whiskey Glass', 1748, true, '{"icon_name":"whiskey-glass","icon_prefix":"fas","icon_category":"tools","unicode":"f7a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glass-whiskey_solid', 'Glass Whiskey', 1749, true, '{"icon_name":"glass-whiskey","icon_prefix":"fas","icon_category":"tools","unicode":"f7a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_screwdriver-wrench_solid', 'Screwdriver Wrench', 1812, true, '{"icon_name":"screwdriver-wrench","icon_prefix":"fas","icon_category":"tools","unicode":"f7d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_school-lock_solid', 'School Lock', 1833, true, '{"icon_name":"school-lock","icon_prefix":"fas","icon_category":"tools","unicode":"e56f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_keyboard_solid', 'Keyboard', 1850, true, '{"icon_name":"keyboard","icon_prefix":"fas","icon_category":"tools","unicode":"f11c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clock_regular', 'Clock (Regular)', 2037, true, '{"icon_name":"clock","icon_prefix":"far","icon_category":"tools","unicode":"f017"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_clock-four_regular', 'Clock Four (Regular)', 2038, true, '{"icon_name":"clock-four","icon_prefix":"far","icon_category":"tools","unicode":"f017"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_alarm-clock_regular', 'Alarm Clock (Regular)', 2050, true, '{"icon_name":"alarm-clock","icon_prefix":"far","icon_category":"tools","unicode":"f34e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_keyboard_regular', 'Keyboard (Regular)', 2240, true, '{"icon_name":"keyboard","icon_prefix":"far","icon_category":"tools","unicode":"f11c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: time (26 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-days_solid', 'Calendar Days', 134, true, '{"icon_name":"calendar-days","icon_prefix":"fas","icon_category":"time","unicode":"f073"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-alt_solid', 'Calendar Alt', 135, true, '{"icon_name":"calendar-alt","icon_prefix":"fas","icon_category":"time","unicode":"f073"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-plus_solid', 'Calendar Plus', 563, true, '{"icon_name":"calendar-plus","icon_prefix":"fas","icon_category":"time","unicode":"f271"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-day_solid', 'Calendar Day', 819, true, '{"icon_name":"calendar-day","icon_prefix":"fas","icon_category":"time","unicode":"f783"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-minus_solid', 'Calendar Minus', 910, true, '{"icon_name":"calendar-minus","icon_prefix":"fas","icon_category":"time","unicode":"f272"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass1_solid', 'Hourglass1', 995, true, '{"icon_name":"hourglass1","icon_prefix":"fas","icon_category":"time","unicode":"f251"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar_solid', 'Calendar', 1008, true, '{"icon_name":"calendar","icon_prefix":"fas","icon_category":"time","unicode":"f133"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-xmark_solid', 'Calendar Xmark', 1187, true, '{"icon_name":"calendar-xmark","icon_prefix":"fas","icon_category":"time","unicode":"f273"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass_solid', 'Hourglass', 1299, true, '{"icon_name":"hourglass","icon_prefix":"fas","icon_category":"time","unicode":"f254"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass-empty_solid', 'Hourglass Empty', 1300, true, '{"icon_name":"hourglass-empty","icon_prefix":"fas","icon_category":"time","unicode":"f254"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_history_solid', 'History', 1332, true, '{"icon_name":"history","icon_prefix":"fas","icon_category":"time","unicode":"f1da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass-half_solid', 'Hourglass Half', 1376, true, '{"icon_name":"hourglass-half","icon_prefix":"fas","icon_category":"time","unicode":"f252"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass2_solid', 'Hourglass2', 1377, true, '{"icon_name":"hourglass2","icon_prefix":"fas","icon_category":"time","unicode":"f252"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass-end_solid', 'Hourglass End', 1889, true, '{"icon_name":"hourglass-end","icon_prefix":"fas","icon_category":"time","unicode":"f253"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass3_solid', 'Hourglass3', 1890, true, '{"icon_name":"hourglass3","icon_prefix":"fas","icon_category":"time","unicode":"f253"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-week_solid', 'Calendar Week', 1913, true, '{"icon_name":"calendar-week","icon_prefix":"fas","icon_category":"time","unicode":"f784"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-days_regular', 'Calendar Days (Regular)', 2002, true, '{"icon_name":"calendar-days","icon_prefix":"far","icon_category":"time","unicode":"f073"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-alt_regular', 'Calendar Alt (Regular)', 2003, true, '{"icon_name":"calendar-alt","icon_prefix":"far","icon_category":"time","unicode":"f073"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-plus_regular', 'Calendar Plus (Regular)', 2060, true, '{"icon_name":"calendar-plus","icon_prefix":"far","icon_category":"time","unicode":"f271"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-minus_regular', 'Calendar Minus (Regular)', 2115, true, '{"icon_name":"calendar-minus","icon_prefix":"far","icon_category":"time","unicode":"f272"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar_regular', 'Calendar (Regular)', 2133, true, '{"icon_name":"calendar","icon_prefix":"far","icon_category":"time","unicode":"f133"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_calendar-xmark_regular', 'Calendar Xmark (Regular)', 2159, true, '{"icon_name":"calendar-xmark","icon_prefix":"far","icon_category":"time","unicode":"f273"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass_regular', 'Hourglass (Regular)', 2182, true, '{"icon_name":"hourglass","icon_prefix":"far","icon_category":"time","unicode":"f254"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass-empty_regular', 'Hourglass Empty (Regular)', 2183, true, '{"icon_name":"hourglass-empty","icon_prefix":"far","icon_category":"time","unicode":"f254"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass-half_regular', 'Hourglass Half (Regular)', 2193, true, '{"icon_name":"hourglass-half","icon_prefix":"far","icon_category":"time","unicode":"f252"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hourglass2_regular', 'Hourglass2 (Regular)', 2194, true, '{"icon_name":"hourglass2","icon_prefix":"far","icon_category":"time","unicode":"f252"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: social (22 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-nodes_solid', 'Share Nodes', 188, true, '{"icon_name":"share-nodes","icon_prefix":"fas","icon_category":"social","unicode":"f1e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share-alt_solid', 'Share Alt', 189, true, '{"icon_name":"share-alt","icon_prefix":"fas","icon_category":"social","unicode":"f1e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye_solid', 'Eye', 281, true, '{"icon_name":"eye","icon_prefix":"fas","icon_category":"social","unicode":"f06e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_share_solid', 'Share', 529, true, '{"icon_name":"share","icon_prefix":"fas","icon_category":"social","unicode":"f064"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_arrows-to-eye_solid', 'Arrows To Eye', 555, true, '{"icon_name":"arrows-to-eye","icon_prefix":"fas","icon_category":"social","unicode":"e4bf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumbs-down_solid', 'Thumbs Down', 605, true, '{"icon_name":"thumbs-down","icon_prefix":"fas","icon_category":"social","unicode":"f165"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye-dropper_solid', 'Eye Dropper', 641, true, '{"icon_name":"eye-dropper","icon_prefix":"fas","icon_category":"social","unicode":"f1fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye-dropper-empty_solid', 'Eye Dropper Empty', 642, true, '{"icon_name":"eye-dropper-empty","icon_prefix":"fas","icon_category":"social","unicode":"f1fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eyedropper_solid', 'Eyedropper', 643, true, '{"icon_name":"eyedropper","icon_prefix":"fas","icon_category":"social","unicode":"f1fb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumbs-up_solid', 'Thumbs Up', 856, true, '{"icon_name":"thumbs-up","icon_prefix":"fas","icon_category":"social","unicode":"f164"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bullseye_solid', 'Bullseye', 868, true, '{"icon_name":"bullseye","icon_prefix":"fas","icon_category":"social","unicode":"f140"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye-slash_solid', 'Eye Slash', 1660, true, '{"icon_name":"eye-slash","icon_prefix":"fas","icon_category":"social","unicode":"f070"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye-low-vision_solid', 'Eye Low Vision', 1699, true, '{"icon_name":"eye-low-vision","icon_prefix":"fas","icon_category":"social","unicode":"f2a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_retweet_solid', 'Retweet', 1799, true, '{"icon_name":"retweet","icon_prefix":"fas","icon_category":"social","unicode":"f079"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-rolling-eyes_solid', 'Face Rolling Eyes', 1855, true, '{"icon_name":"face-rolling-eyes","icon_prefix":"fas","icon_category":"social","unicode":"f5a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meh-rolling-eyes_solid', 'Meh Rolling Eyes', 1856, true, '{"icon_name":"meh-rolling-eyes","icon_prefix":"fas","icon_category":"social","unicode":"f5a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye_regular', 'Eye (Regular)', 2021, true, '{"icon_name":"eye","icon_prefix":"far","icon_category":"social","unicode":"f06e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumbs-down_regular', 'Thumbs Down (Regular)', 2062, true, '{"icon_name":"thumbs-down","icon_prefix":"far","icon_category":"social","unicode":"f165"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_thumbs-up_regular', 'Thumbs Up (Regular)', 2107, true, '{"icon_name":"thumbs-up","icon_prefix":"far","icon_category":"social","unicode":"f164"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eye-slash_regular', 'Eye Slash (Regular)', 2223, true, '{"icon_name":"eye-slash","icon_prefix":"far","icon_category":"social","unicode":"f070"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_face-rolling-eyes_regular', 'Face Rolling Eyes (Regular)', 2241, true, '{"icon_name":"face-rolling-eyes","icon_prefix":"far","icon_category":"social","unicode":"f5a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meh-rolling-eyes_regular', 'Meh Rolling Eyes (Regular)', 2242, true, '{"icon_name":"meh-rolling-eyes","icon_prefix":"far","icon_category":"social","unicode":"f5a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Category: brands (549 icons)
INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-github_brand', 'Square Github', 2257, true, '{"icon_name":"square-github","icon_prefix":"fab","icon_category":"brands","unicode":"f092"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_github-square_brand', 'Github Square', 2258, true, '{"icon_name":"github-square","icon_prefix":"fab","icon_category":"brands","unicode":"f092"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_think-peaks_brand', 'Think Peaks', 2259, true, '{"icon_name":"think-peaks","icon_prefix":"fab","icon_category":"brands","unicode":"f731"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-drive_brand', 'Google Drive', 2260, true, '{"icon_name":"google-drive","icon_prefix":"fab","icon_category":"brands","unicode":"f3aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_autoprefixer_brand', 'Autoprefixer', 2261, true, '{"icon_name":"autoprefixer","icon_prefix":"fab","icon_category":"brands","unicode":"f41c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-viadeo_brand', 'Square Viadeo', 2262, true, '{"icon_name":"square-viadeo","icon_prefix":"fab","icon_category":"brands","unicode":"f2aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_viadeo-square_brand', 'Viadeo Square', 2263, true, '{"icon_name":"viadeo-square","icon_prefix":"fab","icon_category":"brands","unicode":"f2aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cpanel_brand', 'Cpanel', 2264, true, '{"icon_name":"cpanel","icon_prefix":"fab","icon_category":"brands","unicode":"f388"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mendeley_brand', 'Mendeley', 2265, true, '{"icon_name":"mendeley","icon_prefix":"fab","icon_category":"brands","unicode":"f7b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_draft2digital_brand', 'Draft2digital', 2266, true, '{"icon_name":"draft2digital","icon_prefix":"fab","icon_category":"brands","unicode":"f396"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_replyd_brand', 'Replyd', 2267, true, '{"icon_name":"replyd","icon_prefix":"fab","icon_category":"brands","unicode":"f3e6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_empire_brand', 'Empire', 2268, true, '{"icon_name":"empire","icon_prefix":"fab","icon_category":"brands","unicode":"f1d1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_accessible-icon_brand', 'Accessible Icon', 2269, true, '{"icon_name":"accessible-icon","icon_prefix":"fab","icon_category":"brands","unicode":"f368"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quora_brand', 'Quora', 2270, true, '{"icon_name":"quora","icon_prefix":"fab","icon_category":"brands","unicode":"f2c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-jcb_brand', 'Cc Jcb', 2271, true, '{"icon_name":"cc-jcb","icon_prefix":"fab","icon_category":"brands","unicode":"f24b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fedora_brand', 'Fedora', 2272, true, '{"icon_name":"fedora","icon_prefix":"fab","icon_category":"brands","unicode":"f798"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_duolingo_brand', 'Duolingo', 2273, true, '{"icon_name":"duolingo","icon_prefix":"fab","icon_category":"brands","unicode":"e812"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_firstdraft_brand', 'Firstdraft', 2274, true, '{"icon_name":"firstdraft","icon_prefix":"fab","icon_category":"brands","unicode":"f3a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_freebsd_brand', 'Freebsd', 2275, true, '{"icon_name":"freebsd","icon_prefix":"fab","icon_category":"brands","unicode":"f3a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_odysee_brand', 'Odysee', 2276, true, '{"icon_name":"odysee","icon_prefix":"fab","icon_category":"brands","unicode":"e5c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gg-circle_brand', 'Gg Circle', 2277, true, '{"icon_name":"gg-circle","icon_prefix":"fab","icon_category":"brands","unicode":"f261"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloudflare_brand', 'Cloudflare', 2278, true, '{"icon_name":"cloudflare","icon_prefix":"fab","icon_category":"brands","unicode":"e07d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hackerrank_brand', 'Hackerrank', 2279, true, '{"icon_name":"hackerrank","icon_prefix":"fab","icon_category":"brands","unicode":"f5f7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skyatlas_brand', 'Skyatlas', 2280, true, '{"icon_name":"skyatlas","icon_prefix":"fab","icon_category":"brands","unicode":"f216"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_deskpro_brand', 'Deskpro', 2281, true, '{"icon_name":"deskpro","icon_prefix":"fab","icon_category":"brands","unicode":"f38f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_resolving_brand', 'Resolving', 2282, true, '{"icon_name":"resolving","icon_prefix":"fab","icon_category":"brands","unicode":"f3e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blackberry_brand', 'Blackberry', 2283, true, '{"icon_name":"blackberry","icon_prefix":"fab","icon_category":"brands","unicode":"f37b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stripe-s_brand', 'Stripe S', 2284, true, '{"icon_name":"stripe-s","icon_prefix":"fab","icon_category":"brands","unicode":"f42a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-behance_brand', 'Square Behance', 2285, true, '{"icon_name":"square-behance","icon_prefix":"fab","icon_category":"brands","unicode":"f1b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_behance-square_brand', 'Behance Square', 2286, true, '{"icon_name":"behance-square","icon_prefix":"fab","icon_category":"brands","unicode":"f1b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_servicestack_brand', 'Servicestack', 2287, true, '{"icon_name":"servicestack","icon_prefix":"fab","icon_category":"brands","unicode":"f3ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rocketchat_brand', 'Rocketchat', 2288, true, '{"icon_name":"rocketchat","icon_prefix":"fab","icon_category":"brands","unicode":"f3e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rebel_brand', 'Rebel', 2289, true, '{"icon_name":"rebel","icon_prefix":"fab","icon_category":"brands","unicode":"f1d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-web-awesome_brand', 'Square Web Awesome', 2290, true, '{"icon_name":"square-web-awesome","icon_prefix":"fab","icon_category":"brands","unicode":"e683"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_linktree_brand', 'Linktree', 2291, true, '{"icon_name":"linktree","icon_prefix":"fab","icon_category":"brands","unicode":"e7d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_simplybuilt_brand', 'Simplybuilt', 2292, true, '{"icon_name":"simplybuilt","icon_prefix":"fab","icon_category":"brands","unicode":"f215"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stubber_brand', 'Stubber', 2293, true, '{"icon_name":"stubber","icon_prefix":"fab","icon_category":"brands","unicode":"e5c7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_apper_brand', 'Apper', 2294, true, '{"icon_name":"apper","icon_prefix":"fab","icon_category":"brands","unicode":"f371"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-scholar_brand', 'Google Scholar', 2295, true, '{"icon_name":"google-scholar","icon_prefix":"fab","icon_category":"brands","unicode":"e63b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yarn_brand', 'Yarn', 2296, true, '{"icon_name":"yarn","icon_prefix":"fab","icon_category":"brands","unicode":"f7e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stack-overflow_brand', 'Stack Overflow', 2297, true, '{"icon_name":"stack-overflow","icon_prefix":"fab","icon_category":"brands","unicode":"f16c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bluetooth_brand', 'Bluetooth', 2298, true, '{"icon_name":"bluetooth","icon_prefix":"fab","icon_category":"brands","unicode":"f293"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-nc-jp_brand', 'Creative Commons Nc Jp', 2299, true, '{"icon_name":"creative-commons-nc-jp","icon_prefix":"fab","icon_category":"brands","unicode":"f4ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reddit_brand', 'Reddit', 2300, true, '{"icon_name":"reddit","icon_prefix":"fab","icon_category":"brands","unicode":"f1a1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_connectdevelop_brand', 'Connectdevelop', 2301, true, '{"icon_name":"connectdevelop","icon_prefix":"fab","icon_category":"brands","unicode":"f20e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_researchgate_brand', 'Researchgate', 2302, true, '{"icon_name":"researchgate","icon_prefix":"fab","icon_category":"brands","unicode":"f4f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_signal-messenger_brand', 'Signal Messenger', 2303, true, '{"icon_name":"signal-messenger","icon_prefix":"fab","icon_category":"brands","unicode":"e663"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xing_brand', 'Xing', 2304, true, '{"icon_name":"xing","icon_prefix":"fab","icon_category":"brands","unicode":"f168"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-js_brand', 'Square Js', 2305, true, '{"icon_name":"square-js","icon_prefix":"fab","icon_category":"brands","unicode":"f3b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_js-square_brand', 'Js Square', 2306, true, '{"icon_name":"js-square","icon_prefix":"fab","icon_category":"brands","unicode":"f3b9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fonticons_brand', 'Fonticons', 2307, true, '{"icon_name":"fonticons","icon_prefix":"fab","icon_category":"brands","unicode":"f280"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ups_brand', 'Ups', 2308, true, '{"icon_name":"ups","icon_prefix":"fab","icon_category":"brands","unicode":"f7e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_amazon-pay_brand', 'Amazon Pay', 2309, true, '{"icon_name":"amazon-pay","icon_prefix":"fab","icon_category":"brands","unicode":"f42c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pandora_brand', 'Pandora', 2310, true, '{"icon_name":"pandora","icon_prefix":"fab","icon_category":"brands","unicode":"e7da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_openid_brand', 'Openid', 2311, true, '{"icon_name":"openid","icon_prefix":"fab","icon_category":"brands","unicode":"f19b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vsco_brand', 'Vsco', 2312, true, '{"icon_name":"vsco","icon_prefix":"fab","icon_category":"brands","unicode":"e7dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ubuntu_brand', 'Ubuntu', 2313, true, '{"icon_name":"ubuntu","icon_prefix":"fab","icon_category":"brands","unicode":"f7df"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_viacoin_brand', 'Viacoin', 2314, true, '{"icon_name":"viacoin","icon_prefix":"fab","icon_category":"brands","unicode":"f237"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_zhihu_brand', 'Zhihu', 2315, true, '{"icon_name":"zhihu","icon_prefix":"fab","icon_category":"brands","unicode":"f63f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yandex_brand', 'Yandex', 2316, true, '{"icon_name":"yandex","icon_prefix":"fab","icon_category":"brands","unicode":"f413"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pixiv_brand', 'Pixiv', 2317, true, '{"icon_name":"pixiv","icon_prefix":"fab","icon_category":"brands","unicode":"e640"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_openai_brand', 'Openai', 2318, true, '{"icon_name":"openai","icon_prefix":"fab","icon_category":"brands","unicode":"e7cf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sith_brand', 'Sith', 2319, true, '{"icon_name":"sith","icon_prefix":"fab","icon_category":"brands","unicode":"f512"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_nfc-directional_brand', 'Nfc Directional', 2320, true, '{"icon_name":"nfc-directional","icon_prefix":"fab","icon_category":"brands","unicode":"e530"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-by_brand', 'Creative Commons By', 2321, true, '{"icon_name":"creative-commons-by","icon_prefix":"fab","icon_category":"brands","unicode":"f4e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_umbraco_brand', 'Umbraco', 2322, true, '{"icon_name":"umbraco","icon_prefix":"fab","icon_category":"brands","unicode":"f8e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hooli_brand', 'Hooli', 2323, true, '{"icon_name":"hooli","icon_prefix":"fab","icon_category":"brands","unicode":"f427"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-git_brand', 'Square Git', 2324, true, '{"icon_name":"square-git","icon_prefix":"fab","icon_category":"brands","unicode":"f1d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_git-square_brand', 'Git Square', 2325, true, '{"icon_name":"git-square","icon_prefix":"fab","icon_category":"brands","unicode":"f1d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_odnoklassniki_brand', 'Odnoklassniki', 2326, true, '{"icon_name":"odnoklassniki","icon_prefix":"fab","icon_category":"brands","unicode":"f263"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_drupal_brand', 'Drupal', 2327, true, '{"icon_name":"drupal","icon_prefix":"fab","icon_category":"brands","unicode":"f1a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blogger-b_brand', 'Blogger B', 2328, true, '{"icon_name":"blogger-b","icon_prefix":"fab","icon_category":"brands","unicode":"f37d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_invision_brand', 'Invision', 2329, true, '{"icon_name":"invision","icon_prefix":"fab","icon_category":"brands","unicode":"f7b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_facebook-f_brand', 'Facebook F', 2330, true, '{"icon_name":"facebook-f","icon_prefix":"fab","icon_category":"brands","unicode":"f39e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_centos_brand', 'Centos', 2331, true, '{"icon_name":"centos","icon_prefix":"fab","icon_category":"brands","unicode":"f789"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-amazon-pay_brand', 'Cc Amazon Pay', 2332, true, '{"icon_name":"cc-amazon-pay","icon_prefix":"fab","icon_category":"brands","unicode":"f42d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ebay_brand', 'Ebay', 2333, true, '{"icon_name":"ebay","icon_prefix":"fab","icon_category":"brands","unicode":"f4f4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_contao_brand', 'Contao', 2334, true, '{"icon_name":"contao","icon_prefix":"fab","icon_category":"brands","unicode":"f26d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ello_brand', 'Ello', 2335, true, '{"icon_name":"ello","icon_prefix":"fab","icon_category":"brands","unicode":"f5f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sistrix_brand', 'Sistrix', 2336, true, '{"icon_name":"sistrix","icon_prefix":"fab","icon_category":"brands","unicode":"f3ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_periscope_brand', 'Periscope', 2337, true, '{"icon_name":"periscope","icon_prefix":"fab","icon_category":"brands","unicode":"f3da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_expeditedssl_brand', 'Expeditedssl', 2338, true, '{"icon_name":"expeditedssl","icon_prefix":"fab","icon_category":"brands","unicode":"f23e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_napster_brand', 'Napster', 2339, true, '{"icon_name":"napster","icon_prefix":"fab","icon_category":"brands","unicode":"f3d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_delicious_brand', 'Delicious', 2340, true, '{"icon_name":"delicious","icon_prefix":"fab","icon_category":"brands","unicode":"f1a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_guilded_brand', 'Guilded', 2341, true, '{"icon_name":"guilded","icon_prefix":"fab","icon_category":"brands","unicode":"e07e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xbox_brand', 'Xbox', 2342, true, '{"icon_name":"xbox","icon_prefix":"fab","icon_category":"brands","unicode":"f412"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_untappd_brand', 'Untappd', 2343, true, '{"icon_name":"untappd","icon_prefix":"fab","icon_category":"brands","unicode":"f405"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-plus-g_brand', 'Google Plus G', 2344, true, '{"icon_name":"google-plus-g","icon_prefix":"fab","icon_category":"brands","unicode":"f0d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_github-alt_brand', 'Github Alt', 2345, true, '{"icon_name":"github-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f113"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_get-pocket_brand', 'Get Pocket', 2346, true, '{"icon_name":"get-pocket","icon_prefix":"fab","icon_category":"brands","unicode":"f265"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glide_brand', 'Glide', 2347, true, '{"icon_name":"glide","icon_prefix":"fab","icon_category":"brands","unicode":"f2a5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bity_brand', 'Bity', 2348, true, '{"icon_name":"bity","icon_prefix":"fab","icon_category":"brands","unicode":"f37a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wpexplorer_brand', 'Wpexplorer', 2349, true, '{"icon_name":"wpexplorer","icon_prefix":"fab","icon_category":"brands","unicode":"f2de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_megaport_brand', 'Megaport', 2350, true, '{"icon_name":"megaport","icon_prefix":"fab","icon_category":"brands","unicode":"f5a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mdb_brand', 'Mdb', 2351, true, '{"icon_name":"mdb","icon_prefix":"fab","icon_category":"brands","unicode":"f8ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_page4_brand', 'Page4', 2352, true, '{"icon_name":"page4","icon_prefix":"fab","icon_category":"brands","unicode":"f3d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_the-red-yeti_brand', 'The Red Yeti', 2353, true, '{"icon_name":"the-red-yeti","icon_prefix":"fab","icon_category":"brands","unicode":"f69d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jira_brand', 'Jira', 2354, true, '{"icon_name":"jira","icon_prefix":"fab","icon_category":"brands","unicode":"f7b1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fedex_brand', 'Fedex', 2355, true, '{"icon_name":"fedex","icon_prefix":"fab","icon_category":"brands","unicode":"f797"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_evernote_brand', 'Evernote', 2356, true, '{"icon_name":"evernote","icon_prefix":"fab","icon_category":"brands","unicode":"f839"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_usb_brand', 'Usb', 2357, true, '{"icon_name":"usb","icon_prefix":"fab","icon_category":"brands","unicode":"f287"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angrycreative_brand', 'Angrycreative', 2358, true, '{"icon_name":"angrycreative","icon_prefix":"fab","icon_category":"brands","unicode":"f36e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mizuni_brand', 'Mizuni', 2359, true, '{"icon_name":"mizuni","icon_prefix":"fab","icon_category":"brands","unicode":"f3cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_itch-io_brand', 'Itch Io', 2360, true, '{"icon_name":"itch-io","icon_prefix":"fab","icon_category":"brands","unicode":"f83a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_windows_brand', 'Windows', 2361, true, '{"icon_name":"windows","icon_prefix":"fab","icon_category":"brands","unicode":"f17a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stumbleupon_brand', 'Stumbleupon', 2362, true, '{"icon_name":"stumbleupon","icon_prefix":"fab","icon_category":"brands","unicode":"f1a4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google_brand', 'Google', 2363, true, '{"icon_name":"google","icon_prefix":"fab","icon_category":"brands","unicode":"f1a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_discord_brand', 'Discord', 2364, true, '{"icon_name":"discord","icon_prefix":"fab","icon_category":"brands","unicode":"f392"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hacker-news_brand', 'Hacker News', 2365, true, '{"icon_name":"hacker-news","icon_prefix":"fab","icon_category":"brands","unicode":"f1d4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_eleventy_brand', 'Eleventy', 2366, true, '{"icon_name":"eleventy","icon_prefix":"fab","icon_category":"brands","unicode":"e7d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_1ty_brand', '1ty', 2367, true, '{"icon_name":"1ty","icon_prefix":"fab","icon_category":"brands","unicode":"e7d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_teamspeak_brand', 'Teamspeak', 2368, true, '{"icon_name":"teamspeak","icon_prefix":"fab","icon_category":"brands","unicode":"f4f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_supple_brand', 'Supple', 2369, true, '{"icon_name":"supple","icon_prefix":"fab","icon_category":"brands","unicode":"f3f9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-twitter_brand', 'Square Twitter', 2370, true, '{"icon_name":"square-twitter","icon_prefix":"fab","icon_category":"brands","unicode":"f081"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_twitter-square_brand', 'Twitter Square', 2371, true, '{"icon_name":"twitter-square","icon_prefix":"fab","icon_category":"brands","unicode":"f081"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome_brand', 'Font Awesome', 2372, true, '{"icon_name":"font-awesome","icon_prefix":"fab","icon_category":"brands","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-flag_brand', 'Font Awesome Flag', 2373, true, '{"icon_name":"font-awesome-flag","icon_prefix":"fab","icon_category":"brands","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-logo-full_brand', 'Font Awesome Logo Full', 2374, true, '{"icon_name":"font-awesome-logo-full","icon_prefix":"fab","icon_category":"brands","unicode":"f2b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wirsindhandwerk_brand', 'Wirsindhandwerk', 2375, true, '{"icon_name":"wirsindhandwerk","icon_prefix":"fab","icon_category":"brands","unicode":"e2d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wsh_brand', 'Wsh', 2376, true, '{"icon_name":"wsh","icon_prefix":"fab","icon_category":"brands","unicode":"e2d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_confluence_brand', 'Confluence', 2377, true, '{"icon_name":"confluence","icon_prefix":"fab","icon_category":"brands","unicode":"f78d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_digg_brand', 'Digg', 2378, true, '{"icon_name":"digg","icon_prefix":"fab","icon_category":"brands","unicode":"f1a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_threads_brand', 'Threads', 2379, true, '{"icon_name":"threads","icon_prefix":"fab","icon_category":"brands","unicode":"e618"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wpressr_brand', 'Wpressr', 2380, true, '{"icon_name":"wpressr","icon_prefix":"fab","icon_category":"brands","unicode":"f3e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rendact_brand', 'Rendact', 2381, true, '{"icon_name":"rendact","icon_prefix":"fab","icon_category":"brands","unicode":"f3e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yoast_brand', 'Yoast', 2382, true, '{"icon_name":"yoast","icon_prefix":"fab","icon_category":"brands","unicode":"f2b1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_nimblr_brand', 'Nimblr', 2383, true, '{"icon_name":"nimblr","icon_prefix":"fab","icon_category":"brands","unicode":"f5a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pixelfed_brand', 'Pixelfed', 2384, true, '{"icon_name":"pixelfed","icon_prefix":"fab","icon_category":"brands","unicode":"e7db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yahoo_brand', 'Yahoo', 2385, true, '{"icon_name":"yahoo","icon_prefix":"fab","icon_category":"brands","unicode":"f19e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bluesky_brand', 'Bluesky', 2386, true, '{"icon_name":"bluesky","icon_prefix":"fab","icon_category":"brands","unicode":"e671"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_scribd_brand', 'Scribd', 2387, true, '{"icon_name":"scribd","icon_prefix":"fab","icon_category":"brands","unicode":"f28a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-pd_brand', 'Creative Commons Pd', 2388, true, '{"icon_name":"creative-commons-pd","icon_prefix":"fab","icon_category":"brands","unicode":"f4ec"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_earlybirds_brand', 'Earlybirds', 2389, true, '{"icon_name":"earlybirds","icon_prefix":"fab","icon_category":"brands","unicode":"f39a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-odnoklassniki_brand', 'Square Odnoklassniki', 2390, true, '{"icon_name":"square-odnoklassniki","icon_prefix":"fab","icon_category":"brands","unicode":"f264"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_odnoklassniki-square_brand', 'Odnoklassniki Square', 2391, true, '{"icon_name":"odnoklassniki-square","icon_prefix":"fab","icon_category":"brands","unicode":"f264"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_markdown_brand', 'Markdown', 2392, true, '{"icon_name":"markdown","icon_prefix":"fab","icon_category":"brands","unicode":"f60f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_typo3_brand', 'Typo3', 2393, true, '{"icon_name":"typo3","icon_prefix":"fab","icon_category":"brands","unicode":"f42b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_joomla_brand', 'Joomla', 2394, true, '{"icon_name":"joomla","icon_prefix":"fab","icon_category":"brands","unicode":"f1aa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_weixin_brand', 'Weixin', 2395, true, '{"icon_name":"weixin","icon_prefix":"fab","icon_category":"brands","unicode":"f1d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grunt_brand', 'Grunt', 2396, true, '{"icon_name":"grunt","icon_prefix":"fab","icon_category":"brands","unicode":"f3ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rockrms_brand', 'Rockrms', 2397, true, '{"icon_name":"rockrms","icon_prefix":"fab","icon_category":"brands","unicode":"f3e9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unsplash_brand', 'Unsplash', 2398, true, '{"icon_name":"unsplash","icon_prefix":"fab","icon_category":"brands","unicode":"e07c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-instagram_brand', 'Square Instagram', 2399, true, '{"icon_name":"square-instagram","icon_prefix":"fab","icon_category":"brands","unicode":"e055"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_instagram-square_brand', 'Instagram Square', 2400, true, '{"icon_name":"instagram-square","icon_prefix":"fab","icon_category":"brands","unicode":"e055"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_first-order-alt_brand', 'First Order Alt', 2401, true, '{"icon_name":"first-order-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f50a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fulcrum_brand', 'Fulcrum', 2402, true, '{"icon_name":"fulcrum","icon_prefix":"fab","icon_category":"brands","unicode":"f50b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_brave-reverse_brand', 'Brave Reverse', 2403, true, '{"icon_name":"brave-reverse","icon_prefix":"fab","icon_category":"brands","unicode":"e63d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_avianex_brand', 'Avianex', 2404, true, '{"icon_name":"avianex","icon_prefix":"fab","icon_category":"brands","unicode":"f374"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ns8_brand', 'Ns8', 2405, true, '{"icon_name":"ns8","icon_prefix":"fab","icon_category":"brands","unicode":"f3d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-pinterest_brand', 'Square Pinterest', 2406, true, '{"icon_name":"square-pinterest","icon_prefix":"fab","icon_category":"brands","unicode":"f0d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pinterest-square_brand', 'Pinterest Square', 2407, true, '{"icon_name":"pinterest-square","icon_prefix":"fab","icon_category":"brands","unicode":"f0d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bluetooth-b_brand', 'Bluetooth B', 2408, true, '{"icon_name":"bluetooth-b","icon_prefix":"fab","icon_category":"brands","unicode":"f294"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gripfire_brand', 'Gripfire', 2409, true, '{"icon_name":"gripfire","icon_prefix":"fab","icon_category":"brands","unicode":"f3ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-google-plus_brand', 'Square Google Plus', 2410, true, '{"icon_name":"square-google-plus","icon_prefix":"fab","icon_category":"brands","unicode":"f0d4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-plus-square_brand', 'Google Plus Square', 2411, true, '{"icon_name":"google-plus-square","icon_prefix":"fab","icon_category":"brands","unicode":"f0d4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_app-store_brand', 'App Store', 2412, true, '{"icon_name":"app-store","icon_prefix":"fab","icon_category":"brands","unicode":"f36f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wix_brand', 'Wix', 2413, true, '{"icon_name":"wix","icon_prefix":"fab","icon_category":"brands","unicode":"f5cf"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_intercom_brand', 'Intercom', 2414, true, '{"icon_name":"intercom","icon_prefix":"fab","icon_category":"brands","unicode":"f7af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reacteurope_brand', 'Reacteurope', 2415, true, '{"icon_name":"reacteurope","icon_prefix":"fab","icon_category":"brands","unicode":"f75d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_waze_brand', 'Waze', 2416, true, '{"icon_name":"waze","icon_prefix":"fab","icon_category":"brands","unicode":"f83f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-remix_brand', 'Creative Commons Remix', 2417, true, '{"icon_name":"creative-commons-remix","icon_prefix":"fab","icon_category":"brands","unicode":"f4ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bandcamp_brand', 'Bandcamp', 2418, true, '{"icon_name":"bandcamp","icon_prefix":"fab","icon_category":"brands","unicode":"f2d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-web-awesome-stroke_brand', 'Square Web Awesome Stroke', 2419, true, '{"icon_name":"square-web-awesome-stroke","icon_prefix":"fab","icon_category":"brands","unicode":"e684"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vimeo-v_brand', 'Vimeo V', 2420, true, '{"icon_name":"vimeo-v","icon_prefix":"fab","icon_category":"brands","unicode":"f27d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_strava_brand', 'Strava', 2421, true, '{"icon_name":"strava","icon_prefix":"fab","icon_category":"brands","unicode":"f428"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_uniregistry_brand', 'Uniregistry', 2422, true, '{"icon_name":"uniregistry","icon_prefix":"fab","icon_category":"brands","unicode":"f404"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-diners-club_brand', 'Cc Diners Club', 2423, true, '{"icon_name":"cc-diners-club","icon_prefix":"fab","icon_category":"brands","unicode":"f24c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pinterest_brand', 'Pinterest', 2424, true, '{"icon_name":"pinterest","icon_prefix":"fab","icon_category":"brands","unicode":"f0d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_algolia_brand', 'Algolia', 2425, true, '{"icon_name":"algolia","icon_prefix":"fab","icon_category":"brands","unicode":"f36c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stackpath_brand', 'Stackpath', 2426, true, '{"icon_name":"stackpath","icon_prefix":"fab","icon_category":"brands","unicode":"f842"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_octopus-deploy_brand', 'Octopus Deploy', 2427, true, '{"icon_name":"octopus-deploy","icon_prefix":"fab","icon_category":"brands","unicode":"e082"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yammer_brand', 'Yammer', 2428, true, '{"icon_name":"yammer","icon_prefix":"fab","icon_category":"brands","unicode":"f840"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_modx_brand', 'Modx', 2429, true, '{"icon_name":"modx","icon_prefix":"fab","icon_category":"brands","unicode":"f285"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-threads_brand', 'Square Threads', 2430, true, '{"icon_name":"square-threads","icon_prefix":"fab","icon_category":"brands","unicode":"e619"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_old-republic_brand', 'Old Republic', 2431, true, '{"icon_name":"old-republic","icon_prefix":"fab","icon_category":"brands","unicode":"f510"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_suse_brand', 'Suse', 2432, true, '{"icon_name":"suse","icon_prefix":"fab","icon_category":"brands","unicode":"f7d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_app-store-ios_brand', 'App Store Ios', 2433, true, '{"icon_name":"app-store-ios","icon_prefix":"fab","icon_category":"brands","unicode":"f370"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-dribbble_brand', 'Square Dribbble', 2434, true, '{"icon_name":"square-dribbble","icon_prefix":"fab","icon_category":"brands","unicode":"f397"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dribbble-square_brand', 'Dribbble Square', 2435, true, '{"icon_name":"dribbble-square","icon_prefix":"fab","icon_category":"brands","unicode":"f397"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_uikit_brand', 'Uikit', 2436, true, '{"icon_name":"uikit","icon_prefix":"fab","icon_category":"brands","unicode":"f403"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_superpowers_brand', 'Superpowers', 2437, true, '{"icon_name":"superpowers","icon_prefix":"fab","icon_category":"brands","unicode":"f2dd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_youtube_brand', 'Youtube', 2438, true, '{"icon_name":"youtube","icon_prefix":"fab","icon_category":"brands","unicode":"f167"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ember_brand', 'Ember', 2439, true, '{"icon_name":"ember","icon_prefix":"fab","icon_category":"brands","unicode":"f423"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bootstrap_brand', 'Bootstrap', 2440, true, '{"icon_name":"bootstrap","icon_prefix":"fab","icon_category":"brands","unicode":"f836"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_itunes_brand', 'Itunes', 2441, true, '{"icon_name":"itunes","icon_prefix":"fab","icon_category":"brands","unicode":"f3b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-xing_brand', 'Square Xing', 2442, true, '{"icon_name":"square-xing","icon_prefix":"fab","icon_category":"brands","unicode":"f169"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_xing-square_brand', 'Xing Square', 2443, true, '{"icon_name":"xing-square","icon_prefix":"fab","icon_category":"brands","unicode":"f169"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_css3-alt_brand', 'Css3 Alt', 2444, true, '{"icon_name":"css3-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f38b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_squarespace_brand', 'Squarespace', 2445, true, '{"icon_name":"squarespace","icon_prefix":"fab","icon_category":"brands","unicode":"f5be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trello_brand', 'Trello', 2446, true, '{"icon_name":"trello","icon_prefix":"fab","icon_category":"brands","unicode":"f181"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_viadeo_brand', 'Viadeo', 2447, true, '{"icon_name":"viadeo","icon_prefix":"fab","icon_category":"brands","unicode":"f2a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_searchengin_brand', 'Searchengin', 2448, true, '{"icon_name":"searchengin","icon_prefix":"fab","icon_category":"brands","unicode":"f3eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_paypal_brand', 'Paypal', 2449, true, '{"icon_name":"paypal","icon_prefix":"fab","icon_category":"brands","unicode":"f1ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-bluesky_brand', 'Square Bluesky', 2450, true, '{"icon_name":"square-bluesky","icon_prefix":"fab","icon_category":"brands","unicode":"e6a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_d-and-d-beyond_brand', 'D And D Beyond', 2451, true, '{"icon_name":"d-and-d-beyond","icon_prefix":"fab","icon_category":"brands","unicode":"f6ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microsoft_brand', 'Microsoft', 2452, true, '{"icon_name":"microsoft","icon_prefix":"fab","icon_category":"brands","unicode":"f3ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fly_brand', 'Fly', 2453, true, '{"icon_name":"fly","icon_prefix":"fab","icon_category":"brands","unicode":"f417"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-stripe_brand', 'Cc Stripe', 2454, true, '{"icon_name":"cc-stripe","icon_prefix":"fab","icon_category":"brands","unicode":"f1f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wordpress-simple_brand', 'Wordpress Simple', 2455, true, '{"icon_name":"wordpress-simple","icon_prefix":"fab","icon_category":"brands","unicode":"f411"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sellsy_brand', 'Sellsy', 2456, true, '{"icon_name":"sellsy","icon_prefix":"fab","icon_category":"brands","unicode":"f213"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dashcube_brand', 'Dashcube', 2457, true, '{"icon_name":"dashcube","icon_prefix":"fab","icon_category":"brands","unicode":"f210"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gitter_brand', 'Gitter', 2458, true, '{"icon_name":"gitter","icon_prefix":"fab","icon_category":"brands","unicode":"f426"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wolf-pack-battalion_brand', 'Wolf Pack Battalion', 2459, true, '{"icon_name":"wolf-pack-battalion","icon_prefix":"fab","icon_category":"brands","unicode":"f514"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lastfm_brand', 'Lastfm', 2460, true, '{"icon_name":"lastfm","icon_prefix":"fab","icon_category":"brands","unicode":"f202"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shopware_brand', 'Shopware', 2461, true, '{"icon_name":"shopware","icon_prefix":"fab","icon_category":"brands","unicode":"f5b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_blogger_brand', 'Blogger', 2462, true, '{"icon_name":"blogger","icon_prefix":"fab","icon_category":"brands","unicode":"f37c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_edge_brand', 'Edge', 2463, true, '{"icon_name":"edge","icon_prefix":"fab","icon_category":"brands","unicode":"f282"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ioxhost_brand', 'Ioxhost', 2464, true, '{"icon_name":"ioxhost","icon_prefix":"fab","icon_category":"brands","unicode":"f208"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_schlix_brand', 'Schlix', 2465, true, '{"icon_name":"schlix","icon_prefix":"fab","icon_category":"brands","unicode":"f3ea"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_d-and-d_brand', 'D And D', 2466, true, '{"icon_name":"d-and-d","icon_prefix":"fab","icon_category":"brands","unicode":"f38d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vuejs_brand', 'Vuejs', 2467, true, '{"icon_name":"vuejs","icon_prefix":"fab","icon_category":"brands","unicode":"f41f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meta_brand', 'Meta', 2468, true, '{"icon_name":"meta","icon_prefix":"fab","icon_category":"brands","unicode":"e49b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-share_brand', 'Creative Commons Share', 2469, true, '{"icon_name":"creative-commons-share","icon_prefix":"fab","icon_category":"brands","unicode":"f4f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_studiovinari_brand', 'Studiovinari', 2470, true, '{"icon_name":"studiovinari","icon_prefix":"fab","icon_category":"brands","unicode":"f3f8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bitbucket_brand', 'Bitbucket', 2471, true, '{"icon_name":"bitbucket","icon_prefix":"fab","icon_category":"brands","unicode":"f171"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vk_brand', 'Vk', 2472, true, '{"icon_name":"vk","icon_prefix":"fab","icon_category":"brands","unicode":"f189"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_github_brand', 'Github', 2473, true, '{"icon_name":"github","icon_prefix":"fab","icon_category":"brands","unicode":"f09b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_codiepie_brand', 'Codiepie', 2474, true, '{"icon_name":"codiepie","icon_prefix":"fab","icon_category":"brands","unicode":"f284"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pied-piper_brand', 'Pied Piper', 2475, true, '{"icon_name":"pied-piper","icon_prefix":"fab","icon_category":"brands","unicode":"f2ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_raspberry-pi_brand', 'Raspberry Pi', 2476, true, '{"icon_name":"raspberry-pi","icon_prefix":"fab","icon_category":"brands","unicode":"f7bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_css3_brand', 'Css3', 2477, true, '{"icon_name":"css3","icon_prefix":"fab","icon_category":"brands","unicode":"f13c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hubspot_brand', 'Hubspot', 2478, true, '{"icon_name":"hubspot","icon_prefix":"fab","icon_category":"brands","unicode":"f3b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cmplid_brand', 'Cmplid', 2479, true, '{"icon_name":"cmplid","icon_prefix":"fab","icon_category":"brands","unicode":"e360"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dyalog_brand', 'Dyalog', 2480, true, '{"icon_name":"dyalog","icon_prefix":"fab","icon_category":"brands","unicode":"f399"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_elementor_brand', 'Elementor', 2481, true, '{"icon_name":"elementor","icon_prefix":"fab","icon_category":"brands","unicode":"f430"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_first-order_brand', 'First Order', 2482, true, '{"icon_name":"first-order","icon_prefix":"fab","icon_category":"brands","unicode":"f2b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dribbble_brand', 'Dribbble', 2483, true, '{"icon_name":"dribbble","icon_prefix":"fab","icon_category":"brands","unicode":"f17d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_linkedin_brand', 'Linkedin', 2484, true, '{"icon_name":"linkedin","icon_prefix":"fab","icon_category":"brands","unicode":"f08c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-paypal_brand', 'Cc Paypal', 2485, true, '{"icon_name":"cc-paypal","icon_prefix":"fab","icon_category":"brands","unicode":"f1f4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dhl_brand', 'Dhl', 2486, true, '{"icon_name":"dhl","icon_prefix":"fab","icon_category":"brands","unicode":"f790"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tex_brand', 'Tex', 2487, true, '{"icon_name":"tex","icon_prefix":"fab","icon_category":"brands","unicode":"e7ff"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shopify_brand', 'Shopify', 2488, true, '{"icon_name":"shopify","icon_prefix":"fab","icon_category":"brands","unicode":"e057"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-reddit_brand', 'Square Reddit', 2489, true, '{"icon_name":"square-reddit","icon_prefix":"fab","icon_category":"brands","unicode":"f1a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reddit-square_brand', 'Reddit Square', 2490, true, '{"icon_name":"reddit-square","icon_prefix":"fab","icon_category":"brands","unicode":"f1a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-nc_brand', 'Creative Commons Nc', 2491, true, '{"icon_name":"creative-commons-nc","icon_prefix":"fab","icon_category":"brands","unicode":"f4e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_galactic-republic_brand', 'Galactic Republic', 2492, true, '{"icon_name":"galactic-republic","icon_prefix":"fab","icon_category":"brands","unicode":"f50c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_facebook_brand', 'Facebook', 2493, true, '{"icon_name":"facebook","icon_prefix":"fab","icon_category":"brands","unicode":"f09a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gitlab_brand', 'Gitlab', 2494, true, '{"icon_name":"gitlab","icon_prefix":"fab","icon_category":"brands","unicode":"f296"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_qq_brand', 'Qq', 2495, true, '{"icon_name":"qq","icon_prefix":"fab","icon_category":"brands","unicode":"f1d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stripe_brand', 'Stripe', 2496, true, '{"icon_name":"stripe","icon_prefix":"fab","icon_category":"brands","unicode":"f429"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dailymotion_brand', 'Dailymotion', 2497, true, '{"icon_name":"dailymotion","icon_prefix":"fab","icon_category":"brands","unicode":"e052"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_steam_brand', 'Steam', 2498, true, '{"icon_name":"steam","icon_prefix":"fab","icon_category":"brands","unicode":"f1b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snapchat_brand', 'Snapchat', 2499, true, '{"icon_name":"snapchat","icon_prefix":"fab","icon_category":"brands","unicode":"f2ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snapchat-ghost_brand', 'Snapchat Ghost', 2500, true, '{"icon_name":"snapchat-ghost","icon_prefix":"fab","icon_category":"brands","unicode":"f2ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_galactic-senate_brand', 'Galactic Senate', 2501, true, '{"icon_name":"galactic-senate","icon_prefix":"fab","icon_category":"brands","unicode":"f50d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phoenix-framework_brand', 'Phoenix Framework', 2502, true, '{"icon_name":"phoenix-framework","icon_prefix":"fab","icon_category":"brands","unicode":"f3dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_git_brand', 'Git', 2503, true, '{"icon_name":"git","icon_prefix":"fab","icon_category":"brands","unicode":"f1d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_optin-monster_brand', 'Optin Monster', 2504, true, '{"icon_name":"optin-monster","icon_prefix":"fab","icon_category":"brands","unicode":"f23c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jenkins_brand', 'Jenkins', 2505, true, '{"icon_name":"jenkins","icon_prefix":"fab","icon_category":"brands","unicode":"f3b6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_slideshare_brand', 'Slideshare', 2506, true, '{"icon_name":"slideshare","icon_prefix":"fab","icon_category":"brands","unicode":"f1e7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_uber_brand', 'Uber', 2507, true, '{"icon_name":"uber","icon_prefix":"fab","icon_category":"brands","unicode":"f402"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_digital-ocean_brand', 'Digital Ocean', 2508, true, '{"icon_name":"digital-ocean","icon_prefix":"fab","icon_category":"brands","unicode":"f391"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_soundcloud_brand', 'Soundcloud', 2509, true, '{"icon_name":"soundcloud","icon_prefix":"fab","icon_category":"brands","unicode":"f1be"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-figma_brand', 'Square Figma', 2510, true, '{"icon_name":"square-figma","icon_prefix":"fab","icon_category":"brands","unicode":"e7e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-sa_brand', 'Creative Commons Sa', 2511, true, '{"icon_name":"creative-commons-sa","icon_prefix":"fab","icon_category":"brands","unicode":"f4ef"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chrome_brand', 'Chrome', 2512, true, '{"icon_name":"chrome","icon_prefix":"fab","icon_category":"brands","unicode":"f268"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_trade-federation_brand', 'Trade Federation', 2513, true, '{"icon_name":"trade-federation","icon_prefix":"fab","icon_category":"brands","unicode":"f513"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vaadin_brand', 'Vaadin', 2514, true, '{"icon_name":"vaadin","icon_prefix":"fab","icon_category":"brands","unicode":"f408"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_deviantart_brand', 'Deviantart', 2515, true, '{"icon_name":"deviantart","icon_prefix":"fab","icon_category":"brands","unicode":"f1bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_medium_brand', 'Medium', 2516, true, '{"icon_name":"medium","icon_prefix":"fab","icon_category":"brands","unicode":"f23a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_medium-m_brand', 'Medium M', 2517, true, '{"icon_name":"medium-m","icon_prefix":"fab","icon_category":"brands","unicode":"f23a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_opencart_brand', 'Opencart', 2518, true, '{"icon_name":"opencart","icon_prefix":"fab","icon_category":"brands","unicode":"f23d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_y-combinator_brand', 'Y Combinator', 2519, true, '{"icon_name":"y-combinator","icon_prefix":"fab","icon_category":"brands","unicode":"f23b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_line_brand', 'Line', 2520, true, '{"icon_name":"line","icon_prefix":"fab","icon_category":"brands","unicode":"f3c0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_amilia_brand', 'Amilia', 2521, true, '{"icon_name":"amilia","icon_prefix":"fab","icon_category":"brands","unicode":"f36d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_asymmetrik_brand', 'Asymmetrik', 2522, true, '{"icon_name":"asymmetrik","icon_prefix":"fab","icon_category":"brands","unicode":"f372"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phabricator_brand', 'Phabricator', 2523, true, '{"icon_name":"phabricator","icon_prefix":"fab","icon_category":"brands","unicode":"f3db"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bots_brand', 'Bots', 2524, true, '{"icon_name":"bots","icon_prefix":"fab","icon_category":"brands","unicode":"e340"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vine_brand', 'Vine', 2525, true, '{"icon_name":"vine","icon_prefix":"fab","icon_category":"brands","unicode":"f1ca"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_medrt_brand', 'Medrt', 2526, true, '{"icon_name":"medrt","icon_prefix":"fab","icon_category":"brands","unicode":"f3c8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_osi_brand', 'Osi', 2527, true, '{"icon_name":"osi","icon_prefix":"fab","icon_category":"brands","unicode":"f41a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gg_brand', 'Gg', 2528, true, '{"icon_name":"gg","icon_prefix":"fab","icon_category":"brands","unicode":"f260"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_buysellads_brand', 'Buysellads', 2529, true, '{"icon_name":"buysellads","icon_prefix":"fab","icon_category":"brands","unicode":"f20d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-plus_brand', 'Google Plus', 2530, true, '{"icon_name":"google-plus","icon_prefix":"fab","icon_category":"brands","unicode":"f2b3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_screenpal_brand', 'Screenpal', 2531, true, '{"icon_name":"screenpal","icon_prefix":"fab","icon_category":"brands","unicode":"e570"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bitcoin_brand', 'Bitcoin', 2532, true, '{"icon_name":"bitcoin","icon_prefix":"fab","icon_category":"brands","unicode":"f379"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_swift_brand', 'Swift', 2533, true, '{"icon_name":"swift","icon_prefix":"fab","icon_category":"brands","unicode":"f8e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_files-pinwheel_brand', 'Files Pinwheel', 2534, true, '{"icon_name":"files-pinwheel","icon_prefix":"fab","icon_category":"brands","unicode":"e69f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_laravel_brand', 'Laravel', 2535, true, '{"icon_name":"laravel","icon_prefix":"fab","icon_category":"brands","unicode":"f3bd"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wpforms_brand', 'Wpforms', 2536, true, '{"icon_name":"wpforms","icon_prefix":"fab","icon_category":"brands","unicode":"f298"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_speaker-deck_brand', 'Speaker Deck', 2537, true, '{"icon_name":"speaker-deck","icon_prefix":"fab","icon_category":"brands","unicode":"f83c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flickr_brand', 'Flickr', 2538, true, '{"icon_name":"flickr","icon_prefix":"fab","icon_category":"brands","unicode":"f16e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-visa_brand', 'Cc Visa', 2539, true, '{"icon_name":"cc-visa","icon_prefix":"fab","icon_category":"brands","unicode":"f1f0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_upwork_brand', 'Upwork', 2540, true, '{"icon_name":"upwork","icon_prefix":"fab","icon_category":"brands","unicode":"e641"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kakao-talk_brand', 'Kakao Talk', 2541, true, '{"icon_name":"kakao-talk","icon_prefix":"fab","icon_category":"brands","unicode":"e7d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flutter_brand', 'Flutter', 2542, true, '{"icon_name":"flutter","icon_prefix":"fab","icon_category":"brands","unicode":"e694"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_buffer_brand', 'Buffer', 2543, true, '{"icon_name":"buffer","icon_prefix":"fab","icon_category":"brands","unicode":"f837"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gratipay_brand', 'Gratipay', 2544, true, '{"icon_name":"gratipay","icon_prefix":"fab","icon_category":"brands","unicode":"f184"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-pay_brand', 'Google Pay', 2545, true, '{"icon_name":"google-pay","icon_prefix":"fab","icon_category":"brands","unicode":"e079"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_apple_brand', 'Apple', 2546, true, '{"icon_name":"apple","icon_prefix":"fab","icon_category":"brands","unicode":"f179"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tumblr_brand', 'Tumblr', 2547, true, '{"icon_name":"tumblr","icon_prefix":"fab","icon_category":"brands","unicode":"f173"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_phoenix-squadron_brand', 'Phoenix Squadron', 2548, true, '{"icon_name":"phoenix-squadron","icon_prefix":"fab","icon_category":"brands","unicode":"f511"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_centercode_brand', 'Centercode', 2549, true, '{"icon_name":"centercode","icon_prefix":"fab","icon_category":"brands","unicode":"f380"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_debian_brand', 'Debian', 2550, true, '{"icon_name":"debian","icon_prefix":"fab","icon_category":"brands","unicode":"e60b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mastodon_brand', 'Mastodon', 2551, true, '{"icon_name":"mastodon","icon_prefix":"fab","icon_category":"brands","unicode":"f4f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sketch_brand', 'Sketch', 2552, true, '{"icon_name":"sketch","icon_prefix":"fab","icon_category":"brands","unicode":"f7c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_web-awesome_brand', 'Web Awesome', 2553, true, '{"icon_name":"web-awesome","icon_prefix":"fab","icon_category":"brands","unicode":"e682"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sass_brand', 'Sass', 2554, true, '{"icon_name":"sass","icon_prefix":"fab","icon_category":"brands","unicode":"f41e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-whatsapp_brand', 'Square Whatsapp', 2555, true, '{"icon_name":"square-whatsapp","icon_prefix":"fab","icon_category":"brands","unicode":"f40c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_whatsapp-square_brand', 'Whatsapp Square', 2556, true, '{"icon_name":"whatsapp-square","icon_prefix":"fab","icon_category":"brands","unicode":"f40c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_skype_brand', 'Skype', 2557, true, '{"icon_name":"skype","icon_prefix":"fab","icon_category":"brands","unicode":"f17e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angular_brand', 'Angular', 2558, true, '{"icon_name":"angular","icon_prefix":"fab","icon_category":"brands","unicode":"f420"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_opensuse_brand', 'Opensuse', 2559, true, '{"icon_name":"opensuse","icon_prefix":"fab","icon_category":"brands","unicode":"e62b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dropbox_brand', 'Dropbox', 2560, true, '{"icon_name":"dropbox","icon_prefix":"fab","icon_category":"brands","unicode":"f16b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_deezer_brand', 'Deezer', 2561, true, '{"icon_name":"deezer","icon_prefix":"fab","icon_category":"brands","unicode":"e077"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-sampling_brand', 'Creative Commons Sampling', 2562, true, '{"icon_name":"creative-commons-sampling","icon_prefix":"fab","icon_category":"brands","unicode":"f4f0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jedi-order_brand', 'Jedi Order', 2563, true, '{"icon_name":"jedi-order","icon_prefix":"fab","icon_category":"brands","unicode":"f50e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_r-project_brand', 'R Project', 2564, true, '{"icon_name":"r-project","icon_prefix":"fab","icon_category":"brands","unicode":"f4f7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_instalod_brand', 'Instalod', 2565, true, '{"icon_name":"instalod","icon_prefix":"fab","icon_category":"brands","unicode":"e081"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_canadian-maple-leaf_brand', 'Canadian Maple Leaf', 2566, true, '{"icon_name":"canadian-maple-leaf","icon_prefix":"fab","icon_category":"brands","unicode":"f785"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ethereum_brand', 'Ethereum', 2567, true, '{"icon_name":"ethereum","icon_prefix":"fab","icon_category":"brands","unicode":"f42e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_houzz_brand', 'Houzz', 2568, true, '{"icon_name":"houzz","icon_prefix":"fab","icon_category":"brands","unicode":"f27c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_viber_brand', 'Viber', 2569, true, '{"icon_name":"viber","icon_prefix":"fab","icon_category":"brands","unicode":"f409"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kickstarter_brand', 'Kickstarter', 2570, true, '{"icon_name":"kickstarter","icon_prefix":"fab","icon_category":"brands","unicode":"f3bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-kickstarter_brand', 'Square Kickstarter', 2571, true, '{"icon_name":"square-kickstarter","icon_prefix":"fab","icon_category":"brands","unicode":"f3bb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_spotify_brand', 'Spotify', 2572, true, '{"icon_name":"spotify","icon_prefix":"fab","icon_category":"brands","unicode":"f1bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_leanpub_brand', 'Leanpub', 2573, true, '{"icon_name":"leanpub","icon_prefix":"fab","icon_category":"brands","unicode":"f212"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_java_brand', 'Java', 2574, true, '{"icon_name":"java","icon_prefix":"fab","icon_category":"brands","unicode":"f4e4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_nfc-symbol_brand', 'Nfc Symbol', 2575, true, '{"icon_name":"nfc-symbol","icon_prefix":"fab","icon_category":"brands","unicode":"e531"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wodu_brand', 'Wodu', 2576, true, '{"icon_name":"wodu","icon_prefix":"fab","icon_category":"brands","unicode":"e088"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-steam_brand', 'Square Steam', 2577, true, '{"icon_name":"square-steam","icon_prefix":"fab","icon_category":"brands","unicode":"f1b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_steam-square_brand', 'Steam Square', 2578, true, '{"icon_name":"steam-square","icon_prefix":"fab","icon_category":"brands","unicode":"f1b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-nc-eu_brand', 'Creative Commons Nc Eu', 2579, true, '{"icon_name":"creative-commons-nc-eu","icon_prefix":"fab","icon_category":"brands","unicode":"f4e9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_npm_brand', 'Npm', 2580, true, '{"icon_name":"npm","icon_prefix":"fab","icon_category":"brands","unicode":"f3d4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloudscale_brand', 'Cloudscale', 2581, true, '{"icon_name":"cloudscale","icon_prefix":"fab","icon_category":"brands","unicode":"f383"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_themeco_brand', 'Themeco', 2582, true, '{"icon_name":"themeco","icon_prefix":"fab","icon_category":"brands","unicode":"f5c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-play_brand', 'Google Play', 2583, true, '{"icon_name":"google-play","icon_prefix":"fab","icon_category":"brands","unicode":"f3ab"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_korvue_brand', 'Korvue', 2584, true, '{"icon_name":"korvue","icon_prefix":"fab","icon_category":"brands","unicode":"f42f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_w3c_brand', 'W3c', 2585, true, '{"icon_name":"w3c","icon_prefix":"fab","icon_category":"brands","unicode":"e7de"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_grav_brand', 'Grav', 2586, true, '{"icon_name":"grav","icon_prefix":"fab","icon_category":"brands","unicode":"f2d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_aws_brand', 'Aws', 2587, true, '{"icon_name":"aws","icon_prefix":"fab","icon_category":"brands","unicode":"f375"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_glide-g_brand', 'Glide G', 2588, true, '{"icon_name":"glide-g","icon_prefix":"fab","icon_category":"brands","unicode":"f2a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jsfiddle_brand', 'Jsfiddle', 2589, true, '{"icon_name":"jsfiddle","icon_prefix":"fab","icon_category":"brands","unicode":"f1cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_keybase_brand', 'Keybase', 2590, true, '{"icon_name":"keybase","icon_prefix":"fab","icon_category":"brands","unicode":"f4f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lumon-drop_brand', 'Lumon Drop', 2591, true, '{"icon_name":"lumon-drop","icon_prefix":"fab","icon_category":"brands","unicode":"e7e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_weebly_brand', 'Weebly', 2592, true, '{"icon_name":"weebly","icon_prefix":"fab","icon_category":"brands","unicode":"f5cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_docker_brand', 'Docker', 2593, true, '{"icon_name":"docker","icon_prefix":"fab","icon_category":"brands","unicode":"f395"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_magento_brand', 'Magento', 2594, true, '{"icon_name":"magento","icon_prefix":"fab","icon_category":"brands","unicode":"f3c4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_git-alt_brand', 'Git Alt', 2595, true, '{"icon_name":"git-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f841"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_firefox-browser_brand', 'Firefox Browser', 2596, true, '{"icon_name":"firefox-browser","icon_prefix":"fab","icon_category":"brands","unicode":"e007"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloudsmith_brand', 'Cloudsmith', 2597, true, '{"icon_name":"cloudsmith","icon_prefix":"fab","icon_category":"brands","unicode":"f384"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wizards-of-the-coast_brand', 'Wizards Of The Coast', 2598, true, '{"icon_name":"wizards-of-the-coast","icon_prefix":"fab","icon_category":"brands","unicode":"f730"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-nd_brand', 'Creative Commons Nd', 2599, true, '{"icon_name":"creative-commons-nd","icon_prefix":"fab","icon_category":"brands","unicode":"f4eb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_usps_brand', 'Usps', 2600, true, '{"icon_name":"usps","icon_prefix":"fab","icon_category":"brands","unicode":"f7e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-letterboxd_brand', 'Square Letterboxd', 2601, true, '{"icon_name":"square-letterboxd","icon_prefix":"fab","icon_category":"brands","unicode":"e62e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mandalorian_brand', 'Mandalorian', 2602, true, '{"icon_name":"mandalorian","icon_prefix":"fab","icon_category":"brands","unicode":"f50f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_slack_brand', 'Slack', 2603, true, '{"icon_name":"slack","icon_prefix":"fab","icon_category":"brands","unicode":"f198"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_slack-hash_brand', 'Slack Hash', 2604, true, '{"icon_name":"slack-hash","icon_prefix":"fab","icon_category":"brands","unicode":"f198"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_angellist_brand', 'Angellist', 2605, true, '{"icon_name":"angellist","icon_prefix":"fab","icon_category":"brands","unicode":"f209"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_android_brand', 'Android', 2606, true, '{"icon_name":"android","icon_prefix":"fab","icon_category":"brands","unicode":"f17b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_meetup_brand', 'Meetup', 2607, true, '{"icon_name":"meetup","icon_prefix":"fab","icon_category":"brands","unicode":"f2e0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fonticons-fi_brand', 'Fonticons Fi', 2608, true, '{"icon_name":"fonticons-fi","icon_prefix":"fab","icon_category":"brands","unicode":"f3a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_palfed_brand', 'Palfed', 2609, true, '{"icon_name":"palfed","icon_prefix":"fab","icon_category":"brands","unicode":"f3d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wpbeginner_brand', 'Wpbeginner', 2610, true, '{"icon_name":"wpbeginner","icon_prefix":"fab","icon_category":"brands","unicode":"f297"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_diaspora_brand', 'Diaspora', 2611, true, '{"icon_name":"diaspora","icon_prefix":"fab","icon_category":"brands","unicode":"f791"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_product-hunt_brand', 'Product Hunt', 2612, true, '{"icon_name":"product-hunt","icon_prefix":"fab","icon_category":"brands","unicode":"f288"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-upwork_brand', 'Square Upwork', 2613, true, '{"icon_name":"square-upwork","icon_prefix":"fab","icon_category":"brands","unicode":"e67c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cuttlefish_brand', 'Cuttlefish', 2614, true, '{"icon_name":"cuttlefish","icon_prefix":"fab","icon_category":"brands","unicode":"f38c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_medapps_brand', 'Medapps', 2615, true, '{"icon_name":"medapps","icon_prefix":"fab","icon_category":"brands","unicode":"f3c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pix_brand', 'Pix', 2616, true, '{"icon_name":"pix","icon_prefix":"fab","icon_category":"brands","unicode":"e43a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-tumblr_brand', 'Square Tumblr', 2617, true, '{"icon_name":"square-tumblr","icon_prefix":"fab","icon_category":"brands","unicode":"f174"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tumblr-square_brand', 'Tumblr Square', 2618, true, '{"icon_name":"tumblr-square","icon_prefix":"fab","icon_category":"brands","unicode":"f174"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_react_brand', 'React', 2619, true, '{"icon_name":"react","icon_prefix":"fab","icon_category":"brands","unicode":"f41b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_jxl_brand', 'Jxl', 2620, true, '{"icon_name":"jxl","icon_prefix":"fab","icon_category":"brands","unicode":"e67b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-linkedin_brand', 'Square Linkedin', 2621, true, '{"icon_name":"square-linkedin","icon_prefix":"fab","icon_category":"brands","unicode":"e7d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_css_brand', 'Css', 2622, true, '{"icon_name":"css","icon_prefix":"fab","icon_category":"brands","unicode":"e6a2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hashnode_brand', 'Hashnode', 2623, true, '{"icon_name":"hashnode","icon_prefix":"fab","icon_category":"brands","unicode":"e499"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_reddit-alien_brand', 'Reddit Alien', 2624, true, '{"icon_name":"reddit-alien","icon_prefix":"fab","icon_category":"brands","unicode":"f281"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tiktok_brand', 'Tiktok', 2625, true, '{"icon_name":"tiktok","icon_prefix":"fab","icon_category":"brands","unicode":"e07b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wordpress_brand', 'Wordpress', 2626, true, '{"icon_name":"wordpress","icon_prefix":"fab","icon_category":"brands","unicode":"f19a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ideal_brand', 'Ideal', 2627, true, '{"icon_name":"ideal","icon_prefix":"fab","icon_category":"brands","unicode":"e013"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pied-piper-pp_brand', 'Pied Piper Pp', 2628, true, '{"icon_name":"pied-piper-pp","icon_prefix":"fab","icon_category":"brands","unicode":"f1a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ussunnah_brand', 'Ussunnah', 2629, true, '{"icon_name":"ussunnah","icon_prefix":"fab","icon_category":"brands","unicode":"f407"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fort-awesome-alt_brand', 'Fort Awesome Alt', 2630, true, '{"icon_name":"fort-awesome-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f3a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_buromobelexperte_brand', 'Buromobelexperte', 2631, true, '{"icon_name":"buromobelexperte","icon_prefix":"fab","icon_category":"brands","unicode":"f37f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bilibili_brand', 'Bilibili', 2632, true, '{"icon_name":"bilibili","icon_prefix":"fab","icon_category":"brands","unicode":"e3d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_neos_brand', 'Neos', 2633, true, '{"icon_name":"neos","icon_prefix":"fab","icon_category":"brands","unicode":"f612"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dev_brand', 'Dev', 2634, true, '{"icon_name":"dev","icon_prefix":"fab","icon_category":"brands","unicode":"f6cc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hotjar_brand', 'Hotjar', 2635, true, '{"icon_name":"hotjar","icon_prefix":"fab","icon_category":"brands","unicode":"f3b1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dochub_brand', 'Dochub', 2636, true, '{"icon_name":"dochub","icon_prefix":"fab","icon_category":"brands","unicode":"f394"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vimeo_brand', 'Vimeo', 2637, true, '{"icon_name":"vimeo","icon_prefix":"fab","icon_category":"brands","unicode":"f40a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_maxcdn_brand', 'Maxcdn', 2638, true, '{"icon_name":"maxcdn","icon_prefix":"fab","icon_category":"brands","unicode":"f136"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-font-awesome-stroke_brand', 'Square Font Awesome Stroke', 2639, true, '{"icon_name":"square-font-awesome-stroke","icon_prefix":"fab","icon_category":"brands","unicode":"f35c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_font-awesome-alt_brand', 'Font Awesome Alt', 2640, true, '{"icon_name":"font-awesome-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f35c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_speakap_brand', 'Speakap', 2641, true, '{"icon_name":"speakap","icon_prefix":"fab","icon_category":"brands","unicode":"f3f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fantasy-flight-games_brand', 'Fantasy Flight Games', 2642, true, '{"icon_name":"fantasy-flight-games","icon_prefix":"fab","icon_category":"brands","unicode":"f6dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_linux_brand', 'Linux', 2643, true, '{"icon_name":"linux","icon_prefix":"fab","icon_category":"brands","unicode":"f17c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cotton-bureau_brand', 'Cotton Bureau', 2644, true, '{"icon_name":"cotton-bureau","icon_prefix":"fab","icon_category":"brands","unicode":"f89e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_google-wallet_brand', 'Google Wallet', 2645, true, '{"icon_name":"google-wallet","icon_prefix":"fab","icon_category":"brands","unicode":"f1ee"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_foursquare_brand', 'Foursquare', 2646, true, '{"icon_name":"foursquare","icon_prefix":"fab","icon_category":"brands","unicode":"f180"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shirtsinbulk_brand', 'Shirtsinbulk', 2647, true, '{"icon_name":"shirtsinbulk","icon_prefix":"fab","icon_category":"brands","unicode":"f214"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mintbit_brand', 'Mintbit', 2648, true, '{"icon_name":"mintbit","icon_prefix":"fab","icon_category":"brands","unicode":"e62f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_staylinked_brand', 'Staylinked', 2649, true, '{"icon_name":"staylinked","icon_prefix":"fab","icon_category":"brands","unicode":"f3f5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_webflow_brand', 'Webflow', 2650, true, '{"icon_name":"webflow","icon_prefix":"fab","icon_category":"brands","unicode":"e65c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_renren_brand', 'Renren', 2651, true, '{"icon_name":"renren","icon_prefix":"fab","icon_category":"brands","unicode":"f18b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rev_brand', 'Rev', 2652, true, '{"icon_name":"rev","icon_prefix":"fab","icon_category":"brands","unicode":"f5b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_keycdn_brand', 'Keycdn', 2653, true, '{"icon_name":"keycdn","icon_prefix":"fab","icon_category":"brands","unicode":"f3ba"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hire-a-helper_brand', 'Hire A Helper', 2654, true, '{"icon_name":"hire-a-helper","icon_prefix":"fab","icon_category":"brands","unicode":"f3b0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-hacker-news_brand', 'Square Hacker News', 2655, true, '{"icon_name":"square-hacker-news","icon_prefix":"fab","icon_category":"brands","unicode":"f3af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hacker-news-square_brand', 'Hacker News Square', 2656, true, '{"icon_name":"hacker-news-square","icon_prefix":"fab","icon_category":"brands","unicode":"f3af"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-pd-alt_brand', 'Creative Commons Pd Alt', 2657, true, '{"icon_name":"creative-commons-pd-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f4ed"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_orcid_brand', 'Orcid', 2658, true, '{"icon_name":"orcid","icon_prefix":"fab","icon_category":"brands","unicode":"f8d2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_behance_brand', 'Behance', 2659, true, '{"icon_name":"behance","icon_prefix":"fab","icon_category":"brands","unicode":"f1b4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_monero_brand', 'Monero', 2660, true, '{"icon_name":"monero","icon_prefix":"fab","icon_category":"brands","unicode":"f3d0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_figma_brand', 'Figma', 2661, true, '{"icon_name":"figma","icon_prefix":"fab","icon_category":"brands","unicode":"f799"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_instagram_brand', 'Instagram', 2662, true, '{"icon_name":"instagram","icon_prefix":"fab","icon_category":"brands","unicode":"f16d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_perbyte_brand', 'Perbyte', 2663, true, '{"icon_name":"perbyte","icon_prefix":"fab","icon_category":"brands","unicode":"e083"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-vimeo_brand', 'Square Vimeo', 2664, true, '{"icon_name":"square-vimeo","icon_prefix":"fab","icon_category":"brands","unicode":"f194"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vimeo-square_brand', 'Vimeo Square', 2665, true, '{"icon_name":"vimeo-square","icon_prefix":"fab","icon_category":"brands","unicode":"f194"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pushed_brand', 'Pushed', 2666, true, '{"icon_name":"pushed","icon_prefix":"fab","icon_category":"brands","unicode":"f3e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mixcloud_brand', 'Mixcloud', 2667, true, '{"icon_name":"mixcloud","icon_prefix":"fab","icon_category":"brands","unicode":"f289"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yandex-international_brand', 'Yandex International', 2668, true, '{"icon_name":"yandex-international","icon_prefix":"fab","icon_category":"brands","unicode":"f414"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hive_brand', 'Hive', 2669, true, '{"icon_name":"hive","icon_prefix":"fab","icon_category":"brands","unicode":"e07f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-zero_brand', 'Creative Commons Zero', 2670, true, '{"icon_name":"creative-commons-zero","icon_prefix":"fab","icon_category":"brands","unicode":"f4f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-snapchat_brand', 'Square Snapchat', 2671, true, '{"icon_name":"square-snapchat","icon_prefix":"fab","icon_category":"brands","unicode":"f2ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_snapchat-square_brand', 'Snapchat Square', 2672, true, '{"icon_name":"snapchat-square","icon_prefix":"fab","icon_category":"brands","unicode":"f2ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_themeisle_brand', 'Themeisle', 2673, true, '{"icon_name":"themeisle","icon_prefix":"fab","icon_category":"brands","unicode":"f2b2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_dart-lang_brand', 'Dart Lang', 2674, true, '{"icon_name":"dart-lang","icon_prefix":"fab","icon_category":"brands","unicode":"e693"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_deploydog_brand', 'Deploydog', 2675, true, '{"icon_name":"deploydog","icon_prefix":"fab","icon_category":"brands","unicode":"f38e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_flipboard_brand', 'Flipboard', 2676, true, '{"icon_name":"flipboard","icon_prefix":"fab","icon_category":"brands","unicode":"f44d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_buy-n-large_brand', 'Buy N Large', 2677, true, '{"icon_name":"buy-n-large","icon_prefix":"fab","icon_category":"brands","unicode":"f8a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_watchman-monitoring_brand', 'Watchman Monitoring', 2678, true, '{"icon_name":"watchman-monitoring","icon_prefix":"fab","icon_category":"brands","unicode":"e087"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hips_brand', 'Hips', 2679, true, '{"icon_name":"hips","icon_prefix":"fab","icon_category":"brands","unicode":"f452"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cloudversify_brand', 'Cloudversify', 2680, true, '{"icon_name":"cloudversify","icon_prefix":"fab","icon_category":"brands","unicode":"f385"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_goodreads_brand', 'Goodreads', 2681, true, '{"icon_name":"goodreads","icon_prefix":"fab","icon_category":"brands","unicode":"f3a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tidal_brand', 'Tidal', 2682, true, '{"icon_name":"tidal","icon_prefix":"fab","icon_category":"brands","unicode":"e7dc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_unity_brand', 'Unity', 2683, true, '{"icon_name":"unity","icon_prefix":"fab","icon_category":"brands","unicode":"e049"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_tencent-weibo_brand', 'Tencent Weibo', 2684, true, '{"icon_name":"tencent-weibo","icon_prefix":"fab","icon_category":"brands","unicode":"f1d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_free-code-camp_brand', 'Free Code Camp', 2685, true, '{"icon_name":"free-code-camp","icon_prefix":"fab","icon_category":"brands","unicode":"f2c5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_x-twitter_brand', 'X Twitter', 2686, true, '{"icon_name":"x-twitter","icon_prefix":"fab","icon_category":"brands","unicode":"e61b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sticker-mule_brand', 'Sticker Mule', 2687, true, '{"icon_name":"sticker-mule","icon_prefix":"fab","icon_category":"brands","unicode":"f3f7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_twitch_brand', 'Twitch', 2688, true, '{"icon_name":"twitch","icon_prefix":"fab","icon_category":"brands","unicode":"f1e8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kickstarter-k_brand', 'Kickstarter K', 2689, true, '{"icon_name":"kickstarter-k","icon_prefix":"fab","icon_category":"brands","unicode":"f3bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_critical-role_brand', 'Critical Role', 2690, true, '{"icon_name":"critical-role","icon_prefix":"fab","icon_category":"brands","unicode":"f6c9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_steam-symbol_brand', 'Steam Symbol', 2691, true, '{"icon_name":"steam-symbol","icon_prefix":"fab","icon_category":"brands","unicode":"f3f6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mailchimp_brand', 'Mailchimp', 2692, true, '{"icon_name":"mailchimp","icon_prefix":"fab","icon_category":"brands","unicode":"f59e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lumon_brand', 'Lumon', 2693, true, '{"icon_name":"lumon","icon_prefix":"fab","icon_category":"brands","unicode":"e7e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_nutritionix_brand', 'Nutritionix', 2694, true, '{"icon_name":"nutritionix","icon_prefix":"fab","icon_category":"brands","unicode":"f3d6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons-sampling-plus_brand', 'Creative Commons Sampling Plus', 2695, true, '{"icon_name":"creative-commons-sampling-plus","icon_prefix":"fab","icon_category":"brands","unicode":"f4f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_redhat_brand', 'Redhat', 2696, true, '{"icon_name":"redhat","icon_prefix":"fab","icon_category":"brands","unicode":"f7bc"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-pied-piper_brand', 'Square Pied Piper', 2697, true, '{"icon_name":"square-pied-piper","icon_prefix":"fab","icon_category":"brands","unicode":"e01e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pied-piper-square_brand', 'Pied Piper Square', 2698, true, '{"icon_name":"pied-piper-square","icon_prefix":"fab","icon_category":"brands","unicode":"e01e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_whatsapp_brand', 'Whatsapp', 2699, true, '{"icon_name":"whatsapp","icon_prefix":"fab","icon_category":"brands","unicode":"f232"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_imdb_brand', 'Imdb', 2700, true, '{"icon_name":"imdb","icon_prefix":"fab","icon_category":"brands","unicode":"f2d8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_python_brand', 'Python', 2701, true, '{"icon_name":"python","icon_prefix":"fab","icon_category":"brands","unicode":"f3e2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cash-app_brand', 'Cash App', 2702, true, '{"icon_name":"cash-app","icon_prefix":"fab","icon_category":"brands","unicode":"e7d4"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pinterest-p_brand', 'Pinterest P', 2703, true, '{"icon_name":"pinterest-p","icon_prefix":"fab","icon_category":"brands","unicode":"f231"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_whmcs_brand', 'Whmcs', 2704, true, '{"icon_name":"whmcs","icon_prefix":"fab","icon_category":"brands","unicode":"f40d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_joget_brand', 'Joget', 2705, true, '{"icon_name":"joget","icon_prefix":"fab","icon_category":"brands","unicode":"f3b7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-youtube_brand', 'Square Youtube', 2706, true, '{"icon_name":"square-youtube","icon_prefix":"fab","icon_category":"brands","unicode":"f431"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_youtube-square_brand', 'Youtube Square', 2707, true, '{"icon_name":"youtube-square","icon_prefix":"fab","icon_category":"brands","unicode":"f431"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_atlassian_brand', 'Atlassian', 2708, true, '{"icon_name":"atlassian","icon_prefix":"fab","icon_category":"brands","unicode":"f77b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pied-piper-hat_brand', 'Pied Piper Hat', 2709, true, '{"icon_name":"pied-piper-hat","icon_prefix":"fab","icon_category":"brands","unicode":"f4e5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_internet-explorer_brand', 'Internet Explorer', 2710, true, '{"icon_name":"internet-explorer","icon_prefix":"fab","icon_category":"brands","unicode":"f26b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_airbnb_brand', 'Airbnb', 2711, true, '{"icon_name":"airbnb","icon_prefix":"fab","icon_category":"brands","unicode":"f834"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_js_brand', 'Js', 2712, true, '{"icon_name":"js","icon_prefix":"fab","icon_category":"brands","unicode":"f3b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_quinscape_brand', 'Quinscape', 2713, true, '{"icon_name":"quinscape","icon_prefix":"fab","icon_category":"brands","unicode":"f459"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_adversal_brand', 'Adversal', 2714, true, '{"icon_name":"adversal","icon_prefix":"fab","icon_category":"brands","unicode":"f36a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_creative-commons_brand', 'Creative Commons', 2715, true, '{"icon_name":"creative-commons","icon_prefix":"fab","icon_category":"brands","unicode":"f25e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_notion_brand', 'Notion', 2716, true, '{"icon_name":"notion","icon_prefix":"fab","icon_category":"brands","unicode":"e7d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_chromecast_brand', 'Chromecast', 2717, true, '{"icon_name":"chromecast","icon_prefix":"fab","icon_category":"brands","unicode":"f838"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_wikipedia-w_brand', 'Wikipedia W', 2718, true, '{"icon_name":"wikipedia-w","icon_prefix":"fab","icon_category":"brands","unicode":"f266"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sitrox_brand', 'Sitrox', 2719, true, '{"icon_name":"sitrox","icon_prefix":"fab","icon_category":"brands","unicode":"e44a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-gitlab_brand', 'Square Gitlab', 2720, true, '{"icon_name":"square-gitlab","icon_prefix":"fab","icon_category":"brands","unicode":"e5ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gitlab-square_brand', 'Gitlab Square', 2721, true, '{"icon_name":"gitlab-square","icon_prefix":"fab","icon_category":"brands","unicode":"e5ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_shoelace_brand', 'Shoelace', 2722, true, '{"icon_name":"shoelace","icon_prefix":"fab","icon_category":"brands","unicode":"e60c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sellcast_brand', 'Sellcast', 2723, true, '{"icon_name":"sellcast","icon_prefix":"fab","icon_category":"brands","unicode":"f2da"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mix_brand', 'Mix', 2724, true, '{"icon_name":"mix","icon_prefix":"fab","icon_category":"brands","unicode":"f3cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-apple-pay_brand', 'Cc Apple Pay', 2725, true, '{"icon_name":"cc-apple-pay","icon_prefix":"fab","icon_category":"brands","unicode":"f416"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_brave_brand', 'Brave', 2726, true, '{"icon_name":"brave","icon_prefix":"fab","icon_category":"brands","unicode":"e63c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_etsy_brand', 'Etsy', 2727, true, '{"icon_name":"etsy","icon_prefix":"fab","icon_category":"brands","unicode":"f2d7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_btc_brand', 'Btc', 2728, true, '{"icon_name":"btc","icon_prefix":"fab","icon_category":"brands","unicode":"f15a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_adn_brand', 'Adn', 2729, true, '{"icon_name":"adn","icon_prefix":"fab","icon_category":"brands","unicode":"f170"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-x-twitter_brand', 'Square X Twitter', 2730, true, '{"icon_name":"square-x-twitter","icon_prefix":"fab","icon_category":"brands","unicode":"e61a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-font-awesome_brand', 'Square Font Awesome', 2731, true, '{"icon_name":"square-font-awesome","icon_prefix":"fab","icon_category":"brands","unicode":"e5ad"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_forumbee_brand', 'Forumbee', 2732, true, '{"icon_name":"forumbee","icon_prefix":"fab","icon_category":"brands","unicode":"f211"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_2-group_brand', '2 Group', 2733, true, '{"icon_name":"2-group","icon_prefix":"fab","icon_category":"brands","unicode":"e080"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_innosoft_brand', 'Innosoft', 2734, true, '{"icon_name":"innosoft","icon_prefix":"fab","icon_category":"brands","unicode":"e080"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stumbleupon-circle_brand', 'Stumbleupon Circle', 2735, true, '{"icon_name":"stumbleupon-circle","icon_prefix":"fab","icon_category":"brands","unicode":"f1a3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_symfony_brand', 'Symfony', 2736, true, '{"icon_name":"symfony","icon_prefix":"fab","icon_category":"brands","unicode":"f83d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_salesforce_brand', 'Salesforce', 2737, true, '{"icon_name":"salesforce","icon_prefix":"fab","icon_category":"brands","unicode":"f83b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_sourcetree_brand', 'Sourcetree', 2738, true, '{"icon_name":"sourcetree","icon_prefix":"fab","icon_category":"brands","unicode":"f7d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_linkedin-in_brand', 'Linkedin In', 2739, true, '{"icon_name":"linkedin-in","icon_prefix":"fab","icon_category":"brands","unicode":"f0e1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_html5_brand', 'Html5', 2740, true, '{"icon_name":"html5","icon_prefix":"fab","icon_category":"brands","unicode":"f13b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_rust_brand', 'Rust', 2741, true, '{"icon_name":"rust","icon_prefix":"fab","icon_category":"brands","unicode":"e07a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_hornbill_brand', 'Hornbill', 2742, true, '{"icon_name":"hornbill","icon_prefix":"fab","icon_category":"brands","unicode":"f592"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_php_brand', 'Php', 2743, true, '{"icon_name":"php","icon_prefix":"fab","icon_category":"brands","unicode":"f457"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_disqus_brand', 'Disqus', 2744, true, '{"icon_name":"disqus","icon_prefix":"fab","icon_category":"brands","unicode":"e7d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_00px_brand', '00px', 2745, true, '{"icon_name":"00px","icon_prefix":"fab","icon_category":"brands","unicode":"f26e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_affiliatetheme_brand', 'Affiliatetheme', 2746, true, '{"icon_name":"affiliatetheme","icon_prefix":"fab","icon_category":"brands","unicode":"f36b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_red-river_brand', 'Red River', 2747, true, '{"icon_name":"red-river","icon_prefix":"fab","icon_category":"brands","unicode":"f3e3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_twitter_brand', 'Twitter', 2748, true, '{"icon_name":"twitter","icon_prefix":"fab","icon_category":"brands","unicode":"f099"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_fort-awesome_brand', 'Fort Awesome', 2749, true, '{"icon_name":"fort-awesome","icon_prefix":"fab","icon_category":"brands","unicode":"f286"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_mixer_brand', 'Mixer', 2750, true, '{"icon_name":"mixer","icon_prefix":"fab","icon_category":"brands","unicode":"e056"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lyft_brand', 'Lyft', 2751, true, '{"icon_name":"lyft","icon_prefix":"fab","icon_category":"brands","unicode":"f3c3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_apple-pay_brand', 'Apple Pay', 2752, true, '{"icon_name":"apple-pay","icon_prefix":"fab","icon_category":"brands","unicode":"f415"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_artstation_brand', 'Artstation', 2753, true, '{"icon_name":"artstation","icon_prefix":"fab","icon_category":"brands","unicode":"f77a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_node-js_brand', 'Node Js', 2754, true, '{"icon_name":"node-js","icon_prefix":"fab","icon_category":"brands","unicode":"f3d3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_uncharted_brand', 'Uncharted', 2755, true, '{"icon_name":"uncharted","icon_prefix":"fab","icon_category":"brands","unicode":"e084"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_playstation_brand', 'Playstation', 2756, true, '{"icon_name":"playstation","icon_prefix":"fab","icon_category":"brands","unicode":"f3df"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_microblog_brand', 'Microblog', 2757, true, '{"icon_name":"microblog","icon_prefix":"fab","icon_category":"brands","unicode":"e01a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gitkraken_brand', 'Gitkraken', 2758, true, '{"icon_name":"gitkraken","icon_prefix":"fab","icon_category":"brands","unicode":"f3a6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_telegram_brand', 'Telegram', 2759, true, '{"icon_name":"telegram","icon_prefix":"fab","icon_category":"brands","unicode":"f2c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_telegram-plane_brand', 'Telegram Plane', 2760, true, '{"icon_name":"telegram-plane","icon_prefix":"fab","icon_category":"brands","unicode":"f2c6"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_itunes-note_brand', 'Itunes Note', 2761, true, '{"icon_name":"itunes-note","icon_prefix":"fab","icon_category":"brands","unicode":"f3b5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_less_brand', 'Less', 2762, true, '{"icon_name":"less","icon_prefix":"fab","icon_category":"brands","unicode":"f41d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_firefox_brand', 'Firefox', 2763, true, '{"icon_name":"firefox","icon_prefix":"fab","icon_category":"brands","unicode":"f269"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_kaggle_brand', 'Kaggle', 2764, true, '{"icon_name":"kaggle","icon_prefix":"fab","icon_category":"brands","unicode":"f5fa"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_facebook-messenger_brand', 'Facebook Messenger', 2765, true, '{"icon_name":"facebook-messenger","icon_prefix":"fab","icon_category":"brands","unicode":"f39f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_audible_brand', 'Audible', 2766, true, '{"icon_name":"audible","icon_prefix":"fab","icon_category":"brands","unicode":"f373"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_patreon_brand', 'Patreon', 2767, true, '{"icon_name":"patreon","icon_prefix":"fab","icon_category":"brands","unicode":"f3d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_vnv_brand', 'Vnv', 2768, true, '{"icon_name":"vnv","icon_prefix":"fab","icon_category":"brands","unicode":"f40b"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pagelines_brand', 'Pagelines', 2769, true, '{"icon_name":"pagelines","icon_prefix":"fab","icon_category":"brands","unicode":"f18c"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_amazon_brand', 'Amazon', 2770, true, '{"icon_name":"amazon","icon_prefix":"fab","icon_category":"brands","unicode":"f270"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_envira_brand', 'Envira', 2771, true, '{"icon_name":"envira","icon_prefix":"fab","icon_category":"brands","unicode":"f299"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_linode_brand', 'Linode', 2772, true, '{"icon_name":"linode","icon_prefix":"fab","icon_category":"brands","unicode":"f2b8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_accusoft_brand', 'Accusoft', 2773, true, '{"icon_name":"accusoft","icon_prefix":"fab","icon_category":"brands","unicode":"f369"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_erlang_brand', 'Erlang', 2774, true, '{"icon_name":"erlang","icon_prefix":"fab","icon_category":"brands","unicode":"f39d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-discover_brand', 'Cc Discover', 2775, true, '{"icon_name":"cc-discover","icon_prefix":"fab","icon_category":"brands","unicode":"f1f2"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_safari_brand', 'Safari', 2776, true, '{"icon_name":"safari","icon_prefix":"fab","icon_category":"brands","unicode":"f267"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_space-awesome_brand', 'Space Awesome', 2777, true, '{"icon_name":"space-awesome","icon_prefix":"fab","icon_category":"brands","unicode":"e5ac"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_node_brand', 'Node', 2778, true, '{"icon_name":"node","icon_prefix":"fab","icon_category":"brands","unicode":"f419"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_codepen_brand', 'Codepen', 2779, true, '{"icon_name":"codepen","icon_prefix":"fab","icon_category":"brands","unicode":"f1cb"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_ravelry_brand', 'Ravelry', 2780, true, '{"icon_name":"ravelry","icon_prefix":"fab","icon_category":"brands","unicode":"f2d9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_alipay_brand', 'Alipay', 2781, true, '{"icon_name":"alipay","icon_prefix":"fab","icon_category":"brands","unicode":"f642"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-amex_brand', 'Cc Amex', 2782, true, '{"icon_name":"cc-amex","icon_prefix":"fab","icon_category":"brands","unicode":"f1f3"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_pied-piper-alt_brand', 'Pied Piper Alt', 2783, true, '{"icon_name":"pied-piper-alt","icon_prefix":"fab","icon_category":"brands","unicode":"f1a8"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_letterboxd_brand', 'Letterboxd', 2784, true, '{"icon_name":"letterboxd","icon_prefix":"fab","icon_category":"brands","unicode":"e62d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_opera_brand', 'Opera', 2785, true, '{"icon_name":"opera","icon_prefix":"fab","icon_category":"brands","unicode":"f26a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_weibo_brand', 'Weibo', 2786, true, '{"icon_name":"weibo","icon_prefix":"fab","icon_category":"brands","unicode":"f18a"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_readme_brand', 'Readme', 2787, true, '{"icon_name":"readme","icon_prefix":"fab","icon_category":"brands","unicode":"f4d5"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_golang_brand', 'Golang', 2788, true, '{"icon_name":"golang","icon_prefix":"fab","icon_category":"brands","unicode":"e40f"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_stack-exchange_brand', 'Stack Exchange', 2789, true, '{"icon_name":"stack-exchange","icon_prefix":"fab","icon_category":"brands","unicode":"f18d"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gulp_brand', 'Gulp', 2790, true, '{"icon_name":"gulp","icon_prefix":"fab","icon_category":"brands","unicode":"f3ae"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_yelp_brand', 'Yelp', 2791, true, '{"icon_name":"yelp","icon_prefix":"fab","icon_category":"brands","unicode":"f1e9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_gofore_brand', 'Gofore', 2792, true, '{"icon_name":"gofore","icon_prefix":"fab","icon_category":"brands","unicode":"f3a7"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_aviato_brand', 'Aviato', 2793, true, '{"icon_name":"aviato","icon_prefix":"fab","icon_category":"brands","unicode":"f421"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_padlet_brand', 'Padlet', 2794, true, '{"icon_name":"padlet","icon_prefix":"fab","icon_category":"brands","unicode":"e4a0"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_edge-legacy_brand', 'Edge Legacy', 2795, true, '{"icon_name":"edge-legacy","icon_prefix":"fab","icon_category":"brands","unicode":"e078"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-lastfm_brand', 'Square Lastfm', 2796, true, '{"icon_name":"square-lastfm","icon_prefix":"fab","icon_category":"brands","unicode":"f203"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_lastfm-square_brand', 'Lastfm Square', 2797, true, '{"icon_name":"lastfm-square","icon_prefix":"fab","icon_category":"brands","unicode":"f203"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_goodreads-g_brand', 'Goodreads G', 2798, true, '{"icon_name":"goodreads-g","icon_prefix":"fab","icon_category":"brands","unicode":"f3a9"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_cc-mastercard_brand', 'Cc Mastercard', 2799, true, '{"icon_name":"cc-mastercard","icon_prefix":"fab","icon_category":"brands","unicode":"f1f1"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_discourse_brand', 'Discourse', 2800, true, '{"icon_name":"discourse","icon_prefix":"fab","icon_category":"brands","unicode":"f393"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_black-tie_brand', 'Black Tie', 2801, true, '{"icon_name":"black-tie","icon_prefix":"fab","icon_category":"brands","unicode":"f27e"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_square-facebook_brand', 'Square Facebook', 2802, true, '{"icon_name":"square-facebook","icon_prefix":"fab","icon_category":"brands","unicode":"f082"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_facebook-square_brand', 'Facebook Square', 2803, true, '{"icon_name":"facebook-square","icon_prefix":"fab","icon_category":"brands","unicode":"f082"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_battle-net_brand', 'Battle Net', 2804, true, '{"icon_name":"battle-net","icon_prefix":"fab","icon_category":"brands","unicode":"f835"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, metadata)
SELECT id, 'icon_bimobject_brand', 'Bimobject', 2805, true, '{"icon_name":"bimobject","icon_prefix":"fab","icon_category":"brands","unicode":"f378"}'::jsonb
FROM option_sets WHERE name = 'icon_library';

-- Create indexes for fast icon lookups
CREATE INDEX IF NOT EXISTS idx_option_values_icon_category ON option_values ((metadata->>'icon_category'));
CREATE INDEX IF NOT EXISTS idx_option_values_icon_prefix ON option_values ((metadata->>'icon_prefix'));
