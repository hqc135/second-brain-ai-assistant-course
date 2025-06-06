@echo off
echo ===============================================
echo  Second Brain AI Assistant Online - Query Test
echo  运行查询测试
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
)

echo 正在运行查询测试...
echo 配置文件: %RETRIEVER_CONFIG%
echo 测试查询: "What's the difference between vector databases and vector indices?"
echo.

uv run python -m tools.app --retriever-config-path=%RETRIEVER_CONFIG% --query "What's the difference between vector databases and vector indices?"

echo.
echo 查询完成!
pause
