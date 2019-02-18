# -*- coding: utf-8 -*-
from lc.youdu_sever import *
from urllib import parse
import scrapy
import re
import json
from lc.items import LcItem
from lc.login import login_


class ZnSpider(scrapy.Spider):
    name = 'ymt_zn'
    allowed_domains = ['medlive.cn']
    login_()

    def start_requests(self):
        self.ids = database_filter("6")
        hreader = {
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            "Accept-Encoding": "gzip, deflate",
            "Accept-Language": "zh-CN,zh;q=0.9",
            "Cache-Control": "max-age=0",
            "Cookie": "Hm_lvt_62d92d99f7c1e7a31a11759de376479f=1532054661; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22164b59336028a5-02b108c15ff336-3c3c5d0c-2073600-164b5933603253%22%2C%22%24device_id%22%3A%22164b59336028a5-02b108c15ff336-3c3c5d0c-2073600-164b5933603253%22%7D; sajssdk_2015_cross_new_user=1; Hm_lpvt_62d92d99f7c1e7a31a11759de376479f=1532069570; ymtinfo=eyJ1aWQiOiIzMzI3MjQyIiwicmVzb3VyY2UiOiIiLCJhcHBfbmFtZSI6IiIsImV4dF92ZXJzaW9uIjoiMSJ9",
            "Host": "api.medlive.cn"
        }
        start_u = "https://api.medlive.cn/guideline/guide_new_list.ajax.php?start=0&limit=20&userid=3327242"
        yield scrapy.Request(url=start_u, headers=hreader)

    def parse(self, response):
        hreader = {
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            "Accept-Encoding": "gzip, deflate",
            "Accept-Language": "zh-CN,zh;q=0.9",
            "Cache-Control": "max-age=0",
            "Cookie": "Hm_lvt_62d92d99f7c1e7a31a11759de376479f=1532054661; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22164b59336028a5-02b108c15ff336-3c3c5d0c-2073600-164b5933603253%22%2C%22%24device_id%22%3A%22164b59336028a5-02b108c15ff336-3c3c5d0c-2073600-164b5933603253%22%7D; sajssdk_2015_cross_new_user=1; Hm_lpvt_62d92d99f7c1e7a31a11759de376479f=1532069570; ymtinfo=eyJ1aWQiOiIzMzI3MjQyIiwicmVzb3VyY2UiOiIiLCJhcHBfbmFtZSI6IiIsImV4dF92ZXJzaW9uIjoiMSJ9",
            "Host": "api.medlive.cn"
        }
        rsp = parse.unquote_plus(response.text)
        rsps = json.loads(rsp)
        if not rsps["err_msg"]:
            id_list = [id["id"] for id in rsps["data_list"]]
            for id in id_list:
                content_url = "https://api.medlive.cn/guideline/view.ajax.php?&id={}&sub_type=1&data_mode=1".format(id)
                if content_url not in self.ids:
                    yield scrapy.Request(url=content_url, callback=self.parse_content, headers=hreader,
                                         dont_filter=True)
                else:
                    print("过滤过滤==========")
            next_re = re.compile("start=(\d+)&")
            start = next_re.findall(response.url)
            if start:
                next_page = str(int(start[0]) + 1000)
                next_url = "https://api.medlive.cn/guideline/guide_new_list.ajax.php?start={}&limit=1000"
                yield scrapy.Request(url=next_url.format(next_page), headers=hreader)

    def parse_content(self, response):
        rsp = parse.unquote_plus(response.text)
        need_time = 2018
        try:
            rsps = json.loads(rsp)["data"]
            old_time = rsps["publish_date"].split("-")
            year = old_time[0]
            if int(year) == int(need_time):
                item = LcItem()
                item["title"] = rsps["title_cn"]
                item["key_word"] = rsps["web_file_name"].replace(".pdf", "")
                name = rsps["web_file_name"]
                url = rsps["web_file_url"]
                pdf_url = du(url=url, name=name)
                item["content"] = rsps["content"] + "\n" + '<a href={}>查看文献</a>'.format(pdf_url)
                item["create_time"] = rsps["publish_date"]
                item["author"] = rsps["author"]
                item["source"] = rsps["reference"]
                item["gid"] = parse_title(item["title"], item["source"])
                if item["gid"] not in self.ids:
                    yield item
            else:
                print("年代久远过滤了")
        except:
            pass
