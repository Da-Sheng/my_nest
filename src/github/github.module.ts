import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { GitHubController } from './github.controller';
import { GitHubService } from './github.service';
import { ConfigModule } from '../config/config.module';

@Module({
  imports: [
    HttpModule,
    ConfigModule,  // 导入ConfigModule以使ConfigService可用
  ],
  controllers: [GitHubController],
  providers: [GitHubService],
  exports: [GitHubService],
})
export class GitHubModule {} 