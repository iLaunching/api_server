-- Migration: 022_refine_protocol_display_text.sql
-- Purpose: update display_name and display_description to match specific business functions
-- removing "The Origin" etc and focusing on the actual utility: Idea -> Business, Campaign Running, Idea Validation.

-- GENESIS: Starting a business from idea
UPDATE tbl_matrix_protocols 
SET 
    display_name = 'Genesis',
    display_description = '## Start from Scratch\n\nTransform a raw idea into a structured business. We guide you through the foundational steps to build your vision from the ground up.'
WHERE protocol_key = 'GENESIS';

-- CAMPAIGN: Setup and running a campaign
UPDATE tbl_matrix_protocols 
SET 
    display_name = 'Campaign',
    display_description = '## Setup & Run\n\nExecute and manage your growth strategies. Access specialized workflows to launch, monitor, and optimize your marketing campaigns.'
WHERE protocol_key = 'CAMPAIGN';

-- VALIDATION: Validate an idea and start from there
UPDATE tbl_matrix_protocols 
SET 
    display_name = 'Validation',
    display_description = '## Validate Your Idea\n\nHave a concept? Put it to the test. Analyze market fit, stress-test assumptions, and verify viability before you build.'
WHERE protocol_key = 'VALIDATION';
