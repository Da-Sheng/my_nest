#!/bin/bash
set -e

# 简单的版本同步脚本
echo "🔄 同步版本信息..."

# 获取主包版本
MAIN_VERSION=$(node -p "require('./package.json').version")
echo "主包版本: $MAIN_VERSION"

# 同步Layer包版本
if [ -f "layer/nodejs/package.json" ]; then
    # 使用node来更新Layer包版本
    node -e "
        const fs = require('fs');
        const layerPkg = JSON.parse(fs.readFileSync('layer/nodejs/package.json', 'utf8'));
        layerPkg.version = '$MAIN_VERSION';
        fs.writeFileSync('layer/nodejs/package.json', JSON.stringify(layerPkg, null, 4));
        console.log('✅ Layer包版本已同步为: $MAIN_VERSION');
    "
else
    echo "⚠️  找不到layer/nodejs/package.json"
fi

echo "🎉 版本同步完成！" 