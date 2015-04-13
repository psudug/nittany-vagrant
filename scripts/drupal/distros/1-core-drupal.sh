#!/usr/bin/sh
# Standard install
# download drupal
if [ !-z $3 ]; then
  drupalpath=$3
else
  drupalpath="nittany"
fi
cd "$drupalpath"
drush dl drupal-7 --drupal-project-rename=nittany
# do the initial drush si so we have minimal in place
drush @nittany si standard --db-url=mysql://root:@localhost/$drupalpath --account-name=admin --account-mail=$email install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
