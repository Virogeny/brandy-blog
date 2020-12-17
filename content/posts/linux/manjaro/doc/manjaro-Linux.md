+++
title = "manjaro配置"
description = "manjaro linux使用记录"
date = 2020-12-09T14:32:25+08:00
tags = ["linux"]
categories = ["linux"]
draft = false

+++

## 分区

- 参考：[博客](<https://coreja.com/DailyHack/2018/12/Manjaro%E5%AE%89%E8%A3%85%E9%85%8D%E7%BD%AE%E5%B0%8F%E8%AE%B0/#more>)

- >非标准(按需分配，至少有/分区):  

|文件类型|  文件夹  |大小（M）|标记|
|:-----:|:-------:|:------:|:---:|
|fat32  |/boot/efi|300M    |boot,esp（用于双系统启动分区）|
|ext4   |/opt     |20G     |第三方软件安装目录|
|ext4   |/        |40G     |根分区|
|swap   |swap     |4G      |交换分区（一般是内存的一半）|
|home |/home |120G |用户主目录|
|boot |/boot |1G |启动 Linux 时使用的一些核心文件，包括一些连接文件以及镜像文件|
|var |/var |20G |各种日志文件|
|usr |/usr |50G |应用程序和文件都放在这个目录下|

---

## 配置系统源

社区镜像地址参考：[github](https://github.com/archlinuxcn/mirrorlist-repo)

``` sh
# 执行命令，等弹窗出来后选择一个源地址
sudo pacman-mirrors -i -c China -m rank

# 执行
sudo pacman -Syy

# 添加AUR 在/etc/pacman.conf配置文件中添加AUR源
# server地址可查找Wiki
echo "
# AUR仓库地址
[archlinuxcn]
SigLevel = Optional TrustedOnly
# SigLevel = Optional TrustAll
# Server = Server= http://repo.archlinuxcn.org/$arch
Server = http://mirrors.163.com/archlinux-cn/$arch" >> /etc/pacman.conf

# 执行命令更新缓存以及导入密钥链
sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring
```

- $\color{red}\textbf{注意：最后一步可能不成功，一般是国内网络的问题，重复刷新即可}$

---

## 解决安装软件后有错误信息提示的问题

>`说明：一般安装软件最后一步提示错误，但是软件可以正常使用，是因为国内网络访问不了github，可在hosts中添加以下地址解决，但是可能会失效，请自行google进行更新`

```sh
echo "
# github,解决安装完软件报错问题
199.232.4.133 raw.githubusercontent.com

# GitHub Start
52.74.223.119 github.com
192.30.253.119 gist.github.com
54.169.195.247 api.github.com
185.199.111.153 assets-cdn.github.com
151.101.76.133 raw.githubusercontent.com
151.101.108.133 user-images.githubusercontent.com
151.101.76.133 gist.githubusercontent.com
151.101.76.133 cloud.githubusercontent.com
151.101.76.133 camo.githubusercontent.com
151.101.76.133 avatars0.githubusercontent.com
151.101.76.133 avatars1.githubusercontent.com
151.101.76.133 avatars2.githubusercontent.com
151.101.76.133 avatars3.githubusercontent.com
151.101.76.133 avatars4.githubusercontent.com
151.101.76.133 avatars5.githubusercontent.com
151.101.76.133 avatars6.githubusercontent.com
151.101.76.133 avatars7.githubusercontent.com
151.101.76.133 avatars8.githubusercontent.com
# GitHub End
" >> /etc/hosts

```

---

## linux软件

- > *`不需要的软件`*  
  > `Thunderbird` # 雷鸟邮箱  
  > `konversation` # 自带聊天工具  
  > `kget` # kget下载器  
  > `vi` # vi编辑器  
  > `spectacle` # 自带的截图软件  
  > `steam-manjaro` #自带steam  
  > `cantata` # 自带音乐播放器  
  >
  > `nano` # 类似vim的终端编辑器
  >
  > `manjaro-hello` # hello
  >
  > `manjaro-documentation-en` # manjaro英文文档

---

- > 常用或备用软件
  > `chromium/firefox` 浏览器  
  >
  > `WPS` [办公软件](#安装wps)  
  > `neovim` [终端编辑器](#安装neovim)  
  > `vscode` 编辑器，IDE  
  > `微信` [deepin-wechat](#微信)  
  >
  > `yay` AUR包管理工具
  >
  > `flameshot` [火焰截图](#安装flameshot)  
  >
  > `netease-cloud-music`  网易云音乐（[无法输入中文](https://blog.csdn.net/qq_35034099/article/details/105990728)）
  >
  > `fcitx5` [输入法](#安装输入法)
  >
  > `smartgit/gitkraken` git/svn可视化工具（付费）

---

## 安装flameshot

> 配置快捷键直接进行截图，而不用点击才能截图
>
> ```sh
> # 配置命令
> # 普通截图
> flameshot gui
> # 延迟2秒截图，适合截取鼠标悬停的提示信息
> flameshot gui -d 2000
> ```

---

## 安装输入法

> `目前感觉fcitx5的拼音输入法比较好用，具体可自行前往fcitx5的wiki`  
> 以下基于： [fcitx5维基](<https://wiki.archlinux.org/index.php/Fcitx5_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)>) 配置

```sh
#安装fcitx5框架（包括qt，gtk，tool） 拼音输入法 皮肤 萌娘百科词库（AUR可选） 中午呢维基词库（AUR可选）
sudo pacman -Sy fcitx5-im fcitx5-chinese-addons fcitx5-material-color fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki

# 如果没有生成配置文件，则需要在~/.pam_environment中配置环境变量
echo "
INPUT_METHOD  DEFAULT=fcitx5
GTK_IM_MODULE DEFAULT=fcitx5
QT_IM_MODULE  DEFAULT=fcitx5
XMODIFIERS    DEFAULT=\@im=fcitx5
" >> ~/.pam_environment

# 如果没有开机加载，则需要在~/.xprofile添加配置（未测试）
echo "
# 配置fcitx5开机加载
fcitx5 &

# 解决WPS无法输入中文
export QT_IM_MODULE=fcitx5
" >>  ~/.xprofile
```

- $\color{red}\textbf{注意：安装完成之后需要重新登录}$
  
---

## win10双系统删除多余EFI分区

`win10下进行以下操作：`
参考：[CSDN博客](<https://blog.csdn.net/g1027785756/article/details/82999451>)

> - 1. 管理员权限打开cmd控制台，输入：【diskpart】进入命令行分区管理工具
> - 2. 输入【list disk】查看磁盘信息
> - 3. 输入【select disk n】选择所安装的系统EFI分区的磁盘。n：表示磁盘号。 例如：select disk 1；标识选择了磁盘号为1的磁盘
>- 4. 输入【list partition】查看所选磁盘下的分区信息
>- 5. 输入【select partition n】选择EFI分区所在的系统分区上。n：表示分区号。例如：select partition 1；表示选择了当前磁盘下分区号为1的磁盘分区
>- 6. 输入【assign letter=p】p是盘符，只要和自己本地已有的盘符不重复即可，这一步可以将EFI分区转为和普通盘一样的可见磁盘
>- 7. 在我的电脑处查看win10的磁盘会发现多了一个盘，不能直接打开，会提示权限不够
>- 8. 管理员权限打开记事本，从文件打开p盘，会发现有已安装系统的引导，直接删除即可
>- 9. 回到【diskpart】工具处输入【remove letter=p】即可删除p盘

---

## git连接github私有仓库问题（仅参考）

```sh
#查看git配置
git config --list
#设置全局用户名/邮箱
git config --global user.name 'Virogeny'
git config --global user.email 'mescal1993@hotmail.com'
#初始化本地新的git仓库
git init
#查看状态
git status
#文件添加进缓存区
git add 文件名
#删除文件
git rm 文件名
#提交
git commot -m '提交描述'
#克隆github仓库
git clone 地址
#拉取代码
git push
#私有仓库每次都要输入密码解决将用户名和密码写入url
vim .git/config
#推送
git push
```

- 每次push都要输入密码：

```sh
# 执行命令，然后在输入一次就好了
git config --global credential.helper store
```



---

## 开机挂载硬盘

> 参考：[CDSN博客](<https://blog.csdn.net/weixin_43840399/article/details/93475915>)

```shell
#查看已挂载的磁盘，记住要开机挂在的文件系统名
df -h
#查看文件系统名的uuid，记录uuid
ls -l /dev/disk/by-uuid/ | grep sda2
#编辑/etc/fstab
#如果需要自定义挂载点则需要提前建好挂载点的空文件夹，在文件最后添加
UUID=查询的uuid 要挂在到的目录 ntfs defaults 0 0
#UUID是刚刚查询出来的
#/home/mazo/data表示挂载点
#ntfs表示格式，小写
#0 0表示开机不检查磁盘。
#然后保存重启，查看
df -h
```

---

## 配置JDK

> 1. 解压JDK文件
> 2. 在/etc/profile中配置环境变量

- $\color{red}\textbf{注意: JAVA_HOME是JDK安装路径}$

```sh
# 添加环境变量
echo "
# JDK
export JAVA_HOME=/opt/work-tool/jdk1.8.0_241/
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
" >> /etc/profile

# 刷新环境变量（只应用于当前窗口）
source /etc/profile

#查看java版本
java -version
```

---

## 配置MAVEN

> 1. 解压maven压缩包
> 2. 在/etc/profile中配置环境变量

- $\color{red}\textbf{注意：MAVEN_HOME是maven的安装路径}$

```sh
echo "
# MAVEN
export MAVEN_HOME=/opt/work-tool/apache-maven-3.6.3/
export PATH=$MAVEN_HOME/bin:$PATH
" >> /etc/profile

# 刷新环境变量（只应用于当前窗口）
source /etc/profile

#查看maven版本
mvn -v
```

---

## 安装WPS

- $\color{red}\textbf{注意：无法输入中文见上文}$ [安装输入法](#安装输入法)

~~过时的安装方法：sudo pacman -Sy wps-office wps-office-mui-zh-cn ttf-wps-fonts~~

```sh
# 安装wps中文版（装上之后可能还是英文）
yay -Sy wps-office-cn
# 安装wps英文版
yay -Sy wps-office
# 安装wps中文包
yay -Sy wps-office-mui-zh-cn
```

`如果安装之后界面没有设置为中文，则随便建立一个文档，点击右上角的A图标进行语言设置`

---

## 配置zsh终端

- 参考： [博客配置oh-my-zsh](<https://coreja.com/DailyHack/2019/08/config-your-super-zsh/>)

- 参考： [博客主ob-my-zsh打包](<https://coreja.com/DailyHack/2019/08/config-your-super-zsh/oh-my-zsh-core.zip>)

```txt
1. 下载上述链接，将其中的oh-my-zsh-core变成.oh-my-zsh并放在用户目录下。
2. 复制zshrc变成.zshrc到用户目录下
3. 执行chsh -s /usr/bin/zsh，默认使用zsh，这个时候输入zsh应该已经能看到雏形了。
4. 安装压缩包里的两个字体（或者上述有关nerd font链接中任意字体）设置你的终端，使用刚刚安装好的字体
```

---

## 安装neovim

```sh
#安装neovim
# xsel 终端剪切板共用工具
sudo pacman -Sy neovim xsel
#安装vim插件管理工具
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

`配置文件：~/.config/nvim/init.vim：`

- 插件安装参考[github](https://github.com/junegunn/vim-plug)

```.vim
# neovim基础配置推荐：
echo "
" vim配置文件
"--------------------------
" 开启代码高亮
syntax on

" 开启行号显示
set number

" 启用鼠标
set mouse=a

" tab键的宽度
set tabstop=4

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 行号突出显示
" 取消可以在单词前加no
set relativenumber

" 正在编辑的一行显示编辑线
set cursorline

" 编辑时文字不会超出编辑区
set wrap

" vim命令模式下tab键提示
set wildmenu

" 高亮搜索内容
set hlsearch

" 正在搜索输入内容便会高亮显示
set incsearch

" 搜索时忽略大小写
set ignorecase

" 搜索时智能识别大小写
set smartcase

" vim与系统剪切板共享
set clipboard=unnamedplus

" 插件安装
call plug#begin('~/.config/nvim/plugged')

" Plug '插件名或者git路径'获取获取插件
" PlugInstall [name ...] [#threads] 安装插件
" PlugUpdate [name ...] [#threads] 安装或者更新插件
" PlugClean[!] 删除没有列出的插件
" PlugUpgrade 升级 vim-plug
" PlugStatus 检查插件状态

" 插件安装结束
call plug#end()

" >> ~/.config/nvim/init.vim
```

---

## wine安装

- 参考[文章](https://ywnz.com/linuxjc/2553.html)

```sh
# 执行命令
sudo pacman -S wine wine_gecko wine-mono winetricks

# 使用WINEARCH建立32位环境配置
# WINEPREFIX指定安装目录
WINEARCH=win32 WINEPREFIX=/opt/wine32 winecfg
#启动之后进行配置，主要是文件夹映射关系

#在～/xprofile添加变量使wine每次都以32位启动
export WINEARCH=win32
# 更改wine容器默认地址
export WINEPREFIX=/opt/wine32 # 重启生效

# wine安装时最好指定安装目录（完整命令）
WINEARCH=win32 WINEPREFIX=~/.wine wine xx.exe

# 安装必备组件
winetricks riched20
winetricks riched32

# 配置好的命令之后可以简化命令
wine xx.exe

```

---

## 创建桌面快捷方式

```desktop
[Desktop Entry]
Encoding=UTF-8
#版本号
Version=1.0
# 英文名字
Name=yEd
# 完整名字
GenericName=GUI Port Scanner
# 应用启动路径
Exec=java -jar /opt/yed-3.11.1/yed.jar
# 是否在终端运行
Terminal=false
# 图标路径
Icon=/opt/yed-3.11.1/icons/yicon32.png
# 类型
Type=Application
# 应用所属类别，会根据这个在菜单中分类
Categories=Application;Network;Security;should be listed.
# 详细描述
Comment=yEd Graph Editor
```

---

## manjaro基础命令

```sh
# 清除无用包
sudo pacman -Rs $(pacman -Qdtq)
#安装软件前最好执行升级系统命令
sudo pacman -Syu
#安装软件包
sudo pacman -Sy pkg_name
sudo pacman -S pkg_name
#从本地安装软件包
sudo pacman -U pkg_name.tar.xz
sudo pacman -U http://www.example.com/repo/example.pkg.tar.xz
#删除软件包
sudo pacman -R pak_name
#删除软件包以及没有被其他软件使用的依赖
sudo pacman -Rs pkg_name
#查询本地已安装的软件包
pacman -Qs pkg_name
#清理未使用的软件包缓存（/var/cache/pacman/pkg）
pacman -Sc
#清理所有未安装的包的缓存
paccache -ruk0
#下载包而不安装
pacman -Sw pkg_name
#列出已经安装的软件包
pacman -Q
#查看virtualbox包是否已经安装
pacman -Q virtualbox
#查看已安装的包virtualbox的详细信息 pacman -Qi virtualbox
#列出已安装包virtualbox的所有文件
pacman -Ql virtualbox
#查找某个文件属于哪个包
pacman -Qo /etc/passwd
#查询包组
pacman -Sg
#查询包组所包含的软件包
pacman -Sg gnome
#搜索virtualbox相关的包
pacman -Ss virtualbox
#从数据库中搜索virtualbox的信息
pacman -Si virtualbox
#仅同步源
sudo pacman -Sy
#更新系统
sudo pacman -Su
#同步源并更新系统
sudo pacman -Syu
#同步源后安装包
sudo pacman -Sy virtualbox
#从本地数据库中获取virtualbox的信息，并下载安装
sudo pacman -S virtualbox
#强制安装virtualbox包
sudo pacman -Sf virtualbox
#删除virtualbox
sudo pacman -R virtualbox
#强制删除被依赖的包（慎用）
sudo pacman -Rd virtualbox
#删除virtualbox包及依赖其的包
sudo pacman -Rc virtualbox
#删除virtualbox包及其依赖的包
sudo pacman -Rsc virtualbox
#清理/var/cache/pacman/pkg目录下的旧包
sudo pacman -Sc
#清除所有下载的包和数据库
sudo pacman -Scc
#安装下载的virtualbox包（有时候需要降级包的时候就用这个）
cd /var/cache/pacman/pkg
sudo pacman -U virtualbox-5.2.12-1-x86_64.pkg.tar.xz
#升级时不升级virtualbox包
sudo pacman -Su --ignore virtualbox
# 清理无用依赖
yay -Yc

```

`其他命令：`

```sh
#改变shell
chsh -s /bin/zsh
#查看shell
echo $SHELL
#创建用户
useradd 用户名
#设置密码
passed 密码
#彻底删除用户
userdel -r 用户名
#杀掉其他登录的用户
sudo pkill -u 用户名
```

---

## 安装redis

### `1. 可以直接执行命令安装`

```sh
# 执行命令
sudo pacman -Sy redis
systemctl stop|start redis.service
######################
```

### `2. redis包安装`

- [参考文章](https://blog.csdn.net/zzlove1234567890/article/details/90579360)

```sh
# 解压下载的redis压缩包
#进入文件夹
cd redis-6.0.6
# 执行make编译
make
#进入到解压后的 src 目录，通过如下命令启动Redis:
src/redis-server
```

### `3. redis可视化工具`

> AnotherRedisDesktopManager
>
> - 参考[gitee](https://gitee.com/qishibo/AnotherRedisDesktopManager)
> - 参考[github](https://github.com/qishibo/AnotherRedisDesktopManager)

---

## 安装mysql

### `1. 包安装（容易出现各种问题）`

```sh
# 解压进入mysql文件夹
# 创建data文件夹存放数据库数据
mkdir /usr/local/otherTool/mysql-5.7.30/data
# 创建用户组
sudo groupadd mysql
#-r参数表示mysql用户是系统用户，不可用于登录系统，创建用户mysql并将其添加到用户组mysql中
sudo useradd -r -g mysql mysql
# 将mysql目录权限赋予mysql用户
sudo chown -R mysql /usr/local/otherTool/mysql-5.7.30  
sudo chgrp -R mysql /usr/local/otherTool/mysql-5.7.30
```

- 配置文件：
  
```my.cnf
#创建配置文件，并设置文件权限（很重要）
vim /etc/my.cnf
sudo chmod 644 my.cnf
# mysql配置
[client]
default-character-set=utf8
port = 3306
socket = /tmp/mysql.sock

[mysql]
default-character-set=utf8
port = 3306
socket = /tmp/mysql.sock

[mysqld]
character_set_server=utf8
init_connect='SET NAMES utf8'
# mysql路径
basedir=/usr/local/otherTool/mysql-5.7.30
# mysql的数据data包路径
datadir=/usr/local/otherTool/mysql-5.7.30/data
socket=/tmp/mysql.sock
log-error=/var/log/mysqld.log
# 不指定会当在data文件夹里，指定了就会有权限问题
# pid-file=/var/run/mysqld/mysqld.pid

# 不区分大小写
lower_case_table_names = 1
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
max_connections=5000
default-time_zone = '+8:00'

# 开启查询缓存
explicit_defaults_for_timestamp=true`在这里插入代码片`

# 登陆跳过密码
skip-grant-tables
```

```sh
# 切换到/var/log/创建日志文件mysqld.log并设置读写权限
cd /var/log
sudo touch mysqld.log
sudo chmod 777 mysqld.log

# 切换到mysql目录下初始化数据库
cd /usr/local/otherTool/mysql-5.7.30
sudo bin/mysqld --initialize --user=mysql

# 错误信息.so文件不存在，需要安装依赖
sudo pacman -Sy numactl ncurses5-compat-libs

# 启动mysql
sudo /usr/local/otherTool/mysql-5.7.30/support-files/mysql.server start

# 将当前用户添加到mysql组中
# sudo usermod -a -G mysql brandy
#启动
sudo /usr/local/otherTool/mysql-5.7.30/support-files/mysql.server start
# 修改密码
set password for 用户名@localhost = password(‘新密码’);
flush privileges;
# 取消配置文件终端哦跳过密码选项重启
# 登陆
/usr/local/otherTool/mysql-5.7.30/bin/mysql -uroot -proot
```

### `2. mysql替代方案（mariadb）`

```sh
# 安装mariadb数据库
sudo pacman -Sy mariadb
# 安装完成后根据提示执行命令（此部分会在终端提示）
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# 执行命令根据提示设置密码
sudo /usr/bin/mysql_secure_installation
# 启动或停止数据库
systemctl stop|start mariadb.service

# 使用工具接连数据库时要用127.0.0.1，不能使用localhost

`# 更改配置`
# 查看数据库是否区分大小写
`show variables like 'lower%';`
# 如果lower_case_table_names=1则区分大小写
# 修改文件/etc/my.cnf添加
`lower_case_table_name=1`
# 重启数据库
```

---

## 破解navicat15(无法输入中文)

- [参考github](https://github.com/HeQuanX/learning/releases/tag/1.0.1)


$\color{red}\textbf{注意：破解时需要断网输入激活码，破解文件要和navicat安装包在同意目录下}$

```sh
# 解压文件
tar -zxvf navicat15-zh.tar
# 进入bin目录
cd ./navicat15-zh/bin
# 先（断网）启动navicat,然后执行破解命令
./navicat-keygen --text ./RegPrivateKey.pem
# 根据控制台提示进行破解
```

---

## manjaros使用偶尔黑屏解决方案

```cfg
# 在/boot/grub/grub.cfg中修改
# `### BEGIN /etc/grub.d/10_linux ###`注释下的第一个rw  quiet后面追加内容
rw  quiet xdriver=mesa acpi_osi=! acpi_osi="Windows 2009"
#千万不要错，否则可能出问题
```

---

## Vbox安装

```sh
# 安装对应内核版本的vbox
uname -a
sudo pacman -Sy virtualbox virtualbox-ext-oracle
执行命令或重启
sudo modprobe vboxdrv
```

---

## tigerVNC

- [参考博客](https://coreja.com/DailyHack/2020/03/TigerVNC/#more)
- [win10客户端下载地址](https://bintray.com/tigervnc/stable/tigervnc/1.10.1)

```sh
# manajro上执行命令安装
sudo pacman -Sy tigervnc
# 理论上第一次链接会让输入密码，如果没有密码则执行命令根据提示修改密码
vncpasswd
# 输入命令启动（从5900开始,:1就是+1-->5901）这种启动会有问题，需要另外配置
vncserver :1
# 简单启动（端口5900）
x0vncserver -display :0 -passwordfile ~/.vnc/passwd
# 访问时用ip:端口号:例如
192.168.0.1：5900
```

---

## 安装win字体

- [参考文章](https://blog.csdn.net/sinat_33528967/article/details/93380729?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2~all~sobaiduend~default-1-93380729.nonecase&utm_term=manjaro%E5%AD%97%E4%BD%93%E5%AE%89%E8%A3%85&spm=1000.2123.3001.4430)

> 将win上`C:/Windows/Fonts/`中的字体复制到`/usr/share/fonts/`中，最好新建个文件夹

```sh
#执行命令 建立字体索引信息，更新字体缓存
sudo mkfontscale
sudo mkfontdir
fc-cache -fv
```

---

## yay安装软件提示错误信息

> 提示：Cannot find the strip binary required for object file stripping.
 	  解决：sudo pacman -Sy base-devel

---

## 解压zip中文乱码

```shell script
# 使用unar解压
sudo pacman -Sy unarchiver

unar -e cp936 ./xx.zip
```

---

## 微信

[参考github](https://github.com/countstarlight/deepin-wine-wechat-arch)

- 安装成功后可能还有bug,万恶的腾讯

---

- 

---

## idea

###  1. idea常用插件

> `CamelCase` Alt + Shift + U 可以把你的变量格式任意变化，比如驼峰等等。  
> `Translation` 翻译，主要用它翻译源码上面的doc注释，Ctlr + Q 就可以。
> `myBatisCodeHelperPro` mybatis提示（在蓝奏云网盘上）

###  2. idea全局菜单栏（2019版本之前）

```sh
# 安装依赖
sudo pacman -Sy libdbusmenu-glib
```

### 3. idea新版破解

- 关注公众号`Java学习者社区`，回复“idea”
- 关注公众号[搜云库技术团队](https://tech.souyunku.com/?p=30970)

### 4. idea2018.3.6破解

1. 将JetbrainsIdesCrack-4.2.jar放入idea安装目录中
2. 在bin的配置文件"idea64.exe.vmoptions"最后添加jar包路径：(具体路径按照自己的文件路径为准)  
   -javaagent:D:\Virus\ideaIU-2018.3.6.win\bin\JetbrainsIdesCrack-4.2.jar
3. 启动idea,打开激活页面,选择Activation code,然后复制以下代码:  

> ThisCrackLicenseId-{
> “licenseId”:”ThisCrackLicenseId”,
> “licenseeName”:”idea”,
> “assigneeName”:”“,
> “assigneeEmail”:”idea@gmail.com”,
> “licenseRestriction”:”For This Crack, Only Test! Please support genuine!!!”,
> “checkConcurrentUse”:false,
> “products”:[
> {“code”:”II”,”paidUpTo”:”2099-12-31”},
> {“code”:”DM”,”paidUpTo”:”2099-12-31”},
> {“code”:”AC”,”paidUpTo”:”2099-12-31”},
> {“code”:”RS0”,”paidUpTo”:”2099-12-31”},
> {“code”:”WS”,”paidUpTo”:”2099-12-31”},
> {“code”:”DPN”,”paidUpTo”:”2099-12-31”},
> {“code”:”RC”,”paidUpTo”:”2099-12-31”},
> {“code”:”PS”,”paidUpTo”:”2099-12-31”},
> {“code”:”DC”,”paidUpTo”:”2099-12-31”},
> {“code”:”RM”,”paidUpTo”:”2099-12-31”},
> {“code”:”CL”,”paidUpTo”:”2099-12-31”},
> {“code”:”PC”,”paidUpTo”:”2099-12-31”}
> ],
> “hash”:”2911276/0”,
> “gracePeriodDays”:7,
> "autoProlongated":false}

- 有需要的话也可以将以下地址添加进host文件禁止链接idea官网:  
  0.0.0.0 account.jetbrains.com  
  0.0.0.0 www.jetbrains.com

## 配置gitee.io

### 1. 安装hugo	[中文文档](https://www.gohugo.org/)

```sh
sudo pacman -Sy hugo
# 在代码根目录
# 创建新模板
hugo new ./content/posts/fire.md
# 启动服务
hugo server
```

### 2. 主题

[github](https://github.com/nodejh/hugo-theme-cactus-plus/blob/master/README_zh-cn.md)

### 3. [我的地址](https://brandykk.gitee.io/)

## 启用TRIM（仅 SSD）

- 如果你的根分区已经安装在了 SSD 上，启用 [TRIM](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Trim_(computing)) 会是你在安装 Manjaro 后需要做的一件事。TRIM 会帮助清理 SSD 中的块，从而延长 SSD 的使用寿命。

```sh
systemctl enable fstrim.timer
```

