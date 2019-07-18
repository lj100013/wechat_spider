
#! /usr/bin/bash
if [[ $1 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
else
   preday=$1
fi

python /data/job_pro/dataX/meeting/retryUrl.py
if [ $? == 0 ];then
	cat /data/work/url_error/url_error.txt >> /data/work/url_error/url_error_$preday.txt
	> /data/work/url_error/url_error.txt
fi

sleep 7m