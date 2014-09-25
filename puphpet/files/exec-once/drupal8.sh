#!/bin/bash

# Directories
##########################################################
httpDir="/var/www/html/"
rootDir="drupal8/" #leave blank to set http directory as root directory.

##########################################################

# Site
##########################################################
siteName="Drupal 8"
siteSlogan="DUG Vagrant Instance with just core downloaded"
##########################################################

# Database
##########################################################
dbHost="localhost"
dbName="drupal8"
dbUser="drupal8"
dbPassword="123"
dbsu="root" # root user
dbsupw="123" # using yes
##########################################################

# Admin
##########################################################
AdminUsername="admin"
AdminPassword="pass"
adminEmail="email@email.com"
##########################################################

# Paths
##########################################################
WGET_PATH="$(which wget)"
UNZIP="$(which unzip)"
TAR="$(which tar)"
##########################################################

# Download Core
##########################################################
cd $httpDir

drush dl drupal-8.0.x-dev -y --destination=$httpDir --drupal-project-rename=$rootDir

echo -e "////////////////////////////////////////////////////"
echo -e "Drupal 8 Downloaded... you will need to install with the UI for now."
echo -e "////////////////////////////////////////////////////"

echo -e "Add this to your hosts file..."
echo -e "=================================OSX HOSTS============================================="
echo -e "If you are on OSX add this to your /etc/hosts file"
echo -e "192.168.56.101 drupal7.dev"
echo -e "192.168.56.101 www.drupal7.dev"
echo -e "192.168.56.101 drupal8.dev"
echo -e "192.168.56.101 www.drupal8.dev"
echo -e "=================================WINDOWS HOSTS============================================="
echo -e "If you are on Windows add this to your C:\Windows\System32\drivers\etc\hosts file"
echo -e "192.168.56.101 drupal7.dev"
echo -e "192.168.56.101 www.drupal7.dev"
echo -e "192.168.56.101 drupal8.dev"
echo -e "192.168.56.101 www.drupal8.dev"

