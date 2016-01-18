#!/bin/bash

##### ubuntu 14.04 Groundbreakmobile setup ####


 aptitude update
 aptitude -y install vim
 aptitude -y install git 
 aptitude -y install build-essential
 aptitude -y install libc-client2007e-dev
 aptitude -y install libldb-dev
 aptitude -y install libmcrypt-dev
 aptitude -y install apache2
 aptitude -y build-dep php5
sleep 2
./create.so.linker.files.sh
sleep 2
cd ~/GB.ubuntu14.04.setup

 git clone https://github.com/cweiske/phpfarm.git /opt/phpfarm
 cp resources/phpfarm/* /opt/phpfarm/src/.

cd /opt/phpfarm/src
 ./compile.sh 5.4.45
./complie.sh 5.3.29

export PATH="$PATH:/opt/phpfarm/inst/bin"
echo 'PATH="$PATH:/opt/phpfarm/inst/bin"' >> ~/.bashrc


a2enmod fascgi actions suexec

service apache2 restart

echo "# Include FastCGI configuration for PHPFarm" >> /etc/apache2/apache2.conf
echo "IncludeOptional cgi-servers/*.conf" >> /etc/apache2/apache2.conf


mkdir /etc/apache2/cgi-servers/

cp resources/apache/php-cgi-5.3.29.conf /etc/apache2/cgi-servers/.

mkdir -p /var/www/cgi-bin
cp resources/apache/php-cgibin-5.3.29 /var/www/cgi-bin/.
chmod +x /var/www/cgi-bin/php-cgibin-5.3.29

cp resources/apache/GB.standard.vhost.conf /etc/apache2/sites-available/.

a2ensite GB.standard.vhost.conf
apachectl restart

git config --global user.name "NSM GB Server"
git config --global user.email nmorris@groundbreakmobile.com
