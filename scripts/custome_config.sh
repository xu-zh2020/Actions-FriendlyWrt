#!/bin/bash

sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' configs/rockchip/01-nanopi
# ========== 新增 ImmortalWrt feeds 源 ==========
cd friendlywrt

# 写入immortalwrt源到feeds.conf.default
cat >> feeds.conf.default <<EOF
src-git immortalwrt_packages https://github.com/immortalwrt/packages.git;openwrt-25.12
src-git immortalwrt_luci https://github.com/immortalwrt/luci.git;openwrt-25.12
EOF

# 更新feeds并安装包定义
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
# ===============================================
