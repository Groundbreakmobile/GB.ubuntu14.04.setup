#!/bin/bash
#######
# add server swapspace
#######

echo "allocating swap space"
sudo fallocate -l 2G /swapfile

echo "changing swapfile permissions"
sudo chmod 600 /swapfile

echo "marking swapfile as swap"
sudo mkswap /swapfile

echo "enabling swapfile"
sudo swapon /swapfile

echo "adding swap to fstab"
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

echo "altering swappiness"
echo "vm.swappiness=10" >> /etc/sysctl.conf

echo "altering cache pressure"
echo "vm.vfs_cache_pressure = 50" >>/etc/sysctl.conf

echo "done creating swap file"
