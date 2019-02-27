#!/bin/bash
if [[ $1 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
   pre2day=`date -d "2 days ago" +%Y-%m-%d`
else
   preday=$1
   pre2day=$2
fi

bash /data/job_pro/utils/job_flag.sh mongo2hive /data/job_pro/dataX/mongo2hive $preday $pre2day