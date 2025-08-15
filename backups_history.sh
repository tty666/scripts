#!/bin/bash
# -*- ENCODING: UTF-8 -*-
today_date=$(date +"%d-%m-%Y")
tar -zcvf history_backups.$today_date.tar.gz /tmp/history_*
cp history_backups.$today_date.tar.gz /backupsscripts/backups_history
rm -rf history_backups.$today_date.tar.gz
rm -rf /tmp/history_*
