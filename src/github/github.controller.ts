import { Controller, Get, Logger, Query, Param } from '@nestjs/common';
import { GitHubService } from './github.service';
import { ApiResponse, GitHubRepo } from '../../types';

@Controller('api')
export class GitHubController {
  private readonly logger = new Logger(GitHubController.name);

  constructor(private readonly githubService: GitHubService) {}

  @Get('getGit')
  async getRepositories(@Query('username') username?: string): Promise<ApiResponse<GitHubRepo[]>> {
    const targetUsername = username || process.env.GITHUB_USERNAME || 'Da-Sheng';
    
    this.logger.log(`获取GitHub仓库列表: ${targetUsername}`);
    
    try {
      const result = await this.githubService.getUserRepositories(targetUsername);
      return result;
    } catch (error) {
      this.logger.error('获取GitHub仓库失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getGit/:username')
  async getUserRepositories(@Param('username') username: string): Promise<ApiResponse<GitHubRepo[]>> {
    this.logger.log(`获取指定用户GitHub仓库列表: ${username}`);
    
    try {
      const result = await this.githubService.getUserRepositories(username);
      return result;
    } catch (error) {
      this.logger.error('获取GitHub仓库失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }

  @Get('getGit/:username/:repo')
  async getRepositoryDetails(
    @Param('username') username: string,
    @Param('repo') repo: string,
  ): Promise<ApiResponse<GitHubRepo>> {
    this.logger.log(`获取仓库详情: ${username}/${repo}`);
    
    try {
      const result = await this.githubService.getRepositoryDetails(username, repo);
      return result;
    } catch (error) {
      this.logger.error('获取仓库详情失败:', error);
      return {
        success: false,
        error: '服务器内部错误',
      };
    }
  }
} 