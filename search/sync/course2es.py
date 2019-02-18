from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)
import json
from queryUtil import getClassLable
from dbutil import es, mysql_settings, starttime
import logging

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
import time
import random

def main():
    t = int(time.time())
    if starttime != 0:
        t = starttime
    stream = BinLogStreamReader(
        connection_settings=mysql_settings,
        server_id=random.randint(301,400),
        blocking=True,
        only_schemas=['circle_school'],
        only_tables=['t_course'],
        skip_to_timestamp=t,
        only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent]
    )
    for binlogevent in stream:
        try:
            for row in binlogevent.rows:
                if isinstance(binlogevent, DeleteRowsEvent):
                    rowdic = dict(row["values"].items())
                    es_id = rowdic['courseId']
                    logging.info('删除课程 :' + es_id)
                    es.delete(index='search', doc_type='course', id=es_id, ignore=[400, 404])
                elif isinstance(binlogevent, UpdateRowsEvent):
                    rowdic = dict(row["after_values"].items())
                    es_id = rowdic['courseId']
                    if rowdic['status'] in (1, 2, 9):
                        logging.info("更新课程:" + es_id)
                        put2es(rowdic, es_id)
                    else:
                        es.delete(index='search', doc_type='course', id=es_id, ignore=[400, 404])
                elif isinstance(binlogevent, WriteRowsEvent):
                    rowdic = dict(row["values"].items())
                    if 'status' in rowdic and 'courseId' in rowdic and rowdic['status'] in (1, 2, 9):
                        es_id = rowdic['courseId']
                        logging.info("新增课程:" + es_id)
                        put2es(rowdic, es_id)
        except Exception as e:
            logging.info(Exception, ":", e)
    stream.close()


def put2es(rowdic, es_id):
    es_data = {}
    es_data['id'] = str(es_id)
    es_data['userid'] = rowdic['ownerId']
    es_data['classid'] = rowdic['classId']
    es_data['src'] = rowdic['ownerName']
    es_data['dept'] = rowdic['ownerDeptName']
    es_data['label'] = getClassLable(rowdic['courseId'])
    es_data['caption'] = rowdic['theme']
    es_data['pic'] = rowdic['coverImgUrl']
    es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    es.index(index='search', doc_type='course', body=es_data, id=es_id)
if __name__ == "__main__":
    main()
