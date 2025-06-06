@echo off
echo Stopping Docker infrastructure for Second Brain AI Assistant...
echo.

cd /d "%~dp0apps\infrastructure\docker"
docker compose down

if %errorlevel% equ 0 (
    echo.
    echo ✅ Infrastructure stopped successfully!
    echo All containers have been removed.
) else (
    echo.
    echo ❌ Failed to stop infrastructure
    echo Please check Docker logs for more information
)

pause
