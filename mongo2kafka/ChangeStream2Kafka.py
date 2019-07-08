# -*- coding:utf-8 -*-
import bson
import pymongo
import pymysql
import sys
from bson.json_util import dumps
from pykafka import KafkaClient
import configparser
import time
import signal
import logging
import logging.handlers
formatter = logging.Formatter("%(asctime)s %(name)s %(levelname)s %(message)s")
handler1 = logging.StreamHandler()
handler1.setFormatter(formatter)
logger = logging.getLogger("logger")
logger.setLevel(logging.INFO)
logger.addHandler(handler1)

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

database = sys.argv[1].split('.')[0]
# database = 'health'

def getTopic(database):
    conn_mysql = pymysql.connect(MYSQL_HOSTS,MYSQL_USERNAME,MYSQL_PASSWORD,MYSQL_DB)
    cur = conn_mysql.cursor()
    sql="select topic from t_change_stream_kafka where db='%s'" % (database)
    logger.info('getTpoic Sql: '+sql)
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
    logger.info('update offset Sql : '+sql)
    cur.execute(sql)
    cur.close()

def getOffset(database):
    conn_mysql = pymysql.connect(MYSQL_HOSTS,MYSQL_USERNAME,MYSQL_PASSWORD,MYSQL_DB)
    cur = conn_mysql.cursor()
    sql = "select offset from t_change_stream_offset where db='%s'" % (database)
    logger.info('getOffset Sql:'+ sql)
    cur.execute(sql)
    result = cur.fetchall()
    if len(result)>0:
        data = result[0][0]
    else:
        data=None
    conn_mysql.close()
    return data

def term_sig_handler(signum, frame,database):
    logging.info('意外退出更新offset: %d' % signum)
    ts=int(time.time())-10000
    setOffset(database,ts)
    sys.exit(1)

mongo_con = pymongo.MongoClient(host=HOST,port=PORT,username=USERNAME,password=PASSWORD)
kafka_client = KafkaClient(hosts = KAFKA_HOSTS)


if __name__ == '__main__':
    try:
        signal.signal(signal.SIGTERM, term_sig_handler,database)
        signal.signal(signal.SIGINT, term_sig_handler,database)

        topic = getTopic(database)
        logger.info(database+'------------->'+str(topic))
        if topic==None:
            raise RuntimeError('Topic为空!')
        offset = getOffset(database)
        if offset==None:
            offset=int(time.time())-10000
            setOffset(database,offset)
        logger.info(database+'------------->'+str(offset))
        mongo_db = mongo_con.get_database(database)
        stream = mongo_db.watch(full_document = 'updateLookup',start_at_operation_time=bson.timestamp.Timestamp(int(offset),1))

        tp = kafka_client.topics[topic]
        producer = tp.get_producer()
        for change in stream:
            msg =bytes(dumps(change,ensure_ascii=False),encoding='utf8')
            # print(msg)
            producer.produce( msg)
    except Exception as e :
        ts=int(time.time())-10000
        setOffset(database,ts)
        logger.error(e)
        # producer.close()
        sys.exit(1)