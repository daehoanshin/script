#!/bin/sh

echo "###################   #splem_stop.sh ########################################"
export CATALINA_HOME=/home/icsadm/splems/apache-tomcat-9.0.14
Log=$CATALINA_HOME/logs/restart.log
DATE=`date +%Y%m%d-%H%M%S`

# tomcat PID search
tomcatPID=`ps -ef | grep tomcat | grep -v grep | grep -v vi | awk '{print $2}'`
# tomcat process count
tomcatCnt=`ps -ef | grep tomcat | grep -v grep | grep -v vi | wc -l`

if [ $tomcatCnt -gt 0 ]
then
    echo "$DATE : TOMCAT, Apache start (PID : $tomcatPID)"
    echo "$DATE : TOMCAT, Apache start (PID : $tomcatPID)" >> $Log
    sudo service httpd stop
    $CATALINA_HOME/bin/shutdown.sh
    sleep 2
    echo $tomcatCnt
    tomcatCnt=`ps -ef | grep tomcat | grep -v grep | grep -v vi | wc -l`
    if [ $tomcatCnt -eq 0 ]
    then
        echo "$DATE : TOMCAT stop complete"
        echo "$DATE : TOMCAT stop complete" >> $Log
    fi
else
    echo "$DATE : TOMCAT,APACHE already stop"
fi

echo "##############################################################################"
