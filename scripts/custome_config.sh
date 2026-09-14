#!/bin/bash

sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' configs/rockchip/01-nanopi
# ========== 新增 ImmortalWrt opkg软件源（推荐） ==========
cd friendlywrt
# 创建files目录，用来打包文件进固件
mkdir -p files/etc/opkg

# 写入immortalwrt源配置到customfeeds.conf
cat > files/etc/opkg/customfeeds.conf <<EOF
src/gz immortalwrt_base https://mirrors.ustc.edu.cn/immortalwrt/releases/25.12/packages/aarch64_generic/base
src/gz immortalwrt_luci https://mirrors.ustc.edu.cn/immortalwrt/releases/25.12/packages/aarch64_generic/luci
src/gz immortalwrt_packages https://mirrors.ustc.edu.cn/immortalwrt/releases/25.12/packages/aarch64_generic/packages
EOF
# ========================================================
