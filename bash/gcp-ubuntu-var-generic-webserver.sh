#!/bin/bash

#
# refresh apt cache
#
sudo apt update
if [ $? != 0 ]; then
    echo "Error: Unable to update!"
    echo "Terminating program..."
    exit 1
fi

#
# keep the packages up-to-date
#
sudo apt -y upgrade
if [ $? != 0 ]; then
    echo "Error: Unable to upgrade!"
    echo "Terminating program..."
    exit 1
fi

#
# install some useful packages
#
sudo apt -y install locales build-essential sudo cmake gcc gfortran curl wget unzip vim emacs rsyslog \
    nano ca-certificates software-properties-common nginx

#
# download the latest docker-CE
#
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
if [ $? != 0 ]; then
    echo "Error: Unable to obtain docker-CE key signature!"
    echo "Terminating program..."
    exit 1
fi

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install docker-ce
if [ $? != 0 ]; then
    echo "Error: Unable to install docker-CE!"
    echo "Terminating program..."
    exit 1
fi
echo "docker-CE was installed successfully."

#
# obtain the latest docker-compose
#
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0-rc2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version
if [ $? != 0 ]; then
    echo "Error: Unable to install docker-compose!"
    echo "Terminating program..."
    exit 1
fi
echo "docker-compose was installed successfully."

#
# setup kubectl
#
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
if [ $? != 0 ]; then
    echo "Error: Unable to install kubernetes!"
    echo "Terminating program..."
    exit 1
fi
echo "Kubernetes was installed successfully."

#
# get the latest helm 3 binary
#
curl -L "https://get.helm.sh/helm-v3.0.0-beta.3-linux-amd64.tar.gz" -o /tmp/helm-linux-amd64.tar.gz
tar -zxvf /tmp/helm-linux-amd64.tar.gz
mv linux-amd64 /tmp/linux-amd64
sudo mv /tmp/linux-amd64/helm /usr/local/bin/
if [ $? != 0 ]; then
    echo "Error: Unable to install helm!"
    echo "Terminating program..."
    exit 1
fi
echo "Helm was installed successfully."
