#!/bin/bash
. /etc/profile
dst_path=/data/db_source
dt=`date "+%Y-%m-%d"`
#dt="2018-06-08"
#dos2unix /data/program/db_recovery/yqq_mongo_collection
logfile=/var/log/restore/mongo_source.log
#mongo_dbs=(health online-marketing)
domain=dbget.dachentech.com.cn
#_type=(mongodb mongodb_pre)
_type=(mongodb)
rm -f ${dst_path}/mongodb/health_${dt}.tgz
rm -f ${dst_path}/mongodb/online-marketing_${dt}.tgz
rm -f ${dst_path}/mongodb/auth2_${dt}.tgz
rm -f ${dst_path}/mongodb/activity_${dt}.tgz
for line in `grep -Ev '^#' /data/job_pro/dataX/db_source/yqq_mongo_collection_bak`
do
    mongodb=`echo $line|awk -F':' '{print $1}'`
    collection=`echo $line|awk -F':' '{print $2}'`
    for _type in ${_type[@]}
    do
        #如果压缩文件存在，若文件大小为0，代表下载失败，将其删除
        if [[ -f  ${dst_path}/${_type}/${mongodb}_${dt}.tgz ]];then
            filesize=`ls -l ${dst_path}/${_type}/${mongodb}_${dt}.tgz | awk '{ print $5 }'`
            if [ "$filesize" -eq "0" ];then
                ehco "${dst_path}/${_type}/${mongodb}_${dt}.tgz 文件大小为0，删除文件" >> $logfile
                rm -f ${dst_path}/${_type}/${mongodb}_${dt}.tgz
            fi
        fi        
        if [[ ! -f ${dst_path}/${_type}/${mongodb}_${dt}.tgz ]];then
            status_code=`curl -o /dev/null -s -w %{http_code} http://$domain/${_type}/status/${mongodb}_${dt}_status`
            if [[ $status_code == 200 ]]; then
                wget -O ${dst_path}/${_type}/${mongodb}_${dt}.tgz  http://$domain/${_type}/${mongodb}_${dt}.tgz
                echo "${dst_path}/${_type}/${mongodb}_${dt}.tgz 下载成功" >> $logfile
            else
                declare -i count=1
                while [[ $count -le 60 ]]; do
                    sleep 30
                    status_code=`curl -o /dev/null -s -w %{http_code} http://$domain/${_type}/status/${mongodb}_${dt}_status`
                    if [[ $status_code != 200 ]]; then
                        let count++
                    else
                        wget -O ${dst_path}/${_type}/${mongodb}_${dt}.tgz  http://$domain/${_type}/${mongodb}_${dt}.tgz
                        echo "${dst_path}/${_type}/${mongodb}_${dt}.tgz 下载成功" >> $logfile
                        break;
                    fi
                done
                echo "下载${db}失败，超时30分钟"  >> $logfile
            fi  
            if [ $? != 0 ];then
                exit 1
            fi
        fi
        if [[ ! -d ${dst_path}/${_type}/${mongodb} ]];then
            dd if=${dst_path}/${_type}/${mongodb}_${dt}.tgz |openssl des3 -d -k secretdachen |tar zxf - -C ${dst_path}/${_type}/
        fi
    done

    if [[ ${collection} == '' ]];then
        echo "DB:${mongodb} start recovery" >> $logfile
        mongorestore -h 192.168.3.181:27020 -u admin -p adminUsfqga --authenticationDatabase admin -v -d ${mongodb} --drop ${dst_path}/mongodb/${mongodb}
        if [ $? == 0 ];then
            echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb} recovery success! :file:`date "+%Y-%m-%d"`" >> $logfile
        else
            echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb} recovery faild! file:`date "+%Y-%m-%d"`" >> $logfile
            exit 1
        fi


    else
        echo "DB:${mongodb},collection:${collection} start recovery" >> $logfile
        mongorestore -h 192.168.3.181:27020 -u admin -p adminUsfqga --authenticationDatabase admin  -d ${mongodb}  -c ${collection} --drop ${dst_path}/mongodb/${mongodb}/${collection}.bson
        if [ $? == 0 ];then
            echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb}_${collection} recovery success! file:`date "+%Y-%m-%d"`" >> $logfile
        else
            echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${mongodb}_${collection} recovery faild! file:`date "+%Y-%m-%d"`" >> $logfile
            exit 1
        fi

    fi
done
find /data/db_source/mongodb/* -type d |xargs rm -rf
