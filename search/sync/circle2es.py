from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)
import logging
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
from dbutil import es, mysql_settings, starttime
import time
import random

def main():
    t = int(time.time())
    if starttime != 0:
        t = starttime
    stream = BinLogStreamReader(
        connection_settings=mysql_settings,
        server_id=random.randint(201,300),
        blocking=True,
        only_schemas=['circle'],
        only_tables=['circle'],
        skip_to_timestamp=t,
        only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent])
    for binlogevent in stream:
        try:
            for row in binlogevent.rows:
                if isinstance(binlogevent, DeleteRowsEvent):
                    rowdic = dict(row["values"].items())
                    es_id = rowdic['id']
                    logging.info('圈子删除 [circle] : ' + str(es_id))
                    es.delete(index='search', doc_type='circle', id=es_id, ignore=[400, 404])
                elif isinstance(binlogevent, UpdateRowsEvent):
                    rowdic = dict(row["after_values"].items())
                    if rowdic['flag'] != 1 or rowdic['isprivate'] != 0 or rowdic['type'] != 1:
                        es_id = rowdic['id']
                        logging.info('圈子解散或变更为私密圈子 : ' + str(es_id))
                        es.delete(index='search', doc_type='circle', id=es_id, ignore=[400, 404])
                    elif rowdic['type'] == 1 and rowdic['isprivate'] == 0 and rowdic['flag'] == 1:
                        es_id = rowdic['id']
                        logging.info('更新圈子 [circle] : '+ str(es_id))
                        put2es(rowdic,es_id)
                elif isinstance(binlogevent, WriteRowsEvent):
                    rowdic = dict(row["values"].items())
                    if rowdic['type'] == 1 and rowdic['isprivate'] == 0 and rowdic['flag'] == 1:
                        es_id = rowdic['id']
                        logging.info('新增圈子 [circle] : '+ str(es_id))
                        # put2es(rowdic,es_id)
        except Exception as e:
            logging.info(Exception, ":", e)
    stream.close()

def put2es(rowdic,es_id):
    es_data = {}
    es_data['circlename'] = rowdic['name']
    mname=[]
    mastername= rowdic['masterName']
    for k,v in eval(mastername).items():
        mname.append(str(v))
    es_data['id'] = str(es_id)
    es_data['src'] = ','.join(mname)
    es_data['dept'] = rowdic['deptNames']
    es_data['caption'] = rowdic['introduction']
    es_data['pic'] = rowdic['logo']
    es_data['memberCount'] = rowdic['memberCount']
    es_data['masterCount'] = rowdic['masterCount']
    es_data['managerCount'] = rowdic['managerCount']
    es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    es.index(index='search', doc_type='circle', body=es_data, id=es_id)

if __name__ == "__main__":
    main()
