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


class LcPipeline(object):
    def process_item(self, item, spider):
        name = spider.name
        id = item["gid"]
        host = settings['MYSQL_HOST']
        user = settings['MYSQL_USER']
        psd = settings['MYSQL_PASSWORD']
        db = settings['MYSQL_DB']
        c = settings['CHARSET']
        port = settings['MYSQL_PORT']
        # 数据库连接
        con = pymysql.connect(host=host, user=user, passwd=psd, db=db, charset=c, port=port)
        # 数据库游标
        cue = con.cursor()
        print("mysql connect succes")  # 测试语句，这在程序执行时非常有效的理解程序是否执行到这一步
        # sql="insert into gamerank (rank,g_name,g_type,g_status,g_hot) values(%s,%s,%s,%s,%s)" % (item['rank'],item['game'],item['type'],item['status'],item['hot'])
        try:
            cue.execute(
                "insert into wp_posts (post_author,post_date,post_date_gmt,post_content,post_title,post_status,post_name,guid,author,key_word,source) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                ["1", item["create_time"], item["create_time"], item["content"], item["title"], "publish", id, id, item["author"],item["key_word"], item["source"],])
            if name == "jam":
                cue.execute(
                    " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),10,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            # 97 组图秀，98 信息图表 99 生物漫画
            elif name == "sw360":
                if item["wxname"] == "7":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),31,0 from wp_posts limit 1")
                    print("insert success")  # 测试语句
                if item["wxname"] == "97":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),32,0 from wp_posts limit 1")
                    print("insert success")  # 测试语句
                if item["wxname"] == "98":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),33,0 from wp_posts limit 1")
                    print("insert success")  # 测试语句
                if item["wxname"] == "99":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),34,0 from wp_posts limit 1")
                    print("insert success")  # 测试语句
            elif name == "ykd_bl":
                cue.execute(
                    " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),8,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            elif name == "ymt_zn":
                cue.execute(
                    " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),6,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            elif name == "ykd_zn":
                cue.execute(
                    "INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),7,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            elif name == "ys":
                if item["wxname"] == "壹生资讯":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),35,0 from wp_posts limit 1")
                    print("insert success")  # 测试语句
                if item["wxname"] == "壹生视频":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),36,0 from wp_posts limit 1")
                    print("insert success")  # 测试语句
            elif name == "dxzh":
                cue.execute(
                    " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),30,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            elif name == "yxqy":
                cue.execute(
                    " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),37,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            elif name == "zlys":
                cue.execute(
                    " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),23,0 from wp_posts limit 1")
                print("insert success")  # 测试语句
            elif name == "wx":
                print("=========================================================")
                if item["wxname"] == "影像园":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),14,0 from wp_posts limit 1")
                    print("微信insert success")  # 测试语句
                if item["wxname"] == "好医生":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),13,0 from wp_posts limit 1")
                    print("微信insert success")  # 测试语句
                if item["wxname"] == "丁香园":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),3,0 from wp_posts limit 1")
                    print("微信insert success")  # 测试语句
                if item["wxname"] == "看医界":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),9,0 from wp_posts limit 1")
                    print("微信insert success")  # 测试语句
                if item["wxname"] == "医学界消化肝病频道":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),12,0 from wp_posts limit 1")
                    print("微信insert success")  # 测试语句
                if item["wxname"] == "小大夫漫画":
                    cue.execute(
                        " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),11,0 from wp_posts limit 1")
                    print("微信insert success")  # 测试语句
        except Exception as e:
            print('Insert error:', e)
            con.rollback()
        else:
            con.commit()
        con.close()
        return item



