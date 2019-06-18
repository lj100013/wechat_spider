# -*- coding:utf-8 -*-
import bson
import pymongo
import sys
from bson.json_util import dumps
from kafka import KafkaProducer
import configparser

conf = configparser.ConfigParser()
# conf.read(r"D:\job_script\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
HOST=conf.get('mongo2', 'host')
PORT=int(conf.get('mongo2', 'port'))
USERNAME=conf.get('mongo2', 'user')
PASSWORD=conf.get('mongo2', 'password')

database = sys.argv[1].split('.')[0]
table = sys.argv[1].split('.')[1]
# topic = sys.argv[3]
ts = sys.argv[2]

mongo_con = pymongo.MongoClient(host=HOST,port=PORT,username=USERNAME,password=PASSWORD)
producer = KafkaProducer(bootstrap_servers=['192.168.3.121:9092'])

mongo_db = mongo_con.get_database(database)
mongo_collection = mongo_db.get_collection(table)
mongo_cluster = mongo_collection.watch(full_document = 'updateLookup',start_at_operation_time=bson.timestamp.Timestamp(int(ts),1))
for change in mongo_cluster:
    msg =bytes(dumps(change,ensure_ascii=False),encoding='utf8')
    # print(msg)
    producer.send('test_mongo2kudu', msg, partition=0)
    # producer.close()


