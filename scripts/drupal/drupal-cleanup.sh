#!/usr/bin/sh
if [ -z $1 ]; then
    owner='vagrant'
  else
    owner=$1
fi
# set to admin
drush @nittany upwd admin --password=admin
drush @nittany cleanup

# apache file to match
bash /vagrant/scripts/server/sync-domains.sh
# make sure files is owned correctly
sudo chown -R $owner:apache /var/www/html/nittany/sites/default/files
sudo chmod 2775 /var/www/html/nittany/sites/default/files
# make a private files directory
sudo mkdir -p /var/www/drupal_priv/nittany
sudo chown -R $owner:apache /var/www/drupal_priv/nittany
sudo chmod 2775 /var/www/drupal_priv/nittany
drush @nittany vset file_private_path /var/www/drupal_priv/nittany
# create libraries directory
mkdir -p /var/www/html/nittany/sites/all/libraries
