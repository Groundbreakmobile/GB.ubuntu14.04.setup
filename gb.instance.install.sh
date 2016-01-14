#!/bin/bash

##### ubuntu 14.04 Groundbreakmobile setup ####


 aptitude update
 aptitude install vim
 aptitude install git 
 aptitude install build-essential
 aptitude install libc-client2007e-dev
 aptitude install libldb-dev
./create.so.linker.files.sh
 apt-get install libmcrypt-dev
 aptitude install apache2
 aptitude build-dep php5
 git clone https://github.com/cweiske/phpfarm.git /opt/phpfarm
 cp resources/phpfarm/* /opt/phpfarm/src/.

cd /opt/phpfarm/src
 ./compile.sh 5.4.45

export PATH="$PATH:/opt/phpfarm/inst/bin"
echo 'PATH="$PATH:/opt/phpfarm/inst/bin"' >> ~/.bashrc



