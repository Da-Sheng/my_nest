#!/bin/bash
set -e

echo "🚀 开始初始化数据库..."

# 检查必要的环境变量
if [ -z "$DATABASE_URL" ]; then
  echo "❌ 错误: 未设置DATABASE_URL环境变量"
  echo "请设置环境变量: export DATABASE_URL=postgresql://username:password@host:5432/dbname"
  exit 1
fi

# 检查psql命令是否可用
if ! command -v psql &> /dev/null; then
  echo "❌ 错误: 未安装psql命令行工具"
  echo "请安装PostgreSQL客户端工具"
  exit 1
fi

# 检查SQL初始化文件
INIT_SQL_FILE="../../prisma/migrations/init.sql"
if [ ! -f "$INIT_SQL_FILE" ]; then
  echo "❌ 错误: 找不到初始化SQL文件: $INIT_SQL_FILE"
  exit 1
fi

echo "📊 数据库连接信息:"
echo "  URL: $DATABASE_URL"

echo "🔄 执行数据库初始化..."
psql "$DATABASE_URL" -f "$INIT_SQL_FILE"

echo "✅ 数据库初始化完成!"
echo ""
echo "📝 提示: 如果需要插入测试数据，请运行: ./scripts/db-management/seed-db.sh" 