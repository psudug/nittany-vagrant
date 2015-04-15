#!/usr/bin/sh
# Install a Standard drupal site
# download drupal
drush dl drupal-7 --drupal-project-rename=nittany
# do the initial drush si so we have minimal in place
drush @nittany si standard  -y --db-url=mysql://root@localhost/nittany --account-name=admin --account-mail=$1 install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
