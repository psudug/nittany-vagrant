#!/usr/bin/sh
cd $HOME
ln -s /var/www/html/nittany nittany
echo "alias g='git'" >> .bashrc
echo "alias d='drush'" >> .bashrc
echo "alias l='ls -laHF'" >> .bashrc
echo "alias nit='cd /var/www/html/nittany'" >> .bashrc
