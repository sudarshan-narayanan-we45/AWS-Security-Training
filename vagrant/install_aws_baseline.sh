#!/usr/bin/env bash

# Install python and setup
sudo apt install python-minimal
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common unzip
sudo apt-get install -y python-pip
sudo pip install virtualenv
echo "Installing Nmap"
add-apt-repository ppa:pi-rho/security -y
sudo apt-get update
sudo apt-get install -y nmap
#install required packages
sudo apt-get install -y git-core
sudo apt-get install -y awscli
sudo apt-get install httpie
#install terraform
wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
unzip terraform_0.11.10_linux_amd64.zip
sudo mv terraform /usr/local/bin/
#installing node and NPM
echo "Installing NodeJS and NPM"
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
#installing serverless
npm install -g serverless
# install vulnerability scanning tools for aws
mkdir /home/vagrant/Desktop/Labs
cd /home/vagrant/Desktop/Labs
mkdir -p Vulnerability_Assessment
cd /home/vagrant/Desktop/Labs/Vulnerability_Assessment
mkdir -p /home/vagrant/Desktop/Labs/Vulnerability_Assessment/scout2
cd /home/vagrant/Desktop/Labs/Vulnerability_Assessment/scout2
virtualenv venv
source venv/bin/activate
pip install awsscout2
exit
mkdir -p /home/vagrant/Desktop/Labs/Vulnerability_Assessment/prowler
cd /home/vagrant/Desktop/Labs/Vulnerability_Assessment/prowler
git clone https://github.com/toniblyx/prowler.git
cd /home/vagrant/Desktop/Labs/
mkdir -p /home/vagrant/Desktop/Labs/Automation
cd /home/vagrant/Desktop/Labs/Automation
mkdir -p /home/vagrant/Desktop/Labs/Automation/base