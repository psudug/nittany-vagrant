#!/bin/bash
# establish drush needs to be done first for wizard...
bash /vagrant/scripts/drush/setup-drush.sh
# establish home directory
cd $HOME
bash /vagrant/scripts/home/setup-home.sh
# reload bashrc so drush calls can function
source .bashrc
# establish drupal
bash /vagrant/scripts/drupal/setup-drupal.sh
# establish nittany
bash /vagrant/scripts/nittany/setup-nittany.sh
# establish travis CI
bash /vagrant/scripts/travis/setup-travis.sh
# establish git repo
bash /vagrant/scripts/git/setup-repo.sh
