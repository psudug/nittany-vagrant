#!/usr/bin/sh

if [[ ! -z $1 ]]; then
  drupalpath=$1
else
  echo "This script was not meant to be executed by itself! If you want to set up a site, please execute /vagrant/scripts/drupal/setup-drupal.sh!"
  exit
fi
if [[ ! -z $2 ]]; then
  sitedir=$2
fi
#perform multisite preconfig
cd /var/www/html/nittany/sites
read -p "You have chosen to set up a multisite configuration in /var/www/html/nittany/sites. Please enter the project name, which will be a subdirectory. You may use underscores, but no spaces." sitedir
drupalpath="$drupalpath/$sitedir"
mkdir "$sitedir"
#Export variables so they can be passed along to the subsequent setup script
( . ./setup-project.sh )
