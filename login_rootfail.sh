#/bin/bash
one_hour_ago=$(date +%R --date='-1 hours')
current_time=$(date +%R)
lastb -s $one_hour_ago -t $current_time | grep root > /tmp/loginfails_root.txt
wc -l /tmp/loginfails_root.txt > /tmp/fail_count_root.txt
count=$(awk '{print $1}' /tmp/fail_count_root.txt)
day=$(awk '{print $5}' /tmp/loginfails_root.txt | head -n 1)
current_hour=$(date +"%R")
today_day=$(date +"%d")
if [ $count -ge 3 ] && [ $day -eq $today_day ]; then
        echo "Someone is trying to log in too many times as root" | mutt -s "Access attempt to root" sergiosysforence@hotmail.com.ar
        today_date=$(date +"%d-%m-%Y-%H-%M")
        tar -zcvf login_root_backups.$today_date.tar.gz /tmp/loginfails_root.txt
        cp login_root_backups.$today_date.tar.gz /media/veracrypt1/backupsscripts/backups_loginroot
        rm -rf login_root_backups.$today_date.tar.gz
        rm -rf /tmp/loginfails_root.txt
        rm -rf /tmp/fail_count*
fi
