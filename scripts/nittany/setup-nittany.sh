#!/usr/bin/sh

# get nittany recipes and what not
cd ~/.drush
git clone https://github.com/psudug/nittany.git drecipes/nittany
drush cc drush
cd /var/www/html/nittany
# install the baseline of nittany above minimal
drush cook nittany-baseline --y
