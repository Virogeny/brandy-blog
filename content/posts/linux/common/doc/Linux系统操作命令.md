+++

title = "Linux系统操作命令"
description = "Linux命令记录"
date = 2020-12-09T14:32:25+08:00
tags = ["linux"]
categories = ["linux"]
draft = false

+++

## 操作系统基本配置查询

- 参考[微信文章](https://mp.weixin.qq.com/s?__biz=MzAxODI5ODMwOA==&mid=2666549451&idx=1&sn=af65712275f54d4949f8646cc8f6976f&chksm=80dc9460b7ab1d762db2e625e7ae01b7e15d9724242768187089f4fd1148d9ea09482b058564&scene=126&sessionid=1607473795&key=da08e111de57c4e15dbec3a8a9088fe745f52eb15321b02c23665c958c1e60e82ed97946f370ea0e3dc8198298126df4adf3a0d694747bf613ebcda78cc7e69decb84cdca720071c3dd34663da9f057de9b5c085011fa33ac69049375bc430da89b8b49a4ed0be33eccac71f7521238c57ed598c43e9196f751833f696ec5419&ascene=1&uin=MTcyNTgyNTQwMQ%3D%3D&devicetype=Windows+7&version=63000039&lang=zh_CN&exportkey=AQ3d5e43%2F93KWK%2F7MJLN2%2Fs%3D&pass_ticket=WSm7rQbqKtmg%2B5e%2BSv3Z6NYXhvXOEN9AR26s5xF2i%2BOHsYW8Tjq3%2BMHphhnGxqW%2F&wx_header=0)

### 1. 查看操作系统版本

```sh
# cat /etc/redhat-release这个命令主要是查看红帽发行的操作系统的版本号
[root@node5 ~]# cat /etc/redhat-release 
CentOS Linux release 7.4.1708 (Core) 
#cat /etc/issue这个命令适用于大多数linux发行版
[root@node5 ~]# cat /etc/issue
\S
Kernel \r on an \m
```

### 2. 查看操作系统内核版本

 ```sh
[root@node5 ~]# uname -r
3.10.0-693.el7.x86_64
 ```

### 3. 查看操作系统详细信息

```sh
[root@node5 ~]# uname -a
Linux node5 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
#从上面这段输出可以看出，该服务器主机名是node5，linux内核版本是3.10.0-693.el7.x86_64，CPU是x86架构

#该命令可以查看更多信息
[root@node5 ~]# more /etc/*release 
::::::::::::::
/etc/centos-release
::::::::::::::
CentOS Linux release 7.4.1708 (Core) 
::::::::::::::
/etc/os-release
::::::::::::::
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

::::::::::::::
/etc/redhat-release
::::::::::::::
CentOS Linux release 7.4.1708 (Core) 
::::::::::::::
/etc/system-release
::::::::::::::
CentOS Linux release 7.4.1708 (Core)
```

### 4. CPU基本配置查询

- 名词解释：

|       名词       |                             含义                             |
| :--------------: | :----------------------------------------------------------: |
|   CPU物理个数    |                   主板上实际插入的cpu数量                    |
|    CPU核心数     | 单块CPU上面能处理数据的芯片组的数量，如双核、四核等 （cpu cores） |
| 逻辑CPU数/线程数 | 一般情况下，逻辑cpu=物理CPU个数×每颗核数，如果不相等的话，则表示服务器的CPU支持超线程技术 |

### 5. 查看 CPU 物理个数

```sh
[root@node5 ~]# grep 'physical id' /proc/cpuinfo | sort -u | wc -l
1
```

### 6. 查看 CPU 核心数量

```sh
[root@node5 ~]# grep 'core id' /proc/cpuinfo | sort -u | wc -l
4
```

### 7. 查看 CPU 线程数

```sh
#逻辑cpu数：一般情况下，逻辑cpu=物理CPU个数×每颗核数，如果不相等的话，则表示服务器的CPU支持超线程技术（HT：简单来说，它可使处理#器中的1 颗内核如2 颗内核那样在操作系统中发挥作用。这样一来，操作系统可使用的执行资源扩大了一倍，大幅提高了系统的整体性能，此时逻#辑cpu=物理CPU个数×每颗核数x2）
[root@node5 ~]# cat /proc/cpuinfo| grep "processor"|wc -l
4
[root@node5 ~]# grep 'processor' /proc/cpuinfo | sort -u | wc -l
4
```

### 8. 查看CPU型号

```sh
[root@node5 ~]# cat /proc/cpuinfo | grep name | sort | uniq
model name  : Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz
[root@node5 ~]# dmidecode -s processor-version | uniq   #使用uniq进行去重
Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz
```

### 9. 查看内存条信息

```sh
sudo dmidecode -t memory
```

