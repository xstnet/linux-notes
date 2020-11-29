# 查看磁盘与目录容量

## 磁盘

使用`df`命令

> `df`: display free disk space, 显示可用磁盘空间

> 在使用`df`时, 不管指定的是哪个目录, 都只会显示该目录所在的磁盘的使用情况, 不能直接显示该目录的使用情况, 若想查看目录使用概况, 应使用 `du` 命令, 下面会说到

### df命令格式

```bash
df [-akmhiHTt] 目录或文件名
```

#### 可用参数列表: 

- `a`: 列出所有的文件系统,  包括虚拟文件系统, 如 `/proc` 等
- `k`: 以 KBytes为单位显示容量
- `m`: 以MBytes为单位显示容量
- `h`: 使用GBytes, MBytes, KBytes等, 自动使用合适的单位 (常用)
- `i`: 不用磁盘容量, 而以`inode`的数量来显示
- `H`: 以 M=1000K替换M=1024K, 就是使用1000代替1024进位的意思
- `T`: 连同硬盘分区的文件系统名称, 如(ext4, xfs) 也一起列出, 可以用来查看分区格式
- `t`: 只列出指定的分区格式, 如 `df -t ext4 -h`, 将会只显示 `ext4`分区格式的磁盘



### 使用案例

#### 查看所有磁盘可用大小

```bash
$ df -h
文件系统        容量     已用   可用 已用% 挂载点
/dev/vda1        50G   13G   35G   27% /
devtmpfs        909M     0  909M    0% /dev
tmpfs           920M   24K  920M    1% /dev/shm
tmpfs           920M  564K  919M    1% /run
tmpfs           920M     0  920M    0% /sys/fs/cgroup
tmpfs           184M     0  184M    0% /run/user/0
```

#### 查看各个磁盘所使用的分区

```bash
$ df -hT
文件系统         类型       容量   已用  可用  已用% 挂载点
/dev/vda1      ext4       50G   13G   35G   27% /
devtmpfs       devtmpfs  909M     0  909M    0% /dev
tmpfs          tmpfs     920M   24K  920M    1% /dev/shm
tmpfs          tmpfs     920M  564K  919M    1% /run
tmpfs          tmpfs     920M     0  920M    0% /sys/fs/cgroup
tmpfs          tmpfs     184M     0  184M    0% /run/user/0
```

如上, 第二列就代表每个磁盘所使用的分区格式

> 在上面经常看到 `/dev/shm` 这个磁盘, 它是干吗的呢?
>
> 其实是使用内存虚拟出来的硬盘空间, 通常是物理内存的一半, 访问速度非常快, 不过每次启动后该磁盘都会被清空
>
> 和物理内存有关, 在每台主机上都不一样



#### 查看当前目录所在磁盘的使用情况

```bash
$ df -h ./
文件系统          容量   已用   可用 已用% 挂载点
/dev/vda1        50G   13G   35G   27% /
```

将会只显示当前磁盘的使用情况



#### 查看所有的磁盘的使用情况

```bash
$ df -ahT
文件系统         类型          容量   已用  可用  已用% 挂载点
rootfs         -               -     -     -     - /
sysfs          sysfs           0     0     0     - /sys
proc           proc            0     0     0     - /proc
devtmpfs       devtmpfs     909M     0  909M    0% /dev
securityfs     securityfs      0     0     0     - /sys/kernel/security
tmpfs          tmpfs        920M   24K  920M    1% /dev/shm
devpts         devpts          0     0     0     - /dev/pts
tmpfs          tmpfs        920M  564K  919M    1% /run
tmpfs          tmpfs        920M     0  920M    0% /sys/fs/cgroup
cgroup         cgroup          0     0     0     - /sys/fs/cgroup/systemd
pstore         pstore          0     0     0     - /sys/fs/pstore
cgroup         cgroup          0     0     0     - /sys/fs/cgroup/memory
cgroup         cgroup          0     0     0     - /sys/fs/cgroup/net_cls,net_prio
.......
configfs       configfs        0     0     0     - /sys/kernel/config
/dev/vda1      ext4          50G   13G   35G   27% /
systemd-1      -               -     -     -     - /proc/sys/fs/binfmt_misc
hugetlbfs      hugetlbfs       0     0     0     - /dev/hugepages
debugfs        debugfs         0     0     0     - /sys/kernel/debug
mqueue         mqueue          0     0     0     - /dev/mqueue
tmpfs          tmpfs        184M     0  184M    0% /run/user/0
binfmt_misc    binfmt_misc     0     0     0     - /proc/sys/fs/binfmt_misc
```

