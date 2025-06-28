import { Module } from '@nestjs/common';
import { DatabaseModule } from '../src/database/database.module';
import { BlogModule } from '../src/blog/blog.module';
import { GitHubModule } from '../src/github/github.module';

@Module({
  imports: [
    DatabaseModule,
    BlogModule,
    GitHubModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {} 