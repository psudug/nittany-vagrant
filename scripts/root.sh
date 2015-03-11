#!/bin/bash
#call the first bash script
bash /vagrant/scripts/server/install-system-dependencies.sh
# apply performance
bash /vagrant/scripts/server/install-system-performance.sh
chown vagrant:root /var/www/html
chmod 775 /var/www/html
