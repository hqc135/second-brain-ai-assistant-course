@echo off
echo Starting Docker infrastructure for Second Brain AI Assistant...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Docker is not running or not installed.
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)

REM Check if port 27017 is already in use
netstat -an | findstr :27017 >nul
if %errorlevel% equ 0 (
    echo Warning: Port 27017 is already in use.
    echo Please stop any existing MongoDB service and try again.
    pause
    exit /b 1
)

echo Starting MongoDB container...
cd /d "%~dp0apps\infrastructure\docker"
docker compose up --build -d

if %errorlevel% equ 0 (
    echo.
    echo ✅ Infrastructure started successfully!
    echo MongoDB is now running on port 27017
    echo.
    echo Connection details:
    echo - Host: localhost:27017
    echo - Username: decodingml
    echo - Password: decodingml
    echo - Database: secondbrain
    echo.
    echo To stop the infrastructure, run: stop-infrastructure-windows.bat
) else (
    echo.
    echo ❌ Failed to start infrastructure
    echo Please check Docker logs for more information
)

pause
