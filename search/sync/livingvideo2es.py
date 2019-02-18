from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)
import json
from queryUtil import getDeptName, getLivingId,getlivingdesc
from dbutil import es, mysql_settings, starttime
import logging

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
import time
import random

def putliving(rowdic):
    es_id = rowdic['id']
    es_data = {}
    es_data['id'] = str(es_id)
    es_data['circleId'] = rowdic['circleId']
    es_data['userid'] = rowdic['speakerId']
    # es_data['username'] = rowdic['speakerInfo']
    es_data['src'] = rowdic['speakerInfo']
    es_data['dept'] = rowdic['deptName']
    if rowdic.get('description')!='':
        es_data['content'] = rowdic['description']
    else:
        es_data['content'] =getlivingdesc(es_id)
    es_data['caption'] = rowdic['subject']
    es_data['pic'] = rowdic['coverUrl']
    es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    es.index(index='search', doc_type='living', body=es_data, id=es_id)

def putvideo(rowdic):
    es_id = rowdic['id']
    es_data = {}
    livingid = getLivingId(rowdic['webcastId'])
    if livingid and livingid[0] != '':
        es_data['id'] = str(es_id)
        es_data['livingid'] = livingid[0]
        es_data['circleId'] = rowdic['circleId']
        # es_data['username'] = rowdic['speakerInfo']
        es_data['src'] = rowdic['speakerInfo']
        es_data['dept'] = getDeptName(rowdic['deptId'])
        es_data['content'] = rowdic['description']
        es_data['caption'] = rowdic['subject']
        es_data['pic'] = rowdic['coverUrl']
        es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        es.index(index='search', doc_type='living_video', body=es_data, id=es_id)

def main():
    t = int(time.time())
    if starttime != 0:
        t = starttime
    print(t)
    stream = BinLogStreamReader(
        connection_settings=mysql_settings,
        server_id=random.randint(401, 500),
        blocking=True,
        only_schemas=['circle'],
        skip_to_timestamp=t,
        only_tables=['circle_living', 'circle_living_vedio'],
        only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent])

    for binlogevent in stream:
        for row in binlogevent.rows:
            try:
                event = {"schema": binlogevent.schema, "table": binlogevent.table, "log_pos": binlogevent.packet.log_pos}
                if isinstance(binlogevent, DeleteRowsEvent):
                    rowdic = dict(row["values"].items())
                    es_id = rowdic['id']
                    logging.error('直播或录播物理删除:' + str(es_id))
                    es.delete(index='search', doc_type='living', id=es_id,ignore=[400, 404])
                elif isinstance(binlogevent, UpdateRowsEvent):
                    event["action"] = "update"
                    event["before_values"] = dict(row["before_values"].items())
                    event["after_values"] = dict(row["after_values"].items())
                    rowdic = dict(row["after_values"].items())
                    if rowdic.get('deleteFlag') == 1 or (rowdic.get('recommend') == 0 and rowdic.get('hallFlag') == 0 ) or  rowdic.get('action' == 105) or  rowdic.get('publishFlag')==0:
                        es_id = rowdic['id']
                        if binlogevent.table == 'circle_living':
                            logging.info("直播结束或标记删除:" + str(es_id))
                            es.delete(index='search', doc_type='living', id=es_id, ignore=[400, 404])
                        if binlogevent.table == 'circle_living_vedio':
                            logging.info("录播标记删除:" + str(es_id))
                            es.delete(index='search', doc_type='video', id=es_id, ignore=[400, 404])
                    if  rowdic.get('publishFlag')==1:
                        if binlogevent.table == 'circle_living' and (rowdic.get('recommend') == 1 or rowdic.get('hallFlag') == 1):
                            putliving(rowdic)
                        if binlogevent.table == 'circle_living_vedio' and rowdic.get('recommend') == 1:
                            putvideo(rowdic)

                elif isinstance(binlogevent, WriteRowsEvent):
                    rowdic = dict(row["values"].items())
                    if binlogevent.table == 'circle_living':
                        if (rowdic.get('circleId') =='10000' or rowdic.get('hallFlag') == 1 or rowdic.get('recommend') == 1) and rowdic.get('publishFlag')==1:
                            putliving(rowdic)
                    if binlogevent.table == 'circle_living_vedio':
                        if (rowdic.get('circleId') == '10000' or rowdic.get('recommend') == 1) and rowdic.get('publishFlag')==1 :
                            putvideo(rowdic)
            except Exception as e:
                logging.info(Exception, ":", e)
    stream.close()


if __name__ == "__main__":
    main()
