# -*- coding: utf-8 -*-
import datetime
import json
import scrapy
import re
from nowscrawl.items import NowscrawlItem
from utils import *


class WfSpider(scrapy.Spider):
    name = 'wf'
    allowed_domains = ['api.med.wanfangdata.com.cn']
    start_urls = ['http://api.med.wanfangdata.com.cn/']

    def start_requests(self):
        self.ids = database_filter()
        self.user_hos = {}
        base_url = 'http://api.med.wanfangdata.com.cn/Article/Search?startIndex=1&query=CreatorFirst={} and Organization={} and Date within "2010-01-01 2018-08-27"&DBID=WF_QK&pageSize=20&token=CMS'

        with open("users/000000_0", encoding="utf-8")as f:
            use_list = [i.strip() for i in f.readlines()]
        process_index = 1
        index = 0
        for user_data in use_list:
            index += 1
            if index < process_index:
                continue

            data = user_data.split(",")
            user = data[0].strip()
            organization = data[1].strip()
            self.user_hos[user] = organization
            process_str = "目前爬到第 %s 行，作者是 %s" % (index, user)
            print("=========================")
            print(process_str)
            print("=========================")
            yield scrapy.Request(base_url.format(user, organization), callback=self.parse_detal, meta={"name": user})

    def parse_detal(self, response):
        if "name" in response.meta.keys():
            name = response.meta["name"]
        else:
            name = "n"

        content_url = "http://api.med.wanfangdata.com.cn/Article/Detail?articleId={}&token=CMS&type=WF_QK"
        user_compile = re.compile("CreatorFirst=(.*?)%20and")
        ind_comiple = re.compile("startIndex=(.*?)&query")
        url_compile = re.compile("http://(.*?).med.wanfangdata.com.cn")
        url_p = "".join(url_compile.findall(response.url))

        if url_p == "firewall":
            pass

        if response.text and url_p == "api" and len(response.text) > 5:
            user = user_compile.findall(response.url)[0]
            ind = ind_comiple.findall(response.url)[0]

            try:
                rsp = json.loads(response.text)
                nodes = rsp["Records"]
                total = rsp["Total"]
                for data in nodes:
                    item = {}
                    DayAgo = (datetime.datetime.now())
                    nowTime = DayAgo.strftime("%Y-%m-%d %H:%M:%S")
                    item["guid"] = data["ArticleID"]
                    item["post_name"] = data["ArticleID"]
                    item["author"] = data["Creator"]
                    item["first_author"] = item["author"].split("|")[0]
                    item["key_word"] = data["KeyWords"]
                    item["source"] = data["Source"]
                    item["post_title"] = data["Title"]
                    item["post_status"] = "publish"
                    item["post_author"] = "1"
                    item["post_date"] = nowTime
                    item["post_date_gmt"] = nowTime
                    if item["guid"] not in self.ids:
                        yield scrapy.Request(url=content_url.format(data["ArticleID"]), meta={"item": item}, callback=self.content)
                    # "李丹丹|LI Dan-dan;阎丽娟|YAN Li-juan"
                    names = [d.split("|")[0] for d in data["Creator"].split(";")]
                    with open("err_user", "a")as f:
                        f.write(name + "," + json.dumps(names,ensure_ascii=False) + "," + ind + "," + str(total) + "\n")
                if int(ind) < total:
                    next_url = "http://api.med.wanfangdata.com.cn/Article/Search?startIndex={}&query=CreatorFirst={}%20and%20Date%3E=2017-01-01&DBID=WF_QK&pageSize=20&token=CMS"
                    yield scrapy.Request(url=next_url.format(str(int(ind) + 1), user), callback=self.parse_detal,
                                         dont_filter=True)
            except:
                pass
        with open("err_user", "a")as f:
            try:
                f.write(name + ",n,n,n" + "\n")
            except UnicodeError as u:
                pass


    def content(self, response):
        item = response.meta["item"]
        itemc = NowscrawlItem()
        url_compile = re.compile("http://(.*?).med.wanfangdata.com.cn")
        url_p = ''.join(url_compile.findall(response.url))
        if url_p == "firewall":
            pass
        if response.text and url_p == "api" and len(response.text) > 5:
            try:
                contents = json.loads(response.text)
                content = contents["Abstract"]
                str_org = contents["Organization"]
                repeate = set()
                organizations = str_org.split(";")
                for organization in organizations:
                    repeate.add(organization)
                user_organization = ';'.join(repeate)

                itemc["post_name"] = item["post_name"]
                itemc["organization"] = user_organization
                itemc["article_year"] = contents["Year"]
                itemc["key_word"] = item["key_word"]
                itemc["source"] = item["source"]
                itemc["post_title"] = item["post_title"]
                itemc["post_content"] = content + "\n" + '<a href="http://192.168.3.154:8076/qiniu/download/bigdata?filename={}">查看文献</a>'.format(item["guid"])
                itemc["author"] = item["author"]
                itemc["first_author"] = item["first_author"]

                isUserArticle = False
                for k,v in self.user_hos.items():
                    if k == item["first_author"]:
                        if v in itemc["organization"]:
                            isUserArticle = True
                            break

                if isUserArticle:
                    writeArticle(item["post_name"], item["post_title"], str(contents["Year"]), item["key_word"],
                                 itemc["post_content"], item["author"], item["first_author"], user_organization,
                                 item["source"])
                    yield itemc
            except:
                pass

    def captcha(self, response):
        print("提交验证码状态为：", response.status)
