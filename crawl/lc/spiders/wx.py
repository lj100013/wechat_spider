# -*- coding: utf-8 -*-
#!/usr/bin/python
import scrapy
from lc.youdu_sever import *
from scrapy import Request
from lc.items import LcItem
import re
import json
import time


class WechatSpider(scrapy.Spider):
    name = "wx"

    def start_requests(self):
        self.ids = database_filter("14", "13", "3", "9", "12", "11")
        urls = [
            'http://weixin.sogou.com/weixin?type=1&s_from=input&query=好医生',
            'http://weixin.sogou.com/weixin?type=1&s_from=input&query=丁香园',
            'http://weixin.sogou.com/weixin?type=1&s_from=input&query=看医界',
            'http://weixin.sogou.com/weixin?type=1&s_from=input&query=医学界消化肝病频道',
            'http://weixin.sogou.com/weixin?type=1&s_from=input&query=影像园',
            'http://weixin.sogou.com/weixin?type=1&s_from=input&query=小漫画大夫'
        ]
        for u in urls:
            yield scrapy.Request(url=u)

    def parse(self, response):
        content_url = response.xpath(
            '//div[@class="news-box"]/ul[@class="news-list2"]/li[1]/div[@class="gzh-box2"]/div[@class="img-box"]/a/@href').extract_first()
        yield Request(content_url, callback=self.parse_content)

    def parse_content(self, response):
        try:
            article_srcs = response.xpath(
                "//div[@class='profile_info']/strong[@class='profile_nickname']/text()").extract_first()
            article_src = article_srcs.strip()
            datas = re.sub(r"\s+", "", response.text.replace("\xa5", ""))
            date_re = re.compile("varmsgList=(.*?);seajs")
            tmp = date_re.findall(datas)[0]
            tmp = json.loads(tmp)
            # 时间蹉对比保留下跟新的内容
            date_ = [i["comm_msg_info"]["datetime"] for i in tmp["list"] if
                     i["comm_msg_info"]["datetime"] < round(time.time())]
            id = [i["comm_msg_info"]["id"] for i in tmp["list"]]
            # 时间措
            if len(date_) <= 0:
                print("《" + article_src + "》今日没有发布内容！")
                return
            else:
                print("《" + article_src + "》今日发布了" + str(len(date_)) + "条内容！")  # multi_app_msg_item_list
                tmp_url = [[j["content_url"] for j in i["app_msg_ext_info"]["multi_app_msg_item_list"]] for i in
                           tmp["list"]]
                tmp_url2 = [i["app_msg_ext_info"]["content_url"] for i in tmp["list"]]
                need_url = list(set([i for u in tmp_url for i in u] + tmp_url2))
                base_url = "https://mp.weixin.qq.com"
                for k, j in enumerate(need_url):
                    detail_url = base_url + j.replace("amp;", "")
                    yield scrapy.Request(detail_url, callback=self.parse_item,
                                         meta={"source": article_src, "num": id})
        except:
            print("出现验证码！！！！")

    def parse_item(self, response):
        item = LcItem()
        content = hide_and_sub(response, '//div[@id="js_content"]', "</p>")
        item["content"] = content
        item["title"] = response.xpath('//h2[@id="activity-name"]/text()').extract_first().strip()
        item["author"] = response.xpath('//a[@id="js_name"]/text()').extract_first().strip()
        item["key_word"] = "综合"
        item["source"] = response.meta["source"]
        item["wxname"] = response.meta["source"]
        datas = re.sub(r"\s+", "", response.text.replace("\xa5", ""))
        date_re = re.compile('varpublish_time="(.*?)"')
        tmp = date_re.findall(datas)[0]
        item["create_time"] = tmp
        item["gid"] = parse_title(item["title"], item["source"])
        if item["gid"] not in self.ids:
            yield item
        else:
            print("去重去重" * 100)

    def get_text(self, texts):
        text = ""
        if len(texts) > 0:
            for tmp in texts:
                text = text + tmp
        return text.strip()
# https://mp.weixin.qq.com/mp/verifycode?cert=1533188648618.761   130 53
