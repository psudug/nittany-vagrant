#!/bin/sh
cd $HOME
# install git so we can get everything we need
yes | yum install git
git clone https://github.com/psudug/nittany-vagrant /vagrant
# run the root install routine
bash /vagrant/scripts/installer/root.sh root
# install the few non-root options
bash /vagrant/scripts/installer/vagrant.sh
# ask the user what they want to do
bash /vagrant/scripts/buckets/wizard.sh
source .bashrc
# clean up files directory issues
sudo chown root:apache -R /var/www/html/nittany/sites/default/files/
sudo chmod 2775 -R /var/www/html/nittany/sites/default/files/
d sa
