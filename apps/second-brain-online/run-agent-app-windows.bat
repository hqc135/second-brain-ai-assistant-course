@echo off
echo ===============================================
echo  Second Brain AI Assistant Online - Run Agent App
echo  启动AI助手应用 (带Web界面)
echo ===============================================
echo.

REM 检查当前目录
if not exist "pyproject.toml" (
    echo 错误: 请在 second-brain-online 目录中运行此脚本
    pause
    exit /b 1
)

REM 设置默认配置文件
set RETRIEVER_CONFIG=configs/compute_rag_vector_index_openai_parent.yaml

REM 检查配置文件是否存在
if not exist "%RETRIEVER_CONFIG%" (
    echo 错误: 检索器配置文件 '%RETRIEVER_CONFIG%' 不存在
    pause
    exit /b 1
) else (
    echo 找到配置文件: %RETRIEVER_CONFIG%
)

echo.
echo 正在启动AI助手应用...
echo 配置文件: %RETRIEVER_CONFIG%
echo 界面: Web UI
echo.
echo 注意: 应用启动后，请在浏览器中打开显示的URL
echo.

REM 设置 Python 路径和环境
set PYTHONPATH=.
set UV_PROJECT_ENVIRONMENT=.venv-online

uv run python -m tools.app --retriever-config-path=%RETRIEVER_CONFIG% --ui

pause
