#!/bin/bash

# Migration script to create user_navigation table on Railway
# This script connects to your Railway PostgreSQL database and runs the schema

echo "========================================"
echo "User Navigation Table Migration"
echo "========================================"
echo ""

# Check if psql is installed
if ! command -v psql &> /dev/null; then
    echo "❌ Error: psql is not installed"
    echo "Please install PostgreSQL client: sudo apt-get install postgresql-client"
    exit 1
fi

# Check for DATABASE_URL
if [ -z "$DATABASE_URL" ]; then
    echo "❌ Error: DATABASE_URL environment variable is not set"
    echo ""
    echo "To set it, get your DATABASE_URL from Railway:"
    echo "1. Go to Railway Dashboard → api-server service"
    echo "2. Click on PostgreSQL database"
    echo "3. Go to Variables tab"
    echo "4. Copy the DATABASE_URL value"
    echo "5. Run: export DATABASE_URL='your-database-url-here'"
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "📊 Database: ${DATABASE_URL%%@*}@***"
echo ""
echo "Running migration..."
echo ""

# Run the migration
psql "$DATABASE_URL" -f database/user_navigation_schema.sql

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Migration completed successfully!"
    echo ""
    echo "Verifying table exists..."
    psql "$DATABASE_URL" -c "\d user_navigation"
    echo ""
    echo "✅ user_navigation table is ready!"
else
    echo ""
    echo "❌ Migration failed. Please check the error messages above."
    exit 1
fi
