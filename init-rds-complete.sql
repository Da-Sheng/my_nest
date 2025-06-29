-- RDS PostgreSQL 初始化脚本
-- 与本地Docker数据库结构完全一致
-- 执行: psql "host=your-rds-host port=5432 dbname=blog_db user=sk sslmode=require" -f init-rds-complete.sql

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
),
(
    'nodejs-performance-optimization',
    'Node.js 性能优化实战指南',
    '深入探讨Node.js应用的性能优化策略，从基础概念到高级技巧，全面提升应用性能。',
    '# Node.js 性能优化实战指南

在现代Web开发中，性能优化是构建高质量应用程序的关键因素。本文将深入探讨Node.js应用的性能优化策略。

## 性能监控基础

### 1. 关键性能指标
- **响应时间**: 请求处理时间
- **吞吐量**: 单位时间内处理的请求数
- **资源利用率**: CPU、内存使用情况
- **错误率**: 请求失败的比例

### 2. 性能监控工具
```javascript
// 使用内置的性能计时API
console.time("operation");
// 执行操作
console.timeEnd("operation");

// 使用process.hrtime()获取高精度时间
const start = process.hrtime.bigint();
// 执行操作
const end = process.hrtime.bigint();
console.log(`Execution time: ${end - start} nanoseconds`);
```

## 代码层面优化

### 1. 异步编程最佳实践
```javascript
// 避免阻塞事件循环
const fs = require("fs").promises;

// Good: 使用异步方法
async function readFile(filename) {
  try {
    const data = await fs.readFile(filename, "utf8");
    return data;
  } catch (error) {
    console.error("Error reading file:", error);
  }
}

// Bad: 使用同步方法
function readFileSync(filename) {
  return fs.readFileSync(filename, "utf8"); // 阻塞事件循环
}
```

### 2. 内存优化
```javascript
// 避免内存泄漏
class DataProcessor {
  constructor() {
    this.cache = new Map();
  }
  
  process(data) {
    // 设置缓存过期
    const key = data.id;
    this.cache.set(key, data);
    
    // 清理过期缓存
    setTimeout(() => {
      this.cache.delete(key);
    }, 60000);
  }
}

// 使用Stream处理大文件
const fs = require("fs");
const readStream = fs.createReadStream("large-file.txt");
const writeStream = fs.createWriteStream("output.txt");

readStream.pipe(writeStream);
```

## 数据库优化

### 1. 连接池管理
```javascript
const { Pool } = require("pg");

const pool = new Pool({
  host: "localhost",
  user: "postgres", 
  password: "password",
  database: "myapp",
  max: 20, // 最大连接数
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// 使用连接池
async function queryDatabase(sql, params) {
  const client = await pool.connect();
  try {
    const result = await client.query(sql, params);
    return result.rows;
  } finally {
    client.release();
  }
}
```

### 2. 查询优化
```sql
-- 使用索引
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_post_category ON posts(category, created_at);

-- 避免N+1查询
SELECT u.name, COUNT(p.id) as post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.name;
```

## 缓存策略

### 1. 内存缓存
```javascript
const NodeCache = require("node-cache");
const cache = new NodeCache({ stdTTL: 600 }); // 10分钟过期

function getCachedData(key) {
  const cached = cache.get(key);
  if (cached) {
    return cached;
  }
  
  const data = fetchFromDatabase(key);
  cache.set(key, data);
  return data;
}
```

### 2. Redis缓存
```javascript
const redis = require("redis");
const client = redis.createClient();

async function getCachedData(key) {
  const cached = await client.get(key);
  if (cached) {
    return JSON.parse(cached);
  }
  
  const data = await fetchFromDatabase(key);
  await client.setex(key, 3600, JSON.stringify(data)); // 1小时过期
  return data;
}
```

## 负载均衡与集群

### 1. 集群模式
```javascript
const cluster = require("cluster");
const numCPUs = require("os").cpus().length;

if (cluster.isMaster) {
  // 主进程：创建工作进程
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
  
  cluster.on("exit", (worker, code, signal) => {
    console.log(`Worker ${worker.process.pid} died`);
    cluster.fork(); // 重启工作进程
  });
} else {
  // 工作进程：运行应用
  require("./app.js");
}
```

## 性能测试

### 1. 压力测试
```bash
# 使用Artillery进行负载测试
npm install -g artillery

# 创建测试配置
echo "
config:
  target: 'http://localhost:3000'
  phases:
    - duration: 60
      arrivalRate: 10
scenarios:
  - name: 'API测试'
    requests:
      - get:
          url: '/api/posts'
" > load-test.yml

# 运行测试
artillery run load-test.yml
```

通过这些优化策略，你的Node.js应用性能将得到显著提升！',
    '王五',
    '/window.svg',
    '后端架构师，性能优化专家',
    ARRAY['Node.js', '性能优化', '后端开发', '架构设计'],
    '后端技术',
    15,
    false,
    '/globe.svg'
);

-- 插入分类数据
INSERT INTO blog_categories (name, slug, description) VALUES
('前端技术', 'frontend', '前端开发相关技术文章'),
('后端技术', 'backend', '后端开发相关技术文章'),
('编程语言', 'programming-languages', '各种编程语言的学习和使用'),
('性能优化', 'performance', '网站和应用性能优化相关'),
('开发工具', 'tools', '开发工具和环境配置相关')
ON CONFLICT (slug) DO NOTHING;

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
('编程最佳实践', 'best-practices'),
('Node.js', 'nodejs'),
('后端开发', 'backend-dev'),
('架构设计', 'architecture')
ON CONFLICT (slug) DO NOTHING;

-- 验证数据插入结果
SELECT 
    'blog_posts' as table_name, 
    COUNT(*) as record_count,
    'Posts created successfully' as status
FROM blog_posts
UNION ALL
SELECT 
    'blog_categories' as table_name, 
    COUNT(*) as record_count,
    'Categories created successfully' as status  
FROM blog_categories
UNION ALL
SELECT 
    'blog_tags' as table_name, 
    COUNT(*) as record_count,
    'Tags created successfully' as status
FROM blog_tags
ORDER BY table_name;

-- 显示表结构验证
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_schema = 'public' 
  AND table_name IN ('blog_posts', 'blog_categories', 'blog_tags')
ORDER BY table_name, ordinal_position;

-- 成功消息
SELECT '🎉 RDS数据库初始化完成！与本地Docker数据库结构完全一致。' as message; 