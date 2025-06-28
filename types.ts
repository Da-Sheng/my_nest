// 博客文章类型定义
export interface BlogPost {
  id: string;
  slug: string;
  title: string;
  excerpt: string;
  content: string;
  author: Author;
  publishedAt: string;
  updatedAt: string;
  tags: string[];
  category: string;
  readingTime: number;
  featured: boolean;
  coverImage: string;
}

// 博客列表响应类型
export interface BlogListResponse {
  posts: BlogPost[];
  total: number;
  page: number;
  limit: number;
}

// 博客查询参数类型
export interface BlogQueryParams {
  page?: number;
  limit?: number;
  search?: string;
  tag?: string;
  category?: string;
}

// 作者信息类型
export interface Author {
  name: string;
  avatar: string;
  bio: string;
}

// 博客分类类型
export interface Category {
  id: string;
  name: string;
  slug: string;
  description: string;
  count: number;
}

// 标签类型
export interface Tag {
  id: string;
  name: string;
  slug: string;
  count: number;
}

// GitHub 仓库信息类型
export interface GitHubRepo {
  id: number;
  name: string;
  full_name: string;
  description: string | null;
  html_url: string;
  clone_url: string;
  ssh_url: string;
  language: string | null;
  stargazers_count: number;
  forks_count: number;
  watchers_count: number;
  size: number;
  created_at: string;
  updated_at: string;
  pushed_at: string;
  topics: string[];
  visibility: string;
  archived: boolean;
  disabled: boolean;
  fork: boolean;
}

// GitHub API 响应类型
export interface GitHubReposResponse {
  total_count: number;
  incomplete_results: boolean;
  items: GitHubRepo[];
}

// 通用 API 响应类型
export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  message?: string;
  error?: string;
}

// 分页查询基础类型
export interface PaginationQuery {
  page?: number;
  limit?: number;
}

// 创建博客文章的 DTO
export interface CreateBlogPostDto {
  slug: string;
  title: string;
  excerpt: string;
  content: string;
  authorName: string;
  authorAvatar: string;
  authorBio: string;
  tags: string[];
  category: string;
  readingTime: number;
  featured?: boolean;
  coverImage: string;
}

// 更新博客文章的 DTO
export interface UpdateBlogPostDto extends Partial<CreateBlogPostDto> {
  id: string;
} 