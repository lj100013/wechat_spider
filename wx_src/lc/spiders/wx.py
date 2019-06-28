# -*- coding: utf-8 -*-
import scrapy
from lc.items import LcItem
import time
import pymongo
from impala.dbapi import connect
import configparser
conf = configparser.ConfigParser()
conf.read("/data/job_pro/utils/config.ini")
IMPALA_HOST=conf.get('impaladb', 'host')
IMPALA_PORT=int(conf.get('impaladb', 'port'))
MONGO_HOST=conf.get('mongo', 'host')
MONGO_PORT=int(conf.get('mongo', 'port'))
MONGO_USER=conf.get('mongo', 'user')
MONGO_PASSWORD=conf.get('mongo', 'password')


class WechatSpider(scrapy.Spider):
    name = "wx"

    def start_requests(self):
        yesterday = int(time.time() - 87600)  # 1533952277
        timeArray = time.localtime(yesterday)
        dt = time.strftime("%Y-%m-%d", timeArray)
        str_time = yesterday * 1000
        time2 = 1420041600000

        ids = []
        conn = connect(host=IMPALA_HOST, port=IMPALA_PORT) 
        cur = conn.cursor()
        # 使用 cursor() 方法创建一个游标对象 cursor
        try:
            str_sql = "select id from ods.ods_article_source" 
            cur.execute(str_sql)
            records = cur.fetchall()
            for record in records:
                id = record[0]
                ids.append(id)
        except Exception as e:
            print(e)
        finally:
            cur.close()

        myclient = pymongo.MongoClient(host=MONGO_HOST, port=MONGO_PORT,username=MONGO_USER,password=MONGO_PASSWORD)
        mydb = myclient["module"]
        mycol = mydb["t_faq_question"]

        for x in mycol.find({"createTime": {"$gt": str_time}, "content.type": 3, "deleted": False},
                            {"_id": 1, "content.articleUrl": 1, "createTime": 1}):

            if str(x["_id"]) in ids:
                continue

            content = x["content"]
            if content:
                str_url = content["articleUrl"]
                pattern = 'mp.weixin.qq.com'
                if pattern in str_url:
                    yield scrapy.Request(url=str_url, callback=self.parse, meta={"id": x["_id"], "createTime": x["createTime"], "urls": str_url, "dt": dt})

    def parse(self, response):
        str_url = response.meta["urls"]
        source = response.xpath('//a[@id="js_name"]/text()').extract_first()
        content = response.xpath('//div[@class="rich_media_content "]').extract_first()
        title = response.xpath('//h2[@class="rich_media_title"]/text()').extract_first()
        if title:
            title = title.strip()
        item = LcItem()
        if source:
            item["id"] = response.meta["id"]
            item["str_url"] = response.meta["urls"]
            item["source"] = source.strip()
            item["title"] = title
            item["content"] = content
            item["createTime"] = response.meta["createTime"]
            item["dt"] = response.meta["dt"]
            yield item
        else:
            href = response.xpath('//div[@class="original_panel_tool"]/a[@id="js_share_source"]/@href').extract_first()
            if href:
                print("respider ****************************** " + href)
                yield scrapy.Request(url=href, callback=self.parse,
                                     meta={"id": response.meta["id"], "createTime": response.meta["createTime"], "urls": href, "dt": response.meta["dt"]})
            else:
                print("null content url: " + response.url)