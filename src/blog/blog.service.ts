import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { BlogPost, BlogListResponse, BlogQueryParams, ApiResponse } from '../../types';

@Injectable()
export class BlogService {
  private readonly logger = new Logger(BlogService.name);

  constructor(private readonly prisma: PrismaService) {}

  async getBlogList(params: BlogQueryParams = {}): Promise<ApiResponse<BlogListResponse>> {
    try {
      const {
        page = 1,
        limit = 6,
        search = '',
        tag = '',
        category = '',
      } = params;

      this.logger.log(`获取博客列表: page=${page}, limit=${limit}, search=${search}, tag=${tag}, category=${category}`);

      // 构建查询条件
      const where: any = {};

      if (search) {
        where.OR = [
          { title: { contains: search, mode: 'insensitive' } },
          { excerpt: { contains: search, mode: 'insensitive' } },
          { content: { contains: search, mode: 'insensitive' } },
        ];
      }

      if (tag) {
        where.tags = {
          has: tag,
        };
      }

      if (category) {
        where.category = {
          contains: category,
          mode: 'insensitive',
        };
      }

      // 计算偏移量
      const skip = (page - 1) * limit;

      // 获取总数
      const total = await this.prisma.blogPost.count({ where });

      // 获取博客列表
      const posts = await this.prisma.blogPost.findMany({
        where,
        skip,
        take: limit,
        orderBy: {
          publishedAt: 'desc',
        },
      });

      // 转换数据格式
      const blogPosts: BlogPost[] = posts.map(post => ({
        id: post.id,
        slug: post.slug,
        title: post.title,
        excerpt: post.excerpt,
        content: post.content,
        author: {
          name: post.authorName,
          avatar: post.authorAvatar,
          bio: post.authorBio,
        },
        publishedAt: post.publishedAt.toISOString(),
        updatedAt: post.updatedAt.toISOString(),
        tags: post.tags,
        category: post.category,
        readingTime: post.readingTime,
        featured: post.featured,
        coverImage: post.coverImage,
      }));

      const response: BlogListResponse = {
        posts: blogPosts,
        total,
        page,
        limit,
      };

      this.logger.log(`成功获取 ${blogPosts.length} 篇博客，总计 ${total} 篇`);

      return {
        success: true,
        data: response,
        message: `成功获取博客列表`,
      };
    } catch (error) {
      this.logger.error('获取博客列表失败:', error);
      return {
        success: false,
        error: '获取博客列表失败，请稍后重试',
      };
    }
  }

  async getBlogDetail(id: string): Promise<ApiResponse<BlogPost>> {
    try {
      this.logger.log(`获取博客详情: ${id}`);

      const post = await this.prisma.blogPost.findUnique({
        where: { id },
      });

      if (!post) {
        this.logger.warn(`博客不存在: ${id}`);
        return {
          success: false,
          error: '博客文章不存在',
        };
      }

      const blogPost: BlogPost = {
        id: post.id,
        slug: post.slug,
        title: post.title,
        excerpt: post.excerpt,
        content: post.content,
        author: {
          name: post.authorName,
          avatar: post.authorAvatar,
          bio: post.authorBio,
        },
        publishedAt: post.publishedAt.toISOString(),
        updatedAt: post.updatedAt.toISOString(),
        tags: post.tags,
        category: post.category,
        readingTime: post.readingTime,
        featured: post.featured,
        coverImage: post.coverImage,
      };

      this.logger.log(`成功获取博客详情: ${post.title}`);

      return {
        success: true,
        data: blogPost,
        message: '成功获取博客详情',
      };
    } catch (error) {
      this.logger.error('获取博客详情失败:', error);
      return {
        success: false,
        error: '获取博客详情失败，请稍后重试',
      };
    }
  }

  async getBlogBySlug(slug: string): Promise<ApiResponse<BlogPost>> {
    try {
      this.logger.log(`通过slug获取博客详情: ${slug}`);

      const post = await this.prisma.blogPost.findUnique({
        where: { slug },
      });

      if (!post) {
        this.logger.warn(`博客不存在: ${slug}`);
        return {
          success: false,
          error: '博客文章不存在',
        };
      }

      const blogPost: BlogPost = {
        id: post.id,
        slug: post.slug,
        title: post.title,
        excerpt: post.excerpt,
        content: post.content,
        author: {
          name: post.authorName,
          avatar: post.authorAvatar,
          bio: post.authorBio,
        },
        publishedAt: post.publishedAt.toISOString(),
        updatedAt: post.updatedAt.toISOString(),
        tags: post.tags,
        category: post.category,
        readingTime: post.readingTime,
        featured: post.featured,
        coverImage: post.coverImage,
      };

      return {
        success: true,
        data: blogPost,
        message: '成功获取博客详情',
      };
    } catch (error) {
      this.logger.error('通过slug获取博客详情失败:', error);
      return {
        success: false,
        error: '获取博客详情失败，请稍后重试',
      };
    }
  }

  async getFeaturedBlogs(limit: number = 3): Promise<ApiResponse<BlogPost[]>> {
    try {
      this.logger.log(`获取精选博客，限制 ${limit} 篇`);

      const posts = await this.prisma.blogPost.findMany({
        where: { featured: true },
        take: limit,
        orderBy: {
          publishedAt: 'desc',
        },
      });

      const blogPosts: BlogPost[] = posts.map(post => ({
        id: post.id,
        slug: post.slug,
        title: post.title,
        excerpt: post.excerpt,
        content: post.content,
        author: {
          name: post.authorName,
          avatar: post.authorAvatar,
          bio: post.authorBio,
        },
        publishedAt: post.publishedAt.toISOString(),
        updatedAt: post.updatedAt.toISOString(),
        tags: post.tags,
        category: post.category,
        readingTime: post.readingTime,
        featured: post.featured,
        coverImage: post.coverImage,
      }));

      return {
        success: true,
        data: blogPosts,
        message: `成功获取 ${blogPosts.length} 篇精选博客`,
      };
    } catch (error) {
      this.logger.error('获取精选博客失败:', error);
      return {
        success: false,
        error: '获取精选博客失败，请稍后重试',
      };
    }
  }

  async getAllCategories(): Promise<ApiResponse<string[]>> {
    try {
      this.logger.log('获取所有博客分类');

      const categories = await this.prisma.blogPost.findMany({
        select: { category: true },
        distinct: ['category'],
      });

      const categoryList = categories.map(c => c.category).sort();

      return {
        success: true,
        data: categoryList,
        message: `成功获取 ${categoryList.length} 个分类`,
      };
    } catch (error) {
      this.logger.error('获取分类失败:', error);
      return {
        success: false,
        error: '获取分类失败，请稍后重试',
      };
    }
  }

  async getAllTags(): Promise<ApiResponse<string[]>> {
    try {
      this.logger.log('获取所有博客标签');

      const posts = await this.prisma.blogPost.findMany({
        select: { tags: true },
      });

      const allTags = posts.flatMap(post => post.tags);
      const uniqueTags = [...new Set(allTags)].sort();

      return {
        success: true,
        data: uniqueTags,
        message: `成功获取 ${uniqueTags.length} 个标签`,
      };
    } catch (error) {
      this.logger.error('获取标签失败:', error);
      return {
        success: false,
        error: '获取标签失败，请稍后重试',
      };
    }
  }
} 