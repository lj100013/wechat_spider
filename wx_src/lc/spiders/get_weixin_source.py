# -*- coding:utf-8 -*-
import sys
import re
import requests
import pymysql
from lxml import etree
import pymongo
import time
from impala.dbapi import connect
import urllib3
import configparser
import pyodbc
urllib3.disable_warnings()

yesterday = int(time.time() - 87600) # 1533952277
timeArray = time.localtime(yesterday)
dt = time.strftime("%Y-%m-%d", timeArray)
str_time = yesterday * 1000
time2 = 1420041600000

conf = configparser.ConfigParser()
# conf.read(r"D:\\job_script\\utils\\config.ini")
conf.read("/data/job_pro/utils/config.ini")
HOST=conf.get('impaladb', 'host')
PORT=int(conf.get('impaladb', 'port'))

mongo_host = conf.get('mongo', 'host')
mongo_port = conf.getint('mongo', 'port')
mongo_user = conf.get('mongo', 'user')
mongo_password = conf.get('mongo', 'password')
mongo_authentication = conf.get('mongo', 'authentication')

myclient = pymongo.MongoClient(host=mongo_host, port=mongo_port,username=mongo_user,password=mongo_password)
mydb = myclient["module"]
mycol = mydb["t_faq_question"]

ids = []

# cnxnstr = "DSN=Sample Cloudera Impala DSN;HOST=%s;PORT=%s;UID=hive;AuthMech=3;PWD=hive;UseSasl=0" % (HOST,PORT)
cnxnstr = "Driver={/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so};HOST=%s;PORT=%s;UID=hive;AuthMech=3;PWD=hive;UseSasl=0" % (HOST,PORT)
conn = pyodbc.connect(cnxnstr, autocommit=True,timeout=240)
cur = conn.cursor()
# 使用 cursor() 方法创建一个游标对象 cursor
try:
    str_sql = "select id from ods.ods_article_source where title =''"
    cur.execute(str_sql)
    records = cur.fetchall()
    for record in records:
        id = record[0]
        ids.append(id)
except Exception as e:
    print(e)
finally:
    cur.close()

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"}
#wx_data = []
for x in mycol.find({"createTime": {"$gt": str_time}, "content.type": 3, "deleted": False}, {"_id": 1, "content.articleUrl": 1, "createTime": 1}):
    str_id = x["_id"]
    if str(str_id) in ids:
        continue
    content = x["content"]
    createTime = x["createTime"]
    if content:
        url = content["articleUrl"]
        if url:
            pattern = 'mp.weixin.qq.com'
            if pattern not in url:
                source = ''
                if '.cn' in url:
                    source = url.split('.cn')[0] + '.cn'
                elif '.com' in url:
                    source = url.split('.com')[0] + '.com'
                elif '.net' in url:
                    source = url.split('.net')[0] + '.net'
                else:
                    source = url[0:20]
                #wx_data.append((str(str_id), content["articleUrl"], source, str(createTime), dt))
                print(url)
                self_site = 'http://community.file.dachentech.com.cn'
                if self_site in url:
                    continue

                try:
                    rsp = requests.get(url=url, headers=headers, verify=False, timeout=20).text
                except:
                    print("null url:" + url)
                    continue

                esc_content = str(rsp).replace('\n', '')
                esc_content = esc_content.replace('\r', '')
                esc_content = pymysql.escape_string(esc_content)
                print("insert " + source)

                cnxnstr = "Driver={/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so};HOST=%s;PORT=%s;UID=hive;AuthMech=3;PWD=hive;UseSasl=0" % (HOST,PORT)
                conn = pyodbc.connect(cnxnstr, autocommit=True,timeout=240)
                cur = conn.cursor()
                # 使用 cursor() 方法创建一个游标对象 cursor
                try:
                    #print("insert data id:" + str(str_id))
                    str_sql = 'INSERT INTO ods.ods_article_source (id,url,source,title,content,createtime,dt) values("%s","%s","%s","%s","%s","%s","%s")' % (str(str_id), str(url), source, '',esc_content,str(createTime), dt)
                    cur.execute(str_sql)
                    #cur.executemany("INSERT INTO kudu_db.dw_article_source (id,url,source,createtime,dt) values(%s,%s,%s,%s,%s)", wx_data)
                except Exception as e:
                    print(e)
                finally:
                    cur.close()

