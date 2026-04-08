#!/bin/bash

# ==================================================================

# BACKUP GLOBAL - APPSERVER + FILESERVER

# ==================================================================

DATE=$(date +"%Y-%m-%d_%H-%M")
RETENTION_DAYS=7
LOGFILE="/home/userbackup/backup_logs/bitacora_respaldo.log"

# ==============================

# FUNCION LOG
# ==============================

log() {
     local SERVER="$1"
     local STATUS="$2"
     local SIZE="$3"
     echo "[$(date '+%Y-%m-%d %H:%M:%S')] | $SERVER | $STATUS | $SIZE" >> "$LOGFILE"
}

cleanup_old_backups(){
      local path=$1
      find "$path" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \;
}

# ==============================
# APPSERVER
# ==============================
APP_USER="userapp"
APP_HOST="AppServer"
APP_SRC="/home/userapp/app_data"
APP_DEST="/home/userbackup/backups/appserver"

log "AppServer" "INICIO" "-"

if ssh ${APP_USER}@${APP_HOST} \
   "tar -czf /tmp/appserver_${DATE}.tar.gz -C ${APP_SRC} ." && \
     scp ${APP_USER}@${APP_HOST}:/tmp/appserver_${DATE}.tar.gz ${APP_DEST}/
then
     SIZE=$(du -h ${APP_DEST}/appserver_${DATE}.tar.gz | awk '{print $1}')
     ssh ${APP_USER}@${APP_HOST} "rm /tmp/appserver_${DATE}.tar.gz"
     cleanup_old_backups "$APP_DEST"
     log "AppServer" "OK" "$SIZE"
else
     log "AppServer" "ERROR" "-"
fi

# ==============================
# FILESERVER
# ==============================
FILE_USER="userfile"
FILE_HOST="FileServer"
FILE_SRC="/home/userfile/file_data"
FILE_DEST="/home/userbackup/backups/fileserver"

log "FileServer" "INICIO" "-"

if ssh ${FILE_USER}@${FILE_HOST} \
   "tar -czf /tmp/fileserver_${DATE}.tar.gz -C ${FILE_SRC} ." && \

    scp ${FILE_USER}@${FILE_HOST}:/tmp/fileserver_${DATE}.tar.gz ${FILE_DEST}/
then

    SIZE=$(du -h ${FILE_DEST}/fileserver_${DATE}.tar.gz | awk '{print $1}')
    ssh ${FILE_USER}@${FILE_HOST} "rm /tmp/fileserver_${DATE}.tar.gz"
    cleanup_old_backups "$FILE_DEST"
    log "FileServer" "OK" "$SIZE"
else
    log "FileServer" "ERROR" "-"
fi

log "Retencion" "OK" ">$RETENTION_DAYS dias"
log "Backup Global Finalizado"
