#!/bin/sh

echo "###################   #splem_start.sh ########################################"
export CATALINA_HOME=/home/icsadm/splems/apache-tomcat-9.0.14
Log=$CATALINA_HOME/logs/restart.log
DATE=`date +%Y%m%d-%H%M%S`

# tomcat PID search
tomcatPID=`ps -ef | grep tomcat | grep -v grep | grep -v vi | awk '{print $2}'`
# tomcat process count
tomcatCnt=`ps -ef | grep tomcat | grep -v grep | grep -v vi | wc -l`


if [ $tomcatCnt -gt 0 ]
then
    echo "$DATE : TOMCAT already start(PID : $tomcatPID)"
else
    sudo service httpd start
    $CATALINA_HOME/bin/startup.sh
    tomcatPID=`ps -ef | grep tomcat | grep -v grep | grep -v vi | awk '{print $2}'`
    echo "$DATE : TOMCAT, Apache start complete (PID : $tomcatPID)"
    echo "$DATE : TOMCAT, Apache start complete (PID : $tomcatPID)" >> $Log
fi


echo "##############################################################################"
