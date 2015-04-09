#!/usr/bin/sh
#This script will be called from the wizard to automatically back up

#Temporarily turn off file expansion so that *'s wont output directory listings
set -f;

cronguide="Example of job definition:
      # .---------------- minute (0 - 59)
      # |  .------------- hour (0 - 23)
      # |  |  .---------- day of month (1 - 31)
      # |  |  |  .------- month (1 - 12)
      # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7)
      # |  |  |  |  |
      # "
validcron="^([0-9]|[1-5][0-9]|\*) ([0-9]|[1-2][0-3]|\*) ([1-9]|[1-3][0-1]|\*) ([1-9]|[1][0-2]|\*) ([0-7]|\*)$"
backup='/vagrant/scripts/backup/drush-backup.sh'

# Get crontab config, validate and put in task
entercron(){
  read -p "What directory would you like to have your backups placed in? [/vagrant/scripts/backup/] " backupdir
  while [ ! -d "$backupdir" ]; do
    read -p "This is not a valid directory! What directory would you like to have your backups placed in? [/vagrant/scripts/backup/] " backupdir
  done
  #Enter cron line
  read -p "Please enter how often you would like backups to run in numeric crontab format with single space delimited values. $cronguide " cronfreq

  #If cron is valid, enter it into crontab
  if [[ $cronfreq =~ $validcron ]]; then
    if [ ! -z backupdir ]; then
       job="$cronfreq $backup $backupdir"
    else
      job="$cronfreq $backup"
    fi
    echo "$job" | sudo tee --append /etc/crontab > /dev/null
    return 0
  else
    printf "This is not valid syntax!\n"
    entercron
  fi
}
set +f;

echo "\e[0;32mBackup task creation successful!\e[0m If you would like to backup multiple sites, please edit the backup script accordingly!"
