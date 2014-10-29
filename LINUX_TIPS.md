linux 详细的使用说明

##常用技能
* vim
- CtrlP
- ag

* linux
- 在要代理的软件前面加上 proxy

TODO
phabricator 这个软件没有完成,dirctory定位到/home/yantze/phabricator/phabricator/webboot,打开phabricator系统的ip地址，提示无权限
如果成功解决，打开url：http://www.phabricator.com/docs/phabricator/article/Configuring_Accounts_and_Registration.html

1，由于在home建立的网页apache默认是不允许读取的，就算有777也不行
getsebool -a |grep httpd_enable_homedirs
httpd_enable_homedirs --> off
所以要运行：
setsebool httpd_enable_homedirs on
重启可正常

内置命令：
cat << EOF >> output.txt
> line 1
> EOF
printf "%x\n" 111
locale 查看当前语言区的设置
paste -sd, 1.txt 合并单个文件
paste 1.txt 2.txt 按Tab合并两个文件
cut -d: -f1 /etc/passwd | head -2 //打印第一列前两行
cut -c2- //删除空格
cp /your/path/to/file.list{,.20121106} //备份文件
cp -af file tofile //用原来文档的用户名
Ctrl+x Ctrl+e //编辑当前的命令到编辑器，可以在zshrc中export EDITOR='vim'
echo $'\x41'  //输出A
echo "`ls -l`" || echo `ls -l` //shell用IFS定义的分隔符来分隔字符串，包括、n，所以再传给echo就是，"line 1" "line 2"
nl || cat -n || cat -d //给文件加行号，中间的会给空行加行号，其它的不会
dmesg //查看软硬件配置
uptime //查看计算机登陆信息，负载均衡等
su www -c 'php xxx.php' //命令下行指定用户组来执行命令
usermod -a -G groupA user //添加用户到用户组
od -c file / od file //显示文件内容，如果没有c显示其它进制
fc //这个是可以在命令行输入文字到vim中编辑的内置命令

ifconfig
ifconfig -a //显示所有网卡接口
ifconfig eth0 down //禁用eth0网卡
ifconfig eth0 up//启用eth0网卡
ifdown eth0; ifup eth0; //同上

route
如果你有两个以上的网卡，那么很不幸的是默认网关是内部网，现在需要删除默认的再添加自己设定的默认
ip route del default
ip route add default via 192.168.100.1
其中default来自centos的/etc/networks文件
参考资料：
http://tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.rpdb.multiple-links.html
http://unix.stackexchange.com/questions/22770/two-interfaces-two-addresses-two-gateways
http://www.thomas-krenn.com/en/wiki/Two_Default_Gateways_on_One_System

sha  //输入这三个字母后会自动有几个选项，可以自己选吧

!!上一条指令
!hist //执行历史命令中hist开头的最后一条指令
!?hist //执行历史命令中包含hist开头的命令
!10  //执行第十条的历史命令
echo filename haha !#:1  //显示当前第1个参数!#:1的位置
!$  //上一条历史命令的最后一条参数
[ALT+.]  //按这个组合键可以获取最后一条参数
!:2   //获取上一个参数的第二个位置
!:2-4   //获取上一个参数的第二到第四个参数
!:2*    //获取上一个历史参数第二个位置和之后的所有位置
!*  //获取上一个历史命令的所有参数
eg.
$ ls code src
$ cp -r !*

^hits^hist  //替换上一条指令
^hits^hist^:G  //替换上一条命令的所有string

xz://有时候出现tar.xz要分开解压
xz -zk //要压缩的文件，k保留源文件
xz -dk //要解压的文件，k保留源文件

tar 解压指定文件
tar zxvf package.tar.gz -C new_dir

grep MemTotal /proc/meminfo
grep MemFree /proc/meminfo # 查看空闲内存量

id username  #显示用户信息
last # 查看用户登录日志

在putty下
alt+.
在vim下
Ctrl+Y

ldd exefile //查找这个程序需要的动态链接库
ldconfig //刷新当前系统的动态链接库
pkg-config // 查看当前系统中lib的编译选项

awk  //格式化输出 http://coolshell.cn/articles/9070.html
sed  //

watch command //实时监视命令结果变动，可以调节更新频率

生成十六随机数, n是多少位
openssl rand -hex n

截取长度
${variable:0:5}



