import { NestFactory } from '@nestjs/core';
import { AppModule } from './config/app.module';
import { Logger } from '@nestjs/common';
import * as dotenv from 'dotenv';

// 加载环境变量
dotenv.config();

const logger = new Logger('Bootstrap');

export async function createNestApp() {
  const app = await NestFactory.create(AppModule);
  
  // 启用CORS
  app.enableCors({
    origin: true,
    credentials: true,
  });
  
  // 设置全局前缀
  app.setGlobalPrefix('');
  
  // 可在此添加全局中间件、拦截器等
  await app.init();
  return app.getHttpAdapter().getInstance(); // 返回 express 实例
}

// 创建 NestJS 应用实例
const app = NestFactory.create(AppModule);

// 开发环境下启动监听服务
if (process.env.NODE_ENV === 'development') {
  app.then(nestApp => {
    const port = process.env.PORT || 3000;
    
    // 启用CORS
    nestApp.enableCors({
      origin: true,
      credentials: true,
    });
    
    nestApp.listen(port, () => {
      logger.log(`🚀 博客系统BFF启动成功!`);
      logger.log(`📊 服务地址: http://localhost:${port}`);
      logger.log(`📝 API文档: http://localhost:${port}/api`);
      logger.log(`🌍 环境: ${process.env.NODE_ENV}`);
      
      logger.log(`📋 可用的API路由:`);
      logger.log(`  - GET /api/getGit - 获取GitHub仓库列表`);
      logger.log(`  - GET /api/getBlogList - 获取博客列表`);
      logger.log(`  - GET /api/getBlogDetail/:id - 获取博客详情`);
      logger.log(`  - GET /api/getBlogBySlug/:slug - 通过slug获取博客详情`);
      logger.log(`  - GET /api/getFeaturedBlogs - 获取精选博客`);
      logger.log(`  - GET /api/getBlogCategories - 获取博客分类`);
      logger.log(`  - GET /api/getBlogTags - 获取博客标签`);
    });
  });
}

// 默认导出应用实例
export default app; 