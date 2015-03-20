#!/bin/bash
# establish drush needs to be done first for wizard...
bash /vagrant/scripts/drush/setup-drush.sh
# establish home directory
cd $HOME
bash /vagrant/scripts/home/setup-home.sh
# reload bashrc so drush calls can function
source .bashrc
# establish travis CI
#bash /vagrant/scripts/travis/setup-travis.sh
# setup wizard to run on login
cd $HOME
echo "if [ ! -f ./wizard_ran.txt ];" >> .bashrc
echo "  then" >> .bashrc
echo "    source /vagrant/scripts/buckets/wizard.sh" >> .bashrc
echo "fi" >> .bashrc
echo "We're finished! Now you can login to the new VM with the command:"
echo "vagrant ssh"
