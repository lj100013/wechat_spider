# -*- coding:utf-8 -*-
import pymongo
from bson.json_util import dumps
from kafka import KafkaProducer

mongo_con = pymongo.MongoClient(host='192.168.3.251',port=27017,username='admin',password='admin')
producer = KafkaProducer(bootstrap_servers=['192.168.3.121:9092'])

mongo_db = mongo_con.module
mongo_collection = mongo_db.t_faq_question
mongo_cluster = mongo_collection.watch(full_document = 'updateLookup')
for change in mongo_cluster:
    msg =bytes(dumps(change,ensure_ascii=False),encoding='utf8')
    producer.send('test_mongo', msg, partition=0)
    # producer.close()

