#!/bin/bash
set -e

# 清理并准备目录
rm -rf build
mkdir -p build/classes build/lib

# 复制编译的类文件
cp -r out/* build/classes/

# 解压 ANTLR 运行时到临时目录
mkdir -p build/tmp
unzip -q antlr-4.9.2-complete.jar -d build/tmp
# 复制 ANTLR 的类文件（排除 META-INF 冲突）
cp -r build/tmp/org build/classes/ 2>/dev/null || true

# 创建 Manifest
mkdir -p build/META-INF
cat > build/META-INF/MANIFEST.MF << MANIFEST
Manifest-Version: 1.0
Main-Class: Compiler

MANIFEST

# 打包 Fat JAR
jar cfm sysycc-fat.jar build/META-INF/MANIFEST.MF -C build/classes .
echo "Fat JAR created: sysycc-fat.jar"
