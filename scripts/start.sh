#!/bin/bash
#call the first bash script
sh /vagrant/scripts/server/install-system-dependencies.sh
sh /vagrant/scripts/server/install-system-performance.sh
sh /vagrant/scripts/home/setup-home.sh
sh /vagrant/scripts/drush/setup-drush.sh
sh /vagrantscripts/drupal/setup-drupal.sh