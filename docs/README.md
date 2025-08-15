# Script Reference

Detailed notes on the scripts shipped with this repository.

## actualizar.sh

Runs `dnf update -y` and stores the output in `/tmp/update.txt`. The file is
compressed into `backupsupdate.<date>.tar.gz` and copied to
`/backupsscripts/backups_comandoupdate` before temporary files are removed.

## backups_history.sh

Archives temporary history files from `/tmp/history_*` into
`backupshistory.<date>.tar.gz` and moves the archive to
`/backupsscripts/backups_history`.

## controlared.sh

Interactive network scanner that uses `nmap` to enumerate hosts on a given
segment. Unknown MAC addresses trigger a notification email with details about
the intruding device.

## guardahistory_hackendemoniado.sh

Saves the current user's command history into `/tmp/history_hackendemoniado.txt`.

## guardahistory_root.sh

Saves the root user's command history into `/tmp/history_root.txt`.

## login_hackendefail.sh

Monitors failed login attempts for the user `hackendemoniado` within the last
hour. If there are three or more attempts on the current day, an alert email is
sent and a backup of the log file is archived under
`/media/veracrypt1/backupsscripts/backups_loginhackendemoniado`.

## login_rootfail.sh

Checks for repeated failed root login attempts during the previous hour. When
three or more attempts occur on the current day, an alert email is sent and a
backup of the login data is archived under
`/media/veracrypt1/backupsscripts/backups_loginroot`.

## BackBox anonymous configuration

`usr/sbin/backbox-anonymous` is a script to route traffic through Tor and clean
local traces. Its default configuration lives in `etc/default/backbox-anonymous`.
These files are provided as references and are not executed by other scripts in
this repository.

---

Use these scripts with caution and adapt paths or addresses to match your own
environment.

