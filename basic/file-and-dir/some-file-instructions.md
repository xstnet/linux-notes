## 一些文件的作用

### /usr/share/doc

存储了文档的目录



## root

### /root/anaconda-ks.cfg

这个文件存储了安装时的配置信息, 如 安装方式, 所选语言,键盘布局, root密码, 所选软件包, 时区等等; 不仅如此, 这个文件还可用于安装大量的配置相同的系统, 参见:  [链接](https://blog.csdn.net/whyhonest/article/details/7555229/)



## etc

### /etc/sudoers

将用户配置到该文件下,  则该用户可以使用`sudo` 进行提权操作, 否则不能使用`sudo`命令

将用户配置到`sudoers`中的方法: [点击查看](add-user-to-sudoers.md)



### /etc/passwd

记录了所有用户的相关信息, 包括root用户

示例: 

```plain
root:x:0:0:root:/root:/bin/bash
```

通过: 分割, 一共包含了7个信息, 分别代表: 

**用户名**:**口令**:**用户标识号**:**组标识号**:**注释性描述**:**主目录**:**登录Shell**

更多信息可查看: http://c.biancheng.net/view/839.html



### /etc/group

记录了所有的用户组



### /etc/shadow

用于存储 Linux 系统中用户的密码信息，又称为“影子文件”。

由于`/etc/passwd`文件允许所有用户读取，易导致用户密码泄露，因此 Linux 系统将用户的密码信息从 `/etc/passwd` 文件中分离出来，并单独放到了此文件中。

`/etc/shadow` 文件只有 root 用户拥有读权限，其他用户没有任何权限，这样就保证了用户密码的安全性。



更多信息可查看: http://c.biancheng.net/view/840.html



### /etc/shells

记录了当前系统可用的`shell`

可以使用 `chsh`命令来切换`shell`, 不过切换完要重新登录才能生效



### /etc/man_db.conf

指定了`man page`中的路径



### /etc/issue与 /etc/issue.net

bash的登录欢迎信息, 对root用户不起作用

issue.net: 使用`telnet`登录时的欢迎信息



### /etc/motd

bash的登录欢迎信息, 对所有用户起作用



### /dev/shm

使用内存虚拟出来的硬盘空间, 通常是物理内存的一半, 访问速度非常快, 不过每次启动后该磁盘都会被清空