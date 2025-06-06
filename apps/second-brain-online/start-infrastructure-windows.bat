@echo off
echo ===============================================
echo  Second Brain AI Assistant Online - Infrastructure
echo  启动基础设施服务
echo ===============================================
echo.

REM 检查当前目录
if not exist "pyproject.toml" (
    echo 错误: 请在 second-brain-online 目录中运行此脚本
    echo 当前目录: %CD%
    echo 正确目录: ...\second-brain-ai-assistant-course\apps\second-brain-online
    pause
    exit /b 1
)

REM 检查 .env 文件
if not exist ".env" (
    echo 错误: .env 文件不存在
    echo 请从 .env.example 创建 .env 文件
    echo 命令: copy .env.example .env
    pause
    exit /b 1
)

REM 检查Docker是否运行
echo 检查Docker状态...
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: Docker未运行或未安装
    echo 请确保Docker Desktop已安装并正在运行
    pause
    exit /b 1
)

echo 正在启动Docker基础设施...
echo 命令: docker compose -f ../infrastructure/docker/docker-compose.yml up --build -d
echo.

docker compose -f ../infrastructure/docker/docker-compose.yml up --build -d

if %errorlevel% equ 0 (
    echo.
    echo ✅ 基础设施启动成功!
    echo.
    echo 服务状态:
    docker compose -f ../infrastructure/docker/docker-compose.yml ps
    echo.
    echo MongoDB 连接信息:
    echo - 主机: localhost:27017
    echo - 用户名: decodingml
    echo - 密码: decodingml
    echo - 数据库: second_brain_course
    echo.
    echo 现在您可以运行:
    echo - run-agent-app-windows.bat    (启动AI助手应用)
    echo - run-agent-query-windows.bat  (查询测试)
    echo - evaluate-agent-windows.bat   (评估代理)
) else (
    echo.
    echo ❌ 基础设施启动失败!
    echo 请检查Docker状态和配置文件
)

echo.
pause
run-agent-app-windows.batrun-agent-app-windows.bat