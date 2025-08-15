#/bin/bash
one_hour_ago=$(date +%R --date='-1 hours')
current_time=$(date +%R)
lastb -s $one_hour_ago -t $current_time | grep hackende > /tmp/loginfails_hackende.txt
wc -l /tmp/loginfails_hackende.txt > /tmp/fail_count_hackende.txt
count=$(awk '{print $1}' /tmp/fail_count_hackende.txt)
day=$(awk '{print $5}' /tmp/loginfails_hackende.txt | head -n 1)
current_hour=$(date +"%R")
today_day=$(date +"%d")
if [ $count -ge 3 ] && [ $day -eq $today_day ]; then
        echo "Someone is trying to log in too many times as hackendemoniado" | mutt -s "Access attempt to hackendemoniado" sergiosysforence@hotmail.com.ar
        today_date=$(date +"%d-%m-%Y-%H-%M")
        tar -zcvf login_hack_backups.$today_date.tar.gz /tmp/loginfails_hackende.txt
        cp login_hack_backups.$today_date.tar.gz /media/veracrypt1/backupsscripts/backups_login_hackendemoniado
        rm -rf login_hack_backups.$today_date.tar.gz
        rm -rf /tmp/loginfails_hackende.txt
        rm -rf /tmp/fail_count*
fi
