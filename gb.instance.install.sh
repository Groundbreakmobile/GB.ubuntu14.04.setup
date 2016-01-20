#!/bin/bash

##### ubuntu 14.04 Groundbreakmobile setup ####


echo "update apt"
 aptitude update

echo "install vim"
 aptitude -y install vim
# git is already installed
# aptitude -y install git 

echo "install build-essential"
 aptitude -y install build-essential

echo "install libraries"
 aptitude -y install libc-client2007e-dev
 aptitude -y install libldb-dev
 aptitude -y install libmcrypt-dev

echo "install fastcgi"
 aptitude -y install libapache2-mod-fastcgi
 aptitude -y install apache2-mpm-worker
 aptitude -y install apache2-suexec

echo "install apache"
 aptitude -y install apache2

echo "build php dependencies"
 aptitude -y build-dep php5
 aptitude -y install php5-fpm

echo "resting..."
sleep 2
echo "create symbolic links"
./create.so.linker.files.sh
echo "resting..."
sleep 2

cd ~/GB.ubuntu14.04.setup

echo "install phpfarm"
 git clone https://github.com/cweiske/phpfarm.git /opt/phpfarm

echo "customize phpfarm"
 cp resources/phpfarm/* /opt/phpfarm/src/.

#echo "compile php 5.4.45"
#cd /opt/phpfarm/src
# ./compile.sh 5.4.45

echo "compile php 5.3.29"
cd /opt/phpfarm/src
./compile.sh 5.3.29
#ln -s /opt/phpfarm/inst/php-5.3.29/bin/php /usr/bin/php


echo "export new paths"
export PATH="$PATH:/opt/phpfarm/inst/bin"

echo "add new path to bash startup"
echo 'PATH="$PATH:/opt/phpfarm/inst/bin"' >> ~/.bashrc

echo "enable apache modules"
a2enmod fastcgi actions suexec alias rewrite

cd ~/GB.ubuntu14.04.setup/
cp resources/apache2/conf-available/php5-fpm.conf /etc/apache2/conf-available/.

a2enconf php5-fpm

#echo "add FASTCGI options to apache config"
#echo "# Include FastCGI configuration for PHPFarm" >> /etc/apache2/apache2.conf
#echo "IncludeOptional cgi-servers/*.conf" >> /etc/apache2/apache2.conf

echo "restart apache"
service apache2 restart

echo "set up conf cgi"
#mkdir /etc/apache2/cgi-servers/
cp ~/GB.ubuntu14.04.setup/resources/apache2/php-cgisetup.conf /etc/apache2/conf-available/.

ln -s /etc/apache2/conf-available/php-cgisetup.conf /etc/apache2/conf-enabled/php-cgisetup.conf

mkdir -p /var/www/cgi-bin

cp ~/GB.ubuntu14.04.setup/resources/var/www/cgi-bin/php-cgi-5.3.29  /var/www/cgi-bin/.

chown -R www-data:www-data /var/www/cgi-bin

chmod -R 0744 /var/www/cgi-bin

cp ~/GB.ubuntu14.04.setup/resources/etc/apache2/sites-available/5.3.29.vhost.conf /etc/apache2/sites-available/.

a2dismod php5

a2ensite 5.3.29.vhost.conf

a2dissite 000-default.conf

# not yet
#service apache2 restart

mkdir -p /var/www/test.groundbreakmobile.com

echo "<?php phpinfo(); ?>" >/var/www/test.groundbreakmobile.com/index.php

service apache2 restart



#cd ~/GB.ubuntu14.04.setup
#echo "copy php-cgi-5.3.29.conf to cgi-servers"
#cp resources/apache/php-cgi-5.3.29.conf /etc/apache2/cgi-servers/.

#echo "set up cgi-bin"
#mkdir -p /var/www/cgi-bin

#cd ~/GB.ubuntu14.04.setup
#echo "copy php-cgibin-5.3.29 to the bin"
#cp resources/apache/php-cgibin-5.3.29 /var/www/cgi-bin/.
#chmod +x /var/www/cgi-bin/php-cgibin-5.3.29

#cd ~/GB.ubuntu14.04.setup
#echo "copy vhost"
#cp resources/apache/GB.standard.vhost.conf /etc/apache2/sites-available/.

#echo "enable standard site"
#a2ensite GB.standard.vhost.conf

#echo "restart apache"
#apachectl restart

echo "set git publishing credentials"
git config --global user.name "NSM GB Server"
git config --global user.email nmorris@groundbreakmobile.com
