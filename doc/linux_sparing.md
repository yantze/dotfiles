#少用的一些命令

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
