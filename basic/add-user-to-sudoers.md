## 将普通用户添加到sudoers中

当我们使用`sudo` 这个命令时, 如果没有事先在 `sudoers` 中将当前用户添加进去,  此时就会得到一段报错

```bas
xstnet@centos7 ~ # sudo cat /shadow
xstnet 不在 sudoers 文件中。此事将被报告。
或, 或是英文版, 则会报: 
xstnet is not in the sudoers file.  This incident will be reported.
```

为什么会出现这个提示呢?

先说一下为什么要使用`sudo`,  一般root账户的密码不能轻易告诉别人, 如果有个用户需要使用root的权限, 这个时候我们可以提前把这个用户加入到`sudoers`,

这个时候该用户只要使用`sudo` 命令, 并且**输入自已的密码**, 注意不是root账户的密码, 就可以得到管理员权限了, 这样就不会泄漏我们的root密码



接下来我们来配置一下, 把我的用户`xstnet` 加入到 `sudoers`中

### 添加用户到 sudoers

首先要切换到`root`账户

```bash
su root
```

由于`sudoers`这个配置位于 `/etc/sudoers` 这个文件中, 接下来我们要编辑一下这个文件, 将我们的用户添加进去

但是有一个问题需要注意下, 就是这个文件默认的权限是 `440`,  只能读, 不能写, 需要给这个文件加入可写权限

```bash
ls -l /etc/sudoers
# 可以看到只有可读权限
-r--r-----. 1 root root 3938 4月  11 2018 /etc/sudoers
```

加入可写权限

```bash
chmod +w /etc/sudoers
ls -l /etc/sudoers
# 可以看到多了可写权限
-rw-r-----. 1 root root 3938 4月  11 2018 /etc/sudoers
```

使用vim编辑该文件,  在`root   ALL=(ALL)	ALL`下面加入一行

`xstnet   ALL=(ALL)	ALL`



**免密码使用sudo**

如果想免密码, 那么只要把最后一个`ALL`变成 `NOPASSWD:ALL` 即可, 也就是:

`xstne	ALL=(ALL)	NOPASSWD:ALL`



最后记得取消该文件的可写权限

```bash
chmod -w /etc/sudoers
```





好了, 到了这里就配置完成了, 赶紧试试吧

