@echo off
REM filepath: c:\AI Learner\second-brain-ai-assistant-course\apps\second-brain-offline\generate-dataset-pipeline-windows.bat
echo Running Generate Dataset Pipeline for Second Brain AI Assistant...
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

echo Starting generate dataset pipeline...
echo This pipeline will:
echo 1. Fetch documents from MongoDB
echo 2. Generate summarization dataset using AI
echo 3. Save the dataset locally and push to Hugging Face
echo.
echo NOTE: This requires valid OPENAI_API_KEY in your .env file
echo Running costs: ~$1.5
echo Running time: ~60 minutes
echo.

echo Running command: uv run python -m tools.run --run-generate-dataset-pipeline --no-cache
uv run python -m tools.run --run-generate-dataset-pipeline --no-cache

if %errorlevel% neq 0 (
    echo.
    echo Error: Generate dataset pipeline failed!
    echo.
    echo Common issues and solutions:
    echo 1. OPENAI_API_KEY not set or invalid
    echo    - Check your .env file
    echo    - Ensure your OpenAI API key is valid and has sufficient credits
    echo.
    echo 2. MongoDB not running
    echo    - Run: start-infrastructure-windows.bat
    echo.
    echo 3. No data in MongoDB
    echo    - Run ETL pipeline first using: etl-pipeline-windows.bat
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo Generate Dataset Pipeline completed successfully!
echo ============================================================
echo.
echo The fine-tuning dataset has been generated and should be available:
echo - Locally in: data/datasets/
echo - On Hugging Face (if configured)
echo.
echo You can now proceed with:
echo 1. Training the model (Module 4)
echo 2. Setting up RAG vector index (Module 5)
echo.
pause
