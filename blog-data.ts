import { BlogPost, BlogListResponse, BlogQueryParams } from './types';

// 模拟博客数据
const mockBlogPosts: BlogPost[] = [
  {
    id: '1',
    slug: 'getting-started-with-nextjs-15',
    title: 'Next.js 15 入门指南：构建现代化的React应用',
    excerpt: '探索Next.js 15的新特性和最佳实践，学习如何使用App Router构建高性能的React应用程序。',
    content: `# Next.js 15 入门指南

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

\`\`\`bash
npx create-next-app@latest my-app
cd my-app
npm run dev
\`\`\`

然后就可以开始构建你的应用了！

## 最佳实践

1. **使用TypeScript**: 提供更好的类型安全
2. **优化图片**: 使用Next.js的Image组件
3. **SEO优化**: 利用metadata API

这只是Next.js 15强大功能的冰山一角。继续探索，你会发现更多令人惊喜的特性！`,
    author: {
      name: '张三',
      avatar: '/next.svg',
      bio: '全栈开发工程师，专注于React和Node.js技术栈'
    },
    publishedAt: '2024-12-15T10:00:00Z',
    updatedAt: '2024-12-15T10:00:00Z',
    tags: ['Next.js', 'React', 'JavaScript', '前端开发'],
    category: '前端技术',
    readingTime: 8,
    featured: true,
    coverImage: '/vercel.svg'
  },
  {
    id: '2',
    slug: 'mastering-tailwind-css',
    title: '掌握Tailwind CSS：从入门到实战',
    excerpt: '深入了解Tailwind CSS的核心概念和高级技巧，学习如何快速构建美观且响应式的用户界面。',
    content: `# 掌握Tailwind CSS

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

\`\`\`html
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
\`\`\`

### 响应式布局

\`\`\`html
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  <!-- 卡片内容 -->
</div>
\`\`\`

## 高级技巧

1. **自定义颜色**: 在配置文件中定义品牌色彩
2. **组件提取**: 使用@apply指令创建组件类
3. **优化生产**: 使用PurgeCSS移除未使用的样式

Tailwind CSS让CSS开发变得更加高效和愉快！`,
    author: {
      name: '李四',
      avatar: '/globe.svg',
      bio: 'UI/UX设计师，CSS专家'
    },
    publishedAt: '2024-12-10T14:30:00Z',
    updatedAt: '2024-12-12T09:15:00Z',
    tags: ['Tailwind CSS', 'CSS', '前端开发', '设计系统'],
    category: '前端技术',
    readingTime: 12,
    featured: true,
    coverImage: '/file.svg'
  },
  {
    id: '3',
    slug: 'typescript-best-practices',
    title: 'TypeScript最佳实践：编写更好的类型安全代码',
    excerpt: '学习TypeScript的最佳实践和高级特性，提升代码质量和开发效率。',
    content: `# TypeScript最佳实践

TypeScript为JavaScript提供了静态类型检查，能够帮助我们在开发阶段发现潜在的错误。

## 基础类型使用

### 1. 基本类型定义
\`\`\`typescript
// 基础类型
let name: string = "张三";
let age: number = 25;
let isActive: boolean = true;

// 数组类型
let numbers: number[] = [1, 2, 3];
let users: Array<string> = ["张三", "李四"];
\`\`\`

### 2. 接口定义
\`\`\`typescript
interface User {
  id: number;
  name: string;
  email: string;
  avatar?: string; // 可选属性
}

// 使用接口
const user: User = {
  id: 1,
  name: "张三",
  email: "zhangsan@example.com"
};
\`\`\`

## 高级特性

### 1. 泛型
\`\`\`typescript
function identity<T>(arg: T): T {
  return arg;
}

// 使用泛型
let output = identity<string>("hello");
let numberOutput = identity<number>(42);
\`\`\`

### 2. 联合类型
\`\`\`typescript
type Status = "pending" | "approved" | "rejected";

function updateStatus(status: Status) {
  // 只能使用指定的值
}
\`\`\`

### 3. 映射类型
\`\`\`typescript
type Partial<T> = {
  [P in keyof T]?: T[P];
};

// 创建可选版本的User接口
type PartialUser = Partial<User>;
\`\`\`

## 最佳实践

1. **严格模式**: 启用\`strict\`选项
2. **明确类型**: 避免使用\`any\`
3. **接口优于类型别名**: 用于对象类型定义
4. **使用工具类型**: 如\`Pick\`, \`Omit\`, \`Record\`等

TypeScript让JavaScript开发更加安全和高效！`,
    author: {
      name: '王五',
      avatar: '/window.svg',
      bio: 'TypeScript专家，大型项目架构师'
    },
    publishedAt: '2024-12-08T16:45:00Z',
    updatedAt: '2024-12-08T16:45:00Z',
    tags: ['TypeScript', 'JavaScript', '类型安全', '编程最佳实践'],
    category: '编程语言',
    readingTime: 15,
    featured: false,
    coverImage: '/next.svg'
  },
  {
    id: '4',
    slug: 'react-hooks-deep-dive',
    title: 'React Hooks深度解析：理解和使用的完整指南',
    excerpt: '深入探讨React Hooks的工作原理、使用场景和最佳实践，提升React开发技能。',
    content: `# React Hooks深度解析

React Hooks改变了我们编写React组件的方式，让函数组件拥有了类组件的所有能力。

## 基础Hooks

### 1. useState
\`\`\`jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>当前计数: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        增加
      </button>
    </div>
  );
}
\`\`\`

### 2. useEffect
\`\`\`jsx
import { useEffect, useState } from 'react';

function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    fetchUser(userId).then(setUser);
  }, [userId]); // 依赖数组
  
  if (!user) return <div>加载中...</div>;
  
  return <div>用户: {user.name}</div>;
}
\`\`\`

## 高级Hooks

### 1. useContext
\`\`\`jsx
import { createContext, useContext } from 'react';

const ThemeContext = createContext();

function App() {
  return (
    <ThemeContext.Provider value="dark">
      <Header />
    </ThemeContext.Provider>
  );
}

function Header() {
  const theme = useContext(ThemeContext);
  return <header className={theme}>头部</header>;
}
\`\`\`

### 2. useReducer
\`\`\`jsx
import { useReducer } from 'react';

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    default:
      throw new Error();
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, { count: 0 });
  
  return (
    <div>
      计数: {state.count}
      <button onClick={() => dispatch({ type: 'increment' })}>
        +
      </button>
      <button onClick={() => dispatch({ type: 'decrement' })}>
        -
      </button>
    </div>
  );
}
\`\`\`

## 自定义Hooks

\`\`\`jsx
// 自定义Hook：用于获取用户数据
function useUser(userId) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    setLoading(true);
    fetchUser(userId)
      .then(setUser)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [userId]);
  
  return { user, loading, error };
}

// 使用自定义Hook
function UserProfile({ userId }) {
  const { user, loading, error } = useUser(userId);
  
  if (loading) return <div>加载中...</div>;
  if (error) return <div>错误: {error.message}</div>;
  
  return <div>用户: {user.name}</div>;
}
\`\`\`

## 最佳实践

1. **遵循Hook规则**: 只在顶层调用Hook
2. **合理使用依赖数组**: 避免无限循环
3. **创建自定义Hook**: 复用状态逻辑
4. **性能优化**: 使用useMemo和useCallback

React Hooks让函数组件变得更加强大和灵活！`,
    author: {
      name: '赵六',
      avatar: '/vercel.svg',
      bio: 'React核心开发者，前端架构师'
    },
    publishedAt: '2024-12-05T11:20:00Z',
    updatedAt: '2024-12-05T11:20:00Z',
    tags: ['React', 'Hooks', 'JavaScript', '前端开发'],
    category: '前端技术',
    readingTime: 18,
    featured: false,
    coverImage: '/globe.svg'
  },
  {
    id: '5',
    slug: 'web-performance-optimization',
    title: 'Web性能优化实战：让你的网站飞起来',
    excerpt: '全面的Web性能优化指南，包括加载速度、运行时性能和用户体验优化的实用技巧。',
    content: `# Web性能优化实战

网站性能直接影响用户体验和业务转化率。让我们学习如何系统性地优化Web性能。

## 性能指标

### 核心Web Vitals
- **LCP (Largest Contentful Paint)**: 最大内容绘制时间
- **FID (First Input Delay)**: 首次输入延迟
- **CLS (Cumulative Layout Shift)**: 累积布局偏移

### 测量工具
- Chrome DevTools
- Lighthouse
- WebPageTest
- Core Web Vitals插件

## 加载性能优化

### 1. 资源优化
\`\`\`html
<!-- 图片优化 -->
<img src="image.webp" alt="描述" loading="lazy" width="800" height="400">

<!-- 预加载关键资源 -->
<link rel="preload" href="critical.css" as="style">
<link rel="preload" href="hero-image.jpg" as="image">
\`\`\`

### 2. 代码分割
\`\`\`javascript
// 动态导入
const LazyComponent = lazy(() => import('./LazyComponent'));

// 路由级别的代码分割
const About = lazy(() => import('./pages/About'));
\`\`\`

### 3. 缓存策略
\`\`\`javascript
// Service Worker缓存
self.addEventListener('fetch', event => {
  if (event.request.destination === 'image') {
    event.respondWith(
      caches.match(event.request).then(response => {
        return response || fetch(event.request);
      })
    );
  }
});
\`\`\`

## 运行时性能优化

### 1. React性能优化
\`\`\`jsx
// 使用React.memo防止不必要的重渲染
const MemoizedComponent = React.memo(({ data }) => {
  return <div>{data.title}</div>;
});

// 使用useMemo缓存计算结果
const ExpensiveComponent = ({ items }) => {
  const expensiveValue = useMemo(() => {
    return items.reduce((sum, item) => sum + item.value, 0);
  }, [items]);
  
  return <div>总计: {expensiveValue}</div>;
};
\`\`\`

### 2. 虚拟滚动
\`\`\`jsx
import { FixedSizeList as List } from 'react-window';

const VirtualizedList = ({ items }) => (
  <List
    height={600}
    itemCount={items.length}
    itemSize={50}
    itemData={items}
  >
    {({ index, style, data }) => (
      <div style={style}>
        {data[index].name}
      </div>
    )}
  </List>
);
\`\`\`

### 3. 防抖和节流
\`\`\`javascript
// 防抖
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// 搜索输入防抖
const debouncedSearch = debounce(handleSearch, 300);
\`\`\`

## 网络优化

### 1. HTTP/2和HTTP/3
- 多路复用
- 服务器推送
- 头部压缩

### 2. CDN使用
\`\`\`javascript
// 配置CDN
const CDN_URL = 'https://cdn.example.com';
const imageUrl = \`\${CDN_URL}/images/\${imageName}\`;
\`\`\`

### 3. 资源压缩
- Gzip/Brotli压缩
- 图片格式优化（WebP, AVIF）
- JavaScript/CSS压缩

## 性能监控

### 1. 性能API
\`\`\`javascript
// 监控页面加载时间
window.addEventListener('load', () => {
  const perfData = performance.getEntriesByType('navigation')[0];
  console.log('页面加载时间:', perfData.loadEventEnd - perfData.fetchStart);
});
\`\`\`

### 2. 用户体验监控
\`\`\`javascript
// 监控长任务
const observer = new PerformanceObserver(list => {
  for (const entry of list.getEntries()) {
    if (entry.duration > 50) {
      console.warn('长任务检测:', entry);
    }
  }
});
observer.observe({ entryTypes: ['longtask'] });
\`\`\`

## 最佳实践清单

- [ ] 优化关键渲染路径
- [ ] 实施资源预加载策略
- [ ] 使用高效的图片格式
- [ ] 实现代码分割
- [ ] 配置适当的缓存策略
- [ ] 监控核心性能指标
- [ ] 定期进行性能审计

性能优化是一个持续的过程，需要不断监控和改进！`,
    author: {
      name: '孙七',
      avatar: '/file.svg',
      bio: '性能优化专家，Web标准推广者'
    },
    publishedAt: '2024-12-01T13:10:00Z',
    updatedAt: '2024-12-02T08:30:00Z',
    tags: ['性能优化', 'Web开发', '用户体验', '前端工程'],
    category: '性能优化',
    readingTime: 22,
    featured: false,
    coverImage: '/window.svg'
  }
];

