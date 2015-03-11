#!/usr/bin/sh
# get drush recipes so we can cheat a bit
drush dl drush_recipes
cd /var/www/html/
drush dl drupal
#drush si
#drush cook btopro_dev
