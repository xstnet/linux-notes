## Linux ls 只显示目录的方法

在实际应用中，我们有时需要仅列出目录，这里总结了几种不同的方法



### 1. 使用`ls`的`-d`参数

> `-d` 只列出目录,  加参 `*/` 才能保证列出目标目录下的所有子目录, 否则将只会列出目标目录本身
>
> `*/` 表示所有以 /结尾的元素, 起到一个通配符的作用

```bash
ls -dlh /var/*/
drwxr-xr-x 1 root root   4.0K 2020-04-15 19:09:51 /var/backups/
drwxr-xr-x 1 root root   4.0K 2020-11-17 11:32:16 /var/cache/
drwxrwxrwt 1 root root   4.0K 2020-04-23 14:43:08 /var/crash/
drwxr-xr-x 1 root root   4.0K 2020-11-30 14:12:05 /var/lib/
drwxrwsr-x 1 root staff  4.0K 2020-04-15 19:09:51 /var/local/
drwxrwxrwt 1 root root   4.0K 2020-11-17 11:32:55 /var/lock/
drwxrwxr-x 1 root syslog 4.0K 2020-11-18 17:21:41 /var/log/
drwxrwsr-x 1 root mail   4.0K 2020-04-23 14:40:15 /var/mail/
drwxr-xr-x 1 root root   4.0K 2020-04-23 14:40:15 /var/opt/
drwxr-xr-x 1 root root   4.0K 2020-11-30 13:48:41 /var/run/
drwxr-xr-x 1 root root   4.0K 2020-04-10 22:57:25 /var/snap/
drwxr-xr-x 1 root root   4.0K 2020-04-23 14:40:48 /var/spool/
drwxrwxrwt 1 root root   4.0K 2020-04-23 14:43:34 /var/tmp/
drwxr-xr-x 1 root root   4.0K 2020-11-17 11:32:16 /var/www/

# 列出当前目录下的所有子目录
ls -d */
......
```



### 2. 利用 ls 命令的 -F 选项

`-F`参数会在目录后面添加`/`,  这个时候就可以用 `grep`来筛选了

```bash
ls -F /var | grep "/$"
```



### 3.  利用 ls 命令的 -l 选项

当使用`-l`时, 如果是目录那将会在`rwd`三个权限前面加上一个`d`来表示目录, 此时同样可以使用`grep`来过滤这个`d`

```bash
ls -l /var | grep "^d"
```



### 4. 例用find命令

`find`命令用来查找文件, 那么只需要限定只查找目录, 也能达到`ls`的目的

下面使用`-type d`的选项限制只查找目录, 同时使用`-maxdepth 1` 来限制扫描深度为1, 不然会连同子目录一起查找, 不过需要注意会把隐藏目录也找出来

```bash
find /var -type d -maxdepth 1
```

