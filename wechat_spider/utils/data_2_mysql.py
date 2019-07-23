# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import pymysql
import configparser
import logging
conf = configparser.ConfigParser()
# conf.read(r"F:\bigdata_project\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
HOST=conf.get('weixin', 'host')
PORT=int(conf.get('weixin', 'port'))
USER=conf.get('weixin', 'username')
PASSWORD=conf.get('weixin', 'password')
DB=conf.get('weixin', 'database')
CHARSET=conf.get('weixin', 'charset')

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


def process_item(item,appname):
    # 数据库连接
    con = pymysql.connect(host=HOST, user=USER, passwd=PASSWORD, db=DB, charset=CHARSET, port=PORT)
    # 数据库游标
    cue = con.cursor()
    # get term_id
    term_id = ''
    str_sql = "SELECT term_id FROM wp_terms where name = '%s'" % (item["wxname"])
    cue.execute(str_sql)
    result = cue.fetchall()
    if len(result) == 1:
        term_id = result[0]
    ysq_identify = 'Y' if appname == 'ysq' else 'N'
    yyr_identify = 'Y' if appname == 'yyr' else 'N'
    remark = "<br />注：本网所有转载内容系出于传递信息之目的，且明确注明来源和/或作者，不希望被转载的媒体或个人可与我们联系，我们将立即进行删除处理，所有内容及观点仅供参考，不构成任何诊疗建议，对所引用信息的准确性和完整性不作任何保证"
    item["content"] = str(item["content"]) + remark
    try:
        cue.execute(
            "insert into wp_posts (post_author,post_date,post_date_gmt,post_content,post_title,post_status,post_name,guid,author,dept,source,ysq,yyr) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            ["1", item["create_time"], item["create_time"], item["content"], item["title"], "publish", item["gid"], item["gid"],
             item["author"], item["key_word"], item["wxname"],ysq_identify,yyr_identify])
        if term_id:
            str_sql = "INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),%s,0 from wp_posts limit 1" % (term_id)
            cue.execute(str_sql)
        logging.warning("sucess to write into mysql:{}-----{}".format(item["title"],item["wxname"]))
    except Exception as e:
        logging.error('Insert error:', e)
        con.rollback()
    else:
        con.commit()
    con.close()
    return item

# 数据库去重操作(传入guid)
def is_exists(guid,appname):
    # 数据库连接
    con = pymysql.connect(host=HOST, user=USER, passwd=PASSWORD, db=DB, charset=CHARSET, port=PORT)
    # 数据库游标
    _end = con.cursor()
    try:
        _end.execute("SELECT post_name FROM wp_posts where guid = '%s'" % (guid))
        result = _end.fetchall()
        if len(result) > 0:
            _end.execute("update wp_posts set %s='Y' where guid = '%s'" % (appname,guid))
            return True
        else:
            return False
    except Exception as e:
        logging.error('Insert error:', e)
    finally:
        con.commit()
        con.close()

