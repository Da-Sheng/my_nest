#!/bin/bash
set -e

echo "🚀 启动博客系统开发环境..."

# 检查Docker是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行，请先启动 Docker"
    exit 1
fi

# 检查环境变量文件
if [ ! -f .env ]; then
    echo "⚠️  .env 文件不存在，请参考 config.md 创建环境配置"
    echo "📋 复制开发环境配置到 .env 文件:"
    echo "NODE_ENV=development"
    echo "PORT=3000"
    echo "DATABASE_URL=\"postgresql://postgres:blogpassword@localhost:5432/blog_dev_db?schema=public\""
    echo "GITHUB_USERNAME=Da-Sheng"
    echo "GITHUB_TOKEN=your_github_token_here"
    exit 1
fi

# 启动数据库
echo "🐘 启动 PostgreSQL 数据库..."
docker-compose up -d postgres

# 等待数据库启动
echo "⏳ 等待数据库启动..."
sleep 10

# 检查数据库连接
until docker exec blog_postgres_dev pg_isready -U postgres; do
    echo "⏳ 等待数据库准备就绪..."
    sleep 2
done

echo "✅ 数据库已启动"

# 安装依赖
echo "📦 安装项目依赖..."
pnpm install

# 生成 Prisma Client
echo "🔧 生成 Prisma 客户端..."
npx prisma generate

# 运行数据库迁移
echo "🔄 运行数据库迁移..."
npx prisma db push

# 构建项目
echo "🔨 构建项目..."
pnpm run build

echo "🎉 开发环境启动完成！"
echo ""
echo "📊 服务地址:"
echo "  - 应用服务: http://localhost:3000"
echo "  - PgAdmin:  http://localhost:8080 (admin@blog.com / admin)"
echo ""
echo "🔧 开发命令:"
echo "  - 启动应用: pnpm start"
echo "  - 查看数据库: docker-compose up -d pgadmin"
echo "  - 停止服务: docker-compose down"
echo ""
echo "📝 API 路由:"
echo "  - GitHub 仓库: GET /api/getGit"
echo "  - 博客列表: GET /api/getBlogList"
echo "  - 博客详情: GET /api/getBlogDetail/:id"
echo ""
echo "🚀 现在可以启动应用: pnpm start" 