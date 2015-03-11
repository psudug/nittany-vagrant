#!/usr/bin/sh
cd $HOME
ln -s /var/www/html/nittany nittany
echo "alias g='git'" >> .bashrc
echo "alias d='drush'" >> .bashrc
echo "alias l='ls -laHF'" >> .bashrc
# @todo source some file that calls a script to ask the bucket questions.
