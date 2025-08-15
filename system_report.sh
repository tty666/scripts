#!/bin/bash
# Generate a simple system status report including disk and memory usage.
# If the root filesystem usage exceeds the optional threshold argument
# (default 80 percent) a warning is printed.

threshold=${1:-80}
logfile="/tmp/system_report_$(date +"%Y%m%d_%H%M%S").log"

{
    echo "System report generated on $(date)"
    echo "Hostname: $(hostname)"
    echo
    echo "Disk usage:";
    df -h /
    echo
    echo "Memory usage:";
    free -h
    echo
    echo "Top processes by memory:";
    ps -eo pid,comm,%mem,%cpu --sort=-%mem | head
} > "$logfile"

used=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ "$used" -ge "$threshold" ]; then
    echo "WARNING: root filesystem at ${used}% used" >> "$logfile"
fi

cat "$logfile"
echo "Report saved to $logfile"
