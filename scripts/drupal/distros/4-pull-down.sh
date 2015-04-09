#!/usr/bin/sh
# (Expert) Pull down from server
echo 'This is going to establish a connection to a real server you have, then pull down the code and database in question and mirror it locally so you can work off-line.'
echo "If these things sound scary then you probably shouldn't use this mode as its fairly advanced!"
prompt="What server do you want to connect to?"
read -rp "$prompt" address
prompt="What user name?"
read -rp "$prompt" name
prompt="What port (usually 22 / 2222 are common)?"
read -rp "$prompt" port
# copy id to the server
ssh-copy-id -i ~/.ssh/id_rsa.pub "-p $port $name@$address"
# what path to pull
prompt="Where is this site?"
read -rp "$prompt" dir
# ALL REMOTE STUFF
# dump to db export via remote execution
ssh -p $port $name@$address "cd $dir && drush sql-dump --result-file=~/nittany.sql --y"
# rsync full directory from that server
rsync -az -e "ssh -p $port" $name@$address:$dir /var/www/html/nittany
# pull in nittany sql file
rsync -az -e "ssh -p $port" "$name@$address:~/nittany.sql" /var/www/html/nittany.sql

# ALL LOCAL STUFF
# rewrite settings for the local version
rm nittany/sites/default/settings.php
# install drupal just to get db creds in place
drush @nittany si minimal -y --db-url=mysql://root@localhost/nittany --account-name=admin --account-mail=admin@nittany.psudug.dev install_configure_form.update_status_module='array(FALSE,FALSE)' install_configure_form.site_default_country=US --y
# drop local database so we can repopulate it
drush @nittany sql-drop --y
# todo: now do the sql-sync stuff from that system down to this one
drush @nittany sql-query --file=/var/www/html/nittany.sql --y
drush @nittany sqlsan --y
drush @nittany rr
drush @nittany cc all
