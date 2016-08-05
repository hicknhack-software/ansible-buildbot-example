#!/bin/bash

#ANSIBLE_OPTIONS=-vvvv
export ANSIBLE_HOST_KEY_CHECKING=false

source "$PROJECT_FOLDER/$VAGRANT_ANSIBLE_REMOTE/ansible/run.sh"
