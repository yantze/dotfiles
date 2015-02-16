###must installed package
yum install git hg ntpdate the_silver_searcher
yum install zsh tmux bind-utils man-pages
bind-utils:包含dig, nslookup等网络工具
man-pages man-pages-zh-CN:kernel源代码等手册

yum groupinstall -y "Development Tools"


###
locate now is mlocate in Centos&RHEL
yum install mlocate
After that either wait for tomorrow :-) or give command "updatedb". This collects folder and file names to a database, which is the reason everyone wants to use locate instead of find: it is dozens of times faster.


###
python3
wget http://www.python.org/ftp/python/3.4.2/Python-3.4.2.tar.bz2
./configure
./make
./make altinstall
sudo ln -n /usr/local/bin/python3.4 /usr/local/bin/python3
sudo ln -n /usr/local/bin/pip3.4 /usr/local/bin/pip3


