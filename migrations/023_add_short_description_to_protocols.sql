-- Add short_description column to tbl_matrix_protocols
ALTER TABLE tbl_matrix_protocols
ADD COLUMN short_description TEXT;

-- Update existing protocols with sample short descriptions
UPDATE tbl_matrix_protocols
SET short_description = 'The starting point for all new matrix formations.'
WHERE protocol_key = 'GENESIS';

UPDATE tbl_matrix_protocols
SET short_description = 'Execute strategic campaigns for growth.'
WHERE protocol_key = 'CAMPAIGN';

UPDATE tbl_matrix_protocols
SET short_description = 'Advanced validation logic for secure operations.'
WHERE protocol_key = 'VALIDATION';
