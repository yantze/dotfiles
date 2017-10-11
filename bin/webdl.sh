# 使用 wget 下载整个网站解释
# link: https://www.douban.com/note/536265958
# wget 
# --recursive          //回归递推也就是包括所有子目录子文件
# --no-clobber         //不更改已经存在的文件，也不使用在文件名后添加 .#(# 为数字)的方法写入新的文件
# --page-requisites    //下载所有显示完整网页所需的文件，例如图像。
# --html-extension     //将所有text/html文档以.html扩展名保存
# --convert-links      //转换非相对链接为相对链接
# --no-parent          //不要追溯到父目录
# --level=0            // Specify recursion maximum depth level depth.
# --adjust-extension   // A URL like http://site.com/article.cgi?25 will be saved as article.cgi?25.html.
# --tries=3            // 尝试最大次数. 默认 20 次
# --user-agent=agent   // user agent string, eg. 'mozilla'
# --random-wait        // This option causes the time between requests to vary between 0.5 and 1.5 * wait seconds
# -e robots=off        // disable website robots.txt
# 
# --restrict-file-names=windows  // 限制文件名中的字符为指定的 OS (操作系统) 所允许的字符。
# --domains wordpress.org        // 被接受域的列表. 也就是跳出此列表的域名就不follow
# codex.wordpress.org            // 要下载的网站域名下的某个目录


wget --recursive --page-requisites --html-extension --convert-links --no-parent --level=0 -e robots=off --user-agent='mozilla' --random-wait --adjust-extension --tries=3 --restrict-file-names=windows --domains $*