将会列出所有的磁盘的使用情况

> 在上面的结果中会发现 `proc`的使用量居然是0, 这是个什么情况呢?
>
> 这是因为 `proc`中都是`Linux`系统需要的数据, 而且是存储在内存当中的,  当然不占用磁盘空间了



## 目录

查看目录使用情况使用 `du`命令

>  `du`: display disk usage statistics

### du命令格式

```bash
$ du -[optins] dir[ dir ...]
```

#### 常用参数

- `a`: 列出所有的文件与目录容量, 因为默认只列出目录
- `h`: 自动使用 GB, MB, KB等合适的单位来显示, 常用
- `H`: 同`h`, 不过使用`1000`来进位, 如 1MB=1000KB
- `s`: 仅列出总量, 而不列出目录下的各个文件的大小, 等效于 `--max-depth=0`
- `S`: 与`s`有点差别, 不统计子目录的容量,  当使用`--max-depth=1`时即可看到效果
- `k`: 以KB显示容量
- `m`: 以MB显示容量
- `c`: 在最下方显示总用量
- `--max-depth`: 统计目录的深度, 常用的是`--max-depth=1`, 代表只统计当前目录下直接子目录的容量
- `--exclude=pattern`: 排除某个目录, 当有多个时可连用, 可使用通配符



### 使用案例 

#### 查看 `~`目录下每个文件夹的大小

```bash
$ du -h --max-depth=1 ~/
148K	/root/.vim
16K	/root/.local
89M	/root/.cache
64M	/root/.npm
8.0K	/root/.pip
16K	/root/tmp
40K	/root/.config
8.0K	/root/.pki
20K	/root/test
20K	/root/.ssh
125M	/root/.gitbook
279M	/root/
279M	总用量
```

我是使用`root`登录的, 因此家目录是 `/root`



#### 排除某个目录

```bash
$ du -hc --max-depth=1 --exclude=.gitbook ~/
148K	/root/.vim
16K	/root/.local
89M	/root/.cache
64M	/root/.npm
8.0K	/root/.pip
16K	/root/tmp
40K	/root/.config
8.0K	/root/.pki
20K	/root/test
20K	/root/.ssh
154M	/root/
154M	总用量
```

可以看到 `.gitbook/`所占用的125M被排除了



#### 直接查看某个目录的大小

```bash
$ du -sh ~/ /data/conf
279M	/root/
84K	/data/conf

# 或者可以使用 --max-depth=0
$ du -h --max-depth=0 ~/
279M	/root/
```

> 上面使用了多个目录, 可以传N多个目录做为参数的



#### 统计某个目录下的文件与目录的用量

使用 `-a`参数

```bash
$ du -ah --max-depth=1 ./
4.0K	./.bashrc
4.0K	./.pydistutils.cfg
4.0K	./.bash_profile
148K	./.vim
16K	./.local
4.0K	./.vimrc
4.0K	./.tcshrc
92K	./.bash_history
4.0K	./.cshrc
12K	./.viminfo
89M	./.cache
4.0K	./.bash_logout
64M	./.npm
8.0K	./.pip
16K	./tmp
4.0K	./.npmrc
4.0K	./.mysql_history
40K	./.config
8.0K	./.pki
20K	./test
20K	./.ssh
125M	./.gitbook
279M	./
```

