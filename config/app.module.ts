import { Module } from '@nestjs/common';
import { ConfigModule } from '../src/config/config.module';
import { DatabaseModule } from '../src/database/database.module';
import { BlogModule } from '../src/blog/blog.module';
import { GitHubModule } from '../src/github/github.module';

@Module({
  imports: [
    ConfigModule,     // 全局配置模块
    DatabaseModule,
    BlogModule,
    GitHubModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {} 