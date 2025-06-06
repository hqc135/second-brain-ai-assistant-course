#!/usr/bin/env python3
"""
测试OpenAI API连接的Python脚本
"""
import os
from dotenv import load_dotenv

def test_openai_connection():
    # 加载环境变量
    load_dotenv()
    
    api_key = os.getenv('OPENAI_API_KEY')
    base_url = os.getenv('OPENAI_BASE_URL')
    
    if not api_key:
        print("❌ OPENAI_API_KEY 未设置")
        return False
    
    print(f"🔑 API密钥: {api_key[:8]}...")
    print(f"🌐 基础URL: {base_url}")
    print()
    
    try:
        # 尝试导入和使用openai库
        try:
            from openai import OpenAI
        except ImportError:
            print("⚠️  openai库未安装，正在尝试安装...")
            import subprocess
            subprocess.check_call(['pip', 'install', 'openai'])
            from openai import OpenAI
        
        # 创建OpenAI客户端
        client = OpenAI(
            api_key=api_key,
            base_url=base_url
        )
        
        print("📡 正在测试API连接...")
        
        # 发送一个简单的测试请求
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "user", "content": "Hello, this is a test message. Please respond with 'API connection successful!'"}
            ],
            max_tokens=50
        )
        
        response_text = response.choices[0].message.content
        print(f"✅ API连接成功!")
        print(f"📝 响应: {response_text}")
        return True
        
    except Exception as e:
        print(f"❌ API连接失败: {str(e)}")
        print()
        print("可能的解决方案:")
        print("1. 检查您的API密钥是否正确")
        print("2. 确认代理服务商的URL是否正确")
        print("3. 检查网络连接")
        print("4. 确认API密钥有足够的余额")
        return False

if __name__ == "__main__":
    success = test_openai_connection()
    exit(0 if success else 1)
