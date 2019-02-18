# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import datetime
import hashlib
import time
import pymysql
from scrapy.conf import settings
from impala.dbapi import connect

'''
----------------  正在爬取 xxx  -------------------
上传图片: xxx.jpg
上传图片: xxx.jpg
insert xxx 
title: md5 
post_date:xxx
插入类型：丁香园 ，对应的：id
----------------------------------------------------
'''
class LcPipeline(object):
    def process_item(self, item, spider):
        name = spider.name
        id = str(item["id"])
        url = item["str_url"]
        source = item["source"]
        title = item["title"]
        content = str(item["content"])
        esc_content = content.replace('\n', ' ')
        esc_content = pymysql.escape_string(esc_content)
        #title = title.replace('"', '\"')
        title = pymysql.escape_string(title)
        createtime = str(item["createTime"])
        dt = item["dt"]
        # wx_data = []
        # wx_data.append((id, url, source, createtime))

        conn = connect(host='192.168.3.158', port=21050)
        cur = conn.cursor()
        print("connect succes")
        print("=======================")
        print("正在写入:" + url)
        print("=======================")
        print("id:" + id)
        print("url:" + url)
        print("source:" + source)
        print("createtime:" + createtime)
        # 使用 cursor() 方法创建一个游标对象 cursor
        try:
            str_sql = 'INSERT INTO ods.ods_article_source (id,url,source,title,content,createtime,dt) values("%s","%s","%s","%s","%s","%s","%s")' %(id, url, source,title, esc_content, createtime, dt)
            cur.execute(str_sql)
        except Exception as e:
            print(e)
        finally:
            cur.close()

        return item



