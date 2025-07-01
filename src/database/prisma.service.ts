import { Injectable, OnModuleInit, OnModuleDestroy, Logger } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(PrismaService.name);

  constructor() {
    super({
      log: ['error', 'warn'],
      errorFormat: 'minimal',
    });
    this.logger.log('PrismaService实例已创建');
  }

  async onModuleInit() {
    try {
      this.logger.log('连接数据库...');
      await this.$connect();
      this.logger.log('数据库连接成功');
    } catch (error) {
      this.logger.error(`数据库连接失败: ${error.message}`);
      // 不抛出异常，让应用继续启动，后续操作会在需要时处理错误
    }
  }

  async onModuleDestroy() {
    try {
      this.logger.log('断开数据库连接...');
      await this.$disconnect();
      this.logger.log('数据库连接已断开');
    } catch (error) {
      this.logger.error(`断开数据库连接失败: ${error.message}`);
    }
  }
} 