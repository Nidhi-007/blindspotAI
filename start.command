#!/usr/bin/env bash
# BlindSpot AI macOS Finder One-Click Launcher

set -e

# Change directory to the folder where this script lives
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "=========================================================="
echo " Starting BlindSpot AI — Discovery & Risk Platform"
echo "=========================================================="

# Check if venv exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment and installing backend packages..."
    python3 -m venv venv
    ./venv/bin/pip install -r backend/requirements.txt
fi

# Ensure demo data is seeded
echo "Ensuring demonstration database is initialized..."
PYTHONPATH=backend ./venv/bin/python backend/app/seed.py

# Check if node_modules exists
if [ ! -d "frontend/node_modules" ]; then
    echo "Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

cleanup() {
    echo ""
    echo "Shutting down BlindSpot AI services..."
    kill $(jobs -p) 2>/dev/null || true
}
trap cleanup EXIT

echo "Starting Backend API on http://localhost:8000..."
PYTHONPATH=backend ./venv/bin/uvicorn app.main:app --host 127.0.0.1 --port 8000 &

echo "Starting Frontend Development Server on http://localhost:5173..."
cd frontend
npm run dev -- --host 127.0.0.1 &
cd ..

# Automatically open the web browser after 2 seconds
(sleep 2 && open http://localhost:5173) &

echo ""
echo "=========================================================="
echo " BlindSpot AI is running!"
echo " Web UI:   http://localhost:5173"
echo " API Docs: http://localhost:8000/docs"
echo "=========================================================="
echo "Keep this Terminal window open while using the app."
echo "Close this window or press Ctrl+C to stop the servers."

wait
