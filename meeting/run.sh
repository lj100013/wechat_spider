#! /usr/bin/bash
if [ $1 == '' ];then
	python /data/job_pro/dataX/meeting/kafka2kafka_meeting.py
	if [ $? -ne 0 ]
	then
    	exit 1
	fi
else
	echo '=========================='
	echo $1
	echo $2
	echo '=========================='
	python /data/job_pro/dataX/meeting/kafka2kafka_meeting.py $1 $2
	if [ $? -ne 0 ]
	then
    	exit 1
	fi
fi
