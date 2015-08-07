#!/bin/bash

# Overwrites the domains.conf file in vagrant with the virtual hosts defined in
# domains.conf of this folder.
sudo cp /vagrant/scripts/server/files/domains.conf /etc/httpd/conf.d/domains.conf
sudo chkconfig httpd on
sudo service httpd restart
echo 'Synced domains.conf'
