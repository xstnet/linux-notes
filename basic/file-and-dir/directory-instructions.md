## Linux 下常见目录的作用说明

### 什么是FHS

因为得用`Linux`来开发产品或发行版的社区, 公司, 个人 实在是太多了, 如果每个人都有自已的想法,  想想是多么可怕吧

所以就有 `FHS`标准的出现, 即(`FileSystem Hierarchy Standard`)



### 根目录 /

根目录是整个系统中最重要的一个目录, 所有子目录都要从根目录进入, 同时根目录也与**启动, 还愿, 系统修复等操作有关**. 

由于系统启动时需要特定的启动软件, 内核文件, 启动所需程序, 函数库等文件数据, 若系统出现错误时, 根目录也需要包含系统修复的程序才行

由于根目录非常重要, 因些`FHS`要求根目录最好不要放到非常大的分区, 因为越大的分区你会放入越大的数据, 如此一来就会造成更多发生错误的机会



因此`FHS`建议: **根目录(/)所在的分区越小越好, 且用户自行安装的程序最好不要与根目录放在同一个分区内, 保持根目录越小越好. 如此不但性能更佳, 还会减少出错的机会**

> 以上内容来自于 <<鸟哥的Linux私房菜第四版>>  166页



### 根目录下文件夹介绍

| 文件夹      | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| `/bin`      | 存放二进制可执行文件, 如 `ls`, `mv`, `mkdir`, `pwd`, `chmod` 等 |
| `/home`     | 用户家目录, 默认的用户家目录都会放在这里,  比较重要的有如下2种使用方法<br />`~` :  代表当前登录的用户家目录<br />`~zhangsan`:  代表`用户zhangsan`的家目录 |
| `/boot`     | 引导目录, 主要放置启动会使用到的文件, 包括内核文件以及启动选项与启动所需配置文件等, `Linux`内核常用的文件名为`vmlinuz`,  如果使用的是`grub2`这个引导, 则还会存在`/boot/grub2/`目录 |
| `/dev`      | 用于存放设备文件。读写该目录下的文件, 就等于读写某个设备, 比较重要的文件有 `/dev/null`, `/dev/zero`, `/dev/tty`, `/dev/loop*`, `/dev/sd*`等 |
| `/etc`      | 存放系统管理和配置文件,  一般来说, 这个目录下的文件可以不同的用户查看, 但是只有`root`有权力修改,<br /> 关于`etc`名字的由来, 是and so on的意思 来源于 法语的 `et cetera` 翻译成 中文就是 等等 的意思. 至于为什么在/etc下面存放配置文件， 按照原始的UNIX的说法( linux 文件结构参考UNIX的教学实现MINIX) 这下面放的都是一堆零零碎碎的东西, 就叫etc, 这其实是个历史遗留. |
| `/usr`        | `UNIX Software Resource`缩写, 不是`user`的缩写, 也就是`UNIX` 操作系统软件资源放置的目录, 而不是用户的数据<br />系统默认的软件以及大部分第三方软件都会放置在这个目录下 |
| `/var`        | 如果说`/usr`是安装时会占用较大硬盘容量的目录, 那么`/var`就是在系统运行后才会渐渐占用硬盘容量的目录<br />因为`/var`目录主要针对经常性变动的文件, 包缓存(`cache`), 日志文件(`log file`)以及某些软件运行所产生的文件, 例如 `MYSQL`数据库的文件等 |
| `/lib<qual>`  | 可以是`/lib`, 也可以是`/lib64`, 函数库, 动态链接库, 也叫共享库, 类似于`windows`下的`.dll`文件,  系统启动的时候使用, 或某些程序也需要 |
| `/media`      | 放置的是可删除的设备, 包括软盘, 光盘, `DVD`等设备, 常见的文件有 `/media/floppy`, `/media/cdrom`等 |
| `/mnt`        | 暂时挂载额外的设备, 一般建议放在这个目录中. 早些时候这个目录的用途于`/media`相同, 自从有了`media`后, 这个目录就用来挂载 |
| `/opt`        | 额外安装的可选应用程序包所放置的位置。一般情况下，我们可以把tomcat等都安装到这里。可选目录, 类似于 `D:\Sortware` |
| `/proc`       | 虚拟文件系统目录，是系统内存的映射。可直接访问这个目录来获取系统信息。<br />直接映射到内存, 可以直接获取到如: 内核, 进程信息, 网络状态等等 |
| `/sys`        | 和`proc`类似, 也是映射到内存的, 主要是记录内核与系统硬件信息相关的内容,  包括目前已加载的内核模块与硬件设备信息等 |
| `/run`        | `/run`目录是直接映射到内存空间的, 不具有物理空间, 因此性能会快很多, 但是请注意重启后该目录下的文件都会消失, 一般存放各个程序对外的`socket`连接 |
| `/sbin`       | `super binary`, 存放二进制可执行文件，只有root才能访问。这里存放的是系统管理员使用的系统级别的管理命令和程序。如ifconfig等。<br />放在`/sbin`下的为启动过程中所需要的, 包括 了**启动, 修复, 还原原系统**所需要的命令<br />至于某些服务器软件程序, 一般放置在`/usr/sbin`当中, 若是我们自行安装的软件, 则放置到`/usr/local/sbin`当中 |
| `/tmp`        | 这是一般用户或正在执行的程序暂时放置文件的地方, 这个目录任何人都有权限存取, 重要文件不要放在这里, 因为重启后会清除该目录下的文件 |
| `/srv`        | 可以视为`service`的缩写, 是一些网络服务启动成功之后, 这些服备所需要使用的数据目录, 常见的的如 `WWW, FTP`等, `WWW`需要的数据可以放在 `/srv/www/`里面, 但是现在好像没有人这么做 |
| `/lost+found` | 这个目录是使用标准的`ext2`, `ext3`, `ext4` 文件系统才会产生的目录, 目的在于系统发生错误时, 将一些遗失的片段放到这个目录下, 不过如果使用的是`xfs`系统的话, 就不会产生这个目录 |



