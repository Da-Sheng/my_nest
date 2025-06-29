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

    -- 插入示例博客文章 (修正字段命名为下划线格式)
    INSERT INTO blog_posts (
        id, slug, title, excerpt, content,
        author_name, author_avatar, author_bio,
        tags, category, reading_time, featured, cover_image
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
    ),
    (
        'clm_post_tailwind_guide',
        'tailwind-css-mastery',
        'Tailwind CSS 实战：构建美观的现代UI',
        '从基础到高级，全面掌握Tailwind CSS的使用技巧，快速构建响应式和美观的用户界面。',
        '# Tailwind CSS 实战指南

Tailwind CSS 是一个功能优先的CSS框架，让UI开发变得更加高效。

## 核心优势

### 1. 实用工具优先
- 小巧的原子类
- 高度可定制
- 无需编写自定义CSS

### 2. 响应式设计
- 移动优先策略
- 灵活的断点系统
- 简单的语法

## 实战示例

```html
<div class="bg-white p-6 rounded-lg shadow-lg">
  <h3 class="text-xl font-bold mb-4">卡片标题</h3>
  <p class="text-gray-600">描述内容</p>
</div>
```

让我们用Tailwind构建精美的界面！',
        'UI设计师',
        '/api/avatar/designer.png',
        '专注于用户体验和界面设计的设计师',
        ARRAY['Tailwind CSS', 'CSS', 'UI设计'],
        '前端技术',
        8,
        false,
        '/api/images/tailwind-cover.jpg'
    )
    ON CONFLICT (slug) DO NOTHING;

    RAISE NOTICE '初始数据插入完成';
END;
$$ LANGUAGE plpgsql;

-- 执行数据插入
SELECT insert_initial_data();

-- 验证数据插入结果
SELECT 
    'blog_posts' as table_name, 
    COUNT(*) as record_count,
    'Posts created' as status
FROM blog_posts
UNION ALL
SELECT 
    'blog_categories' as table_name, 
    COUNT(*) as record_count,
    'Categories created' as status  
FROM blog_categories
UNION ALL
SELECT 
    'blog_tags' as table_name, 
    COUNT(*) as record_count,
    'Tags created' as status
FROM blog_tags
ORDER BY table_name;

-- 显示成功消息
SELECT '🎉 RDS数据库迁移完成！' as message; 