#!/bin/bash

# BEGIN CONFIGURATION ==========================================================

BACKUP_DIR="/var/www/backups/latest-sql/"  # The directory in which you want backups placed

MYSQL_HOST="localhost"
MYSQL_USER="root"

MYSQL_PATH="$(which mysql)"
MYSQLDUMP_PATH="$(which mysqldump)" 
IG_1="cache_advagg_aggregates"
# END CONFIGURATION ============================================================ 
echo "Backup Started: $(date)"

# Create the backup dirs if they don't exist
if [[ ! -d $BACKUP_DIR ]]
  then
  mkdir -p "$BACKUP_DIR"
fi

# Get a list of mysql databases and dump them one by one
echo "------------------------------------"
DBS="$($MYSQL_PATH -h $MYSQL_HOST -u$MYSQL_USER -Bse 'show databases')"
for db in $DBS
do
	#Only loop through databases that you need.
	if [[ $db != "information_schema" && $db != "mysql" && $db != "performance_schema" ]]
		then
		echo "Dumping: $db to $BACKUP_DIR..."
		$MYSQLDUMP_PATH -u $MYSQL_USER $db --ignore-table=$db.$IG_1 > $BACKUP_DIR$db.sql
	fi
done

echo "------------------------------------"
echo "Databases Done Dumping -- $(date)"
