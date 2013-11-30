#!/bin/bash

CURRENT_LOAD=`uptime | awk -F'load average:' '{ print $2 }' | awk -F '.' '{ print $1 }'`
LOAD_FULL=`uptime | awk -F'load average:' '{ print $2 }' | awk -F ',' '{ print $1 }'`
EMAIL=`cat /root/motd/motd.email`
API=`cat /root/motd/motd.api`

if [[ ${CURRENT_LOAD} -ge 1 ]]
then
  echo "Load is higher than 1, exiting."
  
  curl -d "email=${EMAIL}" -d "&notification[from_screen_name]=MOTD" -d "&notification[message]=Serverload+higher+than+normal+(${LOAD_FULL})" http://boxcar.io/devices/providers/${API}/notifications
  exit 0
fi

CPUTIME=$(ps -eo pcpu | awk 'NR>1' | awk '{tot=tot+$1} END {print tot}')
CPUCORES=$(cat /proc/cpuinfo | grep -c processor)
echo "
System Summary (collected `date`)
 
 - CPU Usage (average)       = `echo $CPUTIME / $CPUCORES | bc`%
 - Memory free (real)        = `free -m | head -n 2 | tail -n 1 | awk {'print $4'}` Mb
 - Memory free (cache)       = `free -m | head -n 3 | tail -n 1 | awk {'print $3'}` Mb
 - Swap in use               = `free -m | tail -n 1 | awk {'print $3'}` Mb
 - System Uptime             =`uptime`
 - Public IP                 = `dig +short myip.opendns.com @resolver1.opendns.com`
 - Disk Space Used           = `df / | awk '{ a = $4 } END { print a }'`
 
This server is managed by puppet.ahlun.be.

" > /etc/motd
