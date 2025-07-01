# 简单版本管理指南

## 概述

项目已集成简单的版本管理功能，支持自动递增版本号并同步主包和Layer包版本。

## 使用方法

### 手动版本管理

```bash
# 递增补丁版本 (1.0.0 -> 1.0.1)
npm run version:patch

# 递增次要版本 (1.0.0 -> 1.1.0)
npm run version:minor

# 递增主要版本 (1.0.0 -> 2.0.0)
npm run version:major
```

### 自动版本管理

部署时自动递增patch版本：

```bash
npm run deploy:aws
```

每次部署会自动执行：
1. 递增patch版本
2. 同步Layer包版本
3. 构建和部署

## 版本同步

版本管理会自动确保：
- 主包 (`package.json`) 和Layer包 (`layer/nodejs/package.json`) 版本保持同步
- 每次版本变更后立即同步所有相关文件

## 当前版本

主包版本: 1.1.0
Layer包版本: 1.1.0

## 注意事项

- 版本递增不会创建git标签
- 每次部署会自动递增patch版本
- 如需要控制版本递增类型，请在部署前手动执行版本命令 