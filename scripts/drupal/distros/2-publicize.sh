#!/usr/bin/sh
# Publicize distribution
# @todo test for existing directory
git clone --branch 7.x-1.x https://github.com/drupalprojects/publicize.git nittany

cd nittany
# remove everything except the make files from the repo
# we then clone it back into itself basically
rm -rf modules
rm -rf themes
rm -rf .git
find . -type f -not -name '*.make*' | xargs rm
# build off the make files
drush make local.make.example --y
# clean up make file now that we built
rm *.make*
drush @nittany si publicize -y --db-url=mysql://root@localhost/nittany --account-name=admin --account-mail=$1 install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
# account for STUPID caching issue of menu name
drush @nittany sqlq "UPDATE block SET title='<none>' WHERE module='menu_block'"
