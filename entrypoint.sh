#!/bin/sh

# Wait for PostgreSQL to be ready
if [ "$DATABASE" = "postgres" ]; then
    echo "Waiting for PostgreSQL to start..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 0.1
    done

    echo "PostgreSQL started"
fi

# Verify DATABASE_URL
if [ -z "$DATABASE_URL" ]; then
    echo "Error: DATABASE_URL is not set. Please configure it in your environment."
    exit 1
fi

# Check if Alembic migrations directory exists
if [ ! -d "./migrations" ]; then
    echo "No migrations directory found. Initializing Alembic..."
    alembic init migrations

    echo "Configuring Alembic..."
    if [ -f "./migrations/alembic.ini" ]; then
        sed -i "s#sqlalchemy.url = .*#sqlalchemy.url = '${DATABASE_URL}'#" migrations/alembic.ini
    else
        echo "Error: alembic.ini file not found in migrations directory"
        exit 1
    fi

fi

# Check if any migration files exist
if [ -z "$(ls -A migrations/versions/ 2>/dev/null)" ]; then
    echo "No migration files found. Creating an initial migration..."
    alembic revision --autogenerate -m "Initial migration"
fi

# Apply migrations
echo "Applying migrations..."
alembic upgrade head || {
    echo "Error: Failed to apply migrations"
    exit 1
}

# Start the FastAPI application
exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