软件使用：
netstat -tupln 查看网络信息
sp mem 查看内存使用，与free一样
lsof list open file 可以使用lsof -i 查看网络的信息
lsof -i:22 //查看22端口在运行什么程序
lsof -c abc //查看abc进程现在在打开的文件
lsof -p 12 //查看进程号为12的打开了什么文件
lsmod //查看使用的模块
iotop 查看磁盘，与top结合
ab -c 20 -n 2000 http://baidu.com/ 查看这个网站的并发量等功能，一个httpd的附属软件
c 代表请求的网页数目,越大越准
n 代表并发2000
lsblk 这个可以查看整个磁盘的逻辑位置
lsb_relase 这个在centos图形界面才可以用
uname -a //这个也可以现实电脑的详细信息，但是显示不了发行版本
uptime //当前电脑时间/系统已经运行时间/目前有多少用户/系统过去1、5、15分钟内的平均负载 //也可以用cat /proc/loadavg
du -ah //查看文件列表的大小
du -sh //查看所有文件的大小总和
cmp file1 file2 //查找当前文件第一个不同的位置
wc -l //统计行数/ -w 统计单词
chattr +i file//让文件为只读 /用lsattr 查看
vmstat 5 //每五秒显示系统的cpu,memory,i/o
top //shift+p 进程排序 /shift+m 内存排序
ntpdate cn.pool.ntp.org //更新时间
make 2>&1 | tee make.log //可以直接显示保
lsof //列出当前正在使用的文件
fuser //列出当前打开的文件和socket
md5sum filename //计算文件的大小

ag keychar  //直接查看当前目录下包含keychar的字符
grep -r "some_text" /path/to/dir //递归查找grep的目录
grep -w "name" test.txt  //查找完整的字符串
grep pattern files
grep -r pattern dir
rsync -arvuzp --chmod=g+rx -e "ssh -p 22333" ./db.txt 172.31.195.91:/home/yantze/test/

lex=flex / yacc / bison
bison是GUN版的语法分析器，yacc是Berkeley版的语法分析器，两者实现功能类似，可能会有微小的语义差别


curl
curl -u "yantze" -d '{"scopes":["public_repo"]}' https://api.github.com/users/yantze\?callback\=haha
curl -u "yantze" -H "Accept: application/vnd.github.v3.text+json"  https://api.github.com/users/yantze
curl -i/-I -u "username":"password"


zsh使用技巧
..  快速向上跳 ‘...’顶目录
ls * 或者ls -l * 都是可以递归显示
j 曾今访问过的目录名 这个功能需要安装autojump
alt+l 直接执行上一次执行的内容
直接输入目录可以进入
zsh 的补全，所有待补全项都可以通过键盘方向键或者 <Ctrl-n/p/f/b> 来选择
聰明的目錄補全 cd /u/p/w/p/s/m/w/s/j<TAB>
快速目录切换 zsh 会记住你每一次切换的路径，然后通过 1 来切换到你上一次访问的路径，2 切换到上上次……一直到 9，还可以通过 d 查看目录访问历史
osx:
man-preview 通过 preview 程序查看一个命令的手册，例如 man-preview git  (需要給oh-my-zsh
中添加參數 osx)
quick-look 快速预览文件
pfd 返回当前 finder 打开的文件夹的路径
cdf 切换到当前 finder 所在的目录

ssh使用技巧
ssh-keygen 生成id_rsa,id_rsa.pub
cat id_rsa.pub>>authorized_keys
如果是linux使用ssh-copy-id，自动就会把id_rsa添加到目的linux主机
如果是windows，使用puttygen转换为putty使用的格式，然后用putty登陆即可
+++进阶,authorized_keys使用command
下面是authorized_keys内容，command可以设置ssh端登陆后的操作
command="$HOME/bin/hello",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA


glances
su root
# rpm -ivh http://fr2.rpmfind.net/linux/epel/6/x86_64/epel-release-6-7.noarch.rpm
# yum install python-pip python-devel
# pip-python install glances
more info:http://www.vpsee.com/2013/07/a-new-system-monitoring-tool-glances-installation-and-usage/

sysstat
iostat #这个软件中包含了这个软件

日志监控软件
iostat
vmstat
sp htop
glances
goaccess #for apache/nginx/lighttp

linux帮助命令
man/page
whereis
type -a #这个可以查找所以的命令位置
whatis #这个可以解释一组命令
which #查找当前path里面的可执行文件
type file #如果用whereis找不到可以先看看文件类型
nm  #查看.o文件中调用了哪些程序

