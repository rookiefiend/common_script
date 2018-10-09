#!/bin/bash

if [ $# = 0  ]; then
    echo "Please input a address suffix! for example: 192.168.34.114"
    exit 1
fi

# 进入修改目录
cd /etc/sysconfig/network-scripts

conf=ifcfg-ens32
if [ -e ifcfg-eth0 ]; then
	conf=ifcfg-eth0
fi

sed -i 's/none/static/g' ${conf}
sed -i 's/IPADDR.*/IPADDR="'$1'"/g' ${conf}

systemctl restart network
