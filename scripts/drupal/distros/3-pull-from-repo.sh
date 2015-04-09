#!/usr/bin/sh
# (Advanced) Build a distro from a repo

prompt='What git repo would you like to pull from?'
read -rp "$prompt" repo
prompt='What branch to use?'
read -rp "$prompt" branch
git clone --branch $branch $repo nittany
cd nittany
# prompt distro to build
prompt='What distribution should we run?'
read -rp "$prompt" distro
drush @nittany si $distro -y --db-url=mysql://root@localhost/nittany --account-name=admin --account-mail=admin@nittany.psudug.dev install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
