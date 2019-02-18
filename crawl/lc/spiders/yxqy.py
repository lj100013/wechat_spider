# -*- coding: utf-8 -*-
from lc.youdu_sever import *
import json
import time
import scrapy
from lc.items import LcItem


class YxqySpider(scrapy.Spider):
    name = 'yxqy'
    allowed_domains = ['nejmqianyan.cn']
    start_urls = ['http://nejmqianyan.cn/']

    def start_requests(self):
        # form_data={"limit":"1000","page":"1"}
        self.data_list = database_filter("37")
        base_url = "http://www.nejmqianyan.cn/?n=api&a=article&c=article&m=weekly&token=a88e236251e7eaebd384b78fe773515a&memberid=23717&time=1533620534&kappversion=1.6.2&kbuild=0929&kappIdentifier=cn.nejmyxqy.app"
        yield scrapy.Request(url=base_url)

    def parse(self, response):
        rsp = json.loads(response.text)
        ids = [node["id"] for node in rsp["Data"] if
               time.strftime("%Y", time.localtime(int(node["thedate"]))) == "2018"]
        url = "http://www.nejmqianyan.cn/?n=api" \
              "&a=article" \
              "&c=article" \
              "&m=weekly_article" \
              "&token=cd90dee3fdb7aa460f90b11073a5bc19" \
              "&memberid=23717" \
              "&time=1533622994" \
              "&kappversion=1.6.2" \
              "&kbuild=0929" \
              "&kappIdentifier=cn.nejmyxqy.app"
        formdata = {"weeklyid": "131", "page": "1", "orderby": "id", "ordertype": "desc", "limit": "2000"}
        for iid in ids:
            formdata["weeklyid"] = str(iid)
            data = json.dumps(formdata)
            yield scrapy.Request(url=url, body=data, method='POST', dont_filter=True, callback=self.detail)

    def detail(self, response):
        rsps = json.loads(response.text)
        datas = [id["id"] for id in rsps["Data"]]
        for i in datas:
            content_url = "http://www.nejmqianyan.cn/?n=api" \
                          "&a=article" \
                          "&c=article" \
                          "&m=detail" \
                          "&id={}" \
                          "&token=38183dc64672bedd40dda808305dbc92" \
                          "&memberid=23717" \
                          "&time=1533622553" \
                          "&kappversion=1.6.2" \
                          "&kbuild=0929" \
                          "&kappIdentifier=cn.nejmyxqy.app".format(str(i))
            yield scrapy.Request(url=content_url, callback=self.parse_content)

    def parse_content(self, response):
        item = LcItem()
        datas = json.loads(response.text)
        if datas["Data"]:
            item["title"] = datas["Data"]["title"]
            item["author"] = datas["Data"]["author"]
            item["key_word"] = datas["Data"]["keyword_search"]
            item["source"] = datas["Data"]["sourcename"]
            timeArray = time.localtime(int(datas["Data"]["pubdate"]))
            create_time = time.strftime("%Y-%m-%d ", timeArray)
            item["create_time"] = create_time
            item["gid"] = parse_title(datas["Data"]["title"], item["source"])
            item["content"] = hide_and_sub(datas["Data"]["content"].replace("\u2022", ""), "*")
            if item["gid"] not in self.data_list:
                yield item
