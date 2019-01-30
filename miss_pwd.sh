#!/bin/bash

set -x 
[ ! -f /root/.ssh/id_rsa.pub  ] && ssh-keygen -t rsa -P '' &>/dev/null

while read line;do
 	ip=`echo $line | cut -d " " -f1`             # 提取文件中的ip
        user_name=`echo $line | cut -d " " -f2`      # 提取文件中的用户名
        pass_word=`echo $line | cut -d " " -f3`      # 提取文件中的密码
	if [ $user_name != $ip ]; then
		user=$user_name
	fi
        if [ $pass_word != $ip ]; then
                pwd=$pass_word
        fi
	expect -c "
        	set timeout -1;
        	spawn ssh-copy-id  $user@$ip;
        	expect {
        	        \"yes/no\" { send \"yes\r\" ;exp_contine; }
        	       	\"password:\" { send \"$pwd\r\"; }
        	};
        	expect eof;
        	"
done < host_ip.txt # 读取存储ip的文件, 若多台主机用户名密码相同, 可将多台主机顺序编写, 然后只需设置第一行的用户名和密码
