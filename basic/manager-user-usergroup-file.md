## 管理用户/用户组/文件权限

本文主要说明用户/用户组/文件权限的管理, 包扩增删改查



## 用户组

查查用户组下有哪些用户

```bash
sudo cat /etc/group | grep 用户组名
```



### 创建用户组

`groupadd 参数 用户组名`

-g：指定新建用户组的gid；

-r：创建系统工作组，系统用户的组ID小于500；

这里不指定用户组的gid, 直接创建

```bash
# 创建一个名为 mygroup的分组
sudo groupadd mygroup

# 查看所有的用户组, 此时就会多出我们刚刚新建的用户组
sudo cat /etc/group
```



### 修改用户组

`groupmod 参数 用户组名`

-g： GID 为用户组指定新的组标识号。

-o：与-g选项同时使用，用户组的新GID可以与系统已有用户组的GID相同。

-n：新用户组 将用户组的名字改为新名字

这里使用 -n来修改用户组的名称

```bash
sudo groupmod -n mygroupnew mygroup
# 经过测试, 把参数放在后面也是可以的, 上面的写法也可以写成下面这样
sudo groupmod mygroup -n mygroupnew
```



### 删除用户组

`groupdel 用户组名`

> 当某个用户的主组是该用户组时, 不能删除该用户组

```bash
sudo groupdel mygroupnew
```



## 管理用户

### 创建用户

`useradd 【参数】 用户名`

-g 属组

-u 设置uid

-m 创建家目录

-M 没有家目录

-G 指定属于多个组

