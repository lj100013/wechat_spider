
#! /usr/bin/bash
if [ $1 == '' ];then
   python /data/job_pro/dataX/meeting/getUrl.py
else
   echo '=========================='
   echo $1
   echo $2
   echo '=========================='
   python /data/job_pro/dataX/meeting/getUrl.py $1 $2
fi
