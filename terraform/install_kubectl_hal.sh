#!/bin/bash

sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

curl -L https://get.armory.io/halyard/install/latest/macos/InstallArmoryHalyard.sh > InstallArmoryHalyard.sh 
sudo bash InstallArmoryHalyard.sh --version latest


