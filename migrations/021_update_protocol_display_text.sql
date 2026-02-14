-- Migration: 021_update_protocol_display_text.sql
-- Purpose: Update display_name and display_description with creative, non-jargon names and Markdown descriptions

-- GENESIS -> The Origin
UPDATE tbl_matrix_protocols 
SET 
    display_name = 'The Origin',
    display_description = '**Spark of Life**\n\nWhere it all begins. Define the core vision and breathe life into the concept. This is the moment of creation.'
WHERE protocol_key = 'GENESIS';

-- CAMPAIGN -> The Surge
UPDATE tbl_matrix_protocols 
SET 
    display_name = 'The Surge',
    display_description = '**Momentum & Impact**\n\nUnleash the potential. Drive growth, amplify the message, and accelerated execution. It''s time to move fast.'
WHERE protocol_key = 'CAMPAIGN';

-- VALIDATION -> The Truth
UPDATE tbl_matrix_protocols 
SET 
    display_name = 'The Truth',
    display_description = '**Clarity & Proof**\n\nAlign with reality. verify results, ensure quality, and refine the strategy. Precision matters.'
WHERE protocol_key = 'VALIDATION';
