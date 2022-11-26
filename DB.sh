#!/bin/ksh

rm /opt/SP/weblogic/Pratiksha/DB/ORSIM* 
cd /opt/SP/weblogic
. ./dbclient.profile

cd /opt/SP/weblogic/Pratiksha
DB=/opt/SP/weblogic/Pratiksha/DB
function EXECSQL
{
    test -z "$1" && return
	sqlplus -s sim16/welcome1@ORSIMPRD <<EOF
        SET lines 132
        SET pages 10000
	SET colsep ,
        $*
        EXIT
EOF
}

function promo
{
      EXECSQL "
          select * from z_log where message_level = 'ERROR' and create_user like 'SIM16%' and trunc(create_date) = trunc(sysdate);
              "
}

function promo2
{
cat > $DB/ORSIM.sql <<EOF
SET PAGESIZE 50000
SET FEED OFF MARKUP HTML ON SPOOL ON
SET NUM 24
SPOOL $DB/ORSIM.html

select * from z_log where message_level = 'ERROR' and create_user like 'SIM16%' and trunc(create_date) = trunc(sysdate);

SPOOL OFF
SET MARKUP HTML OFF SPOOL OFF
EXIT;
EOF

EXECSQL @$DB/ORSIM.sql 2> $DB/ORSIM_ERROR

}

promo2

mv $DB/ORSIM.html $DB/ORSIM.xls
