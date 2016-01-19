    1  aptitude update
    2  history
    3  aptitude -y upgrade
    4  history
    5  aptitude -y install lamp-server^
    6  aptitude -y install apache2
    7  aptitude -y install libapache2-mod-php5
    8  aptitude -y install vim
    9  aptitude -y install build-essential 
   10  aptitude -y install git
   11  aptitude -y install apache2-mpm-worker 
   12  aptitude -y install libapache2-mod-fastcgi 
   13  aptitude -y install php5-fpm 
   14  aptitude -y build-dep php5
   15  aptitude -y php5-imap
   16  aptitude -y install php5-imap
   17  aptitude -y install php5-mcrypt
   18  aptitude -y install libc-client2007e-dev 
   19  aptitude -y install libmcrypt-dev 
   20  git clone --shared https://github.com/cweiske/phpfarm.git /opt/phpfarm
   21  git clone --shared https://github.com/Groundbreakmobile/GB.ubuntu14.04.setup.git
   22  cp GB.ubuntu14.04.setup/resources/phpfarm/* /opt/phpfarm/src/.
   23  cd GB.ubuntu14.04.setup/
   24  ./create.so.linker.files.sh 
   25  cd /opt/phpfarm/src/
   26  ./compile.sh 5.3.29
   27  a2enmod actions fastcgi alias rewrite
   28  service apache2 restart
   29  vim /etc/apache2/conf-available/php-cgisetup.conf
   30  cp /etc/apache2/conf-available/php-cgisetup.conf ~/GB.ubuntu14.04.setup/resources/apache2/.
   31  mkdir ~/GB.ubuntu14.04.setup/resources/apache2/
   32  cp /etc/apache2/conf-available/php-cgisetup.conf ~/GB.ubuntu14.04.setup/resources/apache2/.
   33  ln -s /etc/apache2/conf-available/php-cgisetup.conf /etc/apache2/conf-enabled/php-cgisetup.conf
   34  mkdir /var/www/cgi-bin
   35  vim /var/www/cgi-bin/php-cgi-5.3.29
   36  mkdir -p ~/GB.ubuntu14.04.setup/resources/var/www/cgi-bin/
   37  cp /var/www/cgi-bin/php-cgi-5.3.29 ~/GB.ubuntu14.04.setup/resources/var/www/cgi-bin/.
   38  chown -R www-data:www-data /var/www/cgi-bin
   39  chmod -R 0744 /var/www/cgi-bin
   40  cd ~/GB.ubuntu14.04.setup/resources/
   41  mkdir -p etc/apache2/sites-available
   42  vim etc/apache2/sites-available/5.3.29.vhost.conf
   43  cp etc/apache2/sites-available/5.3.29.vhost.conf /etc/apache2/sites-available/.
   44  a2dismod php5
   45  service apache2 restart
   46  cd /var/www/
   47  ls
   48  a2ensite 5.3.29.vhost.conf
   49  a2dissite 000-default.conf
   50  cat /etc/apache2/sites-enabled/5.3.29.vhost.conf 
   51  mkdir test.groudbreakmobile.com
   52  echo "<?php phpinfo(); ?>" >test.groudbreakmobile.com/test.php
   53  echo "<?php phpinfo(); ?>" >test.groudbreakmobile.com/index.php
   54  service apache2 restart
   55  mv test.groudbreakmobile.com test.groundbreakmobile.com
   56  service apache2 restart
   57  a2dismod php5
   58  service apache2 restart
   59  cat /etc/apache2/sites-enabled/5.3.29.vhost.conf 
   60  cd cgi-bin/
   61  ls
   62  cat php-cgi-5.3.29 
   63  cd
   64  cd GB.ubuntu14.04.setup/
   65  ls
   66  history > standard.server.install.sh
