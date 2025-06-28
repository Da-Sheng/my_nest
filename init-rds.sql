-- RDS PostgreSQL 初始化脚本
-- 在CloudShell中执行: \i init-rds.sql

-- 创建必要的扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 创建更新时间触发器函数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 验证当前数据库信息
SELECT current_database() as database_name, 
       current_user as user_name, 
       version() as postgres_version;

-- 显示当前的表（如果Prisma已经创建了表）
\dt

-- 如果表已存在，插入初始数据
-- 如果表不存在，需要先运行 prisma db push

-- 插入博客分类数据
INSERT INTO blog_categories (id, name, slug, description, created_at, updated_at) 
VALUES 
    ('clm_cat_frontend', '前端技术', 'frontend', '前端开发相关技术文章', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_cat_backend', '后端技术', 'backend', '后端开发相关技术文章', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_cat_fullstack', '全栈开发', 'fullstack', '全栈开发相关文章', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (slug) DO NOTHING;

-- 插入博客标签数据
INSERT INTO blog_tags (id, name, slug, created_at, updated_at)
VALUES 
    ('clm_tag_nextjs', 'Next.js', 'nextjs', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_tag_react', 'React', 'react', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_tag_typescript', 'TypeScript', 'typescript', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_tag_nestjs', 'NestJS', 'nestjs', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_tag_aws', 'AWS', 'aws', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clm_tag_tailwind', 'Tailwind CSS', 'tailwind-css', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (slug) DO NOTHING;

-- 插入示例博客文章
INSERT INTO blog_posts (
    id, slug, title, excerpt, content,
    "authorName", "authorAvatar", "authorBio",
    tags, category, "readingTime", featured, "coverImage",
    "publishedAt", "updatedAt"
) VALUES 
(
    'clm_post_nextjs_aws',
    'nextjs-aws-deployment',
    'Next.js + AWS: 现代化全栈部署指南',
    '学习如何将Next.js应用部署到AWS，使用RDS、Lambda和API Gateway构建可扩展的全栈应用。',
    '# Next.js + AWS 全栈部署指南

在这个教程中，我们将学习如何将Next.js应用部署到AWS云平台。

## 🚀 架构概览

- **前端**: Next.js (部署到S3 + CloudFront)
- **后端**: NestJS Lambda函数  
- **数据库**: RDS PostgreSQL
- **API**: API Gateway

## 📋 准备工作

### 1. AWS服务配置
```bash
# RDS PostgreSQL数据库
aws rds create-db-instance --db-name blog-db

# Lambda函数
sam init --runtime nodejs18.x

# API Gateway
aws apigateway create-rest-api --name blog-api
```

### 2. 环境配置
```env
DATABASE_URL=postgresql://user:pass@rds-endpoint:5432/db
AWS_REGION=ap-southeast-2
```

## 🛠️ 部署步骤

### 步骤1: 数据库初始化
使用Prisma管理数据库schema:
```bash
npx prisma db push
npx prisma generate
```

### 步骤2: Lambda部署
```bash
sam build
sam deploy --guided
```

### 步骤3: 前端部署
```bash
npm run build
aws s3 sync ./out s3://your-bucket
```

通过这种架构，我们可以构建高度可扩展的现代化Web应用！',
    'AWS架构师',
    '/images/aws-expert.jpg',
    '专注于AWS云服务和现代化Web架构的技术专家',
    ARRAY['Next.js', 'AWS', 'NestJS', 'PostgreSQL'],
    '全栈开发',
    12,
    true,
    '/images/nextjs-aws-cover.jpg',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
)
ON CONFLICT (slug) DO NOTHING;

-- 验证数据插入
SELECT 'Categories' as type, count(*) as count FROM blog_categories
UNION ALL
SELECT 'Tags', count(*) FROM blog_tags
UNION ALL 
SELECT 'Posts', count(*) FROM blog_posts;

-- 显示成功消息
SELECT '🎉 数据库初始化完成!' as message; 