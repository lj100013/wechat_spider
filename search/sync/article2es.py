from pymysqlreplication import BinLogStreamReader
import logging
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)
import json
from dbutil import es, mysql_settings, starttime
import time
import random

def main():
    t = int(time.time())
    if starttime != 0:
        t = starttime
    stream = BinLogStreamReader(
        connection_settings=mysql_settings,
        server_id=random.randint(100,200),
        blocking=True,
        only_schemas=['medicine-literature'],
        only_tables=['articleInfo'],
        skip_to_timestamp=t,
        only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent])
    for binlogevent in stream:
        for row in binlogevent.rows:
            try:
                event = {"schema": binlogevent.schema, "table": binlogevent.table,"log_pos": binlogevent.packet.log_pos}
                if isinstance(binlogevent, DeleteRowsEvent):
                    rowdic = dict(row["values"].items())
                    es_id = rowdic['articleID']
                    logging.error('删除文献 [article] : ' + es_id)
                    es.delete(index='search', doc_type='article', id=es_id, ignore=[400, 404])
                elif isinstance(binlogevent, UpdateRowsEvent):
                    event["action"] = "update"
                    event["before_values"] = dict(row["before_values"].items())
                    event["after_values"] = dict(row["after_values"].items())
                    event = dict(event.items())
                    logging.error('数据异常更新:' + json.dumps(event))
                elif isinstance(binlogevent, WriteRowsEvent):
                    rowdic = dict(row["values"].items())
                    es_data = {}
                    es_id = rowdic['articleID']
                    es_data['id'] = str(es_id)
                    es_data['label'] = rowdic['keyWords']
                    es_data['caption'] = rowdic['title']
                    es_data['type'] = rowdic['type']
                    es_data['updatetime'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
                    logging.info('新增文献 [article] : ' + es_id + ' : ' + str(es_data))
                    es.index(index='search', doc_type='article', body=es_data, id=es_id)
            except Exception as e:
                logging.info(Exception, ":", e)
    stream.close()


if __name__ == "__main__":
    main()
