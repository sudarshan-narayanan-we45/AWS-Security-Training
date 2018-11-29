#!/bin/bash
sudo yum -y update
sudo yum-config-manager --enable epel
sudo yum -y install git python-pip supervisor
sudo curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
pip install awscli
echo "Hello World" >> /tmp/hello.txt
aws s3 cp /tmp/hello.txt s3://$1/