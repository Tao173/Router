#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-part2.sh
# Lisence: MIT
#===============================================

# 移除lede内重复软件包
#rm -rf feeds/packages/net/mosdns
#rm -rf feeds/packages/admin/netdata
# rm -rf package/lean/luci-app-dockerman
#rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-netgear
#rm -rf feeds/luci/applications/luci-app-netdata
#rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/luci/applications/luci-app-pushbot

# 添加额外软件包
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
# git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/siwind/luci-app-wolplus package/luci-app-wolplus
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
# svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/luci-app-bypass
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-smartdns package/luci-app-smartdns
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat package/luci-app-socat
svn co https://github.com/doushang/luci-app-shortcutmenu/trunk/luci-app-shortcutmenu package/luci-app-shortcutmenu
svn co https://github.com/op4packages/pdnsd-alt/trunk  package/pdnsd-alt
# 增加shortcutmenu默认配置
# curl -fsSL  https://raw.githubusercontent.com/Tao173/Auto-Update-Router/main/DIY/shortcutmenu > ./package/luci-app-shortcutmenu/root/etc/config/shortcutmenu


# 科学上网插件依赖
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# Themes
git clone https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
# git clone https://github.com/XXKDB/luci-theme-argon_armygreen package/luci-theme-argon_armygreen

# DDNS.to
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto package/luci-app-ddnsto
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto package/ddnsto

