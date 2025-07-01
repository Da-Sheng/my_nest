# 数据库管理指南

本指南说明如何在EC2实例上管理PostgreSQL数据库，包括初始化、迁移和验证数据库。

## 前提条件

1. 一个运行中的EC2实例（建议使用Amazon Linux 2或Ubuntu）
2. 安装了以下工具：
   - Node.js 18+
   - npm 9+
   - PostgreSQL客户端工具（psql）
   - Git

## 安装依赖

```bash
# 安装Node.js和npm（Amazon Linux 2）
sudo yum update -y
sudo yum install -y nodejs npm git

# 安装PostgreSQL客户端（Amazon Linux 2）
sudo amazon-linux-extras install postgresql14

# 或者在Ubuntu上安装
# sudo apt update
# sudo apt install -y nodejs npm git postgresql-client
```

## 获取项目代码

```bash
# 克隆项目仓库
git clone <your-repository-url>
cd my_nest

# 安装项目依赖
npm install
```

## 数据库管理脚本

所有数据库管理脚本位于`scripts/db-management/`目录下：

1. **init-db.sh**: 初始化数据库结构和基础数据
2. **migrate-db.sh**: 执行数据库迁移
3. **check-db.sh**: 验证数据库状态

## 使用方法

### 1. 设置环境变量

```bash
# 设置数据库连接URL
export DATABASE_URL="postgresql://username:password@your-rds-endpoint:5432/blog_db"
```

### 2. 初始化数据库

```bash
cd scripts/db-management
chmod +x init-db.sh
./init-db.sh
```

### 3. 执行数据库迁移

```bash
cd scripts/db-management
chmod +x migrate-db.sh
./migrate-db.sh
```

### 4. 验证数据库状态

```bash
cd scripts/db-management
chmod +x check-db.sh
./check-db.sh
```

## 常见问题

### 权限错误

如果遇到权限错误，请确保脚本有执行权限：

```bash
chmod +x scripts/db-management/*.sh
```

### 连接错误

如果遇到数据库连接错误，请检查：

1. 数据库URL是否正确
2. EC2安全组是否允许连接到RDS
3. RDS安全组是否允许来自EC2的连接

### Prisma错误

如果遇到Prisma相关错误，请尝试：

```bash
npx prisma generate
```

## 自动化建议

考虑使用以下方法自动化数据库管理：

1. **AWS Systems Manager**: 创建文档和自动化运行脚本
2. **CI/CD管道**: 在部署流程中包含数据库迁移步骤
3. **定时任务**: 使用cron设置定期验证数据库状态 