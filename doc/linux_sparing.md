#少用的一些命令
常用的命令在LINUX_TIPS.md文件中

###解压/boot目录下的img文件
先用file initramfs.xxx.img查看文件类型，是gzip文件
改名initramfs.xxx.img.gz,使用gzip -d initramfs.xxx.img.gz
再检查文件类型file initramfs.xxx.img.gz，是ASCII cpio文件
使用cpio -idvm < initramfs.xxx.img解压文件

这样也可以
```
# 提取
zcat ../initrd.gz | cpio -iv
# 创建
find . -print0 | cpio -0 -H newc -ov | gzip -c > ../initrd.gz
```

###把源格式文件shift-jis轉換爲utf-8
iconv -f shift-jis -t utf-8 file1.cue >  file2.cue


###
ps -ef/ c column means the cpu utilization, please RTFM

###内存不够,外加添加虚拟内存方法
g++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
 
主要原因大体上是因为内存不足,有点坑 临时使用交换分区来解决吧
 
sudo dd if=/dev/zero of=/swapfile bs=64M count=16
sudo mkswap /swapfile
sudo swapon /swapfile

After compiling, you may wish to

Code:
sudo swapoff /swapfile
sudo rm /swapfile
