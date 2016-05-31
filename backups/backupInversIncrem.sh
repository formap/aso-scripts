#!/bin/bash

SOURCE_DIR=/root

DEST_DIR=/backup/backup-rsync

EXCLUDES=/backup/backup-rsync/excludes.txt

BSERVER=localhost

BACKUP_DATE=$(date +"%Y%m%d%H%M%S")

OPTS="--ignore-errors --delete-excluded --exclude-from=$EXCLUDES --delete --backup --backup-dir=$DEST_DIR/$BACKUP_DATE -av"

rsync $OPTS $SOURCE_DIR root@$BSERVER:$DEST_DIR/complet
