#! /usr/bin/bash
if [ $1 == '' ];then
   python /data/job_pro/dataX/meeting/kafka2kudu_meeting.py
else
   echo '=========================='
   echo $1
   echo $2
   echo '=========================='
   python /data/job_pro/dataX/meeting/kafka2kudu_meeting.py $1 $2
fi
