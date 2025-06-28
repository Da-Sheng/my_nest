import { Injectable, OnModuleInit, OnModuleDestroy, Logger } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(PrismaService.name);

  constructor() {
    super({
      log: ['query', 'info', 'warn', 'error'],
    });
  }

  async onModuleInit() {
    this.logger.log('连接数据库...');
    await this.$connect();
    this.logger.log('数据库连接成功');
  }

  async onModuleDestroy() {
    this.logger.log('断开数据库连接...');
    await this.$disconnect();
    this.logger.log('数据库连接已断开');
  }
} 