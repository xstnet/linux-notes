## shell中用户变量与环境变量

### 用户变量

在`shell`中定义用户变量很简单, 直接使用 `var=value` 即可, 注意=两边不能有空格

如: 

```bash
$ myname=xstnet
$ myname='xstnet'
$ myname="xstnet"
```

以上3种方式是等价的, 区别就是第一种方式不能定义带空格的值, 第3种方式会解析字符串中出现的变量

**查看用户变量**

直接使用`echo`命令即可输出, 注意要输出的变量前要加`$`符号

```bash
$ echo $myname
xstnet
```

**取消变量的设置**

使用`unset`命令

```bash
$ unset myname
echo $myname
```



### 环境变量

上面说了用户变量, 那么它和环境变量的区别是什么呢?

区别在于环境变量可以被子进程使用, 而用户变量不能被子进程使用

比如我们在上面定义的`myname`这个变量, 如果在shell中执行另外一个命令, 那么该命令是不能够使用`myname`这个命令的



#### 定义环境变量

使用`export`关键字即可定义环境变量

```bash
$ export MYNAME=xstnet
$ echo $MYNAME
xstnet
```

使用`declare -x` 命令

**declare [-aixr] variable**

- `-a`: 将变量的类型设置为`array`
- `-i`: 将变量的类型设置为`integer`, 也就是int型
- `-x`: 用法与`export`一样, 将变量设置为环境变量
- `-r`: 将变量设置为`readonly`, 不可修改



这里我们只使用`-x`参数, 注意这里有2种用法, 一种是直接设置为环境变量, 还有一种是将用户变量转化为环境变量

```bash
# 直接设置环境变量
$ declare -x MYNAME=xstnet

# 转化用户变旦为环境变量
$ myname=xstnet
$ declare -x myname
```



#### 查看所有环境变量

使用`env` 命令或 `export`命令列出所有的环境变量

```bash
$ env
# 或直接使用 export
$ export

USER=root
HISTSIZE=3000
SSH_CLIENT=xx.xx.xx.xx
HOME=/root
PS1="省略"
PS2='> '
......
```

上面的命令会列出所的环境变量, 下面我们来说明一下一些常见的变量的作用



- `HOME`: 代表当前用户的家目录
- `USER`: 当前登录的账号, 比如我的是`root`
- `HISTFILESIZE`:  `.bash_history`最大历史记录条数, 使用`history`命令时能显示的最大条数, 就是由这个环境变量控制的
- `HISTSIZE`: 内存中可记录的最大历史记录条数, 因为退出时才会将命令写入到文件中
- `SSH_CLIENT`:  当使用`ssh`登录时, 这个里面就记录了客户端所在网络的`IP`地址
- `PATH`: 用来查找命令所在目录的`PATH`
- `RANDOM`: 随机数种子, 每次查看都不一样
- `HOSTNAME`: 主机的名称, 有些`Linux`系统叫做`HOST`
- `LANG`: 当前所使用的语言, 可以使用 `locale`命令来查看所支持的语言, 使用`cat /etc/locale.conf` 来查看当前系统默认的语言
- `PS1`: 当前命令提示符的样式, 这里提供一个可视化定义`PS1`的网页, [PS1生成器](http://ezprompt.net/)
- `PS2`: 当一行命令太长时使用`\` 转义进行换行时, 第二行的提示符, 默认是`> `, 是不是很熟悉
- `LINES`:  当前终端的高度, 代表能输出多少行内容, 改变终端窗口的高度该值会自动变化
- `COLUMNS`: 当前终端的栏位宽度, 当宽度改变时, 该值也会变
- `$`: 当前shell的`PID`,  通过`echo $$` 即可查看当前shell的`PID`, 为什么有2个`$`? 是因为查看环境变量要加上`$`符号
- `?`: 上一条命令的返回值, 为0则代表执行成功, 否则是失败, 如: `echo $?`



#### 查看当前使用的shell

方法1: `echo $0`

```bash
$ echo $0
-bash
```

方法2: `echo $$`, 然后通过`PID`去查找是什么应用

```bash
$ echo $$
28366
# 通过PID去查找
$ ps -ef | grep 28366
root      7649 28366  0 17:00 pts/0    00:00:00 ps -ef
root      7650 28366  0 17:00 pts/0    00:00:00 grep --color=auto 28366
root     28366 28362  0 15:51 pts/0    00:00:00 -bash
# 通过上面也能看出来当前的shell 是 bash
```



### 查看所有的用户变量和环境变量

使用 `set`命令

```bash
set
# 一堆的变量
.......
.......
```

你可能会奇怪这些变量都是哪来的

其实这一堆的变量都是`/etc/profile`, `.bachrc`, `~/.bash_profile`等文件中定义的, 包括里面的变量, 函数等等都会被列出来