# 调整位置
sed -i 's/status/services/g' package/luci-app-shortcutmenu/luasrc/controller/*.lua

# 修改插件名字
sed -i 's/"挂载 SMB 网络共享"/"挂载共享"/g' `grep "挂载 SMB 网络共享" -rl ./`
sed -i 's/"Argon 主题设置"/"主题设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' `grep "阿里云盘 WebDAV" -rl ./`
sed -i 's/"USB 打印服务器"/"USB 打印"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"BaiduPCS Web"/"百度网盘"/g' `grep "BaiduPCS Web" -rl ./`
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' `grep "解锁网易云灰色歌曲" -rl ./`
sed -i 's/网页快捷菜单/端口访问/g' `grep "网页快捷菜单" -rl ./`
sed -i 's/AirPlay 2 音频接收器/AirPlay/g' `grep "AirPlay 2 音频接收器" -rl ./`
sed -i 's/Argon 主题设置/主题设置/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/USB 打印服务器/USB打印服务/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' `grep "Turbo ACC 网络加速" -rl ./`
sed -i 's/广告屏蔽大师 Plus+/广告屏蔽大师/g' `grep "广告屏蔽大师 Plus+" -rl ./`


# 修改默认IP
sed -i 's/192.168.1.1/192.168.124.38/g' package/base-files/files/bin/config_generate
# Autocore
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile
#2. 取消首次登陆WEB页密码 设置ttyd免帐号登录
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/default-settings/files/zzz-default-settings
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root::0:0:99999:7:::/' package/default-settings/files/zzz-default-settings
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config
sed -i "s/-SNAPSHOT/-Lienol/g" package/default-settings/files/zzz-default-settings
#7. 修改版本号
# sed -i "s/OpenWrt /OpenWrt-Tao $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/default-settings/files/zzz-default-settings
# Hostname
sed -i 's/OpenWrt/OpenWrt-Tao/g' package/base-files/files/bin/config_generate
#修改主题多余版本信息
## /usr/lib/lua/luci/view/themes/argon/footer.htm
sed -i "s|(<%= ver.luciversion %>)||g" package/luci-theme-argon/luasrc/view/themes/*/footer.htm
sed -i "s|ArgonTheme <%# vPKG_VERSION %></a> /|ArgonTheme <%# vPKG_VERSION %></a>|g" package/luci-theme-argon/luasrc/view/themes/*/footer.htm
sed -i "/<%= ver.distversion %>/d" package/luci-theme-argon/luasrc/view/themes/*/footer.htm
sed -i "s|(<%= ver.luciversion %>)||g" package/luci-theme-argon/luasrc/view/themes/*/footer_login.htm
sed -i "s|ArgonTheme <%# vPKG_VERSION %></a> /|ArgonTheme <%# vPKG_VERSION %></a>|g" package/luci-theme-argon/luasrc/view/themes/*/footer_login.htm
sed -i "/<%= ver.distversion %>/d" package/luci-theme-argon/luasrc/view/themes/*/footer_login.htm
#去除固件版本小尾巴
#sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
#修改web页面内核信息(菜鸟转义)
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep \\"KERNEL_VERSION=5\\" | cut -d \\"=\\" \\-f 2")?g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
#web概览修改
#sed -i "s| + cpubench.cpubench||g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
sed -i "s?boardinfo.release.description + ' / ' : '') + (luciversion || '')?boardinfo.release.description + '  ' : '')?g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#sed -i "s?boardinfo.release.description+' / ':'')+(luciversion||'')?boardinfo.release.description + '  ' : '')?g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
sed -i "66r files/sourcecode" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
sed -i "89a \            _('Source Code'),      sourcelink," feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/default-settings/files/zzz-default-settings
# sed -i '/exit 0/d' package/default-settings/files/zzz-default-settings
# cat files/mydefault >> package/default-settings/files/zzz-default-settings && rm -rf /files/mydefault  
sed -i '16a\msgid "Source Code"' feeds/luci/modules/luci-base/po/zh_Hans/base.po #添加汉化
sed -i '17a\msgstr "编译作者"' feeds/luci/modules/luci-base/po/zh_Hans/base.po #添加汉化
sed -i '18a \\' feeds/luci/modules/luci-base/po/zh_Hans/base.po #添加汉化   

# 状态系统增加个性信息
sed -i "s/exit 0//" package/default-settings/files/zzz-default-settings
echo "sed -i '/CPU usage/a\<tr><td width=\"33%\">关于</td><td><a class=\"author-website\" href=\"https://NOMCAI.ML\">菜菜的壁纸库</a>&nbsp;&nbsp;&nbsp;<a class=\"author-blog\" href=\"https://github.com/Joecaicai/Actions-OpenWrt-AX6.git\">固件编译源地址</a>&nbsp;&nbsp;&nbsp;<a class=\"author-blog\" href=\"https://space.bilibili.com/15669979\">菜菜的哔哩哔哩</a></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
#简化版关于作者
echo "sed -i '/CPU usage/a\<tr><td width=\"33%\">关于</td><td><a class=\"author-website\" href=\"https://NOMCAI.ML\">菜菜的壁纸库</a></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "sed -i '/关于/a\<tr><td width=\"33%\">天气</td><td><iframe width=\"640\" scrolling=\"no\" height=\"75\" frameborder=\"0\" allowtransparency=\"true\" src=\"https://i.tianqi.com?c=code&id=39&color=%23FF7600&icon=3&num=2&site=12\"></iframe></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "sed -i '/天气/a\<tr><td width=\"33%\"> </td><td class=\"container\" style=\"height:200px;\"><canvas class=\"illo\" width=\"640\" height=\"640\" style=\"max-width: 200px; max-height: 200px; touch-action: none; width: 640px; height: 640px;\"></canvas></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
#动漫旋转双人组
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/twopeople1.js\"></script>' >> /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/zdog.dist.js\"></script>' >> /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script id=\"rendered-js\" src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/pen.js\"></script>' >> /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/ginkgo-leaf.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
#嵌入看板娘
echo "echo '<script src=\"https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/font-awesome/css/font-awesome.min.css\"/>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/stevenjoezhang/live2d-widget/autoload.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/live2d-mini/autoload.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "" >> package/default-settings/files/zzz-default-settings
echo "" >> package/default-settings/files/zzz-default-settings
echo "exit 0" >> package/default-settings/files/zzz-default-settings


# dockerd去版本验证
#sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile

#8 预解压安装kodexplorer 提前下载，避免后期需要下载解压
# 会和 apcupsd 冲突
if grep -Eq '^CONFIG_PACKAGE_luci-app-kodexplorer=y' .config;then
    mkdir -p files/opt/kodexplorer
    # curl -s https://api.kodcloud.com/?app/version
    wget --no-check-certificate https://static.kodcloud.com/update/download/kodbox.$(
        curl -s  https://api.github.com/repos/kalcaddle/kodbox/releases/latest | jq -r .name | cut -d " " -f 1
    ).zip -O /tmp/kodbox.zip
    unzip -q  /tmp/kodbox.zip  -d files/opt/kodexplorer
    rm -f /tmp/kodbox.zip
fi

./scripts/feeds update -a
./scripts/feeds install -a
