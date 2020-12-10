+++

title = "WIN10安装基础开发工具"
description = "WIN10基础开发工具安装记录"
date = 2020-12-09T14:32:25+08:00
tags = ["linux"]
categories = ["linux"]
draft = false

+++

## JDK

```txt
1. 新建系统变量:
    变量名： JAVA_HOME
    变量值：安装目录
2. 继续新建CLASSPATH变量
    变量名： CLASSPATH
    变量值： .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
3. 添加Path
    在系统变量区域，选择Path,点击下面的编辑按钮，在弹出的框中选择新建添加2行，一行输入 %JAVA_HOME%\bin ，一行输入 %JAVA_HOME%\jre\bin
4. 在命令提示符中输入javac命令
```

## MAVEN

```txt
1. 新建系统变量:
    变量名： MAVEN_HOME
    变量值：安装目录
2. 添加Path
    在系统变量区域，选择Path,点击下面的编辑按钮，在弹出的框中选择新建添加 %MAVEN_HOME%\bin
4. 在命令提示符中输入 mvn -v 命令
```

## mysql

>安装目录下新建 my.ini 文件（注意修改下面的路径）

```ini
[Client]
#设置3306端口
port = 3306
[mysqld]
#设置3306端口
port = 3306
# 设置mysql的安装目录
basedir=D:\MySQL5.7\mysql-5.7.27-winx64
# 设置mysql数据库的数据的存放目录
datadir=D:\MySQL5.7\mysql-5.7.27-winx64\data
# 允许最大连接数
max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
#开启查询缓存
explicit_defaults_for_timestamp=true
```

1. 新建系统变量  
变量名称： MYSQL_HOME
变量值： MySQL安装目录

2. 编辑系统变量 Path  
将 %MYSQL_HOME%\bin 添加到 Path即可

3. 管理员身份运行命令提示符cmd  
进入mysql安装bin目录,执行mysqld -install命令进行安装

4. 执行mysqld --initialize-insecure --user=mysql命令初始化  
成功后，会生成data目录

5. 进入mysql的安装目录下，打开命令提示符（可以Shift+右键->选择命令提示符）输入：mysqld --skip-grant-tables  
回车之后就不要动了，再新打开一个命令提示符窗口，同样进入mysql的安装目录下：  

>输入：mysql -u root -p 密码为空，直接回车  
接着输入以下命令：  
use mysql;  
update user set authentication_string=password("root") where user="root";  
flush privileges;  
以上三条命令执行完毕之后，打开命令提示符窗口，输入mysql -u root -proot  
输入启动命令: net start mysql

## redis后台启动

在reids安装目录执行命令，将其注册为服务  
`redis:redis-server --service-install redis.windows.conf`

## win10激活

```txt
1. “以管理员身份”打开“MSDOS”窗口
2. `slmgr.vbs /upk` 弹出窗口显未“已成功卸载了产品密钥”
3. `slmgr /ipk 激活码` 弹出窗口提示：“成功的安装了产品密钥”
4. `slmgr /skms zh.us.to` 弹出窗口提示：“密钥管理服务计算机名成功的设置为zh.us.to”
5. `slmgr /ato`此时将弹出窗口提示：“成功的激活了产品”
打开的“运行”窗口中，输入命令“slmgr.vbs -xpr”，点击“确定”按钮，即可查看当前系统是否永久激活
```
