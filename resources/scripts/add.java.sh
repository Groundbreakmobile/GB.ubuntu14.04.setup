#!/bin/bash

######
# install elasticsearch
######


echo "Setting up the repos..."
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

sudo apt-get install oracle-java8-installer

echo 'Adding JAVA_HOME'
echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment

source /etc/environment

echo 'done setting up java'

