#!/usr/bin/sh

if [[ ! -z $1 ]]; then
  sitedir=$1
else
  echo "This script was not meant to be executed by itself! If you want to set up a site, please execute /vagrant/scripts/drupal/setup-drupal.sh!"
  exit
fi
# Scripts to edit the hosts files go here
sudo sh -c "echo '127.0.0.1\t$sitedir.psudug.dev' >> /etc/hosts"
