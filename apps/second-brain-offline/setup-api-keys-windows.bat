@echo off
REM filepath: c:\AI Learner\second-brain-ai-assistant-course\apps\second-brain-offline\setup-api-keys-windows.bat
echo ========================================
echo  Second Brain AI Assistant - API设置助手
echo ========================================
echo.

echo 当前 .env 文件状态检查:
echo.

REM 检查.env文件是否存在
if not exist ".env" (
    echo 错误: .env 文件不存在!
    echo 正在从 .env.example 创建 .env 文件...
    copy .env.example .env
    echo .env 文件已创建。
    echo.
)

REM 显示当前OPENAI_API_KEY设置
echo 当前的 OPENAI_API_KEY 设置:
findstr "OPENAI_API_KEY=" .env
echo.

echo 问题诊断:
echo -----------
echo 1. 检查您的 OpenAI API 密钥格式
echo    正确格式应该是: sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo    长度通常为51个字符，以 "sk-" 开头
echo.
echo 2. 如果您使用的是代理API服务:
echo    - 确保API密钥格式与服务提供商要求一致
echo    - 确保 OPENAI_BASE_URL 设置正确
echo.
echo 3. 常见解决方案:
echo    a) 获取新的 OpenAI API 密钥:
echo       - 访问: https://platform.openai.com/account/api-keys
echo       - 创建新密钥并复制完整内容
echo.
echo    b) 如果使用代理服务:
echo       - 确认您的代理服务商提供的密钥格式
echo       - 确认基础URL设置正确
echo.

echo 当前 OPENAI_BASE_URL 设置:
findstr "OPENAI_BASE_URL=" .env
echo.

echo ========================================
echo  手动编辑 .env 文件
echo ========================================
echo.
echo 请按照以下步骤操作:
echo.
echo 1. 使用记事本或其他文本编辑器打开 .env 文件
echo 2. 找到 OPENAI_API_KEY= 这一行
echo 3. 将等号后面的内容替换为您的有效API密钥
echo 4. 保存文件
echo.
echo 示例:
echo OPENAI_API_KEY=sk-your_actual_api_key_here
echo.

set /p choice="是否现在打开 .env 文件进行编辑? (y/n): "
if /i "%choice%"=="y" (
    echo 正在打开 .env 文件...
    notepad .env
)

echo.
echo ========================================
echo  测试API密钥设置
echo ========================================
echo.
echo 编辑完成后，您可以运行以下命令测试配置:
echo.
echo 测试命令: .\test-config-windows.bat
echo.

pause
