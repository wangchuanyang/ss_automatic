# ss_automatic

解释一下脚本的实现过程<br />
1 通过`dev/urandom`生成随机8位密码 <br />
2 用这个随机密码配置ss配置文件。<br />
3 输出这个密码到passwd.txt文本文件，这个文件可供http访问。本来到这一步也就完成了，但因为vps服务器没有上ssl，在博客上直接引用这个txt文件会提示不安全内容而不加载，要手动加载，比较麻烦，所以有了下面的步骤。<br />
4 通过ftp把这个passwd.txt上传到博客所在的服务器，博文上直接引用本地资源就不会有问题了。<br />
PS 如果你的博客没有ssl，可以忽略ftp部分。<br />

在博文上引用这个txt文件可通过iframe实现。<br />
<code> <iframe name="txt" marginwidth="0" marginheight="0" width="70" height="15" src="passwd.txt" frameborder="0"></iframe> </code>

crontab定时执行以上脚本，我设定的是每天1时更改一次。<br />
<code>    0 1 * * * sh ~/sh/ss.sh</code>
