#!/usr/bin/sh
# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
# defaults
wwwuser='apache'
apcini="/etc/php.d/apc.ini"
phpini="/etc/php.ini"
mycnf="/etc/my.cnf"
zzz_performance="/etc/httpd/conf.d/zzz_performance.conf"

# performance / recommended settings
rm $apcini
cp files/apc.txt $apcini
cat files/php.txt >> $phpini
cat files/my.txt >> $mycnf
cp files/zzz_performance.conf $zzz_performance

chkconfig httpd on
chkconfig mysqld on
service httpd restart
service mysqld restart
