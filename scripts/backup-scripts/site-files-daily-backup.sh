#!/bin/bash
# BEGIN CONFIGURATION ==========================================================

BACKUP_DIR="/var/www/backups/site-backups/"  # The directory in which you want backups placed
SITES_DIR="/var/www/html/"
RSYNC_PATH="$(which rsync)"



# END CONFIGURATION ============================================================
# Create the backup
$RSYNC_PATH --delete-after -zavr $SITES_DIR $BACKUP_DIR
