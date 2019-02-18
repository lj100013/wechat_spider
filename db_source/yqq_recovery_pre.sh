#!/bin/bash
. /etc/profile
dst_path=/data/db_source
dt=`date "+%Y-%m-%d"`
#dos2unix /data/program/db_recovery/yqq_mongo_collection
logfile=/var/log/restore/restore_yqq_pre.log
#mongo_dbs=(health online-marketing)
domain=dbget.dachentech.com.cn
declare -A mydict
#mydict=(["mongodb"]="27020" ["mongodb_pre"]="27018")
mydict=(["mongodb_pre"]="27018")

for platform in $(echo ${!mydict[*]})
do
    echo $platform
    for line in `grep -Ev '^#' /data/job_pro/dataX/db_source/yqq_mongo_collection`
    do
        mongodb=`echo $line|awk -F':' '{print $1}'`
        collection=`echo $line|awk -F':' '{print $2}'`
        #如果压缩文件存在，若文件大小为0，代表下载失败，将其删除
        if [[ -f  ${dst_path}/${platform}/${mongodb}_${dt}.tgz ]];then
            filesize=`ls -l ${dst_path}/${platform}/${mongodb}_${dt}.tgz | awk '{ print $5 }'`
            if [ "$filesize" -eq "0" ];then
                ehco "${dst_path}/${platform}/${mongodb}_${dt}.tgz 文件大小为0，删除文件" >> $logfile
                rm -f ${dst_path}/${platform}/${mongodb}_${dt}.tgz
            fi
        fi        
        if [[ ! -f ${dst_path}/${platform}/${mongodb}_${dt}.tgz ]];then
            echo "${dst_path}/${platform}/${mongodb}_${dt}.tgz 不存在，开始下载" >> $logfile
            status_code=`curl -o /dev/null -s -w %{http_code} http://$domain/${platform}/status/${mongodb}_${dt}_status`
            if [[ $status_code == 200 ]]; then
                wget -O ${dst_path}/${platform}/${mongodb}_${dt}.tgz  http://$domain/${platform}/${mongodb}_${dt}.tgz
                echo "${dst_path}/${platform}/${mongodb}_${dt}.tgz 下载成功" >> $logfile
            else
                declare -i count=1
                while [[ $count -le 60 ]]; do
                    sleep 30
                    status_code=`curl -o /dev/null -s -w %{http_code} http://$domain/${platform}/status/${mongodb}_${dt}_status`
                    if [[ $status_code != 200 ]]; then
                        let count++
                    else
                        wget -O ${dst_path}/${platform}/${mongodb}_${dt}.tgz  http://$domain/${platform}/${mongodb}_${dt}.tgz
                        echo "${dst_path}/${platform}/${mongodb}_${dt}.tgz 下载成功" >> $logfile
                        break;
                    fi
                done
                echo "下载${db}失败，超时30分钟"  >> $logfile
            fi  
            if [ $? != 0 ];then
                exit 1
            fi
        fi
            
        if [[ ! -d ${dst_path}/${platform}/${mongodb} ]];then
            echo "${dst_path}/${platform}/${mongodb}未解压，开始解压" >> $logfile
            dd if=${dst_path}/${platform}/${mongodb}_${dt}.tgz |openssl des3 -d -k secretdachen |tar zxf - -C ${dst_path}/${platform}/
            if [ $? != 0 ];then
               exit 1
            fi
       fi

        if [[ ${collection} == '' ]];then
            echo "DB:${mongodb} start recovery" >> $logfile
            mongorestore -h 192.168.3.7:${mydict[$platform]} -u admin -p adminUsfqga --authenticationDatabase admin -v -d ${mongodb} --drop ${dst_path}/${platform}/${mongodb}
            if [ $? == 0 ];then
                echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb} ${mydict[$platform]} recovery success!" >> $logfile
            else
                echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb} ${mydict[$platform]} recovery faild!" >> $logfile
                exit 1
            fi


        else
            echo "DB:${mongodb},collection:${collection} start recovery" >> $logfile
            mongorestore -h 192.168.3.7:${mydict[$platform]} -u admin -p adminUsfqga --authenticationDatabase admin -v -d ${mongodb}  -c ${collection} --drop ${dst_path}/${platform}/${mongodb}/${collection}.bson
            if [ $? == 0 ];then
                echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb}_${collection} ${mydict[$platform]} recovery success!" >> $logfile
            else
                echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb}_${collection} ${mydict[$platform]} recovery faild!" >> $logfile
                exit 1
            fi
            

        fi
    done
    sleep 2
    find /data/db_source/${platform}/* -type d |xargs rm -rf
done
find /data/db_source/${platform}/ -name "*.tgz" -ctime +1|xargs rm -f
