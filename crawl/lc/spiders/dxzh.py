# -*- coding: utf-8 -*-
from lc.youdu_sever import *
import json
import scrapy
from lc.items import LcItem


class DxzhSpider(scrapy.Spider):
    name = 'dxzh'
    allowed_domains = ['dxy.cn']

    def start_requests(self):
        self.data_list = database_filter("30")
        for i in range(20):
            n_url = "https://www.dxy.cn/webservices/search/article?keyword=%E8%B5%84%E8%AE%AF&limit=20&pge={}&type=1".format(
                str(i))
            yield scrapy.Request(n_url)

    def parse(self, response):
        rsp = json.loads(response.text)["message"]["list"]
        if len(rsp) != 0:
            for l in rsp:
                detail = "https://www.dxy.cn/webservices/article?id={}&username=dxy_yf12t9v5"
                detail_url = detail.format(l["id"])
                yield scrapy.Request(detail_url, callback=self.parse_content)

    def parse_content(self, response):
        item = LcItem()
        rsps = json.loads(response.text)
        if "source" not in list(rsps["message"].keys()):
            item["source"] = ""
        else:
            item["source"] = rsps["message"]["source"]
        if "pubDate" not in list(rsps["message"].keys()):
            item["create_time"] = ""
        else:
            item["create_time"] = rsps["message"]["pubDate"]
        item["title"] = rsps["message"]["title"]
        item["author"] = rsps["message"]["author"]
        item["key_word"] = rsps["message"]["description"]
        item["content"] = hide_and_sub(rsps["message"]["body"], "*", "</p>")
        item["gid"] = parse_title(rsps["message"]["title"],item["source"])
        if item["gid"] not in self.data_list:
            yield item

# 账号密码17128584415 nizaiganma11
