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
 aptitude -y libapache2-mod-fastcgi

echo "install apache"
 aptitude -y install apache2

echo "build php dependencies"
 aptitude -y build-dep php5

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

echo "compile php 5.4.45"
cd /opt/phpfarm/src
 ./compile.sh 5.4.45

echo "compile php 5.3.29"
cd /opt/phpfarm/src
./complie.sh 5.3.29

echo "export new paths"
export PATH="$PATH:/opt/phpfarm/inst/bin"

echo "add new path to bash startup"
echo 'PATH="$PATH:/opt/phpfarm/inst/bin"' >> ~/.bashrc

echo "enable apache modules"
a2enmod fastcgi actions suexec

echo "add FASTCGI options to apache config"
echo "# Include FastCGI configuration for PHPFarm" >> /etc/apache2/apache2.conf
echo "IncludeOptional cgi-servers/*.conf" >> /etc/apache2/apache2.conf

echo "restart apache"
service apache2 restart

echo "set up cgi directories"
mkdir /etc/apache2/cgi-servers/

cd ~/GB.ubuntu14.04.setup
echo "copy php-cgi-5.3.29.conf to cgi-servers"
cp resources/apache/php-cgi-5.3.29.conf /etc/apache2/cgi-servers/.

echo "set up cgi-bin"
mkdir -p /var/www/cgi-bin

cd ~/GB.ubuntu14.04.setup
echo "copy php-cgibin-5.3.29 to the bin"
cp resources/apache/php-cgibin-5.3.29 /var/www/cgi-bin/.
chmod +x /var/www/cgi-bin/php-cgibin-5.3.29

cd ~/GB.ubuntu14.04.setup
echo "copy vhost"
cp resources/apache/GB.standard.vhost.conf /etc/apache2/sites-available/.

echo "enable standard site"
a2ensite GB.standard.vhost.conf

echo "restart apache"
apachectl restart

echo "set git publishing credentials"
git config --global user.name "NSM GB Server"
git config --global user.email nmorris@groundbreakmobile.com
