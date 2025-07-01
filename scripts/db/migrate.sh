#!/bin/bash
set -e

echo "🚀 开始数据库迁移..."

# 检查必要的环境变量
if [ -z "$DATABASE_URL" ]; then
  echo "❌ 错误: 未设置DATABASE_URL环境变量"
  echo "请设置环境变量: export DATABASE_URL=postgresql://username:password@host:5432/dbname"
  exit 1
fi

# 检查Prisma CLI是否可用
if ! command -v npx &> /dev/null; then
  echo "❌ 错误: 未安装npx命令"
  echo "请安装Node.js和npm"
  exit 1
fi

# 检查schema.prisma文件
SCHEMA_FILE="../../prisma/schema.prisma"
if [ ! -f "$SCHEMA_FILE" ]; then
  echo "❌ 错误: 找不到Prisma schema文件: $SCHEMA_FILE"
  exit 1
fi

echo "📊 数据库连接信息:"
echo "  URL: $DATABASE_URL"

echo "🔄 生成Prisma客户端..."
cd ../..
npx prisma generate

echo "🔄 执行数据库迁移..."
npx prisma db push --accept-data-loss

echo "✅ 数据库迁移完成!" 