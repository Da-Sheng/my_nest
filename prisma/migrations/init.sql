-- AWS RDS PostgreSQL 初始化脚本
-- 执行顺序：先运行此脚本，再执行 prisma db push

-- 创建扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 创建更新时间触发器函数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 创建性能索引（Prisma会创建表结构）
-- 这些索引将在Prisma表创建后自动应用

-- 插入初始数据的函数
CREATE OR REPLACE FUNCTION insert_initial_data()
RETURNS void AS $$
BEGIN
    -- 插入博客分类
    INSERT INTO blog_categories (id, name, slug, description) VALUES
    ('clm_cat_frontend', '前端技术', 'frontend', '前端开发相关技术文章'),
    ('clm_cat_backend', '后端技术', 'backend', '后端开发相关技术文章'),
    ('clm_cat_fullstack', '全栈开发', 'fullstack', '全栈开发相关文章')
    ON CONFLICT (slug) DO NOTHING;

    -- 插入博客标签  
    INSERT INTO blog_tags (id, name, slug) VALUES
    ('clm_tag_nextjs', 'Next.js', 'nextjs'),
    ('clm_tag_react', 'React', 'react'),
    ('clm_tag_tailwind', 'Tailwind CSS', 'tailwind-css'),
    ('clm_tag_typescript', 'TypeScript', 'typescript'),
    ('clm_tag_nestjs', 'NestJS', 'nestjs'),
    ('clm_tag_aws', 'AWS', 'aws')
    ON CONFLICT (slug) DO NOTHING;

    -- 插入示例博客文章
    INSERT INTO blog_posts (
        id, slug, title, excerpt, content,
        "authorName", "authorAvatar", "authorBio",
        tags, category, "readingTime", featured, "coverImage"
    ) VALUES
    (
        'clm_post_nextjs_guide',
        'nextjs-15-complete-guide',
        'Next.js 15 完整指南：构建现代化Web应用',
        '深入探索Next.js 15的新特性，包括App Router、Server Components等核心功能，助你构建高性能的React应用。',
        '# Next.js 15 完整指南

Next.js 15 带来了革命性的改进，让Web开发变得更加简单和高效。

## 主要新特性

### 1. 改进的App Router
- 更快的路由性能
- 简化的数据获取
- 更好的错误处理

### 2. Server Components
- 减少客户端JavaScript
- 更好的SEO表现
- 服务器端渲染优化

## 快速开始

```bash
npx create-next-app@latest my-app
cd my-app
npm run dev
```

开始你的Next.js 15之旅吧！',
        '技术团队',
        '/api/avatar/team.png',
        '专注于现代Web技术的开发团队',
        ARRAY['Next.js', 'React', 'TypeScript'],
        '前端技术',
        12,
        true,
        '/api/images/nextjs-cover.jpg'
    )
    ON CONFLICT (slug) DO NOTHING;

    RAISE NOTICE '初始数据插入完成';
END;
$$ LANGUAGE plpgsql; 