# NestJS Lambda博客系统

基于NestJS和AWS Lambda的博客系统后端，使用Layer架构优化部署。

## 项目架构

```
my_nest/
├── layer/nodejs/              # Lambda Layer
│   ├── package.json          # Layer依赖定义
│   └── node_modules/         # Layer构建产物
├── scripts/
│   ├── build-layer.sh        # Layer构建脚本
│   ├── manage-layer.sh       # Layer管理工具
│   └── db-management/        # 数据库管理脚本
├── dist/                     # 构建产物
├── src/                      # 源代码
│   ├── blog/                 # 博客模块
│   ├── database/             # 数据库模块
│   ├── config/               # 配置模块
│   └── github/               # GitHub模块
├── prisma/                   # Prisma模型和迁移
└── template.yaml             # SAM模板
```

## 主要特点

- **Lambda Layer架构**: 将依赖与业务逻辑分离，优化部署和冷启动时间
- **NestJS框架**: 使用模块化、依赖注入等企业级特性
- **Prisma ORM**: 类型安全的数据库访问
- **数据库管理分离**: 将数据库初始化和迁移逻辑从Lambda中分离出来

## 快速开始

### 本地开发

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run start

# 构建项目
npm run build
```

### 部署到AWS

```bash
# 部署到AWS
npm run deploy:aws
```

## 数据库管理

数据库初始化和迁移已从Lambda函数中分离出来，需要单独管理。详细说明请参阅：

[数据库管理指南](scripts/db-management/README.md)

## 环境变量

- `NODE_ENV`: 环境名称（development/production）
- `DATABASE_URL`: PostgreSQL数据库连接URL
- `GITHUB_USERNAME`: GitHub用户名
- `GITHUB_TOKEN`: GitHub访问令牌

## API文档

- `GET /api/getBlogList`: 获取博客列表
- `GET /api/getBlogDetail/:id`: 获取博客详情
- `GET /api/getBlogBySlug/:slug`: 通过slug获取博客详情
- `GET /api/getFeaturedBlogs`: 获取精选博客
- `GET /api/getGit`: 获取GitHub仓库列表 