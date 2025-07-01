#!/bin/bash
set -e

echo "🚀 开始完整构建..."

# 1. 构建Lambda Layer
# echo "📦 步骤1: 构建Lambda Layer"
# chmod +x scripts/build-layer.sh
# ./scripts/build-layer.sh

# 2. 安装主项目依赖（排除layer中的依赖）
echo "📦 步骤2: 安装主项目依赖"
yarn install

# 3. 生成Prisma客户端
# 这一步很重要，它会:
# - 生成TypeScript类型定义，确保类型安全
# - 提供IDE代码补全支持
# - 作为Layer构建失败时的备份机制
# - 不会执行数据库初始化或迁移
echo "🔧 步骤3: 生成Prisma客户端"
yarn run db:generate

# 4. 构建主函数（rollup会排除layer依赖）
echo "🔨 步骤4: 构建Lambda函数"
yarn run build:rollup

# 5. 验证构建结果
echo "✅ 步骤5: 验证构建结果"
if [ ! -f "dist/lambda.js" ]; then
    echo "❌ 主函数构建失败"
    exit 1
fi

# 不再检查Layer，因为我们使用手动上传的Layer
# if [ ! -d "layer/nodejs/node_modules" ]; then
#     echo "❌ Layer构建失败"
#     exit 1
# fi

echo "📊 构建统计:"
echo "  主函数大小: $(du -sh dist/lambda.js | cut -f1)"
# echo "  Layer大小: $(du -sh layer/nodejs/node_modules | cut -f1)"

echo "🎉 构建完成！" 