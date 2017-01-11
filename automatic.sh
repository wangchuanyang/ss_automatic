    #! /bin/bash
    #FTP的IP 用户名 密码
    ftp_ip=Your_IP
    ftp_user=ftp
    ftp_passwd=yourpasswd
    #FTP部分结束

    passwd=`cat /dev/urandom | head -1 | md5sum | head -c 8`
    cat > /etc/shadowsocks/config.json << EOF
    {
        "server":"0.0.0.0",
        "server_port":8989,
        "local_address":"127.0.0.1",
        "local_port":1080,
        "password":"$passwd",
        "timeout":60,
        "method":"chacha20"
    }
    EOF
    echo $passwd > /home/wwwroot/passwd.txt
    cd /home/wwwroot
    ftp -v -n $ftp_ip << END
    user $ftp_user $ftp_passwd
    passive
    delete passwd.txt
    put passwd.txt
    bye
    END
    /etc/init.d/shadowsocks restart
    exit
