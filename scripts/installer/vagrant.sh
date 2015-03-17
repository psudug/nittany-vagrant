#!/bin/bash
if [ -z $1 ]; then
    owner='vagrant'
  else
    owner=$1
fi
# establish drush needs to be done first for wizard...
bash /vagrant/scripts/drush/setup-drush.sh
# establish home directory
cd $HOME
bash /vagrant/scripts/home/setup-home.sh
# reload bashrc so drush calls can function
source .bashrc
# establish drupal
bash /vagrant/scripts/drupal/setup-drupal.sh $owner
# establish nittany
bash /vagrant/scripts/nittany/setup-nittany.sh
# establish travis CI
bash /vagrant/scripts/travis/setup-travis.sh
# establish git repo
bash /vagrant/scripts/git/setup-repo.sh
# setup wizard to run on login
cd $HOME
ln -s /var/www/html/nittany nittany
echo "if [ ! -f ./wizard_ran.txt ];" >> .bashrc
echo "  then" >> .bashrc
echo "    source /vagrant/scripts/buckets/wizard.sh" >> .bashrc
echo "fi" >> .bashrc
