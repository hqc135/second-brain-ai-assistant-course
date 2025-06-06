@echo off
REM filepath: c:\AI Learner\second-brain-ai-assistant-course\apps\second-brain-offline\test-config-windows.bat
echo ========================================
echo  测试 Second Brain AI Assistant 配置
echo ========================================
echo.

echo 正在测试环境配置...
echo.

REM 检查Python环境
echo 1. 检查 Python 环境:
uv --version
if %errorlevel% neq 0 (
    echo 错误: uv 未安装或不可用
    echo 请安装 uv: https://docs.astral.sh/uv/getting-started/installation/
    pause
    exit /b 1
)
echo ✓ uv 已安装
echo.

REM 检查.env文件
echo 2. 检查 .env 文件:
if not exist ".env" (
    echo 错误: .env 文件不存在
    echo 请运行: .\setup-api-keys-windows.bat
    pause
    exit /b 1
)
echo ✓ .env 文件存在
echo.

REM 测试配置加载
echo 3. 测试配置加载:
echo 正在验证 API 密钥设置...
echo.

uv run python test_config.py

if %errorlevel% neq 0 (
    echo.
    echo 配置测试失败！请检查您的 .env 文件设置。
    echo 运行 .\setup-api-keys-windows.bat 获取帮助。
    pause
    exit /b 1
)

echo.
echo ========================================
echo ✓ 配置测试成功！
echo ========================================
echo.
echo 您现在可以运行以下命令:
echo - .\download-notion-dataset-windows.bat
echo - .\generate-dataset-pipeline-windows.bat
echo.

pause
