#!/bin/sh

# Backup database/files, using Drush
# Script will need to be added to crontab to execute at a given time.

#Place drush and vagrant paths into cron if they aren't there.
grep -q -e "/usr/local/rvm/bin:/usr/bin/drush:/home/vagrant/bin" /etc/crontab
if [ $? = 1 ]; then
  #Remove old PATH and insert modified PATH
  sudo sh -c "sed -i '/^PATH/d' /etc/crontab"
  sudo sh -c "sed -i '1i PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/rvm/bin:/usr/bin/drush:/home/vagrant/bin' /etc/crontab"
fi

# Default backup directory. Optional argument can be passed on call from crontab with alternate backup directory.
DIR_BACKUP=/vagrant/backups

#Override backup directory if argument passed
if [ -z $1 ]; then
  DIR_BACKUP=$1
fi

#Make sure backup directory exists
cd /vagrant
if [[ ! -e "backups" ]];
then sudo mkdir "backups"
sudo chmod 700 "backups"
fi

log_msg() {
  # Log to syslog
  logger -t `basename $0` "$*"

  # Echo to stdout
  LOG_TS=`date +'%H:%M:%S'`
  echo "$LOG_TS - $*"
}

BACKUP_FILE=$DIR_BACKUP/$site_archive_`date +%Y%m%d`.tar

log_msg "Backing up files and database to $BACKUP_FILE ..."

#List drush aliases to backup here in the following format:
  #site="sitename"
  #drush @aliasname archive-dump \
    #--destination=$BACKUP_FILE \
    #--preserve-symlinks \
    #--overwrite

#Default backup for nittany drupal site
site="nittany"
drush @nittany archive-dump \
  --destination=$BACKUP_FILE \
  --preserve-symlinks \
  --overwrite

RC=$?

if [ "$RC" = 0 ]; then
  log_msg "Backup for $site completed successfully ..."
else
  log_msg "Backup for $site exited with return code: $RC"
fi
