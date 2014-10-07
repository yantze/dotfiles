#!/bin/env sh

#可以压缩导出的文档
mysqldump -uraiuds -p radius | gzip -9 >sql.gz
