#!/bin/bash 

preday=`date -d last-day +%Y-%m-%d`
if [ $1 ];then
    preday=$1
 fi

echo '###########################'
echo 'preday:'$preday
echo '###########################'

impala-shell --var=preday=${preday} -f /data/job_pro/dataX/mysql2hive/mysql2hive_credit.hql
