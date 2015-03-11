#!/usr/bin/sh

# get nittany recipes and what not
cd $HOME/.drush
git clone https://github.com/psudug/nittany.git drecipes/nittany
drush cc drush
# install the baseline of nittany above minimal
drush @nittany cook nittany_baseline --y
