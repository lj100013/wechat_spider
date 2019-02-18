import time
import pymongo
from bson import Timestamp
from queryUtil import getUserName, getCircleName, getDeptName,getFaq
from dbutil import es, mongoclient, starttime
import logging
import json

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
import time

t = int(time.time())
if starttime != 0:
    t = starttime

oplog = mongoclient.local.oplog.rs
first = oplog.find().sort('$natural', pymongo.ASCENDING).limit(-1).next()
ts = Timestamp(t, 1)
def put_faq_index(data):
    es_data = {}
    es_id = data['_id']
    es_data['id'] = str(es_id)
    es_data['circleId'] = data['publish']['platformId']
    es_data['userid'] = data['userId']

    if 'supplements' in data.get('content') and 'extData' in  data.get('content').get('supplements')[0] and data.get('content').get('supplements')[0].get('extData').get('livingChannel')=='1':
        es_data['src'] = '医生圈平台'
    elif data['publish']['publisherType'] == 1:
        es_data['src'] = getUserName(data['userId'])
    else:
        es_data['src'] = getCircleName(data['publish']['publisher'])
    if 'deptId' in data:
        es_data['dept'] = getDeptName(data['deptId'])
    es_data['content'] = data['content']['summary']
    if 'pics' in data['content']:
        es_data['pic'] = data['content']['pics']
    if data.get('content').get('terminal')=='web' :
        if 'coverUrl' in data['content']:
            es_data['pic'] = data['content']['coverUrl']
    if 'supplements' in data['content'] and 'firstFrame' in data['content']['supplements'][0]:
        es_data['pic'] = data['content']['supplements'][0]['firstFrame']
    es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    if data['type'] == 1:
        es.index(index='search', doc_type='faq', body=es_data, id=es_id)
    elif data['type'] == 2:
        es.index(index='search', doc_type='question', body=es_data, id=es_id)
    elif data['type'] == 3:
        es.index(index='search', doc_type='reward', body=es_data, id=es_id)

while True:
    cursor = oplog.find({'ts': {'$gt': ts}},
                        cursor_type=pymongo.CursorType.TAILABLE_AWAIT,
                        oplog_replay=True)
    while cursor.alive:
        for doc in cursor:
            try:
                ts = doc['ns']
                if ts == 'module.t_faq_question':
                    data = doc['o']
                    # logging.info('faq帖子 Oplog : ' + str(data))
                    if doc['op']=='i' and 'publish' in data:
                        if (data.get('publish').get('platformId') == '10000' and data['deleted'] == False) or (data.get('recommend') == True and data['deleted'] == False):
                            put_faq_index(data)
                    elif doc['op']=='u' and '$set' in data:
                        data=data['$set']
                        es_id=doc['o2']['_id']
                        if 'content' in data:
                            es_data = {}
                            hits=es.search(index="search", body=json.dumps({"query": {"match": {"_id":str(es_id)}}}))
                            if len(hits['hits']['hits'])>0:
                                type=hits['hits']['hits'][0]['_type']
                            content=data['content']['summary']
                            es.update(index='search', doc_type=type, id=es_id,body={'doc':{'content':str(content)}}, ignore=[400, 404])
                        if data.get('recommend') == True or ('deleted' in data and data['deleted']==False):
                            data=getFaq(es_id)
                            put_faq_index(data)
                        elif data.get('deleted') == True or data.get('recommend') == False:
                            hits=es.search(index="search", body=json.dumps({"query": {"match": {"_id":str(es_id)}}}))
                            data=hits['hits']['hits']
                            if hits['hits']['total']>0:
                                type=hits['hits']['hits'][0]['_type']
                                es.delete(index='search', doc_type=type, id=es_id, ignore=[400, 404])
            except Exception as e:
                logging.info(Exception, ":", e)
