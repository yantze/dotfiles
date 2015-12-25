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
    -r recursive
    -I ignore binary
