#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo dnf update -y > /tmp/update.txt
today_date=$(date +"%d-%m-%Y")
tar -zcvf update_backups.$today_date.tar.gz /tmp/update.txt
cp update_backups.$today_date.tar.gz /backupsscripts/backups_comandoupdate
rm -rf update_backups.$today_date.tar.gz
rm -rf /tmp/update.txt
