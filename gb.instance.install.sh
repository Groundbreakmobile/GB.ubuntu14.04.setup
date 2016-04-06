#!/bin/bash

##### ubuntu 14.04 Groundbreakmobile setup ####


echo "update apt"
 aptitude update
 aptitude -y upgrade

#echo "install vim"# vim installed by default in EC2 ubuntu 14.04 image
# aptitude -y install vim
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

mkdir /opt/phpfarm/inst/conf
mkdir /opt/phpfarm/inst/ini


echo "compile php 5.4.45"
cd /opt/phpfarm/src
 ./compile.sh 5.4.45
#add php-fpm to the bin folder
ln -s /opt/phpfarm/inst/php-5.4.45/sbin/php-fpm /opt/phpfarm/inst/php-5.4.45/bin/php-fpm
cp ~/GB.ubuntu14.04.setup/resources/apache2/php-fpm.conf /opt/phpfarm/inst/php-5.4.45/etc/.
cp ~/GB.ubuntu14.04.setup/resources/apache2/php-fpm.conf /opt/phpfarm/inst/conf/.
cp /opt/phpfarm/inst/php-5.4.45/lib/php.ini /opt/phpfarm/inst/ini/.
ln -s /opt/phpfarm/inst/php-5.4.45/etc/php-fpm.conf /opt/phpfarm/inst/php-5.4.45/bin/php-fpm.conf



#echo "compile php 5.3.29"
#cd /opt/phpfarm/src
#./compile.sh 5.3.29
#add php-fpm to the bin folder
#ln -s /opt/phpfarm/inst/php-5.3.29/sbin/php-fpm /opt/phpfarm/inst/php-5.3.29/bin/php-fpm
#cp ~/GB.ubuntu14.04.setup/resources/apache2/php-fpm.conf /opt/phpfarm/inst/php-5.3.29/etc/.
#cp ~/GB.ubuntu14.04.setup/resources/apache2/php-fpm.conf /opt/phpfarm/inst/conf/.
#cp /opt/phpfarm/inst/php-5.3.29/lib/php.ini /opt/phpfarm/inst/ini/.
#ln -s /opt/phpfarm/inst/php-5.3.29/etc/php-fpm.conf /opt/phpfarm/inst/php-5.3.29/bin/php-fpm.conf


echo "export new paths"
#export PATH="$PATH:/opt/phpfarm/inst/bin:/opt/phpfarm/inst/current-bin"  # duplicated below

echo "add new path to bash startup"
echo 'PATH="$PATH:/opt/phpfarm/inst/bin:/opt/phpfarm/inst/current-bin"' >> ~/.bashrc
source ~/.bashrc

echo "choose php version"
/opt/phpfarm/inst/bin/switch-phpfarm 5.4.45
#switch-phpfarm 5.3.29

echo "adding APC"

echo "installing pear"
aptitude -y install php-pear

echo "adding php-fpm init script"
cp ~/GB.ubuntu14.04.setup/resources/init.d/php-init-fpm /etc/init.d/.
chmod 755 /etc/init.d/php-init-fpm
update-rc.d php-init-fpm defaults


echo "enable apache modules"
a2enmod fastcgi actions suexec alias rewrite

cd ~/GB.ubuntu14.04.setup/



cp ~/GB.ubuntu14.04.setup/resources/etc/apache2/sites-available/5.3.29.vhost.conf /etc/apache2/sites-available/.

a2ensite 5.3.29.vhost.conf

a2dissite 000-default.conf

mkdir -p /var/www/test.groundbreakmobile.com

echo "<?php phpinfo(); ?>" >/var/www/test.groundbreakmobile.com/index.php

ln -s /opt/phpfarm/inst/current-bin/php /usr/bin/php

echo "set up apc for 5.4.45"

mkdir -p /opt/phpfarm/src/extensions/
rm -rf /opt/phpfarm/src/extensions/*
cd /opt/phpfarm/src/extensions/
pecl download apc
tar vxzf APC-3.1.13.tgz
 cd APC-3.1.13/
 /opt/phpfarm/inst/bin/phpize-5.4.45
 ./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.4.45
  make
  make install


echo "set up jsmin for 5.4.45"

mkdir -p /opt/phpfarm/src/extensions/
rm -rf /opt/phpfarm/src/extensions/*
cd /opt/phpfarm/src/extensions/
pecl download jsmin
tar vxzf jsmin-2.0.1.tgz
cd jsmin-2.0.1/
/opt/phpfarm/inst/bin/phpize-5.4.45
./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.4.45
make 
make install


# start php-fpm
#php-fpm is now a service#/opt/phpfarm/inst/php-5.3.29/sbin/php-fpm -y /opt/phpfarm/inst/php-5.3.29/etc/php-fpm.conf -c /opt/phpfarm/inst/php-5.3.29/lib/php.ini
service php-init-fpm start

a2enmod proxy_fcgi

echo "restart apache"
service apache2 restart


echo "set up cli sugarcrm repair script"
cp ~/GB.ubuntu14.04.setup/resources/usr/bin/repair.php /usr/bin/repair
chmod +x /usr/bin/repair

echo "set git publishing credentials"
git config --global user.name "NSM GB Server"
git config --global user.email nmorris@groundbreakmobile.com

echo "setting up composer"
~/GB.ubuntu14.04.setup/add.composer.sh
