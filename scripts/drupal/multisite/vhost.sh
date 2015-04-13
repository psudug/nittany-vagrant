#!/usr/bin/sh

if [[ ! -z $1 ]]; then
  drupalpath=$1
else
  echo "This script was not meant to be executed by itself! If you want to set up a site, please execute /vagrant/scripts/drupal/setup-drupal.sh!"
  exit
fi
if [[ ! -z $2 ]]; then
  sitedir=$2
fi
#perform vhost preconfig
read -p "You have chosen to install a new drupal instance at your siteroot of /var/www/html/. Please enter the project name, which will be a subdirectory. You may use underscores, but no spaces. " sitedir
drupalpath="/var/www/html/$sitedir"
vhostconfig="/etc/httpd/conf.d/$sitedir.domains.conf"
mkdir "$drupalpath"
if [ ! -f "$vhostconfig" ]; then
  sudo touch $vhostconfig
fi
sudo cat > "$vhostconfig" <<- EOF
NameVirtualHost *:80
<VirtualHost *:80>
  DocumentRoot $drupalpath
  ServerName $sitedir.psudug.dev
  ServerAlias $sitedir.psudug.dev
  <Directory $drupalpath>
    AllowOverride All
    Order allow,deny
    allow from all
  </Directory>
</VirtualHost>
EOF
