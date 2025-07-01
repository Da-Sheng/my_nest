# 脚本使用指南

本文档说明了项目中的脚本结构和使用方式。

## 脚本目录结构

```
scripts/
├── build/           # 构建相关脚本
│   ├── all.sh       # 完整构建脚本（包括Layer和应用）
│   ├── app.sh       # 应用构建脚本
│   └── layer.sh     # Layer构建脚本
├── deploy/          # 部署相关脚本
│   ├── aws.sh       # AWS部署脚本
│   └── local.sh     # 本地部署脚本
├── layer/           # Layer管理脚本
│   └── manage.sh    # Layer管理主脚本
└── db/              # 数据库管理脚本
    ├── init.sh      # 初始化脚本
    ├── migrate.sh   # 迁移脚本
    ├── check.sh     # 检查脚本
    └── README.md    # 数据库管理文档
```

## NPM/Yarn 脚本命令

所有脚本都可以通过NPM/Yarn命令运行，无需直接调用shell脚本。

### 构建命令

- `npm run build` - 完整构建（包括Layer和应用）
- `npm run build:app` - 仅构建应用
- `npm run build:layer` - 仅构建Layer
- `npm run build:rollup` - 使用Rollup构建应用

### 部署命令

- `npm run deploy` - 本地部署（开发环境）
- `npm run deploy:aws` - 部署到AWS
- `npm run dev:setup` - 设置开发环境

### 数据库命令

- `npm run db:generate` - 生成Prisma客户端
- `npm run db:push` - 推送数据库变更
- `npm run db:migrate` - 执行数据库迁移
- `npm run db:studio` - 启动Prisma Studio
- `npm run db:init` - 初始化数据库
- `npm run db:check` - 检查数据库状态

### Layer管理命令

- `npm run layer:info` - 显示Layer信息
- `npm run layer:build` - 构建Layer
- `npm run layer:upload` - 上传Layer到AWS
- `npm run layer:list` - 列出AWS上的Layer
- `npm run layer:sync` - 同步Layer版本

### 版本管理命令

- `npm run version:patch` - 增加补丁版本号
- `npm run version:minor` - 增加次要版本号
- `npm run version:major` - 增加主要版本号

## 常用场景

### 1. 完整构建和部署到AWS

```bash
# 构建应用和Layer
npm run build

# 上传Layer到AWS
npm run layer:upload

# 部署应用到AWS
npm run deploy:aws
```

### 2. 开发环境设置

```bash
# 设置开发环境
npm run dev:setup

# 启动应用
npm start
```

### 3. 数据库管理

```bash
# 初始化数据库
npm run db:init

# 执行数据库迁移
npm run db:migrate

# 检查数据库状态
npm run db:check
```

### 4. Layer管理

```bash
# 查看Layer信息
npm run layer:info

# 构建Layer
npm run layer:build

# 上传Layer到AWS
npm run layer:upload

# 查看AWS上的Layer列表
npm run layer:list
```

## 注意事项

1. 所有脚本都会自动设置执行权限，无需手动运行`chmod +x`
2. 数据库操作需要设置`DATABASE_URL`环境变量
3. AWS部署需要设置`.env.sam.local`文件
4. Layer上传需要安装和配置AWS CLI
