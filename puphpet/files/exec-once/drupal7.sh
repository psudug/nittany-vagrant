#!/bin/bash

# Directories
##########################################################
httpDir="/var/www/html/"
rootDir="drupal7/" #leave blank to set http directory as root directory.
libraries="sites/all/libraries/"
modules="sites/all/modules/"
##########################################################

# Site
##########################################################
siteName="Drupal 7"
siteSlogan="DUG Vagrant Instance with some modules downloaded and enabled"
##########################################################

# Database
##########################################################
dbHost="localhost"
dbName="drupal7"
dbUser="drupal7"
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

drush dl drupal-7 -y --destination=$httpDir --drupal-project-rename=$rootDir

cd $httpDir$rootDir
rm CHANGELOG.txt COPYRIGHT.txt INSTALL.txt INSTALL.mysql.txt INSTALL.pgsql.txt INSTALL.sqlite.txt LICENSE.txt MAINTAINERS.txt README.txt UPGRADE.txt -rf

# Install core
##########################################################
drush site-install -y standard --account-mail=$adminEmail --account-name=$AdminUsername --db-su=$dbsu --db-su-pw=$dbsupw --account-pass=$AdminPassword --site-name=$siteName --site-mail=$adminEmail --db-url=mysql://$dbUser:$dbPassword@$dbHost/$dbName

mkdir $httpDir$rootDir$modules\contrib
mkdir $httpDir$rootDir$modules\custom
mkdir $httpDir$rootDir$modules\features

# Libraries
###########################################################################
echo "creating libraries directories"
mkdir $httpDir$rootDir$libraries
#########################################################################





# Download modules and themes
##########################################################
drush -y dl admin_menu backup_migrate ckeditor_link context ctools date devel entity entitycache entityreference features field_group globalredirect httprl imce imce_wysiwyg jquery_update libraries link menu_block metatag module_filter pathauto redirect rules search404 strongarm token transliteration views webform wysiwyg xmlsitemap

cd $httpDir$rootDir

# Features
###########################################################################
cp /var/www/shared/modules/text_formatting/ $modules\features/ -rf 
###########################################################################

# Libraries
###########################################################################
cp /var/www/shared/libraries/* $libraries -rf
###########################################################################

# Enable modules
###########################################################################
drush -y en admin_menu admin_menu_toolbar ckeditor_link contact context_ui date devel entitycache entityreference features field_group globalredirect httprl imce_wysiwyg jquery_update libraries link menu_block metatag module_filter pathauto redirect search404 strongarm text_formatting token transliteration views_ui webform xmlsitemap

# Pre configure settings
###########################################################################
# Set Site Slogan
drush vset -y site_slogan "$siteSlogan"

# Disable user pictures
drush vset -y user_pictures 0

# Allow only admins to register users
drush vset -y user_register 0

# Remove require user email verification
drush vset -y user_email_verification 0

# Set the site name using the variable in top of script
drush vset -y site_name "$siteName"

# Configure JQuery update 
drush vset -y jquery_update_compression_type "min"
drush vset -y jquery_update_jquery_cdn "google"
drush -y eval "variable_set('jquery_update_jquery_version', strval(1.8));"
drush -y eval "variable_set('jquery_update_jquery_admin_version', strval(1.5));"
###########################################################################

cd $httpDir$rootDir
drush dis -y dashboard
drush dis -y overlay
drush dis -y shortcut
drush dis -y toolbar
drush dis -y update



echo -e "////////////////////////////////////////////////////"
echo -e "Drupal 7 Installed"
echo -e "////////////////////////////////////////////////////"

