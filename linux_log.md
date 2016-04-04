# Linux use log

want to find path of log file but not in con.
```bash
lsof | grep php-fpm
```

want to use remi repo to install new software
```bash
sudo yum --enablerepo=remi install php-tcpdf
```
you can list repositories by:
```bash
yum repolist
yum repolist disabled
```

want to find string without binary files
```bash
grep to_find_string . -r -I
```
- -r recursive
- -I ignore binary

检测 `vt-us1.vent.link` 到本地的 ping 时长
```bash
traceroute -T -p 33322 vt-us1.vnet.link
```

yum warning RPMDB alter out of yum. because of rpm use none yum api to modify soft
```bash
yum clean all
yum history sync
```
