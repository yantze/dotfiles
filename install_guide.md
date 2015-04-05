#本项目安装指南

###添加字体
YaHei.Consolas.1.12.Revise https://github.com/yantze/vimrc/tree/master/vimfiles/fonts
MONACO.TTF                 地址同上


###安装javascript语法检查和自动排版(<shift-f>)
到~/.vim/vimfiles/bundle/tern_for_vim下执行npm install 


###安装ycm的步骤 for c/c++ style user
默认关闭编译YCM，如果需要开启，确保安装了python-dev和gcc4.4.1+后,
请自行取消script/install_rc.sh中YCM的注释

**ubuntu**
$ sudo apt install build-essential cmake python-dev
**centos**
$ sudo yum isntall cmake28

**如果不使用c/c++的语义提示**
到~/.vim/vimfiles/bundle/YouCompleteMe执行./install.sh

**如果要使用语义提示需要安装clang**
$ sudo apt-get install clang

centos 需要安装EPEL(Extra Packages for Enterprise Linux)
$ sudo yum install clang

或者去下载clang的lib,具体的请看YCM作者的介绍
如果之前就安装过了,可以用locate libclang.so查找libclang.so的位置
比如结果是/usr/lib64/llvm/libclang.so 

**切换到ycm的项目目录，然后执行下面的命令**
./install.sh --clang-completer
或者
cmake28 -G "Unix Makefiles" . -DPATH_TO_LLVM_ROOT=/usr/lib64/llvm ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs
完成YCM安装
[warning]我的vimrc默认未开启YCM,你可以在_vimrc.bundles中取消相应的注释
[warning]如果出现下面的错误或者如果你在vps上编译YCM,说明你的内存不够用
```
g++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
```
使用交换分区来解决
```bash
sudo dd if=/dev/zero of=/swapfile bs=64M count=16
sudo mkswap /swapfile
sudo chmod 644 /swapfile
sudo swapon /swapfile
```
当完成编译后,可以选择取消交换分区
```bash
sudo swapoff /swapfile
sudo rm /swapfile
```

###ManPageView
manpageview需要安装文本浏览器(text browser)软件, 需要安装links、elinks或者links2中的一个

###vba文件安装方法(这个项目暂时不需要)
如果有扩展名为vba的vim插件,需要用vimball方式安装
用vim打开vba格式的文件，输入 `:so %`,
即可安装，然后`:q`退出,
删除插件也很方便，直接在vim里输入 `:RmVimball 插件名`
比如我其中一个插件manviewpage.vba就是用这个方法(我已经默认安装)


###提取php函数名
```bash
find ./php.5.3 -type f -name "*.h" -o -name "*.c" | xargs grep -E "PHP_FUNCTION|ZEND_FUNCTION" | sed -ie "s/.*_FUNCTION(//g;s/)//g" | sort | uniq > functions.txt
```
