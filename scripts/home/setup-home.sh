#!/usr/bin/sh
cd $HOME
ln -s /var/www/html/nittany nittany
echo "if [ ! -f ./wizard_ran.txt ];" >> .bashrc
echo "  then" >> .bashrc
echo "    source /vagrant/scripts/buckets/wizard.sh" >> .bashrc
echo "fi" >> .bashrc
echo "alias g='git'" >> .bashrc
echo "alias d='drush'" >> .bashrc
echo "alias l='ls -laHF'" >> .bashrc
echo "alias nit='cd /var/www/html/nittany'" >> .bashrc