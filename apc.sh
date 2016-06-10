cd /opt/phpfarm/src/
mkdir extensions
rm -rf extensions
cd extensions/
 pecl download apc
tar vxzf APC-3.1.13.tgz
 cd APC-3.1.13/
 /opt/phpfarm/inst/bin/phpize-5.4.45
 ./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.4.45
  make
  make install
