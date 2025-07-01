#!/bin/bash
set -e

echo "🚀 部署博客系统到 AWS..."

# 检查必要的工具
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI 未安装，请先安装 AWS CLI"
    exit 1
fi

if ! command -v sam &> /dev/null; then
    echo "❌ SAM CLI 未安装，请先安装 SAM CLI"
    exit 1
fi

# 检查生产环境变量
if [ ! -f .env.sam.local ]; then
    echo "⚠️  .env.sam.local 文件不存在"
    echo "📋 请创建生产环境配置文件 .env.sam.local:"
    echo "NODE_ENV=production"
    echo "DATABASE_URL=\"postgresql://username:password@your-rds-endpoint:5432/blog_prod_db\""
    echo "GITHUB_USERNAME=Da-Sheng"
    echo "GITHUB_TOKEN=your_github_token"
    echo "AWS_REGION=us-east-1"
    exit 1
fi

# 读取生产环境变量
export $(cat .env.sam.local | grep -v '^#' | xargs)

echo "🔨 构建项目..."
# 注意：Layer现在是手动上传的，不再在构建过程中自动构建

# 自动递增版本（patch版本）
echo "📈 自动递增版本..."
OLD_VERSION=$(node -p "require('./package.json').version")
npm version patch --no-git-tag-version
NEW_VERSION=$(node -p "require('./package.json').version")
echo "版本更新: $OLD_VERSION -> $NEW_VERSION"

# 同步Layer版本
chmod +x scripts/layer/manage.sh
./scripts/layer/manage.sh sync

# 使用新的构建脚本，它会自动处理主函数
chmod +x scripts/build/app.sh
./scripts/build/app.sh

echo "📄 验证构建文件..."
if [ ! -f "dist/lambda.js" ]; then
    echo "❌ 构建失败，找不到 dist/lambda.js"
    exit 1
fi

echo "📋 验证 SAM 模板..."
sam validate --template template.yaml

echo "🏗️  构建 SAM 应用..."
sam build

echo "🚀 部署到 AWS..."
sam deploy \
    --guided \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
        Environment=production \
        DatabaseUrl="$DATABASE_URL" \
        GitHubUsername="$GITHUB_USERNAME" \
        GitHubToken="$GITHUB_TOKEN"

echo "✅ 部署完成！"
echo ""
echo "📊 部署信息:"
echo "  - 环境: 生产环境"
echo "  - 应用版本: $NEW_VERSION"
echo "  - 区域: $AWS_REGION"
echo "  - 堆栈: 请查看 SAM 输出获取 API Gateway URL"
echo ""
echo "🔧 有用的命令:"
echo "  - 查看日志: sam logs -n NestLambdaFunction --stack-name <stack-name> --tail"
echo "  - 查看资源: aws cloudformation describe-stacks --stack-name <stack-name>"
echo "  - 删除资源: sam delete --stack-name <stack-name>"
echo ""
echo "📝 测试 API:"
echo "  curl -X GET https://your-api-id.execute-api.region.amazonaws.com/Prod/api/getBlogList"
echo ""
echo "⚠️  注意: 数据库初始化和迁移需要单独执行:"
echo "  1. 连接到EC2实例"
echo "  2. 执行: cd scripts/db"
echo "  3. 执行: ./init.sh 或 ./migrate.sh" 