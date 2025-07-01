#!/bin/bash

# Lambda Layer管理脚本

show_help() {
    echo "🔧 Lambda Layer管理工具"
    echo ""
    echo "用法: $0 [命令]"
    echo ""
    echo "命令:"
    echo "  build      构建layer"
    echo "  clean      清理layer构建产物"
    echo "  rebuild    清理并重新构建layer"
    echo "  info       显示layer信息"
    echo "  deps       显示layer依赖列表"
    echo "  upload     打包并上传layer到AWS Lambda"
    echo "  list       列出AWS上的所有layer版本"
    echo "  help       显示此帮助信息"
    echo ""
}

build_layer() {
    echo "🏗️  构建Lambda Layer..."
    chmod +x scripts/build-layer.sh
    ./scripts/build-layer.sh
}

clean_layer() {
    echo "🧹 清理Layer构建产物..."
    rm -rf layer/nodejs/node_modules
    rm -rf layer/nodejs/package-lock.json
    echo "✅ 清理完成"
}

show_info() {
    echo "📊 Lambda Layer信息:"
    echo ""
    
    if [ -d "layer/nodejs/node_modules" ]; then
        echo "✅ Layer状态: 已构建"
        echo "📁 Layer大小: $(du -sh layer/nodejs/node_modules | cut -f1)"
        echo "📦 依赖数量: $(ls layer/nodejs/node_modules | wc -l | xargs)"
    else
        echo "❌ Layer状态: 未构建"
    fi
    
    echo ""
    echo "📝 Layer配置文件: layer/nodejs/package.json"
    echo "🔧 构建脚本: scripts/build-layer.sh"
}

show_deps() {
    echo "📦 Layer依赖列表:"
    echo ""
    if [ -f "layer/nodejs/package.json" ]; then
        cat layer/nodejs/package.json | grep -A20 '"dependencies"' | grep -E '^\s*".*":' | sed 's/[",]//g' | sed 's/^\s*/  /'
    else
        echo "❌ 找不到layer/nodejs/package.json"
    fi
}

upload_layer() {
    # 检查AWS CLI是否安装
    if ! command -v aws &> /dev/null; then
        echo "❌ AWS CLI未安装，请先安装AWS CLI"
        exit 1
    fi

    # 检查Layer是否已构建
    if [ ! -d "layer/nodejs/node_modules" ]; then
        echo "❌ Layer未构建，请先运行 ./scripts/manage-layer.sh build"
        exit 1
    fi
    
    # 检查Prisma生成文件是否存在
    if [ ! -d "layer/nodejs/node_modules/.prisma" ]; then
        echo "⚠️ Layer中缺少Prisma生成文件，正在添加..."
        # 确保已生成Prisma客户端
        npx prisma generate
        # 复制到Layer
        mkdir -p layer/nodejs/node_modules/.prisma
        cp -r node_modules/.prisma/* layer/nodejs/node_modules/.prisma/
        cp prisma/schema.prisma layer/nodejs/node_modules/.prisma/schema.prisma
    fi

    echo "📦 正在打包Layer..."
    # 创建临时目录
    TEMP_DIR=$(mktemp -d)
    mkdir -p $TEMP_DIR/nodejs
    
    # 复制node_modules到临时目录
    cp -r layer/nodejs/node_modules $TEMP_DIR/nodejs/
    
    # 确保包含schema.prisma文件
    echo "📄 确保包含schema.prisma文件..."
    mkdir -p $TEMP_DIR/nodejs/prisma
    cp prisma/schema.prisma $TEMP_DIR/nodejs/prisma/
    
    # 进入临时目录并创建zip文件
    cd $TEMP_DIR
    zip -r layer.zip nodejs > /dev/null
    cd - > /dev/null
    
    # 移动zip文件到项目目录
    mv $TEMP_DIR/layer.zip ./layer.zip
    
    # 清理临时目录
    rm -rf $TEMP_DIR
    
    echo "📤 正在上传Layer到AWS Lambda..."
    # 从package.json获取版本号
    VERSION=$(node -p "require('./package.json').version")
    
    # 上传Layer
    LAYER_ARN=$(aws lambda publish-layer-version \
        --layer-name node-modules \
        --description "NestJS Lambda Layer v${VERSION}" \
        --license-info "MIT" \
        --compatible-runtimes nodejs22.x \
        --zip-file fileb://layer.zip \
        --output text \
        --query LayerVersionArn)
    
    # 删除zip文件
    rm layer.zip
    
    echo "✅ Layer上传成功！"
    echo "📋 Layer ARN: $LAYER_ARN"
    echo ""
    echo "🔧 在template.yaml中使用此ARN:"
    echo "Layers:"
    echo "  - $LAYER_ARN"
}

list_layers() {
    # 检查AWS CLI是否安装
    if ! command -v aws &> /dev/null; then
        echo "❌ AWS CLI未安装，请先安装AWS CLI"
        exit 1
    fi
    
    echo "📋 正在获取AWS上的Layer列表..."
    aws lambda list-layers --output table
    
    echo ""
    echo "📊 获取特定Layer的版本列表:"
    echo "aws lambda list-layer-versions --layer-name node-modules --output table"
}

case "$1" in
    build)
        build_layer
        ;;
    clean)
        clean_layer
        ;;
    rebuild)
        clean_layer
        build_layer
        ;;
    info)
        show_info
        ;;
    deps)
        show_deps
        ;;
    upload)
        upload_layer
        ;;
    list)
        list_layers
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "❌ 未知命令: $1"
        echo ""
        show_help
        exit 1
        ;;
esac 