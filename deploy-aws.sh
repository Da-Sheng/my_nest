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

# 检查AWS凭证
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS 凭证未配置，请运行 'aws configure'"
    exit 1
fi

# 检查生产环境变量
if [ ! -f .env.production ]; then
    echo "⚠️  .env.production 文件不存在"
    echo "📋 请创建生产环境配置文件 .env.production:"
    echo "NODE_ENV=production"
    echo "DATABASE_URL=\"postgresql://username:password@your-rds-endpoint:5432/blog_prod_db\""
    echo "GITHUB_USERNAME=Da-Sheng"
    echo "GITHUB_TOKEN=your_github_token"
    echo "AWS_REGION=us-east-1"
    exit 1
fi

# 读取生产环境变量
export $(cat .env.production | grep -v '^#' | xargs)

echo "📦 安装生产依赖..."
pnpm install --production

echo "🔧 生成 Prisma 客户端..."
npx prisma generate

echo "🔨 构建项目..."
pnpm run build

echo "📄 验证构建文件..."
if [ ! -f "dist/lambda.js" ]; then
    echo "❌ 构建失败，找不到 dist/lambda.js"
    exit 1
fi

echo "🔄 运行数据库迁移 (生产环境)..."
npx prisma db push

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