#!/bin/bash 

PREDAY=`date -d last-day +%Y-%m-%d`
if [ $1 ];then
    PREDAY=$1
 fi

echo '###########################'
echo 'PREDAY:'$PREDAY
echo '###########################'

hive -hivevar PREDAY=$PREDAY -f /data/job_pro/dataX/search/hive2es_all_init.hql
