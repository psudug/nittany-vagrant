#!/usr/bin/sh
# This script creates a repo of all the work it just did and puts it in version control
# then it's up to you to hook it up to a git server.
# setup repo
cd /var/www/html/nittany
# initalize the repo
git init
# copy our git ignore and attributes goodness
cp /vagrant/scripts/git/files/gitignore .gitignore
cp /vagrant/scripts/git/files/gitattributes .gitattributes
# this adds everything to git
git add -A
# commit it all
git commit -m "initial commit"
# add in pre-commit hook for quality control
cp /vagrant/scripts/git/files/pre-commit.sh .git/hooks/pre-commit
