# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import pymysql

from nowscrawl import settings


class NowscrawlPipeline(object):
    def process_item(self, item, spider):
        host = settings.MYSQL_HOST
        user = settings.MYSQL_USER
        psd = settings.MYSQL_PASSWORD
        db = settings.MYSQL_DB
        c = settings.CHARSET
        port = settings.MYSQL_PORT
        #数据库连接
        con = pymysql.connect(host=host, user=user, passwd=psd, db=db, charset=c, port=port)
        # 数据库游标
        cue = con.cursor()
        print("mysql connect succes")  # 测试语句，这在程序执行时非常有效的理解程序是否执行到这一步
        print("正在爬取:" + item["post_title"])
        print("{}：insert success".format(item["post_title"]))
        print("插入来源：{} ".format(item["source"]))
        try:
            cue.execute(
                "insert into wp_article_posts (post_content,post_title,post_name,first_author,author,key_word,source,organization,post_year) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                [ item["post_content"],item["post_title"], item["post_name"], item["first_author"], item["author"],
                 item["key_word"], item["source"], item["organization"], str(item["article_year"])])
            print("insert success")  # 测试语句
        except Exception as e:
            print('Insert error:', e)
            con.rollback()
        else:
            con.commit()
        con.close()
        return item
