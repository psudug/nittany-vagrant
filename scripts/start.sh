#!/bin/bash
#call the first bash script
sh /vagrant/scripts/server/install-system-dependencies.sh
# apply performance
sh /vagrant/scripts/server/install-system-performance.sh
# establish home directory
sh /vagrant/scripts/home/setup-home.sh
# establish drush
sh /vagrant/scripts/drush/setup-drush.sh
# establish drupal
sh /vagrantscripts/drupal/setup-drupal.sh