find http://www.cnblogs.com/peida/archive/2012/11/14/2769248.html
常用find：
find . -type f -exec ls -l {} \;
find . -type f -mtime +14 -exec rm {} \; 
find . -name "*.log" -mtime +5 -ok rm {} \;
find /etc -name "passwd*" -exec grep "root" {} \;
find . -name "*.log" -exec mv {} .. \;
find . -name "*.log" -exec cp {} test3 \;
find . -depth; 这个可以不让find输出文件夹
find . -name "*.log" print0 | xargs -0 cat | wc -l
find . -perm /u+x -type f -exec rm {} \;  //删除可执行文件

sshfs
sshfs -o allow_other root@192.168.9.109:/opt /opt/s109 #挂载(如配上ssh key可完全自动化)
添加allow_other是因为执行这条命令的人可能需要其它人使用，所以添加这个参数后就可以用用其它的用户了
fusermount -u /opt/s109 #卸载
也可以用umount /opt/s109 来卸载
mount -o remount,rw /
mount -t tmpfs tmpfs /tmpram -o size=512m  //创建ramdisk

dd
备份/dev/hdb全盘数据，并利用gzip工具进行压缩，保存到指定路径
    dd if=/dev/hdb | gzip> /root/image.gz
将压缩的备份文件恢复到指定盘
    gzip -dc /root/image.gz | dd f=/dev/hdb
备份磁盘开始的512个字节大小的MBR 主引导记录信息到指定文件
    dd if=/dev/hda f=/root/image count=1 bs=512   默认从硬盘0柱面0磁道1扇区读取512个字节
    count=1指仅拷贝一个块；bs=512指块大小为512个字节。
    恢复：dd if=/root/image f=/dev/hda
修复硬盘：                 自初始化硬盘
    dd if=/dev/sda f=/dev/sda  SCSI硬盘 或dd if=/dev/hda f=/dev/hda   IDE
BLOCKS单位:b=512, c=1, k=1024, w=2, xm=number m
跳过一段以后才输出 seek=BLOCKS 
跳过一段以后才输入 skip=BLOCKS 
eg:dd if=fork.c of=i.iso count=20 bs=2c
讲的是从fork.c中提取20个2char，写到文件i.iso中
eg:dd if=fork.c of=i.iso count=20 bs=2c seek=2c skip=2c
讲的是从fork.c中先偏移读取指针2char，提取20个2char，再放弃输出2char，然后输出18char到i.iso文件中
eg:dd if=/dev/zero of=2g.img seek=1000 count=1 bs=1M
这条命令输出后，结果是占用了1M磁盘空间，但是用ll显示，是1001M的文件


dev
/dev/urandom
/dev/zero

二进制 text2bin test2hex
hexdump
xxd



本机使用的软件
rouchdb #一个json格式的nosql数据库
fail2ban

zsh使用技巧
..  快速向上跳 ‘...’顶目录
ls * 或者ls -l * 都是可以递归显示
j 曾今访问过的目录名 这个功能需要安装autojump
alt+l 直接执行上一次执行的内容
直接输入目录可以进入

dirs 的命令
d  //d is an alias for dirs -v | head -10
po //popd , popd is pop dir
pp //pushd , put the current dir 
在zsh中输入d命令下面的数字，可以直接进入




valgrind c检查错误工具，编译需要加上'-g'
valgrind ./execufile


tmux
#shortcut explan
!           Break the current pane out of the window.
;           Move to the previously active pane.
x           Kill the current pane.
{           Swap the current pane with the previous pane.
}           Swap the current pane with the next pane.
m           split the current window with manpage
q num       #select a panel in window
x           #kill one panel in window
[           #surface upon window
w           #show all window(Select from interactive list of windows)
tmux list-sessions  #list all sessions
#cheatsheet:https://gist.github.com/MohamedAlaa/2961058#file-tmux-cheatsheet-markdown

bind-key F1 set-window-option force-width 81

较少使用的命令
shred - overwrite a file to hide its contents, and optionally delete it
python -m SimpleHTTPServer 8888 & //python 2+
python -m http.server 8888 & //python 3+
gpg -c file件加密
gpg file.gpg件解密

有一个命令参考比较齐全，之后再消化一下
http://www.pixelbeat.org/cmdline_zh_CN.html

killall
killadd5

要安装的软件
yum install bind-utils
