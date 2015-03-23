#!/bin/bash

#   Version of Ansible that is used
ANSIBLE_GIT_REPO=git://github.com/dresden-weekly/ansible.git
ANSIBLE_VERSION=${ANSIBLE_VERSION:=1.8.4-clean}
if [ $ANSIBLE_VERSION == '1.9' ] ; then
  ANSIBLE_GIT_BRANCH=devel
fi

source $PROJECT_FOLDER/$VAGRANT_ANSIBLE_REMOTE/ansible/git-install.sh
