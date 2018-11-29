#!/usr/bin/env bash
sudo apt update --fix-missing
add-apt-repository ppa:pi-rho/security -y
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates vim curl software-properties-common unzip 
sudo apt-get install -y nmap git-core awscli httpie python-minimal python-pip build-essential
sudo curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs
sudo pip install virtualenv
#install terraform
wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
unzip terraform_0.11.10_linux_amd64.zip
sudo mv terraform /usr/local/bin/
echo "Installing NodeJS and NPM"
sudo npm install -g serverless
# install vulnerability scanning tools for aws
mkdir -p /home/vagrant/Desktop/Labs
mkdir -p /home/vagrant/Desktop/Labs/providers
cd /home/vagrant/Desktop/Labs/providers
#install terraform providers
wget https://releases.hashicorp.com/terraform-provider-aws/0.1.2/terraform-provider-aws_0.1.2_linux_amd64.zip
unzip terraform-provider-aws_0.1.2_linux_amd64.zip
wget https://releases.hashicorp.com/terraform-provider-random/2.0.0/terraform-provider-random_2.0.0_linux_amd64.zip
unzip terraform-provider-random_2.0.0_linux_amd64.zip
cd /home/vagrant/Desktop/Labs
git clone https://github.com/we45/AWS-Security-Training.git
mkdir -p /home/vagrant/Desktop/Labs/Vulnerability_Assessment
mkdir -p /home/vagrant/Desktop/Labs/Vulnerability_Assessment/scout2
mkdir -p /home/vagrant/Desktop/Labs/Vulnerability_Assessment/prowler
cd /home/vagrant/Desktop/Labs/Vulnerability_Assessment/scout2
pip install awsscout2
cd /home/vagrant/Desktop/Labs/Vulnerability_Assessment
git clone https://github.com/toniblyx/prowler.git
#install root shell stuff
sudo apt-get install -y gksu
