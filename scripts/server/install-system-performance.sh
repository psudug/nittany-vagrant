#!/usr/bin/sh
# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
sudo mkdir -p /etc/httpd/conf.d/web_performance

# defaults
wwwuser='apache'
apcini="/etc/php.d/apc.ini"
phpini="/etc/php.ini"
mycnf="/etc/my.cnf"
web_performance="/etc/httpd/conf.d/web_performance/"

# performance / recommended settings
rm $apcini
cp files/apc.txt $apcini
cat files/php.txt >> $phpini
cat files/my.txt >> $mycnf
cp files/web_performance/* -rf $web_performance

chkconfig httpd on
chkconfig mysqld on
service httpd restart
service mysqld restart
