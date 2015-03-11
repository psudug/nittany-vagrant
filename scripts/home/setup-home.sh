#!/usr/bin/sh

cd ~
echo "alias g='git'" >> .bashrc
echo "alias d='drush'" >> .bashrc
echo "alias l='ls -laHF'" >> .bashrc
#source some file that calls a script to ask the bucket questions.