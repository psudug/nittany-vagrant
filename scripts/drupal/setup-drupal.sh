#!/usr/bin/sh
cd /var/www/html/
# download drupal
drush dl drupal-7 --drupal-project-rename=nittany
# do the initial drush si so we have minimal in place
drush @nittany si minimal --db-url=mysql://root:@localhost/nittany --account-name=admin --account-mail=admin@nittany.psudug.dev install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
# set to admin
drush @nittany upwd admin --password=admin
