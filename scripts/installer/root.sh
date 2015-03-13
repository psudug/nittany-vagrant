#!/bin/bash
#call the first bash script
bash /vagrant/scripts/server/install-system-dependencies.sh
# apply performance
bash /vagrant/scripts/server/install-system-performance.sh
# test for an argument as to what user to write as
if [ -z $1 ]; then
    owner='vagrant'
  else
    owner=$1
fi
chown $owner:root /var/www/html
chmod 775 /var/www/html
