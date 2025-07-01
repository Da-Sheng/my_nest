# 手动管理Lambda Layer指南

## 概述

本指南说明如何手动构建、上传和管理Lambda Layer，而不是通过SAM模板自动部署。这种方式适合以下场景：

1. Layer很大，每次部署都上传会消耗大量时间和带宽
2. Layer更新频率低，不需要每次应用更新都重新部署
3. 希望更精细地控制Layer的版本和生命周期

## 步骤1: 构建Layer

首先构建Layer，确保所有依赖都正确安装：

```bash
# 构建Layer
./scripts/manage-layer.sh build

# 查看Layer信息
./scripts/manage-layer.sh info
```

## 步骤2: 上传Layer到AWS

使用提供的脚本上传Layer到AWS Lambda：

```bash
# 上传Layer
./scripts/manage-layer.sh upload
```

上传成功后，脚本会输出Layer的ARN，例如：

```
✅ Layer上传成功！
📋 Layer ARN: arn:aws:lambda:ap-southeast-2:123456789012:layer:node-modules:1
```

## 步骤3: 配置template.yaml

修改template.yaml，使用手动上传的Layer ARN：

```yaml
NestLambdaFunction:
  Type: AWS::Serverless::Function
  Properties:
    # ...其他属性...
    Layers:
      - arn:aws:lambda:ap-southeast-2:123456789012:layer:node-modules:1
```

注意：
- 删除或注释掉原有的NodeModulesLayer资源定义
- 确保ARN中的版本号与最新上传的版本一致

## 步骤4: 部署应用

正常部署应用，但不再包含Layer的构建和上传：

```bash
# 部署应用
./deploy-aws.sh
```

## Layer版本管理

每次上传Layer都会创建一个新版本。查看所有Layer版本：

```bash
# 列出所有Layer
./scripts/manage-layer.sh list

# 查看特定Layer的所有版本
aws lambda list-layer-versions --layer-name node-modules --output table
```

## 更新Layer

当依赖需要更新时：

1. 更新`layer/nodejs/package.json`
2. 重新构建Layer: `./scripts/manage-layer.sh rebuild`
3. 上传新版本: `./scripts/manage-layer.sh upload`
4. 更新template.yaml中的Layer ARN版本号
5. 重新部署应用

## 注意事项

1. 手动上传的Layer不会随SAM堆栈的删除而删除，需要手动清理
2. 确保Layer的运行时兼容性与Lambda函数一致
3. 保持Layer大小在合理范围内（最大250MB）
4. 记录每个版本的变更，便于追踪和回滚 