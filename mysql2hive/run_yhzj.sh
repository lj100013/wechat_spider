#!/bin/bash
if [[ $2 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
   pre2day=`date -d "2 days ago" +%Y-%m-%d`
else
   preday=$2
   pre2day=$3
fi

jobname=$1

bash /data/job_pro/utils/job_flag.sh $jobname /data/job_pro/dataX/mysql2hive $preday $pre2day