### /usr/ 目录下文件夹

| 文件平         | 说明                                                         |
| -------------- | ------------------------------------------------------------ |
| 第一部分       | `FHS` 规定必须存在的目录                                     |
| `/usr/bin`       | 所有一般用户能够使用的命令都放在这里, 目前新的`CentOs 7` 已将全部的用户命令放置于此, 采用符号链接的方式将`/bin`链接至此, 也就是说 `/usr/bin` 与 `/bin` 是一模一样的<br />另外, `FHS`要求该目录下不应该有子目录 |
| `/usr/lib`       | 基本上, 与`/lib`功能相同, 目前 `/lib`也已经链接到此处        |
| `/usr/local`     | 系统管理员在本机安装自已下载的软件, 建议安装到此目录, 这样会比较便于管理 |
| `/usr/sbin`      | 非系统正常运行所需要的命令, 最常见的就是某些网络服务器软件的服务命令(`daemon`), 不过基本功能与`/sbin`也差不多, 因此目前 `/sbin`就是链接到这里的 |
| `/usr/share`     | 主要放置只读的数据文件, 也包括共享文件, 在这个目录下放置的数据几乎是不分硬件架构均可读的数据, 因为几乎都是文本文件, 常见的还是这些目录<br />`/usr/share/man`: 在线帮助文件<br />`/usr/share/doc`: 软件的说明帮助文档<br />`/usr/share/zoneinfo`: 与时区有关的时区文件 |
| 第二部分       | `FHS`建议可以存在的目录                                      |
| `/usr/games`     | 与游戏相关的数据放置处                                       |
| `/usr/include`   | `c/c++`等语言所使用的头文件与包含文件(`include`)放置处, 当我们以 `Tarball` 方式(`*.tar.gz`)安装某些程序时, 会使用到里面的许多文件 |
| `/usr/libexec`   | 某些不被一般用户常用的执行文件或脚本等, 都会放置在此目录中, 例如大部分的 `X窗口`下面的操作命令,很多都是放在这里 |
| `/usr/lib<qual>` | 与 `/lib<qual>`功能相同, 因此 `/lib<qual>`也链接到该目录     |
| `/usr/src`       | 一般源代码建议放置在这里, `source`的意思, 至于内核源代码则建议放置到 `/usr/src/Linux/`目录下 |



### /var/ 目录下文件夹介绍



| 文件夹     | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| `/var/cache` | 应用程序本身运行过程中产生的一些缓存                         |
| `/var/lib`   | 程序本身执行的过程中, 需要使用到的数据文件放置的目录, 在此目录下不同的软件应该要有各自的目录, 如 `MYSQL`的数据库放置到 `/var/lib/mysql` |
| `/var/lock`  | 许多程序遵循在`/var/lock` 中产生一个锁定文件的约定，以支持他们正在使用某个特定的设备或文件。其他程序注意到这个锁定文件，将不试图使用这个设备或文件。注意该目录不可以随便更改。 |
| `/var/log`   | 非常重要,  这是日志文件放置的目录, 里面比较重要的文件有`/var/log/messages`, `/var/log/wtmp(记录登录信息)` |
| `/var/mail`  | 放置个人电子邮箱的目录, 不这这个目录也链接到 `/var/spool/mail`目录中, 通常这2个目录互为链接文件 |
| `/var/run`   | 某些程序或是服务启动后, 会将它们的`PID`放置在这个目录下, 这个目录链接到 `/run`目录下, 映射到内存中 |
| `/var/spool` | 通常放置一些队列数据,  这些队列数据被使用后通常都会被删除, 如**计划任务数据**会被放置到`/var/spool/cron`目录下 |



### CentOS 7 中的变化

比较大的差异是 将许多位于根目录下的目录 通过符号链接都指向到了`/usr`里面去了

以下列个汇总

- `/bin` ---> `/usr/bin`
- `/sbin` ---> `/usr/sbin`
- `/lib` ---> `/usr/lib`
- `/lib64` ---> `/usr/lib64`
- `/var/lock` ---> `/run/lock`
- `/var/run` ---> `/run`
