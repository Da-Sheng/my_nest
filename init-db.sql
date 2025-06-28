-- 数据库初始化脚本
-- 此脚本将在PostgreSQL容器启动时自动执行

-- 创建扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 创建博客文章表
CREATE TABLE IF NOT EXISTS blog_posts (
    id VARCHAR(25) PRIMARY KEY DEFAULT 'ckm' || REPLACE(uuid_generate_v4()::text, '-', ''),
    slug VARCHAR(255) UNIQUE NOT NULL,
    title TEXT NOT NULL,
    excerpt TEXT NOT NULL,
    content TEXT NOT NULL,
    author_name VARCHAR(255) NOT NULL,
    author_avatar VARCHAR(500) NOT NULL,
    author_bio TEXT NOT NULL,
    published_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    tags TEXT[] DEFAULT '{}',
    category VARCHAR(100) NOT NULL,
    reading_time INTEGER NOT NULL DEFAULT 0,
    featured BOOLEAN DEFAULT FALSE,
    cover_image VARCHAR(500) NOT NULL
);

-- 创建博客分类表
CREATE TABLE IF NOT EXISTS blog_categories (
    id VARCHAR(25) PRIMARY KEY DEFAULT 'ckm' || REPLACE(uuid_generate_v4()::text, '-', ''),
    name VARCHAR(100) UNIQUE NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建博客标签表
CREATE TABLE IF NOT EXISTS blog_tags (
    id VARCHAR(25) PRIMARY KEY DEFAULT 'ckm' || REPLACE(uuid_generate_v4()::text, '-', ''),
    name VARCHAR(100) UNIQUE NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建更新时间触发器函数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 为博客文章表创建更新时间触发器
DROP TRIGGER IF EXISTS update_blog_posts_updated_at ON blog_posts;
CREATE TRIGGER update_blog_posts_updated_at
    BEFORE UPDATE ON blog_posts
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 为博客分类表创建更新时间触发器
DROP TRIGGER IF EXISTS update_blog_categories_updated_at ON blog_categories;
CREATE TRIGGER update_blog_categories_updated_at
    BEFORE UPDATE ON blog_categories
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 为博客标签表创建更新时间触发器
DROP TRIGGER IF EXISTS update_blog_tags_updated_at ON blog_tags;
CREATE TRIGGER update_blog_tags_updated_at
    BEFORE UPDATE ON blog_tags
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_blog_posts_slug ON blog_posts(slug);
CREATE INDEX IF NOT EXISTS idx_blog_posts_category ON blog_posts(category);
CREATE INDEX IF NOT EXISTS idx_blog_posts_featured ON blog_posts(featured);
CREATE INDEX IF NOT EXISTS idx_blog_posts_published_at ON blog_posts(published_at);
CREATE INDEX IF NOT EXISTS idx_blog_posts_tags ON blog_posts USING GIN(tags);

-- 插入初始博客数据
INSERT INTO blog_posts (slug, title, excerpt, content, author_name, author_avatar, author_bio, tags, category, reading_time, featured, cover_image) VALUES
(
    'getting-started-with-nextjs-15',
    'Next.js 15 入门指南：构建现代化的React应用',
    '探索Next.js 15的新特性和最佳实践，学习如何使用App Router构建高性能的React应用程序。',
    '# Next.js 15 入门指南

Next.js 15 带来了许多令人兴奋的新特性和改进，让开发者能够更轻松地构建现代化的React应用程序。

## 主要新特性

### 1. 改进的App Router
App Router在Next.js 15中变得更加稳定和高效。它提供了：
- 更好的路由性能
- 简化的数据获取模式
- 改进的错误处理

### 2. 服务器组件优化
服务器组件现在支持：
- 更快的渲染速度
- 更好的SEO优化
- 减少的客户端JavaScript包大小

## 快速开始

首先，创建一个新的Next.js项目：

```bash
npx create-next-app@latest my-app
cd my-app
npm run dev
```

然后就可以开始构建你的应用了！

## 最佳实践

1. **使用TypeScript**: 提供更好的类型安全
2. **优化图片**: 使用Next.js的Image组件
3. **SEO优化**: 利用metadata API

这只是Next.js 15强大功能的冰山一角。继续探索，你会发现更多令人惊喜的特性！',
    '张三',
    '/next.svg',
    '全栈开发工程师，专注于React和Node.js技术栈',
    ARRAY['Next.js', 'React', 'JavaScript', '前端开发'],
    '前端技术',
    8,
    true,
    '/vercel.svg'
),
(
    'mastering-tailwind-css',
    '掌握Tailwind CSS：从入门到实战',
    '深入了解Tailwind CSS的核心概念和高级技巧，学习如何快速构建美观且响应式的用户界面。',
    '# 掌握Tailwind CSS

Tailwind CSS是一个功能优先的CSS框架，它提供了大量的实用工具类来快速构建用户界面。

## 为什么选择Tailwind CSS？

### 优势
- **快速开发**: 无需编写自定义CSS
- **一致性**: 设计系统内置
- **响应式**: 移动优先的设计方法
- **可定制**: 高度可配置

### 核心概念
1. **实用工具优先**: 使用小的、单一用途的类
2. **响应式设计**: 内置断点系统
3. **状态变体**: hover、focus等状态的支持

## 实战示例

### 创建一个卡片组件

```html
<div class="bg-white rounded-lg shadow-lg p-6 max-w-sm mx-auto">
  <img class="w-full h-48 object-cover rounded-t-lg" src="image.jpg" alt="Card image">
  <div class="mt-4">
    <h3 class="text-xl font-semibold text-gray-800">卡片标题</h3>
    <p class="text-gray-600 mt-2">这是卡片的描述内容。</p>
    <button class="mt-4 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors">
      了解更多
    </button>
  </div>
</div>
```

### 响应式布局

```html
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  <!-- 卡片内容 -->
</div>
```

## 高级技巧

1. **自定义颜色**: 在配置文件中定义品牌色彩
2. **组件提取**: 使用@apply指令创建组件类
3. **优化生产**: 使用PurgeCSS移除未使用的样式

Tailwind CSS让CSS开发变得更加高效和愉快！',
    '李四',
    '/globe.svg',
    'UI/UX设计师，CSS专家',
    ARRAY['Tailwind CSS', 'CSS', '前端开发', '设计系统'],
    '前端技术',
    12,
    true,
    '/file.svg'
);

-- 插入分类数据
INSERT INTO blog_categories (name, slug, description) VALUES
('前端技术', 'frontend', '前端开发相关技术文章'),
('后端技术', 'backend', '后端开发相关技术文章'),
('编程语言', 'programming-languages', '各种编程语言的学习和使用'),
('性能优化', 'performance', '网站和应用性能优化相关'),
('开发工具', 'tools', '开发工具和环境配置相关');

-- 插入标签数据
INSERT INTO blog_tags (name, slug) VALUES
('Next.js', 'nextjs'),
('React', 'react'),
('JavaScript', 'javascript'),
('TypeScript', 'typescript'),
('Tailwind CSS', 'tailwind-css'),
('CSS', 'css'),
('前端开发', 'frontend-dev'),
('设计系统', 'design-system'),
('性能优化', 'performance'),
('编程最佳实践', 'best-practices'); 