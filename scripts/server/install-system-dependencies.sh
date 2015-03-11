#!/usr/bin/sh

# a script to install server dependencies

# using yum to install main packages
yum -y install git nano make mysql mysql-server httpd php php-gd php-xml php-pdo php-mbstring php-mysql php-pear php-devel php-pecl-ssh2 php-pecl-apc

#using pecl to install uploadprogress, this is optional.
pecl install uploadprogress

# adding uploadprogresss to php conf files
touch /etc/php.d/uploadprogress.ini
echo extension=uploadprogress.so > /etc/php.d/uploadprogress.ini

# starting apache, mysql on boot
chkconfig httpd on
chkconfig mysqld on
service httpd restart
service mysqld restart

# set httpd_can_sendmail so drupal mails go out
setsebool -P httpd_can_sendmail on
