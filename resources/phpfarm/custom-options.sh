#!/bin/bash
#gcov='--enable-gcov'
configoptions="\
--enable-bcmath \
--enable-calendar \
--with-curl \
--enable-exif \
--enable-ftp \
--with-gd \
--with-imap \
--with-imap-ssl \
--with-kerberos \
--enable-mbstring \
--with-mcrypt \
--with-mhash \
--with-mysql \
--with-mysqli \
--with-openssl \
--with-pear \
--enable-pcntl \
--with-pdo-mysql \
--enable-soap \
--enable-sockets \
--enable-sqlite-utf8 \
--enable-wddx \
--enable-zip \
--with-zlib \
--with-ldap=/usr \
--with-jpeg-dir \
--enable-gd-native-ttf \
--enable-fpm \
--with-freetype-dir \
--with-freetype-dir=/usr/local/include/freetype2 \
--with-unixODBC=/usr \
--with-gettext \
$gcov"
