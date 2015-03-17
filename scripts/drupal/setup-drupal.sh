#!/usr/bin/sh
if [ -z $1 ]; then
    owner='vagrant'
  else
    owner=$1
fi
cd /var/www/html/
# download drupal
drush dl drupal-7 --drupal-project-rename=nittany
# do the initial drush si so we have minimal in place
drush @nittany si standard --db-url=mysql://root:@localhost/nittany --account-name=admin --account-mail=admin@nittany.psudug.dev install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
# set to admin
drush @nittany upwd admin --password=admin
drush @nittany cleanup

# apache file to match
sudo cp /vagrant/scripts/server/files/domains.conf /etc/httpd/conf.d/domains.conf
sudo chkconfig httpd on
sudo service httpd restart
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
