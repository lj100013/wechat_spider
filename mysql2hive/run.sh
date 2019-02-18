#!/bin/bash 
if [[ $1 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
else
   preday=$1
fi
echo '###########################'
echo 'preday:'$preday
echo '###########################'

jobname=mysql2hive

USER=root           #设定用户名
PASSWORD="123456"  #设定数据库的用户密码  
DB=report        #选定需要的数据库  
TLB=job_flag_pro
HOST=ds-01
 
COMMAND="select flag from $TLB where job_time='$preday' and job_name='$jobname'"
declare status=`mysql -h${HOST} -u${USER} -p'Dachen$222' -D ${DB} -e "${COMMAND}" --skip-column-name`
echo "######################"
echo '$jobname running status:'$status
echo "######################"
if [ "$status" =  "" ] ; then 
   INSERT="insert into $TLB(job_name,job_time,flag) values('$jobname','$preday',1)"
   mysql -h${HOST} -u${USER} -p'Dachen$222' -D ${DB} -e "${INSERT}"
   hive -hivevar preday=$preday -f /data/job_pro/dataX/mysql2hive/mysql2hive.hql
   if [ $? -ne 0 ]
      then 
      echo "delete this job!!!"
      mysql -h${HOST} -u${USER} -p'Dachen$222' -D ${DB} -e "delete from $TLB where job_name='$jobname' and job_time='$preday' "
      exit 1
   else
      mysql -h${HOST} -u${USER} -p'Dachen$222' -D ${DB} -e "update $TLB set flag=2 where job_name='$jobname' and job_time='$preday' "
      exit
   fi
elif [ "$status" =  "1" ]; then
   echo "Warning !! $jobname Running !! Sleep 10"
   sleep 10
   bash /data/job_pro/dataX/mysql2hive/run.sh
elif [ "$status" =  "2" ]; then 
   echo "Warning !! $jobname is done!!!" 
fi

