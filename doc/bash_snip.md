取出文件列表

# 防止WordSplitting，避免使用$(ls *.txt)
for file in *.txt
do
    # 防止文件名以-开头
    cp "./$file" /path/to/target
done
按行读取文件

while read line
do
    echo "$line"
done < text.txt
拷贝文件

cp -- "$file" "$target"
# -- 防止文件名以-开头
# " 防止文件名中含有空格
字符串比较

[[ $foo == "$bar" ]]
cd到目录

# -P prefix
cd -P -- "$(dirname -- "$f")"
数字比较

((foo > 7))
# 或者
[ "$foo" -gt 7 ]
判断文件中是否包含某个字符串

if grep -q fooregex /path/to/file; then
    # do something here
fi
多条件判断

if [ a = b ] && [ c = d ]
# 或者
if [[ a = b && c = d ]]
对文件的修改

先修改到临时文件，再mv回去

多行字符串

# 不要使用echo
cat <<EOF
  Hello world
  How's it going?
EOF
对cd命令是否成功的判断

cd /foo && bar
# 或者有很多依赖于cd之后的命令
cd /foo || exit 1
# ...
# ...
# 或者顺便说点什么 
cd /foo || { echo "hi, man!"; exit 1; }
for循环

for ((i=1; i<=n; i++)); do
    # do something here
done
错误重定向

# 先重定向到文件，再定向到标准输出(标准输出已经到tty了)
somecmd >>logfile 2>&1

不显示终端的输入(stty)

echo "Please enter your password:"

stty -echo

read PASSWORD

stty echo

# 输出刚才输入的内容

echo $PASSWORD
交互式选择(select)

# 江山和美人，你更喜欢那个？

echo "Which do you prefer?"

select result in "beauty" "land"

do

    break

done

echo $result
得到当前脚本的绝对路径

echo $(cd "$(dirname "$0")"; pwd)
