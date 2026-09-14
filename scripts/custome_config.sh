#!/bin/bash

sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' configs/rockchip/01-nanopi
cd friendlywrt

cat >> feeds.conf.default <<EOF
src-git immortalwrt_packages https://github.com/immortalwrt/packages.git;openwrt-25.12
src-git immortalwrt_luci https://github.com/immortalwrt/luci.git;openwrt-25.12
EOF

./scripts/feeds clean
./scripts/feeds update -a

#只安装你真正需要的插件，举例 homeproxy
./scripts/feeds install luci-app-homeproxy
./scripts/feeds install homeproxy

#把包加入编译配置，内置进固件
cat >> configs/rockchip/01-nanopi <<EOF
CONFIG_PACKAGE_luci-app-homeproxy=y
CONFIG_PACKAGE_homeproxy=y
EOF
# ====================================================================
