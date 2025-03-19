-- RevoU Auto Garage - Complete Setup Script
-- This file runs all necessary scripts in the correct order

-- First, set up the database schema
\i schema.sql

-- Then, load the sample data
\i sample_data.sql

-- Run some example queries (uncomment to run)
-- \i queries.sql

-- Success message
SELECT 'RevoU Auto Garage database setup complete!' AS status;
