## curl
```bash
curl http://xxx.com
curl -H 'Host:www.jfz.com' http://192.168.1.251/index.html
curl -d 'post1=data1' http://xxx.com
curl -d 'file1=@/data/file1' http://xxx.com/fileupload
curl -F 'input1=data1' http://xxx.com
```bash

### 刷票程序
```bash
curl -d 'radio_5[]=144' -d 'radio_5[]={$ids[0]}' -d 'radio_5[]=
{$ids[1]}' -d 'radio_5[]={$ids[2]}' -d 'radio_5[]={$ids[3]}' -d
'radio_5[]={$ids[4]}' -A '{$ua}' -H 'Content-Type:application/x-
www-form-urlencoded; charset=UTF-8' -H
'Origin:http://www.cyzone.cn' -H 'X-Requested-With:XMLHttpRequest'
-H 'Accept:application/json, text/javascript, */*; q=0.01' -e
'http://www.cyzone.cn/features/2015cyxg/' -H 'X-FORWARDED-FOR:$ip'
-H 'CLIENT-IP:$ip' 'http://www.cyzone.cn/index.php?
m=vote&c=index&a=post&subjectid=5'
```

### 每5分钟上报一次上报最近5分钟的日志
```bash
tail -F access.log > tmp.log */5 * * * * mv tmp.log upload.txt; curl
-d "upload_file=@upload.txt" http://xxx.com/log_upload.php; rm
upload.txt 
```
