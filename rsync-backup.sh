#!/bin/bash

echo rsync_backup_time $(date +%s) > ~/rsync-backup-time.prom
rsync -rltEv --delete -e "ssh -p 2222" ~/rsync-backup-time.prom ~/STUFF-A ~/STUFF-B USER@SERVER:/backups/PLACE/
rm ~/rsync-backup-time.prom
