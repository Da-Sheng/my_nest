import { NestFactory } from '@nestjs/core';
import { AppModule } from './config/app.module';

export async function createNestApp() {
  const app = await NestFactory.create(AppModule);
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
    nestApp.listen(port, () => {
      console.log(`页面一对Server BFF启动成功! 端口: http://localhost:${port}`);
    });
  });
}

// 默认导出应用实例
export default app; 