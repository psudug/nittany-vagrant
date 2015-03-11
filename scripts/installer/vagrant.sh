#!/bin/bash
# establish home directory
bash /vagrant/scripts/home/setup-home.sh
# establish drush
bash /vagrant/scripts/drush/setup-drush.sh
# establish drupal
bash /vagrant/scripts/drupal/setup-drupal.sh
