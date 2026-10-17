#!/usr/bin/env bash
# BlindSpot AI All-in-One Startup Script

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "=========================================================="
echo " Starting BlindSpot AI — Discovery & Risk Platform"
echo "=========================================================="

# Check if venv exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
    ./venv/bin/pip install -r backend/requirements.txt
fi

# Seed initial demonstration data
echo "Ensuring demo data is seeded..."
PYTHONPATH=backend ./venv/bin/python backend/app/seed.py

# Check if node_modules exists
if [ ! -d "frontend/node_modules" ]; then
    echo "Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

# Function to kill child processes on exit
cleanup() {
    echo ""
    echo "Shutting down BlindSpot AI services..."
    kill $(jobs -p) 2>/dev/null || true
}
trap cleanup EXIT

echo "Starting Backend API on http://localhost:8000..."
PYTHONPATH=backend ./venv/bin/uvicorn app.main:app --host 0.0.0.0 --port 8000 &

echo "Starting Frontend Development Server on http://localhost:5173..."
cd frontend
npm run dev -- --host 0.0.0.0 &
cd ..

echo ""
echo "=========================================================="
echo " BlindSpot AI is live!"
echo " Web UI:  http://localhost:5173"
echo " API Docs: http://localhost:8000/docs"
echo "=========================================================="
echo "Press Ctrl+C to stop all servers."

wait
