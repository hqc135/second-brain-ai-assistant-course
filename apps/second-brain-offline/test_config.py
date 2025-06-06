#!/usr/bin/env python3
"""
测试配置文件的Python脚本
"""
import os
from dotenv import load_dotenv

def test_config():
    # 加载环境变量
    load_dotenv()
    
    # 检查必需的环境变量
    required_vars = ['OPENAI_API_KEY', 'HUGGINGFACE_ACCESS_TOKEN']
    missing_vars = []
    
    print("检查环境变量:")
    print("-" * 30)
    
    for var in required_vars:
        value = os.getenv(var)
        if not value or value.strip() == '':
            missing_vars.append(var)
            print(f'❌ {var}: 未设置或为空')
        else:
            # 只显示前几个字符以保护隐私
            masked_value = value[:8] + '...' if len(value) > 8 else value
            print(f'✓ {var}: {masked_value} (已设置)')
    
    print()
    
    if missing_vars:
        print(f'错误: 以下环境变量缺失或为空: {missing_vars}')
        print('请运行: .\\setup-api-keys-windows.bat 来配置这些变量')
        return False
    else:
        print('✓ 所有必需的环境变量都已正确设置!')
        return True

if __name__ == "__main__":
    success = test_config()
    exit(0 if success else 1)