// 模拟延迟函数
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

// 获取博客列表的API函数
export async function getBlogPosts(params: BlogQueryParams = {}): Promise<BlogListResponse> {
  // 模拟网络延迟
  await delay(800);
  
  const {
    page = 1,
    limit = 6,
    search = '',
    tag = '',
    category = ''
  } = params;

  let filteredPosts = [...mockBlogPosts];

  // 搜索过滤
  if (search) {
    const searchLower = search.toLowerCase();
    filteredPosts = filteredPosts.filter(post =>
      post.title.toLowerCase().includes(searchLower) ||
      post.excerpt.toLowerCase().includes(searchLower) ||
      post.content.toLowerCase().includes(searchLower)
    );
  }

  // 标签过滤
  if (tag) {
    filteredPosts = filteredPosts.filter(post =>
      post.tags.some(t => t.toLowerCase().includes(tag.toLowerCase()))
    );
  }

  // 分类过滤
  if (category) {
    filteredPosts = filteredPosts.filter(post =>
      post.category.toLowerCase().includes(category.toLowerCase())
    );
  }

  // 按发布时间排序（最新的在前）
  filteredPosts.sort((a, b) => 
    new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
  );

  // 分页
  const startIndex = (page - 1) * limit;
  const endIndex = startIndex + limit;
  const paginatedPosts = filteredPosts.slice(startIndex, endIndex);

  return {
    posts: paginatedPosts,
    total: filteredPosts.length,
    page,
    limit
  };
}

