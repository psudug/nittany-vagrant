#!/bin/sh
cd $HOME
yes | yum install git
git clone https://github.com/psudug/nittany-vagrant /vagrant
bash /vagrant/scripts/installer/root.sh root
bash /vagrant/scripts/installer/vagrant.sh root
source .bashrc
# clean up files directory issues
sudo chown root:apache -R /var/www/html/nittany/sites/default/files/
sudo chmod 2775 -R /var/www/html/nittany/sites/default/files/
d sa
