#!/bin/bash

# BEGIN CONFIGURATION ==========================================================

BACKUP_DIR="/var/www/backups/mysql-backups/"  # The directory in which you want backups placed
DUMP_MYSQL=true
KEEP_MYSQL="720" #Keep 24 hours of backups

MYSQL_HOST="localhost"
MYSQL_USER="root"

TIME_INC="/hourly/"

# Construct Date
MONTH="month-$(date '+%m')_"
DAY="day-$(date '+%d')_"
HOUR="hour-$(date '+%H')_"
MIN="min-$(date '+%M')_"
SEC="sec-$(date '+%S')"

#Use the date construct
THE_DATE="$MONTH$DAY$HOUR$MIN$SEC"

MYSQL_PATH="$(which mysql)" 
MYSQLDUMP_PATH="$(which mysqldump)" 
FIND_PATH="$(which find)"

# END CONFIGURATION ============================================================ 

#Lets Get This Party Started
echo "Backup Started: $(date)"

# Create the backup dirs if they don't exist
if [[ ! -d $BACKUP_DIR ]]
  then
  mkdir -p "$BACKUP_DIR"
fi

if [ "$DUMP_MYSQL" = "true" ]
  then
  # Get a list of mysql databases and dump them one by one
  echo "------------------------------------"
  
  # for this to work without a password you will need to add the .my.cnf file in repo to your home directory.
  #if running cron as root then you need to add it to the root's home directory.
  
  DBS="$($MYSQL_PATH -h $MYSQL_HOST -u$MYSQL_USER -Bse 'show databases')"
  for db in $DBS
  do
    #Only loop through databases that you need.
    if [[ $db != "information_schema" && $db != "mysql" && $db != "performance_schema" ]]
      then
      echo "Dumping: $db to hourly location..."
      if [[ ! -d $BACKUP_DIR$db$TIME_INC ]]
        then
        mkdir -p "$BACKUP_DIR$db$TIME_INC"
      fi
      $MYSQLDUMP_PATH -u $MYSQL_USER $db > $BACKUP_DIR$db$TIME_INC$db\_$THE_DATE.sql
			
			# Delete old dumps
      echo "------------------------------------"
      echo "Deleting backups older than 24 hours..."
      # List dumps to be deleted to stdout (for report)
      $FIND_PATH $BACKUP_DIR$db$TIME_INC*.sql -mmin +$KEEP_MYSQL
      # Delete dumps older than specified number of days
      $FIND_PATH $BACKUP_DIR$db$TIME_INC*.sql -mmin +$KEEP_MYSQL -exec rm {} +
    fi
  done

  

fi

# Every good party has to come to an end.
echo "------------------------------------"
echo "We finished yo!: $(date)"
