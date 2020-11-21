## pwd 命令

### 功能

显示出当前/活动目录的名称

另外肯定有人好奇pwd的英文名称是什么,  其实是 `pathname of the current working directory`



### 参数

- `-L` 显示当前目录的逻辑目录, 如: 当前在一个软链接的目录内, `-L` 会显示当前软链接的目录
- `-P` 显示当前目录的物理目录, 如: 当前在一个软链接的目录内, `-P` 会显示该软链接指向的目录



### 实例

先查看 `/sbin` 发现该目录是一个符号链接目录, 指向 `/usr/sbin`

```bash
root@VM_0_7_centos /sbin # ll /sbin
lrwxrwxrwx. 1 root root 8 8月   8 2018 /sbin -> usr/sbin

root@VM_0_7_centos /sbin # cd /sbin
root@VM_0_7_centos /sbin # pwd
/sbin
```

使用`pwd -L`查看, 发现显示的目录就是该符号链接本身的目录

```bash
root@VM_0_7_centos /sbin # pwd -L
/sbin
```

使用 `pwd -P` 查看,  则显示的是该符号链接指向的目录

```bash
root@VM_0_7_centos /sbin # pwd -P
/usr/sbin
```



### 环境变量

`pwd` 命令对应一个环境变量 `PWD`, 及大写的`pwd`

可以在shell脚本中使用 `$PWD` 来调用当前的目录, 也可以直接在命令行中输出

```bash
echo $PWD
```

