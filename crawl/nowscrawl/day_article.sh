
if [[ $1 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
else
   preday=$1
fi
echo '###########################'
echo 'preday:'$preday
echo '###########################'

hive -hiveconf hive.exec.mode.local.auto=true -hivevar preday=$preday -f /data/job_pro/dataX/crawl/nowscrawl/article_hive.hql
cd /data/job_pro/dataX/crawl/nowscrawl/nowscrawl
scrapy crawl wf

