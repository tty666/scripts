#!/bin/bash
# -*- ENCODING: UTF-8 -*-
# Ejecuta "dnf update" y guarda un backup del log.
# El primer parámetro permite especificar la cantidad de días a conservar backups (por defecto 7).

retention_days=${1:-7}
logfile="/tmp/update.txt"
backupdir="/backupsscripts/backups_comandoupdate"
fechahoy=$(date +"%d-%m-%Y")

# Ejecuta actualización y guarda el log
sudo dnf update -y > "$logfile"

# Crea backup comprimido del log
archivo="backupsupdate.$fechahoy.tar.gz"
tar -zcvf "$archivo" "$logfile"
cp "$archivo" "$backupdir"
rm -f "$archivo" "$logfile"

# Limpia backups antiguos
find "$backupdir" -type f -name "backupsupdate.*.tar.gz" -mtime +"$retention_days" -print -delete

echo "Backup almacenado en $backupdir"
echo "Se eliminarán backups con más de $retention_days días"