-s 指定登录[shell](https://www.linuxcool.com/)

-d 指定家目录

-c 注释



实例, 创建一个用户并加入到 上面创建的`mygroupnew`这个用户组中

```bash
sudo useradd -g mygroupnew -m myuser
```



### 设置用户密码

> 设置和修改都使用`passwd`命令



当没有对用户设置密码时, 则该用户登录时就无需密码

`passwd 参数 用户名`

-l：锁定已经命名的账户名称

-u：解开账户锁定状态

-x, --maximum=DAYS：密码使用最大时间（天）

-n, --minimum=DAYS：密码使用最小时间（天）

-d：删除使用者的密码

-S：检查指定使用者的密码认证种类

--stdin：非交互式修改/设置密码，弊端是操作日志能查密码，用history -c 干掉。



实例1, 使用交互式的方式来设置用户的密码

```bash
sudo passwd myuser
# 此时会提示输入用户密码, 确认2次后, 密码设置成功
```

实例2, 使用非交互式的方式来设置用户的密码

>  这里使用了标准输入`stdin`, 说明需要一个输出, 这种方式直接就设置成功了, 不需要确认, 缺点是可以从history中看到密码的明文
>
> 

```bash
echo 123456 | sudo passwd --stdin myuser
```



### 修改用户

`usermod 参数 用户名`

-a:   将用户加入到另一个用户组, 只能和-G一起使用

-c：修改用户帐号的备注文字。

-d：修改用户登入时的目录。

-m:  --move-home       将家目录内容移至新位置 (仅于 -d 一起使用)

-e：修改帐号的有效期限。

-f： 改在密码过期后多少天即关闭该帐号。

-g：修改用户所属的群组。 主要组

-G：修改用户所属的附加群组。 次要组

-l：修改用户帐号名称。

-L：锁定用户密码，使密码无效。

-s：修改用户登入后所使用的shell。

-u：修改用户ID。

-U：解除密码锁定。

常用的参数包括-c， -d， -m， -g， -G， -s， -u以及-o等，与useradd命令中的选项一样，可以为用户指定新的资源值。



实例: 

####  使用 -g 参数修改用户的主要组, 只能有一个

```bash
# 使用 -g 参数修改用户的主要组
sudo usermod -g 新的组名 用户名

# 可以通过 id <用户名> 来查看某个用户 所属的用户组
id myuser
uid=501(myuser) gid=1001(mygroupnew) groups=1001(mygroupnew),1002(xstnet)
# 其中 gid 代表主要分组, groups 代表次要分组
```



#### 使用 -G参数修改用户的次要组, 

>  次要组可以有多个, 需要使用 -aG参数来添加
>
> 注意, 如果 -G 配置了一个新的组, 那么在次要组中将会和主要组同时存在

```bash
sudo usermod -G mygroupnew myuser
```



#### 将用户加入到另一个组

```bash
sudo usermod -aG xstnet,mygroupnew myuser
```



#### 修改用户的名称

> 注竟使用-l不会修改用户的家目录名称, 若要修改用户的家目录,  应使用 -d参数
>
> 需要从要改名的帐号中登出并杀掉该用户的所有进程，要杀掉该用户的所有进程可以执行下面命令，
>
> `sudo pkill -u username` 或强制杀死
>
> `sudo pkill -9 -u username`

```bash
sudo usermod -l 新用户名 旧用户名
# 例
sudo usermod -l myusernew myuser
```



#### 修改用户的家目录

```bash
sudo usermod -d /home/new-directory -m username
```



### 删除用户

`userdel 参数 用户名`

-r:  自动删除用户的家目录

```bash
# 不删除家目录
sudo userdel username

# 删除家目录
sudo userdel –r username
```



### 查看用户信息

使用id命令可以查看某个用户的 UID, 所属主要用户组, 次要用户组

```bash
id username
```





## 文件权限管理



### 修改文件的所属用户组

`chgrp [选项] [组] [文件]`

-c 当发生改变时输出调试信息

-f 不显示错误信息

-R 处理指定目录以及其子目录下的所有文件

-v 运行时显示详细的处理信息

--dereference 作用于符号链接的指向，而不是符号链接本身

--no-dereference 作用于符号链接本身



```bash
sudo chgrp -v www test.txt

# 递归的处理
sudo chgrp -R www ./test
```



### 修改文件的拥有者

chown将指定文件的拥有者改为指定的用户或组，用户可以是用户名或者用户ID；组可以是组名或者组ID；文件是以空格分开的要改变权限的文件列表，支持通配符。系统管理员经常使用chown命令，在将文件拷贝到另一个用户的名录下之后，让用户拥有使用该文件的权限。

`chown [选项]... [所有者][:[组]] 文件...`



-c 显示更改的部分的信息

-f 忽略错误信息

-h 修复符号链接

-R 递归处理指定目录以及其子目录下的所有文件

-v 显示详细的处理信息

-deference 作用于符号链接的指向，而不是链接文件本身



例: 

#### 只修改文件的所有者, 不修改用户组

```bash
sudo chown -v www ./test.txt
```



#### 只修改文件的用户组, 不修改文件的所有者

> 使用 冒号, 但是只写后面的用户组

```bash
sudo chown -v :www ./test.txt
```



#### 既修改文件的所有者, 又修改文件的用户组

```bash
sudo chown -v www:www ./test.txt
# 也可以修改到不同的用户和用户组
sudo chown -v www:root ./test.txt
# 使用 -R 来实现递归
sudo chown -R www:root ./test
```



### 修改文件的权限

`chmod [-cfvR] [--help] [--version] mode [file]`

-c 当发生改变时，报告处理信息
-f 错误信息不输出
-R 处理指定目录以及其子目录下的所有文件
-v 运行时显示详细处理信息

例; 

```bash
sudo chmod 777 ./text.txt
sudo chmod -R 777 ./test
```

或者使用 `r|w|x`三个快捷操作, 但是这个只能对拥有者添加权限, 用户组和other不会添加

```bash
# 添加可读权限
sudo chmod +r ./text.txt 
# 取消可读权限
sudo chmod -r ./text.txt

# 添加可写权限
sudo chmod +w ./text.txt 
# 取消可写权限
sudo chmod -w ./text.txt

# 添加可执行权限
sudo chmod +x ./text.txt 
# 取消可执行权限
sudo chmod -x ./text.txt
```

