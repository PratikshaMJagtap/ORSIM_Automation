#!/bin/ksh

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
          SELECT * FROM Z_STG_DDT_ORDERS WHERE status='N' AND INSERT_DATE >= sysdate -1;
              "
}

function promo2
{
cat > $DB/ORSIM1.sql <<EOF
SET PAGESIZE 50000
SET FEED OFF MARKUP HTML ON SPOOL ON
SET NUM 24
SPOOL $DB/ORSIM1.html

SELECT * FROM Z_STG_DDT_ORDERS WHERE status='N' AND INSERT_DATE >= sysdate -1;

SPOOL OFF
SET MARKUP HTML OFF SPOOL OFF
EXIT;
EOF

EXECSQL @$DB/ORSIM1.sql 2> $DB/ORSIM1_ERROR

}

promo2

mv $DB/ORSIM1.html $DB/ORSIM1.xls
