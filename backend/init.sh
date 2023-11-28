#!/bin/bash

set -x # Exit on error

echo "Starting init file"

npm install db-migrate-pg
# Run the database migration
echo "Running db-migrate..."
npx db-migrate up all

echo "Script completed successfully."

echo "Starting server..."
node app.js
