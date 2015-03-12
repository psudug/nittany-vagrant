#!/usr/bin/sh

# setup repo
cd /var/www/html/nittany
git init
cp /vagrant/scripts/git/files/gitignore .gitignore
cp /vagrant/scripts/git/files/gitattributes .gitattributes
git add -A
git commit -m "initial commit"
# add in pre-commit hook for quality control
cp /vagrant/scripts/git/files/pre-commit.sh .git/hooks/pre-commit
