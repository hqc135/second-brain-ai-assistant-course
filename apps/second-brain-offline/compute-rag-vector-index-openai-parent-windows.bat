@echo off
echo ===============================================
echo  Second Brain AI Assistant - RAG Vector Index
echo  使用OpenAI Parent策略构建向量索引
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

echo 什么是RAG向量索引?
echo.
echo RAG向量索引用于将文档转换为向量嵌入，以便进行相似性搜索。
echo 该管道将：
echo 1. 读取MongoDB中的文档
echo 2. 使用OpenAI模型生成嵌入向量
echo 3. 使用Parent Document策略进行分块
echo 4. 将向量索引存储到MongoDB向量数据库中
echo.

echo 预计执行时间: 10-30分钟（取决于文档数量和网络速度）
echo.

set /p confirm=确认开始构建RAG向量索引? (y/N): 
if /i not "%confirm%"=="y" (
    echo 操作已取消
    pause
    exit /b 0
)

echo.
echo ===========================================
echo  开始构建RAG向量索引...
echo ===========================================
echo.

echo 正在运行: uv run python -m tools.run --run-compute-rag-vector-index-openai-parent-pipeline --no-cache
echo.

uv run python -m tools.run --run-compute-rag-vector-index-openai-parent-pipeline --no-cache

if %errorlevel% equ 0 (
    echo.
    echo ✅ RAG向量索引构建成功!
    echo.
    echo 向量索引已保存到MongoDB中，您现在可以：
    echo 1. 运行RAG查询测试: check-rag-openai-parent-windows.bat
    echo 2. 开始使用AI助手进行问答
    echo.
) else (
    echo.
    echo ❌ RAG向量索引构建失败!
    echo 请检查上面的错误信息
    echo.
    echo 常见问题:
    echo - 确保MongoDB正在运行
    echo - 确保OpenAI API密钥有效
    echo - 确保已完成ETL管道（运行过etl-pipeline-windows.bat）
)

echo.
pause
