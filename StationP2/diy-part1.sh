#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-part1.sh
# Lisence: MIT
#===============================================

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git sirpdboypackage https://github.com/sirpdboy/sirpdboy-package.git' >>feeds.conf.default
echo 'src-git node https://github.com/nxhack/openwrt-node-packages.git' >>feeds.conf.default