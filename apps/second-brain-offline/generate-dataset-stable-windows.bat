@echo off
echo ===============================================
echo  Second Brain AI Assistant - 稳定版数据集生成
echo  降低并发数以提高稳定性
echo ===============================================
echo.

REM 检查当前目录
if not exist "pyproject.toml" (
    echo 错误: 请在 second-brain-offline 目录中运行此脚本
    pause
    exit /b 1
)

echo 正在运行稳定版数据集生成管道...
echo 配置: 并发请求数=2, 增加重试延迟
echo.

REM 设置环境变量来降低并发数
set MAX_CONCURRENT_REQUESTS=2
set RETRY_DELAY=1.0

uv run python -m tools.run --run-generate-dataset-pipeline --no-cache

if %errorlevel% equ 0 (
    echo.
    echo ✅ 数据集生成完成!
    echo 生成的数据集位于输出目录中
) else (
    echo.
    echo ❌ 数据集生成失败
    echo 建议: 检查网络连接或API配额
)

pause
