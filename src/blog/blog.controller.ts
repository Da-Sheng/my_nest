import { Controller, Get, Logger, Query, Param, ParseIntPipe } from '@nestjs/common';
import { BlogService } from './blog.service';
import { ApiResponse, BlogPost, BlogListResponse } from '../../types';

@Controller('api')
export class BlogController {
  private readonly logger = new Logger(BlogController.name);

  constructor(private readonly blogService: BlogService) {}

  @Get('getBlogList')
  async getBlogList(
    @Query('page', new ParseIntPipe({ optional: true })) page?: number,
    @Query('limit', new ParseIntPipe({ optional: true })) limit?: number,
    @Query('search') search?: string,
    @Query('tag') tag?: string,
    @Query('category') category?: string,
  ): Promise<ApiResponse<BlogListResponse>> {
    this.logger.log(`获取博客列表请求: page=${page}, limit=${limit}, search=${search}`);
    
    try {
      const result = await this.blogService.getBlogList({
        page,
        limit,
        search,
        tag,
        category,
      });
      return result;
    } catch (error) {
      this.logger.error('获取博客列表失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getBlogDetail/:id')
  async getBlogDetail(@Param('id') id: string): Promise<ApiResponse<BlogPost>> {
    this.logger.log(`获取博客详情: ${id}`);
    
    try {
      const result = await this.blogService.getBlogDetail(id);
      return result;
    } catch (error) {
      this.logger.error('获取博客详情失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getBlogBySlug/:slug')
  async getBlogBySlug(@Param('slug') slug: string): Promise<ApiResponse<BlogPost>> {
    this.logger.log(`通过slug获取博客详情: ${slug}`);
    
    try {
      const result = await this.blogService.getBlogBySlug(slug);
      return result;
    } catch (error) {
      this.logger.error('通过slug获取博客详情失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getFeaturedBlogs')
  async getFeaturedBlogs(
    @Query('limit', new ParseIntPipe({ optional: true })) limit?: number,
  ): Promise<ApiResponse<BlogPost[]>> {
    this.logger.log(`获取精选博客: limit=${limit}`);
    
    try {
      const result = await this.blogService.getFeaturedBlogs(limit || 3);
      return result;
    } catch (error) {
      this.logger.error('获取精选博客失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getBlogCategories')
  async getBlogCategories(): Promise<ApiResponse<string[]>> {
    this.logger.log('获取博客分类');
    
    try {
      const result = await this.blogService.getAllCategories();
      return result;
    } catch (error) {
      this.logger.error('获取博客分类失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getBlogTags')
  async getBlogTags(): Promise<ApiResponse<string[]>> {
    this.logger.log('获取博客标签');
    
    try {
      const result = await this.blogService.getAllTags();
      return result;
    } catch (error) {
      this.logger.error('获取博客标签失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }
} 