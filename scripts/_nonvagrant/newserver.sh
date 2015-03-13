#!/bin/sh
cd $HOME
yes | yum install git
git clone https://github.com/psudug/nittany-vagrant /vagrant
bash /vagrant/scripts/installer/root.sh root
bash /vagrant/scripts/installer/vagrant.sh
source .bashrc
sudo chown apache:apache -R /var/www/html/nittany/sites/default/files/
d sa
