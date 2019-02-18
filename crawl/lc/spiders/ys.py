# -*- coding: utf-8 -*-
from lc.youdu_sever import *
import scrapy
import re
from lc.items import LcItem


class YsSpider(scrapy.Spider):
    name = 'ys'
    allowed_domains = ['medtrib.cn']

    def start_requests(self):
        self.data_zxs = database_filter("35")
        # self.data_sps = database_filter("36")
        for i in ["https://www.cmtopdr.com/post/?pager.offset=0"]:
            yield scrapy.Request(url=i)

    def parse(self, response):
        headers = {
            "cookie": "media.multi.cmtopdr=4602a0e1-3610-4c59-9962-c6ad342f89bf;"
                      " Hm_lvt_b38e9b203293848c324d0d4862967c0e=1533520041;"
                      " SERVERID=cb0d2711c6ba56f0ef517bfcef16c67b|1533521871|1533520033;"
                      " Hm_lpvt_b38e9b203293848c324d0d4862967c0e=1533521872",
            "user-agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36"

        }
        time_list = []
        ##############壹生咨询####################
        if "post/?pager.offset=" in response.url:
            title_list = response.xpath('//div[@class="news_list"]/ul/li')
            for title in title_list:
                title_url = "https://www.cmtopdr.com" + title.xpath("./h5/a/@href").extract_first()
                create_time = str(title.xpath(".//i/text()").extract_first().split("-")[0])
                time_list.append(create_time)
                yield scrapy.Request(url=title_url, meta={"hreaders": headers},
                                     callback=self.parse_content, dont_filter=True, headers=headers)
            page_re = re.compile("pager.offset=(\d+)")
            page_num = str(int(page_re.findall(response.url)[0]) + 10)
            if int(time_list.count("2018")) != 0:
                next_base = "https://www.cmtopdr.com/post/?pager.offset=" + page_num
                yield scrapy.Request(url=next_base, headers=headers, dont_filter=True)
            else:
                print("过滤小于2018年数据")
        ################壹生视频########################
        if "getlives.json" in response.url:
            rsp = json.loads(response.text)
            for pag in rsp["result"]["pag"]:
                title = pag["title"]
                author = pag["hospital"] + "," + pag["level"] + "," + pag["userName"]
                end_time = pag["strEnd"]
                key_word = pag["subDepartment"]
                detail_url = "https://www.cmtopdr.com/classroom/live/detail/{}.html".format(pag["liveUuid"])
                yield scrapy.Request(url=detail_url, meta={"t": title, "a": author, "e": end_time, "k": key_word,
                                                           }, dont_filter=True,
                                     headers=headers, callback=self.parse_video)
                time_list.append(pag["strEnd"].split("-")[0])
            next_param = rsp["result"]["dataPage"]
            formdata = {"nextOffset": next_param}
            if int(time_list.count("2018")) != 0:
                next_url = "https://www.cmtopdr.com/getlives.json"
                yield scrapy.FormRequest(url=next_url, formdata=formdata, headers=headers, dont_filter=True)
            else:
                print("过滤小于2018年数据")

    def parse_content(self, response):
        item = LcItem()
        content = hide_and_sub(response, '//div[@class="detail_cnt"]', "</p>")
        title = response.xpath('//div[@class="detail_cnt"]/h4/text()').extract_first()
        item["content"] = content
        item["title"] = title
        item["create_time"] = response.xpath(
            '//div[@class="detail_cnt"]//div[@class="para"]/span[1]/text()').extract_first()
        print(response.url,"==============")
        if response.xpath('//div[@class="detail_cnt"]//div[@class="para"]/span[2]/text()'):
            item["author"] = response.xpath('//div[@class="detail_cnt"]//div[@class="para"]/span[2]/text()').extract_first().replace("作者：","")
            item["source"] = "壹生"
            item["gid"] = parse_title(title, item["source"])
            item["key_word"] = ",".join(
                response.xpath('//div[@class="detail_cnt"]//div[@class="label"]//span//text()').extract())
            item["wxname"] = "壹生资讯"
            if item["gid"] not in self.data_zxs:
                yield item

    def parse_video(self, response):
        item = LcItem()
        vido_url = " https://www.cmtopdr.com" + response.xpath('//a[@id="jumpPlay"]/@href').extract_first()
        content = hide_and_sub(response, '//div[@class="tabs_cnt course"]', "</p>")
        item["content"] = content.replace('==/">', '==">') + "\n" + vido_url
        item["title"] = response.meta["t"]
        item["create_time"] = response.meta["e"]
        item["author"] = response.meta["a"]
        item["source"] = "壹生视频教学"
        item["gid"] = parse_title(response.meta["t"], item["source"])
        item["key_word"] = response.meta["k"]
        item["wxname"] = "壹生视频"
        if item["gid"] not in self.data_sps:
            yield item

    # 视频登入
    # def login_vedio(self):
    #     login_data={
    #         "username": "17199814656",
    #         "password": "nizaiganma11",
    #         "capcha": "9px3",
    #         "rememberMe": "true"
    #     }
    #     login_url="https://www.cmtopdr.com/userAuth"
    #     rsps=requests.post(url=login_url,data=login_data)
    #     if int(rsps.status_code) == 200:
    #         print("登入成功",rsps.status_code)
