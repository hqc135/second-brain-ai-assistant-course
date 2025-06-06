@echo off
echo Starting Second Brain AI Assistant Infrastructure on Windows...
echo.

REM Check if Docker is running
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Docker is not running or not installed.
    echo Please make sure Docker Desktop is installed and running.
    pause
    exit /b 1
)

echo Step 1: Starting Docker infrastructure...
docker compose -f ../infrastructure/docker/docker-compose.yml up --build -d
if %errorlevel% neq 0 (
    echo Error: Failed to start Docker infrastructure.
    pause
    exit /b 1
)

echo Step 2: Stopping local ZenML server (if running)...
uv run zenml logout --local

echo Step 3: Starting local ZenML server...
uv run zenml login --local
if %errorlevel% neq 0 (
    echo Error: Failed to start ZenML server.
    echo Note: This might be normal if ZenML is not yet configured.
)

echo.
echo Infrastructure startup complete!
echo MongoDB is running on localhost:27017
echo - Username: decodingml
echo - Password: decodingml
echo.
pause
