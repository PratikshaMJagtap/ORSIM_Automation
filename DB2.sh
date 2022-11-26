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
          select * from z_stg_asn where ko_date is not null and asn_external_id not in (select asn_id from dsd);
              "
}

function promo2
{
cat > $DB/ORSIM2.sql <<EOF
SET PAGESIZE 50000
SET FEED OFF MARKUP HTML ON SPOOL ON
SET NUM 24
SPOOL $DB/ORSIM2.html

select * from z_stg_asn where ko_date is not null and asn_external_id not in (select asn_id from dsd);

SPOOL OFF
SET MARKUP HTML OFF SPOOL OFF
EXIT;
EOF

EXECSQL @$DB/ORSIM2.sql 2> $DB/ORSIM2_ERROR

}

promo2

mv $DB/ORSIM2.html $DB/ORSIM2.xls
