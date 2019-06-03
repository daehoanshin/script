#!/bin/sh
find /data01/logs -name *.log -ctime +90 -exec rm -f {} \;

if [ -d /home/icsadm/logs ]
then
        echo "/home/icsadm/logs delete"
        rm -rf /home/icsadm/logs
fi
