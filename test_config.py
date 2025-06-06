#!/usr/bin/env python3
"""
测试脚本：验证OpenAI API中转服务配置是否正确
"""

import os
import sys
from pathlib import Path

# 获取当前脚本的目录
current_dir = Path(__file__).parent

def test_env_files():
    """检查环境文件是否存在"""
    offline_env = current_dir / "apps" / "second-brain-offline" / ".env"
    online_env = current_dir / "apps" / "second-brain-online" / ".env"
    
    print(f"离线应用.env文件: {'✅ 存在' if offline_env.exists() else '❌ 不存在'}")
    if offline_env.exists():
        print(f"   路径: {offline_env}")
        with open(offline_env, 'r', encoding='utf-8') as f:
            content = f.read()
            if 'OPENAI_BASE_URL' in content:
                print("   ✅ 包含 OPENAI_BASE_URL 配置")
                for line in content.split('\n'):
                    if 'OPENAI_BASE_URL' in line:
                        print(f"   {line}")
            else:
                print("   ❌ 缺少 OPENAI_BASE_URL 配置")
    
    print(f"在线应用.env文件: {'✅ 存在' if online_env.exists() else '❌ 不存在'}")
    if online_env.exists():
        print(f"   路径: {online_env}")
        with open(online_env, 'r', encoding='utf-8') as f:
            content = f.read()
            if 'OPENAI_BASE_URL' in content:
                print("   ✅ 包含 OPENAI_BASE_URL 配置")
                for line in content.split('\n'):
                    if 'OPENAI_BASE_URL' in line:
                        print(f"   {line}")
            else:
                print("   ❌ 缺少 OPENAI_BASE_URL 配置")
    
    return offline_env.exists(), online_env.exists()

def test_config_files():
    """检查配置文件是否已修改"""
    config_files = [
        current_dir / "apps" / "second-brain-offline" / "src" / "second_brain_offline" / "config.py",
        current_dir / "apps" / "second-brain-online" / "src" / "second_brain_online" / "config.py",
    ]
    
    for config_file in config_files:
        if config_file.exists():
            print(f"✅ 配置文件存在: {config_file.name}")
            with open(config_file, 'r', encoding='utf-8') as f:
                content = f.read()
                if 'OPENAI_BASE_URL' in content:
                    print("   ✅ 包含 OPENAI_BASE_URL 字段")
                else:
                    print("   ❌ 缺少 OPENAI_BASE_URL 字段")
        else:
            print(f"❌ 配置文件不存在: {config_file}")

def check_code_modifications():
    """检查代码修改"""
    modified_files = [
        current_dir / "apps" / "second-brain-online" / "src" / "second_brain_online" / "application" / "agents" / "agents.py",
        current_dir / "apps" / "second-brain-offline" / "tools" / "rag.py",
    ]
    
    for file_path in modified_files:
        if file_path.exists():
            print(f"✅ 代码文件存在: {file_path.name}")
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                if 'settings.OPENAI_BASE_URL' in content:
                    print("   ✅ 使用了 settings.OPENAI_BASE_URL")
                elif 'https://api.openai.com' in content:
                    print("   ⚠️ 仍包含硬编码的OpenAI URL")
                else:
                    print("   ❓ 无法确定状态")
        else:
            print(f"❌ 代码文件不存在: {file_path}")

if __name__ == "__main__":
    print("🔧 开始测试OpenAI API中转服务配置...")
    print("-" * 50)
    
    # 检查环境文件
    print("1. 检查环境配置文件:")
    offline_env_exists, online_env_exists = test_env_files()
    print("-" * 30)
    
    # 检查配置类文件
    print("2. 检查配置类文件:")
    test_config_files()
    print("-" * 30)
    
    # 检查代码修改
    print("3. 检查代码修改:")
    check_code_modifications()
    print("-" * 50)
    
    if offline_env_exists and online_env_exists:
        print("🎉 配置文件检查完成！请手动验证API调用是否正常工作。")
        print("\n📋 下一步:")
        print("1. 进入 apps/second-brain-offline 目录")
        print("2. 激活虚拟环境")
        print("3. 运行 make local-infrastructure-up")
        print("4. 测试API调用")
    else:
        print("⚠️ 部分配置文件缺失，请检查上述输出。")
