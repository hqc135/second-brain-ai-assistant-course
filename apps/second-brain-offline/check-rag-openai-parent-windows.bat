@echo off
echo ===============================================
echo  Second Brain AI Assistant - RAG查询测试
echo  测试OpenAI Parent策略的RAG检索
echo ===============================================
echo.

REM 检查当前目录
if not exist "pyproject.toml" (
    echo 错误: 请在 second-brain-offline 目录中运行此脚本
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

echo 什么是RAG查询测试?
echo.
echo 这个脚本将测试您构建的RAG向量索引是否工作正常。
echo 它会：
echo 1. 连接到MongoDB向量数据库
echo 2. 执行示例查询
echo 3. 检索相关文档片段
echo 4. 展示检索结果
echo.

echo 正在运行RAG查询测试...
echo.

uv run python -m tools.rag --config ./configs/compute_rag_vector_index_openai_parent.yaml

if %errorlevel% equ 0 (
    echo.
    echo ✅ RAG查询测试成功!
    echo 您的向量索引工作正常，可以开始使用AI助手了。
) else (
    echo.
    echo ❌ RAG查询测试失败!
    echo 请确保：
    echo 1. 已运行 compute-rag-vector-index-openai-parent-windows.bat
    echo 2. MongoDB正在运行
    echo 3. 向量索引已成功构建
)

echo.
pause
