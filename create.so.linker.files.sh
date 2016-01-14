#!/bin/bash

sudo updatedb --prunepaths=/mnt
cd /usr/lib

if [ ! -L liblber-2.4.so.2 ];
then
    sudo ln -s "$(locate liblber-2.4.so.2)"
fi

if [ ! -L liblber-2.4.so.2.8.3 ];
then
    sudo ln -s "$(locate liblber-2.4.so.2.8.3)"
fi

if [ ! -L liblber.so ];
then
    sudo ln -s "$(locate liblber.so)"
fi

if [ ! -L libldap.so ];
then
    sudo ln -s "$(locate libldap.so)"
fi

if [ ! -L libldap_r.so ];
then
    sudo ln -s "$(locate libldap_r.so)"
fi
