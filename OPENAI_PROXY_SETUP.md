# OpenAI API 中转服务配置修改总结

## 📋 修改概述

本次修改将项目中所有OpenAI API调用的base_url从默认的 `https://api.openai.com/v1` 更改为中转服务地址 `https://api.gptsapi.net/v1`。

## 🔧 修改的文件列表

### 1. 环境配置文件
- `apps/second-brain-offline/.env` - 添加了 `OPENAI_BASE_URL=https://api.gptsapi.net/v1`
- `apps/second-brain-online/.env` - 新建文件，包含完整的环境配置
- `workshops/rag/solution/.env` - 新建文件
- `workshops/rag/template/.env` - 新建文件

### 2. 配置类文件
- `apps/second-brain-offline/src/second_brain_offline/config.py` - 添加 `OPENAI_BASE_URL` 字段
- `apps/second-brain-online/src/second_brain_online/config.py` - 添加 `OPENAI_BASE_URL` 字段
- `workshops/rag/solution/src/rag_workshop/config.py` - 添加 `OPENAI_BASE_URL` 字段
- `workshops/rag/template/src/rag_workshop/config.py` - 添加 `OPENAI_BASE_URL` 字段

### 3. OpenAI客户端初始化文件
- `apps/second-brain-online/src/second_brain_online/application/agents/agents.py` - 修改 LiteLLMModel 的 api_base
- `apps/second-brain-online/src/second_brain_online/application/agents/tools/summarizer.py` - 修改 OpenAI 客户端的 base_url
- `apps/second-brain-offline/tools/rag.py` - 修改 ChatOpenAI 的配置
- `apps/second-brain-offline/src/second_brain_offline/application/agents/contextual_summarization.py` - 修改 AsyncOpenAI 客户端
- `workshops/rag/solution/src/rag_workshop/agents.py` - 修改 LiteLLMModel 的 api_base
- `workshops/rag/solution/src/rag_workshop/generation.py` - 修改 ChatOpenAI 的配置

### 4. 嵌入模型文件
- `apps/second-brain-offline/src/second_brain_offline/application/rag/embeddings.py` - 修改 OpenAIEmbeddings 配置
- `apps/second-brain-online/src/second_brain_online/application/rag/embeddings.py` - 修改 OpenAIEmbeddings 配置

## 📝 具体修改内容

### 环境变量配置
```env
# 原来
OPENAI_API_KEY=your_key_here

# 修改后
OPENAI_API_KEY=your_key_here
OPENAI_BASE_URL=https://api.gptsapi.net/v1
```

### 配置类修改
```python
# 添加到 Settings 类中
OPENAI_BASE_URL: str = Field(
    default="https://api.openai.com/v1",
    description="Base URL for OpenAI API service.",
)
```

### 客户端初始化修改
```python
# 原来
OpenAI()
# 或
OpenAI(base_url="https://api.openai.com/v1")

# 修改后
OpenAI(
    base_url=settings.OPENAI_BASE_URL,
    api_key=settings.OPENAI_API_KEY,
)
```

### LangChain ChatOpenAI 修改
```python
# 原来
ChatOpenAI(temperature=0, model="gpt-4o")

# 修改后
ChatOpenAI(
    temperature=0, 
    model="gpt-4o",
    base_url=settings.OPENAI_BASE_URL,
    api_key=settings.OPENAI_API_KEY
)
```

### LiteLLMModel 修改
```python
# 原来
LiteLLMModel(
    model_id=settings.OPENAI_MODEL_ID,
    api_base="https://api.openai.com/v1",
    api_key=settings.OPENAI_API_KEY,
)

# 修改后
LiteLLMModel(
    model_id=settings.OPENAI_MODEL_ID,
    api_base=settings.OPENAI_BASE_URL,
    api_key=settings.OPENAI_API_KEY,
)
```

## ✅ 验证步骤

1. **运行配置测试脚本**：
   ```bash
   cd c:\AI Learner\second-brain-ai-assistant-course
   python test_config.py
   ```

2. **测试离线应用**：
   ```bash
   cd apps/second-brain-offline
   # 激活虚拟环境后
   python -c "from second_brain_offline.config import settings; print(f'Base URL: {settings.OPENAI_BASE_URL}')"
   ```

3. **测试在线应用**：
   ```bash
   cd apps/second-brain-online
   # 激活虚拟环境后
   python -c "from second_brain_online.config import settings; print(f'Base URL: {settings.OPENAI_BASE_URL}')"
   ```

## 🔄 回滚方案

如果需要回滚到原始OpenAI API：

1. 将所有 `.env` 文件中的 `OPENAI_BASE_URL` 改回 `https://api.openai.com/v1`
2. 或者删除 `OPENAI_BASE_URL` 环境变量（会使用默认值）

## 📋 注意事项

1. 确保中转服务 `https://api.gptsapi.net` 稳定可用
2. API密钥格式和权限需要与中转服务兼容
3. 某些模型名称可能在中转服务中有所不同，需要根据具体服务调整
4. 监控API调用成功率和响应时间
5. 定期检查中转服务的服务条款和费用

## 🎯 下一步

配置完成后，可以按照原有的运行指南启动项目：

1. 启动基础设施：`make local-infrastructure-up`
2. 运行ETL管道：`make etl-pipeline`
3. 生成数据集：`make generate-dataset-pipeline`
4. 构建RAG索引：`make compute-rag-vector-index-openai-parent-pipeline`
5. 启动AI助手：`make run_agent_app`

所有OpenAI API调用现在都会通过中转服务 `https://api.gptsapi.net` 进行。
