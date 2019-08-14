#coding:utf-8
import time
import logging
def formate_date(create_date):
    timestamp = create_date.replace("document.write(timeConvert('", '').replace("'))","")
    try:
        timestamp = int(timestamp)
    except Exception as e:
        logging.error("failed to convert date format:{}".format(e))
        timestamp = int(time.time())
    timeArray = time.localtime(timestamp)
    date_time = time.strftime("%Y-%m-%d %H:%M:%S", timeArray)
    return date_time

