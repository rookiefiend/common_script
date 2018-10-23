#!/bin/bash
# 临时关闭
swapoff $(blkid | grep swap | awk -F ":" '{print $1}')

# 永久关闭
sed 's:.*swap:#&:g' /etc/fstab
