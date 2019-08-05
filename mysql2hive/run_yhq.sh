#!/bin/bash
if [[ $1 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
   pre2day=`date -d "2 days ago" +%Y-%m-%d`
else
   preday=$1
   pre2day=$2
fi

jobname=$1

bash /data/job_pro/utils/job_flag.sh $jobname /data/job_pro/dataX/mysql2hive $preday $pre2day