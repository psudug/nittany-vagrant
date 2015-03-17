#!/usr/bin/sh

# get nittany recipes and what not
cd $HOME/.drush
git clone https://github.com/psudug/nittany.git drecipes/nittany
drush cc drush
# install the baseline of nittany above minimal
drush @nittany cook nittany_baseline --y
# clean up blocks on admin page
drush @nittany sql-query "UPDATE block SET status=0,region=-1 WHERE theme='rubik' AND region='content' AND delta<>'main'"
drush @nittany cc all
