#!/bin/bash
set -e

echo "🏗️  构建Lambda Layer..."

# 清理旧的layer构建
rm -rf layer/nodejs/node_modules
rm -rf layer/nodejs/package-lock.json

# 进入layer目录
cd layer/nodejs

echo "📦 安装Layer依赖..."
npm install --production --no-bin-links

# 返回项目根目录
cd ../..

# 生成Prisma客户端
echo "🔧 生成Prisma客户端..."
npx prisma generate

# 确保Layer中包含Prisma客户端所需的文件
echo "📂 复制Prisma文件到Layer..."
mkdir -p layer/nodejs/node_modules/.prisma
cp -r node_modules/.prisma/* layer/nodejs/node_modules/.prisma/
cp prisma/schema.prisma layer/nodejs/node_modules/.prisma/schema.prisma

echo "📊 Layer大小统计:"
du -sh layer/nodejs/node_modules

echo "✅ Layer构建完成！"
echo "📁 Layer内容位于: layer/nodejs/" 