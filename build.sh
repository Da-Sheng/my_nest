#!/bin/bash
set -e
echo "开始构建..."
yarn install
yarn run build:rollup
echo "构建完成" 