// 获取单个博客文章的API函数
export async function getBlogPost(slug: string): Promise<BlogPost | null> {
  // 模拟网络延迟
  await delay(600);
  
  const post = mockBlogPosts.find(post => post.slug === slug);
  return post || null;
}

// 获取相关博客文章的API函数
export async function getRelatedPosts(slug: string, limit: number = 3): Promise<BlogPost[]> {
  // 模拟网络延迟
  await delay(400);
  
  const currentPost = mockBlogPosts.find(post => post.slug === slug);
  if (!currentPost) return [];

  // 根据标签和分类找相关文章
  const relatedPosts = mockBlogPosts
    .filter(post => post.slug !== slug)
    .filter(post => 
      post.category === currentPost.category ||
      post.tags.some(tag => currentPost.tags.includes(tag))
    )
    .slice(0, limit);

  return relatedPosts;
}

// 获取所有标签
export async function getAllTags(): Promise<string[]> {
  await delay(300);
  
  const allTags = mockBlogPosts.flatMap(post => post.tags);
  const uniqueTags = [...new Set(allTags)];
  return uniqueTags.sort();
}

// 获取所有分类
export async function getAllCategories(): Promise<string[]> {
  await delay(300);
  
  const allCategories = mockBlogPosts.map(post => post.category);
  const uniqueCategories = [...new Set(allCategories)];
  return uniqueCategories.sort();
}

// 获取精选文章
export async function getFeaturedPosts(limit: number = 3): Promise<BlogPost[]> {
  await delay(500);
  
  return mockBlogPosts
    .filter(post => post.featured)
    .slice(0, limit);
}

// 搜索建议函数
export async function getSearchSuggestions(query: string): Promise<string[]> {
  await delay(200);
  
  if (!query || query.length < 2) return [];
  
  const queryLower = query.toLowerCase();
  const suggestions: Set<string> = new Set();
  
  mockBlogPosts.forEach(post => {
    // 从标题中提取建议
    if (post.title.toLowerCase().includes(queryLower)) {
      suggestions.add(post.title);
    }
    
    // 从标签中提取建议
    post.tags.forEach(tag => {
      if (tag.toLowerCase().includes(queryLower)) {
        suggestions.add(tag);
      }
    });
  });
  
  return Array.from(suggestions).slice(0, 5);
} 