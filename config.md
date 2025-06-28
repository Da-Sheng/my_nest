# 环境变量配置说明

## 开发环境 (.env.development)
```env
NODE_ENV=development
PORT=3000
DATABASE_URL="postgresql://postgres:blogpassword@localhost:5432/blog_dev_db?schema=public"
POSTGRES_DB=blog_dev_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=blogpassword
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
GITHUB_USERNAME=Da-Sheng
GITHUB_TOKEN=ghp_your_github_personal_access_token
LOG_LEVEL=debug
```

## 生产环境 (.env.production)
```env
NODE_ENV=production
PORT=3000
DATABASE_URL="postgresql://your_username:your_password@your-rds-endpoint.amazonaws.com:5432/blog_prod_db?schema=public"
GITHUB_USERNAME=Da-Sheng
GITHUB_TOKEN=ghp_your_github_personal_access_token
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
LOG_LEVEL=info
```

## 配置说明
1. **DATABASE_URL**: 数据库连接字符串
2. **GITHUB_TOKEN**: GitHub Personal Access Token，用于调用 GitHub API
3. **AWS 配置**: 生产环境 RDS 数据库连接信息
4. **日志级别**: 开发环境用 debug，生产环境用 info

## 设置步骤
1. 复制对应环境的配置到项目根目录的 `.env` 文件
2. 替换其中的占位符为真实值
3. 确保 `.env` 文件在 `.gitignore` 中 