# -*- coding:utf-8 -*-
import random

import bson
import json
import pymongo
import pymysql
import sys
from bson.json_util import dumps
from kafka import KafkaProducer
import configparser
import time
import signal

conf = configparser.ConfigParser()
# conf.read(r"D:\job_script\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
HOST = conf.get('mongo', 'host')
PORT = int(conf.get('mongo', 'port'))
USERNAME = conf.get('mongo', 'user')
PASSWORD = conf.get('mongo', 'password')
KAFKA_HOSTS = conf.get('kafka', 'hosts')

MYSQL_HOSTS= conf.get('mysqldb','host')
MYSQL_USERNAME=conf.get('mysqldb','user')
MYSQL_PASSWORD=conf.get('mysqldb','password')
MYSQL_DB=conf.get('mysqldb','dbreport')



def getTopic(database):
    conn_mysql = pymysql.connect(MYSQL_HOSTS,MYSQL_USERNAME,MYSQL_PASSWORD,MYSQL_DB)
    cur = conn_mysql.cursor()
    sql="select topic from t_change_stream_kafka where db='%s'" % (database)
    print('getTpoic Sql: '+sql)
    cur.execute(sql)
    result = cur.fetchall()
    if len(result)>0:
        data = result[0][0]
    else:
        data=None
    conn_mysql.close()
    return data

def setOffset(database,ts):
    conn_mysql = pymysql.connect(MYSQL_HOSTS,MYSQL_USERNAME,MYSQL_PASSWORD,MYSQL_DB)
    cur = conn_mysql.cursor()
    sql = "replace into t_change_stream_offset(db,offset) values('%s',%d)" % (database,ts)
    print('update offset Sql : '+sql)
    cur.execute(sql)
    conn_mysql.commit()
    cur.close()

def getOffset(database):
    conn_mysql = pymysql.connect(MYSQL_HOSTS,MYSQL_USERNAME,MYSQL_PASSWORD,MYSQL_DB)
    cur = conn_mysql.cursor()
    sql = "select offset from t_change_stream_offset where db='%s'" % (database)
    print('getOffset Sql:'+ sql)
    cur.execute(sql)
    result = cur.fetchall()
    if len(result)>0:
        data = result[0][0]
    else:
        data=None
    conn_mysql.close()
    return data

def term_sig_handler(signum, frame):
    print('意外退出更新offset: %d,%s' % (signum,database))
    ts=int(time.time())-300
    setOffset(database,ts)
    sys.exit(1)

def partitionDefine(keyToPartition,numPartitions):
    if keyToPartition is None:
        return random.randint(0, numPartitions-1)
    else:
        return abs(hash(keyToPartition)) %numPartitions

if __name__ == '__main__':
    try:
        mongo_con = pymongo.MongoClient(host=HOST,port=PORT,username=USERNAME,password=PASSWORD)

        signal.signal(signal.SIGTERM, term_sig_handler)
        signal.signal(signal.SIGINT, term_sig_handler)
        hosts_producer_arr=[]
        if ',' in KAFKA_HOSTS:
           hostslist=KAFKA_HOSTS.split(',')
           for i in range(0,len(hostslist)):
              host=hostslist[i].strip()
              hosts_producer_arr.append(host)
        else:
            hosts_producer_arr.append(KAFKA_HOSTS)
        # database = sys.argv[1].split('.')[0]
        database = 'health'
        topic = getTopic(database)
        print(database+'------------->'+str(topic))
        if topic==None:
            raise RuntimeError('Topic为空!')
        offset = getOffset(database)

        if offset==None:
            offset=int(time.time())-300
            setOffset(database,offset)

        print(database+'------------->'+str(offset))
        mongo_db = mongo_con.get_database(database)
        stream = mongo_db.watch(full_document = 'updateLookup',start_at_operation_time=bson.timestamp.Timestamp(int(offset),1))

        producer = KafkaProducer(bootstrap_servers = hosts_producer_arr)
        partition = producer.partitions_for(topic)
        numPartitions = len(partition)

        print('*****************开始发送数据*****************')
        for change in stream:
            msg =bytes(dumps(change,ensure_ascii=False),encoding='utf8')
            jsondata = str(msg,'utf-8')
            text = json.loads(jsondata)
            tb = text['ns']['db']+'.'+text['ns']['coll']
            i =partitionDefine(tb,numPartitions)
            producer.send(msg,partition=i)
    except Exception as e :
        ts=int(time.time())-300
        setOffset(database,ts)
        print(e)
        # producer.close()
        sys.exit(1)