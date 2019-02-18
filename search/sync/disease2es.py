import pymongo
from bson import Timestamp
from dbutil import es,mongoclient,starttime

oplog = mongoclient.local.oplog.rs
first = oplog.find().sort('$natural', pymongo.ASCENDING).limit(-1).next()
import logging
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
import time
from queryUtil import getdisease_pics,getdisease

t = int(time.time())
if starttime != 0:
    t = starttime
ts = Timestamp(t, 1)

def putdis2es(es_id,data):
    es_data = {}
    es_data['circleId']='10000'
    if 'authCircleName'in data:
        es_data['src']=data['authCircleName']
    else:
        es_data['src']=data['userName']
    es_data['dept']=data['userDept']
    es_data['caption']=data['title']
    pics=getdisease_pics(es_id);
    es_data['pic']=pics
    labels=[]
    if 'labelList' in data:
        for item in data['labelList']:
            labels.append(item['name'])
    es_data['id'] = str(es_id)
    es_data['label']=','.join(labels)
    es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    es.index(index='search', doc_type='disease', body=es_data, id=es_id)

while True:
    cursor = oplog.find({'ts': {'$gt': ts}},
                        cursor_type=pymongo.CursorType.TAILABLE_AWAIT,
                        oplog_replay=True)
    while cursor.alive:
        for doc in cursor:
            try:
                ns = doc['ns']
                if ns == 'diseasediscuss.disease_info':
                    data = doc['o']
                    # logging.info('病例讨论 oplog : '+str(data))
                    if doc['op']=='i':
                        if 'circleId' not in data and 'hide' not in data and data['status']==1:
                            es_id = data['_id']
                            putdis2es(es_id,data)
                    elif doc['op']=='u' and '$set' in data:
                        data=data['$set']
                        if data.get('recommend')==True:
                            es_id=doc['o2']['_id']
                            mdata=getdisease(es_id)
                            putdis2es(es_id,mdata)
                        if 'hide' in data or ('status' in data and data.get('status')!=1) or data.get('recommend')==False:
                            es_id=doc['o2']['_id']
                            es.delete(index='search', doc_type='disease', id=es_id,ignore=[400, 404])

            except Exception as e:
                logging.info(Exception, ":", e)