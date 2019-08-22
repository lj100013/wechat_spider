import time
import pymongo
from bson import Timestamp
from dbutil import es, mongoclient,starttime
from queryUtil import get_suspend_user
import sys

import logging
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
import time

db = mongoclient['health']
skcol = db['b_disease_type']

oplog = mongoclient.local.oplog.rs
first = oplog.find().sort('$natural', pymongo.ASCENDING).limit(-1).next()
t = int(time.time())
if starttime != 0:
    t = starttime
ts = Timestamp(t, 1)

def packrow(data):
    if data.get('suspend')!=4:
        es_data['id'] = str(es_id)
        es_data['src'] = data['name']
        if 'hospital' in data['doctor']:
            es_data['hospital'] = data['doctor']['hospital']
        if 'departments' in data['doctor']:
            es_data['dept'] = data['doctor']['departments']
        if 'title' in data['doctor']:
            es_data['title'] = data['doctor']['title']
        if 'expertise' in data['doctor']:
            skList = data['doctor']['expertise']
            skStr = []
            if skList:
                for skcode in skList:
                    row = skcol.find_one({"_id": skcode})
                    if row == None:
                        break
                    skStr.append(row['name'])
            es_data['expertise'] = ','.join(skStr)
        else:
            es_data['expertise'] = ''
        if 'headPicFileName' in data:
            es_data['pic'] = data['headPicFileName']
        elif data.get('sex')==2:
            es_data['pic'] = 'https://default.file.dachentech.com.cn/user/head_icon_women.png'
        else:
            es_data['pic'] = 'https://default.file.dachentech.com.cn/user/head_icon_men.png'
        es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        return es_data

while True:
    cursor = oplog.find({'ts': {'$gt': ts}},
                        cursor_type=pymongo.CursorType.TAILABLE_AWAIT,
                        oplog_replay=True)
    while cursor.alive:
        for doc in cursor:
            try:
                ts = doc['ns']
                if ts == 'health.user':
                    es_data = {}
                    # logging.info(doc)
                    data=doc['o']
                    if doc['op'] == 'i' or (doc['op']=='u' and '$set' not in data):
                        es_id = doc['o']['_id']
                        if data['userType'] == 3 and 'doctor' in data:
                            es_data=packrow(data);
                            es.index(index='search', doc_type='user', body=es_data, id=es_id)
                    if doc['op'] == 'u' and '$set' in data:
                        es_id = doc['o2']['_id']
                        data=data['$set']
                        if 'suspend' in data and data['suspend']==4:
                            logging.info('禁用用户:'+str(es_id))
                            row = get_suspend_user(es_id)
                            name=row['name']
                            logging.info('禁用用户:'+str(es_id)+'-'+name)
                            es.delete(index='search', doc_type='user', id=es_id,ignore=[400, 404])
                        if 'suspend' in data and data['suspend'] ==0:
                            row=get_suspend_user(es_id)
                            es_data=packrow(row)
                            es.index(index='search', doc_type='user', body=es_data, id=es_id)
                        if 'name' in data:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'src':data['name']}}, ignore=[400, 404])
                        if 'doctor.hospital' in data:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'hospital':data['doctor.hospital']}}, ignore=[400, 404])
                        if 'doctor.departments' in data:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'dept':data['doctor.departments']}}, ignore=[400, 404])
                        if 'doctor.title' in data:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'title':data['doctor.title']}}, ignore=[400, 404])
                        if 'headPicFileName' in data:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'pic':data['headPicFileName']}}, ignore=[400, 404])
                        if data.get('sex')==2:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'pic':'https://default.file.dachentech.com.cn/user/head_icon_women.png'}}, ignore=[400, 404])
                        elif data.get('sex')==1:
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':{'pic':'https://default.file.dachentech.com.cn/user/head_icon_men.png'}}, ignore=[400, 404])
                        if 'doctor.expertise' in data:
                            skList = data['doctor.expertise']
                            skStr = []
                            if skList:
                                for skcode in skList:
                                    row = skcol.find_one({"_id": skcode})
                                    if row == None:
                                        break
                                    skStr.append(row['name'])
                            es_data['expertise'] = ','.join(skStr)
                            es.update(index='search', doc_type='user', id=es_id,body={'doc':es_data}, ignore=[400, 404])

            except Exception as e:
                logging.error(Exception, ":", doc)
                logging.info(Exception, ":", e)
                sys.exit(1)
