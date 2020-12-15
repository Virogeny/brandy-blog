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

### 10. top命令顶部栏信息描述

```sh
top - 09:47:39 up 23:55,  4 users,  load average: 1.15, 0.97, 0.94
任务: 248 total,   1 running, 247 sleeping,   0 stopped,   0 zombie
%Cpu(s): 11.4 us,  4.3 sy,  0.0 ni, 82.3 id,  0.1 wa,  1.7 hi,  0.2 si,  0.0 st
MiB Mem :   7872.6 total,    148.2 free,   5413.9 used,   2310.5 buff/cache
MiB Swap:   4096.0 total,   3852.2 free,    243.8 used.   1626.9 avail Mem 
```

> 说明：
>
> 统计信息区：
>
> 前五行是当前系统情况整体的统计信息区。下面我们看每一行信息的具体意义。
>
> 第一行，任务队列信息，同 uptime 命令的执行结果，具体参数说明情况如下：
>
> 14:06:23 — 当前系统时间
>
> up 70 days, 16:44 — 系统已经运行了70天16小时44分钟（在这期间系统没有重启过的吆！）
>
> 2 users — 当前有2个用户登录系统
>
> load average: 1.15, 1.42, 1.44 — load average后面的三个数分别是1分钟、5分钟、15分钟的负载情况。
>
> load average数据是每隔5秒钟检查一次活跃的进程数，然后按特定算法计算出的数值。如果这个数除以逻辑CPU的数量，结果高于5的时候就表明系统在超负荷运转了。
>
> 第二行，Tasks — 任务（进程），具体信息说明如下：
>
> 系统现在共有206个进程，其中处于运行中的有1个，205个在休眠（sleep），stoped状态的有0个，zombie状态（僵尸）的有0个。
>
> 第三行，cpu状态信息，具体属性说明如下：
>
> 5.9%us — 用户空间占用CPU的百分比。
>
> 3.4% sy — 内核空间占用CPU的百分比。
>
> 0.0% ni — 改变过优先级的进程占用CPU的百分比
>
> 90.4% id — 空闲CPU百分比
>
> 0.0% wa — IO等待占用CPU的百分比
>
> 0.0% hi — 硬中断（Hardware IRQ）占用CPU的百分比
>
> 0.2% si — 软中断（Software Interrupts）占用CPU的百分比
>
> 备注：在这里CPU的使用比率和windows概念不同，需要理解linux系统用户空间和内核空间的相关知识！
>
> 第四行,内存状态，具体信息如下：
>
> 32949016k total — 物理内存总量（32GB）
>
> 14411180k used — 使用中的内存总量（14GB）
>
> 18537836k free — 空闲内存总量（18GB）
>
> 169884k buffers — 缓存的内存量 （169M）
>
> 第五行，swap交换分区信息，具体信息说明如下：
>
> 32764556k total — 交换区总量（32GB）
>
> 0k used — 使用的交换区总量（0K）
>
> 32764556k free — 空闲交换区总量（32GB）
>
> 3612636k cached — 缓冲的交换区总量（3.6GB）
>
> 备注：
>
> 第四行中使用中的内存总量（used）指的是现在系统内核控制的内存数，空闲内存总量（free）是内核还未纳入其管控范围的数量。纳入内核管理的内存不见得都在使用中，还包括过去使用过的现在可以被重复利用的内存，内核并不把这些可被重新使用的内存交还到free中去，因此在linux上free内存会越来越少，但不用为此担心。
>
> 如果出于习惯去计算可用内存数，这里有个近似的计算公式：第四行的free + 第四行的buffers + 第五行的cached，按这个公式此台服务器的可用内存：18537836k +169884k +3612636k = 22GB左右。
>
> 对于内存监控，在top里我们要时刻监控第五行swap交换分区的used，如果这个数值在不断的变化，说明内核在不断进行内存和swap的数据交换，这是真正的内存不够用了。
>
> 第六行，空行。
>
> 第七行以下：各进程（任务）的状态监控，项目列信息说明如下：
>
> PID — 进程id
>
> USER — 进程所有者
>
> PR — 进程优先级
>
> NI — nice值。负值表示高优先级，正值表示低优先级
>
> VIRT — 进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
>
> RES — 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
>
> SHR — 共享内存大小，单位kb
>
> S — 进程状态。D=不可中断的睡眠状态 R=运行 S=睡眠 T=跟踪/停止 Z=僵尸进程
>
> %CPU — 上次更新到现在的CPU时间占用百分比
>
> %MEM — 进程使用的物理内存百分比
>
> TIME+ — 进程使用的CPU时间总计，单位1/100秒
>
> COMMAND — 进程名称（命令名/命令行）