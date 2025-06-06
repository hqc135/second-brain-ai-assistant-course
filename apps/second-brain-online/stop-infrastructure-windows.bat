@echo off
echo ===============================================
echo  Second Brain AI Assistant Online - Stop Infrastructure
echo  停止基础设施服务
echo ===============================================
echo.

echo 正在停止Docker基础设施...
docker compose -f ../infrastructure/docker/docker-compose.yml stop

if %errorlevel% equ 0 (
    echo.
    echo ✅ 基础设施已停止!
) else (
    echo.
    echo ❌ 停止基础设施时出现错误
)

pause
