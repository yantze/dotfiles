command log
---

ctags config
```
ctags -R # 相对路径
ctags -R /server/ # 绝对路径，可以在任何目录下查看
# 在 ~/.vimrc 中添加
set tags+=/server/php-src/tags # 或在 vim command 中运行
# 完成后可以在源代码中跳转申明
```
