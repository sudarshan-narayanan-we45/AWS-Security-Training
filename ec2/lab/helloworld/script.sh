#!/bin/bash
apt-get update
apt-get -y install python-pip python-dev build-essential supervisor python-tornado
cd /home/ubuntu/helloworld
sudo cp -r helloworld.conf /etc/supervisor/conf.d/
sudo pip install -r requirements.txt
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart all
sudo supervisorctl status
