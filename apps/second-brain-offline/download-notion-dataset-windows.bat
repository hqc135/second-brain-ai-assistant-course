@echo off
REM filepath: c:\AI Learner\second-brain-ai-assistant-course\apps\second-brain-offline\download-notion-dataset-windows.bat
echo Downloading Notion Dataset for Second Brain AI Assistant...
echo.

REM Check if .env file exists
if not exist .env (
    echo Error: .env file is missing.
    echo Please create one based on .env.example by running:
    echo copy .env.example .env
    echo.
    echo Then edit the .env file and add your API keys.
    pause
    exit /b 1
)

REM Check if UV is available
uv --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: UV is not installed or not in PATH.
    echo Please install UV first: https://docs.astral.sh/uv/getting-started/installation/
    pause
    exit /b 1
)

echo Starting download from S3...
echo This will download the Notion dataset to the data/notion directory...
echo.

REM Execute the S3 download command
uv run python -m tools.use_s3 download decodingml-public-data second_brain_course/notion/notion.zip data/notion --no-sign-request

if %errorlevel% neq 0 (
    echo.
    echo Download failed! This might be due to:
    echo 1. Missing or invalid AWS credentials
    echo 2. Network connectivity issues
    echo 3. Missing dependencies
    echo.
    echo Note: This course uses pre-processed datasets from S3.
    echo You don't need AWS credentials if the data is publicly available.
    pause
    exit /b 1
)

echo.
echo Download completed successfully!
echo The Notion dataset is now available in the data/notion directory.
echo.
pause
