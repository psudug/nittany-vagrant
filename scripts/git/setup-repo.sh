#!/usr/bin/sh

# setup repo
cd /var/www/html/nittany
git init
cp /vagrant/scripts/git/files/gitignore .gitignore
git add -A
git commit -m "initial commit"
