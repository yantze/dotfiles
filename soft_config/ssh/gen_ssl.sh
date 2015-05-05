# 用openssl生成自签名网站ssl(https)证书
openssl req -x509 -newkey rsa:1024 -nodes -days 365 -out zhetenga.com.pem -keyout zhetenga.com.key

# linux下用openssl生成https(ssl)证书请求(csr)
要申请下来一个https(ssl)证书首先要生成一个证书请求文件，并提交。
要生成证书请求(csr)，首先要生成一个key文件，命令：
openssl genrsa -out server.key 2048
其中 2048 是证书位数，可以为其它数字例如1024。
接着生成证书请求，也就是csr文件，命令：
openssl req -new -key server.key -out server.csr
如果要检查生成的私钥或证书请求，可以分别使用：
openssl rsa -noout -text -in server.key
openssl req -noout -text -in server.csr
