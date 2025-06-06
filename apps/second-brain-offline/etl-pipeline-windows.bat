@echo off
echo ===============================================
echo  Second Brain AI Assistant - ETL Pipeline
echo  使用预计算数据集 (推荐)
echo ===============================================
echo.

REM 检查当前目录
if not exist "pyproject.toml" (
    echo 错误: 请在 second-brain-offline 目录中运行此脚本
    echo 当前目录: %CD%
    echo 正确目录: ...\second-brain-ai-assistant-course\apps\second-brain-offline
    pause
    exit /b 1
)

REM 检查 .env 文件
if not exist ".env" (
    echo 错误: .env 文件不存在
    echo 请先运行: setup-api-keys-windows.bat
    pause
    exit /b 1
)

echo 选择ETL管道类型:
echo.
echo 1. 预计算数据集管道 (推荐) - 快速且免费
echo    - 使用预先准备好的数据集
echo    - 不需要OpenAI API调用
echo    - 大约需要5-10分钟
echo.
echo 2. 完整ETL管道 - 从头开始处理
echo    - 爬取网站数据
echo    - 使用OpenAI API进行评分和处理
echo    - 需要API费用，大约需要30-60分钟
echo.
set /p choice=请选择 (1 或 2): 

if "%choice%"=="1" goto precomputed
if "%choice%"=="2" goto full
echo 无效选择，使用默认的预计算数据集管道...

:precomputed
echo.
echo ===========================================
echo  运行预计算ETL管道
echo ===========================================
echo.
echo 正在运行: uv run python -m tools.run --run-etl-precomputed-pipeline --no-cache
echo.
uv run python -m tools.run --run-etl-precomputed-pipeline --no-cache
goto end

:full
echo.
echo ===========================================
echo  运行完整ETL管道
echo ===========================================
echo.
echo 警告: 这将使用OpenAI API并产生费用!
set /p confirm=确认继续? (y/N): 
if /i not "%confirm%"=="y" (
    echo 操作已取消
    goto end
)
echo.
echo 正在运行: uv run python -m tools.run --run-etl-pipeline --no-cache
echo.
uv run python -m tools.run --run-etl-pipeline --no-cache
goto end

:end
if %errorlevel% equ 0 (
    echo.
    echo ✅ ETL管道执行成功!
    echo.
    echo 数据已加载到MongoDB:
    echo - 主机: localhost:27017
    echo - 用户名: decodingml
    echo - 密码: decodingml
    echo - 数据库: secondbrain
    echo.
    echo 您现在可以运行其他管道了:
    echo - generate-dataset-pipeline-windows.bat
    echo - 或其他分析脚本
) else (
    echo.
    echo ❌ ETL管道执行失败!
    echo 请检查上面的错误信息
)
echo.
pause
