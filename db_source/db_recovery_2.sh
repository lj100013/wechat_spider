#!/bin/bash
source /etc/profile
#生产环境抽取的数据压缩包路径
dst_path=/data/db_source
#mongo_path=/data/backup/nfs/crond/mongodb
#mongo需要还原的库名
mongo_dbs=(health online-marketing activity module diseasediscuss micro-school drugOrg circledaq auth2 basepost)
#mongo_dbs=(basepost)
#mysql_path=/data/backup/nfs/crond/mysql
#20180823新加mysql的health库
mysql_dbs=(activitywwh circle medicine-literature circle_school health)
#总日志路径
logfile=/var/log/restore/restore.log
domain=dbget.dachentech.com.cn
#数据还原的日期
dt=`date "+%Y-%m-%d"`



for db in ${mysql_dbs[@]}
do
    #如果压缩文件存在，若文件大小为0，代表下载失败，将其删除
    if [[ -f  ${dst_path}/mysql/${db}_${dt}.tgz ]];then
        filesize=`ls -l ${dst_path}/mysql/${db}_${dt}.tgz | awk '{ print $5 }'`
        if [ "$filesize" -eq "0" ];then
            ehco "${dst_path}/mysql/${db}_${dt}.tgz 文件大小为0，删除文件" >> $logfile
            rm -f ${dst_path}/mysql/${db}_${dt}.tgz
        fi
    fi
    if [[ ! -f  ${dst_path}/mysql/${db}_${dt}.tgz ]];then
        echo "${dst_path}/mysql/${db}_${dt}.tgz 不存在，开始下载" >> $logfile
        wget -O ${dst_path}/mysql/${db}_${dt}.tgz  http://$domain/mysql/${db}_${dt}.tgz
    fi
    if [[ ! -f ${dst_path}/mysql/${db}_${dt}.sql ]];then
        echo "${dst_path}/mysql/${db}_${dt}.sql 未解压，开始解压" >> $logfile
        dd if=${dst_path}/mysql/${db}_${dt}.tgz |openssl des3 -d -k secretdachen |tar zxf - -C ${dst_path}/mysql
    fi
    mysql -h192.168.3.154 -uroot -p"Dachen@222" -f ${db} < ${dst_path}/mysql/${db}_${dt}.sql > /dev/null 2>&1
    if [ $? == 0 ];then
            echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${db} recovery success! file:${dst_path}/mysql/${db}_${dt}.tgz" >> $logfile
            rm -f ${dst_path}/mysql/${db}_${dt}.sql
    else
            echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${db} recovery faild! file:`date "+%Y-%m-%d"`" >> $logfile
            exit 1
    fi
#    rm -f ${dst_path}/mysql/${db}_${dt}.sql
done

for db in ${mongo_dbs[@]}
do
    #如果压缩文件存在，若文件大小为0，代表下载失败，将其删除
    if [[ -f  ${dst_path}/mongodb/${db}_${dt}.tgz ]];then
        filesize=`ls -l ${dst_path}/mongodb/${db}_${dt}.tgz | awk '{ print $5 }'`
        if [ "$filesize" -eq "0" ];then
            ehco "${dst_path}/mongodb/${db}_${dt}.tgz 文件大小为0，删除文件" >> $logfile
            rm -f ${dst_path}/mongodb/${db}_${dt}.tgz
        fi
    fi
    if [[ ! -f ${dst_path}/mongodb/${db}_${dt}.tgz ]];then
        echo "${dst_path}/mongodb/${db}_${dt}.tgz 不存在，开始下载" >> $logfile
        status_code=`curl -o /dev/null -s -w %{http_code} http://$domain/mongodb/status/${db}_${dt}_status`
        if [[ $status_code == 200 ]]; then
            wget -O ${dst_path}/mongodb/${db}_${dt}.tgz  http://$domain/mongodb/${db}_${dt}.tgz
            echo "${dst_path}/mongodb/${db}_${dt}.tgz 下载成功" >> $logfile
        else
            declare -i count=1
            while [[ $count -le 60 ]]; do
                sleep 30
                status_code=`curl -o /dev/null -s -w %{http_code} http://$domain/mongodb/status/${db}_${dt}_status`
                if [[ $status_code != 200 ]]; then
                    let count++
                else
                    wget -O ${dst_path}/mongodb/${db}_${dt}.tgz  http://$domain/mongodb/${db}_${dt}.tgz
                    echo "${dst_path}/mongodb/${db}_${dt}.tgz 下载成功" >> $logfile
                    break;
                fi
            done
            echo "下载${db}失败，超时30分钟"  >> $logfile
        fi  
        if [ $? != 0 ];then
            exit 1
        fi
    fi
    if [[ ! -d ${dst_path}/mongodb/${db} ]];then
        echo "${dst_path}/mongodb/${db} 未解压，开始解压" >> $logfile
        dd if=${dst_path}/mongodb/${db}_${dt}.tgz |openssl des3 -d -k secretdachen |tar zxf - -C ${dst_path}/mongodb
    fi
    mongorestore -h 192.168.3.154:27017 --authenticationDatabase admin -v --drop -d ${db}  ${dst_path}/mongodb/${db}
    if [ $? == 0 ];then
        echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${db} recovery success!" >> $logfile
    else
        echo "[`date "+%Y-%m-%d %H:%M:%S"`]   ${db} recovery faild! file:`date "+%Y-%m-%d"`" >> $logfile
        exit 1
    fi
    rm -rf ${dst_path}/mongodb/${db}
done
find ${dst_path} -name '*.tgz' -ctime +3 | xargs rm -rf 



