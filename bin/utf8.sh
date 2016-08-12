iconv -f GB2312 -t UTF-8 $1 > $1.tmp
rm -f $1
mv $1.tmp $1
