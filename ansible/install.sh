#!/bin/bash

#   Version of Ansible that is used
ANSIBLE_GIT_REPO=git://github.com/dresden-weekly/ansible.git
ANSIBLE_VERSION=${ANSIBLE_VERSION:=1.9.0.1-clean}

source $PROJECT_FOLDER/$VAGRANT_ANSIBLE_REMOTE/ansible/git-install.sh

sudo apt-get install python-pip -y
sudo pip install pywinrm
