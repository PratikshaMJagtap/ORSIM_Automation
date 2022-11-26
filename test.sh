#!/bin/ksh
script_home="/opt/SP/weblogic/Pratiksha/Pratiksha_HC"
if [ `ps -ef | grep weblogic.Server | grep -v grep | wc -l` = 1 ]
then
   echo "it4339yr,Manage.Server,OK" > $script_home/NM_it4339yr.txt
else
   echo "it4339yr,Manage.Server,KO" > $script_home/NM_it4339yr.txt
fi
if [ `ps aux | grep java | grep NodeManager | wc -l` = 1 ]
then
   echo "it4339yr,NodeManager,OK" >> $script_home/NM_it4339yr.txt
else
   echo "it4339yr,NodeManager,KO" >> $script_home/NM_it4339yr.txt
fi

cd /opt/SP/weblogic/Pratiksha/Pratiksha_HC
tar -cvf check_it4339yr.tar NM_it4339yr.txt

