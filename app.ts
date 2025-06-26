import { NestFactory } from '@nestjs/core';
import { AppModule } from './config/app.module';

export async function createNestApp() {
  const app = await NestFactory.create(AppModule);
  // 可在此添加全局中间件、拦截器等
  await app.init();
  return app.getHttpAdapter().getInstance(); // 返回 express 实例
} 