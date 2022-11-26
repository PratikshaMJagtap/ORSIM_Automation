#############_NodeManager Script by Pratiksha_############
#!/bin/ksh
date=`date +"%d-%m-%Y"`
date1=`date`
script_home="/opt/SP/weblogic/Pratiksha/HC"
path="/opt/SP/weblogic/Pratiksha/Pratiksha_HC"
cd $script_home
rm FinalResult.txt

if [ `ps aux |grep java |grep Admin_SIMDomain | wc -l` -ge 1 ]
then
   echo "it4351yr,SIM.Application.Cluster.Admin.Process,OK" > $script_home/FinalResult.txt
else
   echo "it4351yr,SIM.Application.Cluster.Admin.Process,KO" > $script_home/FinalResult.txt
fi
if [ `ps -ef | grep AdminServer |grep BIPDomain | wc -l` -ge 1 ]
then
   echo "it4351yr,BIP.Application.Cluster.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,BIP.Application.Cluster.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps -ef | grep AdminServer |grep IDMDomain | wc -l` -ge 1 ]
then
   echo "it4351yr,OID/IDM.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,OID/IDM.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps -ef | grep AdminServer |grep OHSDomain2 | wc -l` -ge 1 ]
then
   echo "it4351yr,OHS.SIM.cluster.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,OHS.SIM.cluster.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps -ef | grep AdminServer |grep OHSDomain3 | wc -l` -ge 1 ]
then
   echo "it4351yr,OHSDomain3.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,OHSDomain3.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps -ef | grep java | grep Admin_OSBDomain_OSB_BE |wc -l` -ge 1 ]
then
   echo "it4351yr,OSB.Cluster.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,OSB.Cluster.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps -ef | grep java | grep Admin_OHSDomain1_OSB_FE | wc -l` -ge 1 ]
then
   echo "it4351yr,OHS.OSB.Cluster.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,OHS.OSB.Cluster.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps -ef | grep java | grep Admin_OAMDomain | wc -l` -ge 1 ]
then
   echo "it4351yr,OAM.Application.Cluster.Admin.Process,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,OAM.Application.Cluster.Admin.Process,KO" >> $script_home/FinalResult.txt
fi
if [ `ps aux | grep java | grep NodeManager |grep -v grep | wc -l` -ge 7 ]
then
   echo "it4351yr,Admin.NodeManagers,OK" >> $script_home/FinalResult.txt
else
   echo "it4351yr,Admin.Admin.NodeManagers,KO" >> $script_home/FinalResult.txt
fi

while read line
do
ssh weblogic@$line.it.sedc.internal.vodafone.com << QA
cd
sh /opt/SP/weblogic/Pratiksha/Pratiksha_HC/test.sh
exit
QA
scp weblogic@$line.it.sedc.internal.vodafone.com:/opt/SP/weblogic/Pratiksha/Pratiksha_HC/check_$line.tar .
tar -xvf $script_home/check_$line.tar
done < $script_home/ServerList.txt

cd $script_home
cat NM*.txt >> FinalResult.txt
date >> FinalResult.txt

rm $script_home/NM*.txt
rm $script_home/check*.tar

cd /opt/SP/weblogic/Pratiksha/HC
sh DB.sh 1>/dev/null
sh DB1.sh 1>/dev/null
sh DB2.sh 1>/dev/null
