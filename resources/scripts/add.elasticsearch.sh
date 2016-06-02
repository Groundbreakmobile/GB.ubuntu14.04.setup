#!/bin/bash

######
# set up elasticsearch
######

echo 'Downloading elasticsearch...'
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.4.1.deb

echo 'installing elasticsearch...'
sudo dpkg -i elasticsearch-1.4.1.deb

echo 'setting up autostart...'
sudo update-rc.d elasticsearch defaults

echo 'securing elasticsearch...'
echo 'network.bind_host: localhost' >> /etc/elasticsearch/elasticsearch.yml

echo 'starting elasticsearch...'
service elasticsearch start

sleep 3

echo 'testing elasticsearch...'
curl -X GET 'http://localhost:9200'

echo 'Done.'
