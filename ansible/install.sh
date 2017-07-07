#!/bin/bash

#   Version of Ansible that is used
ANSIBLE_VERSION=${ANSIBLE_VERSION:=2.3.1.0 1}
ANSIBLE_GIT_BRANCH=v2.3.1.0-1

source $PROJECT_FOLDER/$VAGRANT_ANSIBLE_REMOTE/ansible/git-install.sh

#   WinRM support
sudo apt-get install python-pip -y
sudo pip install pywinrm
