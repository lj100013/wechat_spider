# -*- coding: utf-8 -*-
from lc.items import LcItem
from lc.youdu_sever import *
import re
import scrapy


class Sw360Spider(scrapy.Spider):
    name = 'sw360'
    allowed_domains = ['bio360.net']

    def start_requests(self):
        # itemid
        self.ids = database_filter("31", "32","33","34")
        for cid in ["99","97", "98","7"]:
            if cid == "7":
                for i in range(1000):
                    base_url = "http://www.bio360.net/article/ajax?&page={}&class_id={}".format(str(i), cid)
                    yield scrapy.Request(base_url, dont_filter=True)
            else:
                for i in range(20):
                    base_url = "http://www.bio360.net/media/ajax?&page={}&class_id={}".format(str(i), cid)
                    yield scrapy.Request(base_url, dont_filter=True)

    def parse(self, response):
        cid = re.compile("class_id=(\d+)").findall(response.url)[0]
        if cid == "7":
            nodes = response.xpath('//li[@class="row"]')
            for node in list(set(nodes)):
                content_url = node.xpath('./div/h3/a/@href').extract_first()
                kw = ','.join(node.xpath('.//div[@class="newcon"]//a/text()').extract())
                yield scrapy.Request(url=content_url, callback=self.parse_content, meta={"kw": kw, "wn": cid})
        # 97 组图秀，98 信息图表 99 生物漫画
        if cid in ["97", "98", "99"]:
            nodes = response.xpath('//div[@class="caption"]/h3/a/@href').extract()
            for u in list(set(nodes)):
                yield scrapy.Request(url=u, callback=self.parse_media, meta={"wn": cid})

    def parse_media(self, response):
        item = LcItem()
        if response.text:
            datas = response.xpath('//div[@class="article-header"]/div[1]/div[1]/text()').extract_first()
            title = response.xpath('//div[@class="article-header"]/h1/text()').extract_first()
            item["source"] = datas.split("/")[0]
            item["author"] = datas.split("/")[1]
            item["create_time"] = datas.split("/")[2]
            item["title"] = title
            need_html = "".join(
                response.xpath('//div[@class="article-content"]|//div[@class="multimedia"]').extract()).replace(
                'src="/storage/media/', 'src="http://www.bio360.net/storage/media/')
            item["content"] = hide_and_sub(need_html, "*", "</p>")
            item["key_word"] = ""
            item["wxname"] = response.meta["wn"]
            item["gid"] = parse_title(title, item["source"])
            if item["gid"] not in self.ids:
                yield item

    def parse_content(self, response):
        item = LcItem()
        datas = response.xpath('//div[@class="article-header"]/div[1]/div[1]/text()').extract_first()
        title = response.xpath('//div[@class="article-header"]/h1/text()').extract_first()
        sourse = re.compile('来源：(.*?)/').findall(datas)[0].strip()
        date = "-".join(re.compile('(\d+)-(\d+)-(\d+)').findall(datas)[0])
        author = re.compile('/ 作者：(.*?)/').findall(datas)
        if author:
            author = author[0].strip()
        else:
            author = ""
        item["content"] = hide_and_sub(response, '//div[@class="article-content"]', "</p>")
        item["title"] = title
        item["source"] = sourse
        item["gid"] = parse_title(title, sourse)
        item["author"] = author
        item["create_time"] = date
        item["key_word"] = response.meta["kw"]
        item["wxname"] = response.meta["wn"]
        if item["gid"] not in self.ids and date.split("-")[0] == "2018":
            yield item
