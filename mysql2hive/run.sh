#!/bin/bash 
if [[ $1 == '' ]];then
   preday=`date -d "yesterday" +%Y-%m-%d`
else
   preday=$1
fi
echo '###########################'
echo 'preday:'$preday
echo '###########################'

function __readINI() {
 INIFILE=$1; SECTION=$2; ITEM=$3
 _readIni=`awk -F '=' '/\['$SECTION'\]/{a=1}a==1&&$1~/'$ITEM'/{print $2;exit}' $INIFILE`
 echo ${_readIni}
}

jobname=mysql2hive

configdir=/data/job_pro/utils/
USER=( $( __readINI $configdir/config.ini report user ) )
PASSWORD=( $( __readINI $configdir/config.ini report passwd ) )
HOST=( $( __readINI $configdir/config.ini report host ) )
 
COMMAND="select flag from job_flag_pro where job_time='$preday' and job_name='$jobname'"
declare status=`mysql -h${HOST} -u${USER} -p${PASSWORD} -D report -e "${COMMAND}" --skip-column-name`
echo "######################"
echo '$jobname running status:'$status
echo "######################"
if [ "$status" =  "" ] ; then 
   INSERT="insert into job_flag_pro(job_name,job_time,flag) values('$jobname','$preday',1)"
   mysql -h${HOST} -u${USER} -p${PASSWORD} -D report -e "${INSERT}"
   hive -hivevar preday=$preday -f /data/job_pro/dataX/mysql2hive/mysql2hive.hql
   if [ $? -ne 0 ]
      then 
      echo "delete this job!!!"
      mysql -h${HOST} -u${USER} -p${PASSWORD} -D report -e "delete from job_flag_pro where job_name='$jobname' and job_time='$preday' "
      exit 1
   else
      mysql -h${HOST} -u${USER} -p${PASSWORD} -D report -e "update job_flag_pro set flag=2 where job_name='$jobname' and job_time='$preday' "
      exit
   fi
elif [ "$status" =  "1" ]; then
   echo "Warning !! $jobname Running !! Sleep 10"
   sleep 10
   bash /data/job_pro/dataX/mysql2hive/run.sh
elif [ "$status" =  "2" ]; then 
   echo "Warning !! $jobname is done!!!" 
fi