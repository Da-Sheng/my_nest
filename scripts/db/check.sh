#!/bin/bash
set -e

echo "🔍 检查数据库状态..."

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

# 检查SQL验证文件
CHECK_SQL_FILE="../../scripts/check-database.sql"
if [ ! -f "$CHECK_SQL_FILE" ]; then
  echo "❌ 错误: 找不到验证SQL文件: $CHECK_SQL_FILE"
  exit 1
fi

echo "📊 数据库连接信息:"
echo "  URL: $DATABASE_URL"

echo "🔄 执行数据库验证..."
psql "$DATABASE_URL" -f "$CHECK_SQL_FILE"

echo "✅ 数据库验证完成!" 