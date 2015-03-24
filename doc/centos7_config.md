###restart network
systemctl restart NetworkManager


# install yum-axelget
# yum-axelget是EPEL提供的一个yum插件。使用该插件后用yum可以并行下载:
# sudo yum install yum-axelget
# 同时安装axel,axel是一个并行下载工具，在下载http、ftp等简单协议的文件时非常好用。
