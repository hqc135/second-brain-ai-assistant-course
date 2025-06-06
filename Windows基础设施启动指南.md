# Windows 用户基础设施启动指南

## 问题说明

在 Windows 系统上，PowerShell 默认不包含 `make` 命令，这会导致无法直接运行项目中的 `make local-infrastructure-up` 命令。

## 解决方案

我们为 Windows 用户创建了替代的批处理文件来启动和停止基础设施。

## 使用方法

### 1. 启动基础设施

双击运行以下批处理文件：
```
start-infrastructure-windows.bat
```

或者在命令行中运行：
```cmd
start-infrastructure-windows.bat
```

### 2. 停止基础设施

双击运行以下批处理文件：
```
stop-infrastructure-windows.bat
```

或者在命令行中运行：
```cmd
stop-infrastructure-windows.bat
```

## 手动运行 Docker 命令

如果你更喜欢手动运行 Docker 命令，可以使用以下命令：

### 启动 MongoDB
```cmd
cd apps\infrastructure\docker
docker compose up --build -d
```

### 停止 MongoDB
```cmd
cd apps\infrastructure\docker
docker compose down
```

## 验证服务运行状态

### 检查 Docker 容器状态
```cmd
docker ps
```

你应该看到一个名为类似 `docker_local_dev_atlas_1` 的 MongoDB 容器正在运行。

### 检查端口占用
```cmd
netstat -an | findstr :27017
```

如果 MongoDB 正在运行，你应该看到端口 27017 被占用。

## MongoDB 连接信息

启动成功后，你可以使用以下信息连接到 MongoDB：

- **主机**: localhost:27017
- **用户名**: decodingml
- **密码**: decodingml
- **数据库**: secondbrain

## 故障排除

### 1. Docker 未运行
```
Error: Docker is not running or not installed.
```
**解决方案**: 启动 Docker Desktop 并等待其完全启动。

### 2. 端口已被占用
```
Warning: Port 27017 is already in use.
```
**解决方案**: 
- 停止现有的 MongoDB 服务
- 或者修改 docker-compose.yml 文件中的端口映射

### 3. 权限问题
如果遇到权限问题，请以管理员身份运行批处理文件。

## 后续步骤

基础设施启动后，你可以继续运行项目的其他命令，例如：

```cmd
# 进入 offline 应用目录
cd apps\second-brain-offline

# 运行 ETL 管道
uv run python -m tools.run --run-etl-pipeline --no-cache

# 或者进入 online 应用目录
cd ..\second-brain-online

# 运行代理应用
uv run python -m tools.app --retriever-config-path=configs/compute_rag_vector_index_openai_parent.yaml --ui
```

## 安装 Make 工具（可选）

如果你希望使用原始的 `make` 命令，可以安装以下工具之一：

### 选项 1: 使用 Chocolatey
```powershell
# 安装 Chocolatey (如果尚未安装)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 安装 make
choco install make
```

### 选项 2: 使用 WSL (Windows Subsystem for Linux)
1. 启用 WSL：`wsl --install`
2. 在 WSL 中运行原始的 make 命令

### 选项 3: 使用 Git Bash
Git for Windows 自带的 Git Bash 包含了 make 工具。

## 总结

使用提供的批处理文件是最简单的解决方案，无需安装额外工具即可在 Windows 上运行项目的基础设施。
