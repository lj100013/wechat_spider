# -*- coding:utf-8 -*-
import bson
import pymongo
import sys
from bson.json_util import dumps
from pykafka import KafkaClient
import configparser

conf = configparser.ConfigParser()
# conf.read(r"D:\job_script\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
HOST = conf.get('mongo2', 'host')
PORT = int(conf.get('mongo2', 'port'))
USERNAME = conf.get('mongo2', 'user')
PASSWORD = conf.get('mongo2', 'password')
KAFKA_HOSTS = conf.get('kafka', 'hosts')
KAFKA_TOPIC = conf.get('kafka', 'topic')

database = sys.argv[1].split('.')[0]
table = sys.argv[1].split('.')[1]
# topic = sys.argv[3]
ts = sys.argv[2]

mongo_con = pymongo.MongoClient(host=HOST,port=PORT,username=USERNAME,password=PASSWORD)
kafka_client = KafkaClient(hosts = KAFKA_HOSTS)
topicdocu = kafka_client.topics[KAFKA_TOPIC]
producer = topicdocu.get_producer()

mongo_db = mongo_con.get_database(database)
mongo_collection = mongo_db.get_collection(table)
mongo_cluster = mongo_collection.watch(full_document = 'updateLookup',start_at_operation_time=bson.timestamp.Timestamp(int(ts),1))
for change in mongo_cluster:
    msg =bytes(dumps(change,ensure_ascii=False),encoding='utf8')
    # print(msg)
    producer.produce( msg)
    # producer.close()