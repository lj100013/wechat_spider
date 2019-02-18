# -*- coding: UTF-8 -*-

'''
Python 3.x
无忧代理IP Created on 2018年05月11日
描述：本DEMO演示了使用爬虫（动态）代理IP请求网页的过程，代码使用了多线程
逻辑：每隔5秒从API接口获取IP，对于每一个IP开启一个线程去抓取网页源码
注意：需先安装socks模块 pip3 install 'requests[socks]'
@author: www.data5u.com
'''
import datetime
import re
from urllib import parse

import requests
import time
import threading
import urllib3
import json
ips = []

# 爬数据的线程类
class CrawlThread(threading.Thread):
    def __init__(self,proxyip):
        super(CrawlThread, self).__init__()
        self.proxyip=proxyip
        self.rsp = None
    def run(self):
        # 开始计时
        start = time.time()
        #消除关闭证书验证的警告
        urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
        #使用代理IP请求网址，注意第三个参数verify=False意思是跳过SSL验证（可以防止报SSL错误）
        self.rsp=requests.get(url=targetUrl, proxies={"http" : 'socks5://user:password@' + self.proxyip, "https" : 'socks5://user:password@' + self.proxyip}, verify=False, timeout=15)
        self.rsp = self.rsp
        # # 结束计时
        # end = time.time()
        # 输出内容
        # print(threading.current_thread().getName() + "使用代理IP, 耗时 " + str(end - start) + "毫秒 " + self.proxyip + "获取到如下HTML内容：\n" + html + "\n*************")

    def parse_conten(self):
        content_url = "http://api.med.wanfangdata.com.cn/Article/Detail?articleId={}&token=CMS&type=WF_QK"
        user_compile = re.compile("CreatorFirst=(.*?)%20and")
        ind_comiple = re.compile("startIndex=(.*?)&query")
        url_compile = re.compile("http://(.*?).med.wanfangdata.com.cn")
        url_p = "".join(url_compile.findall(self.rsp.url))
        total = 0
        user = "n"
        ind = "n"
        if self.rsp.text and url_p == "api" and len(self.rsp.text) > 5:
            user = user_compile.findall(self.rsp.url)[0]
            ind = ind_comiple.findall(self.rsp.url)[0]
            self.rsp = json.loads(self.rsp.text)
            nodes = self.rsp["Records"]
            total = self.rsp["Total"]
            for data in nodes:
                item = {}
                DayAgo = (datetime.datetime.now())
                nowTime = DayAgo.strftime("%Y-%m-%d %H:%M:%S")
                item["guid"] = data["ArticleID"]
                item["post_name"] = data["ArticleID"]
                item["author"] = data["Creator"]
                item["key_word"] = data["KeyWords"]
                item["source"] = data["Source"]
                item["post_title"] = data["Title"]
                item["post_status"] = "publish"
                item["post_author"] = "1"
                item["post_date"] = nowTime
                item["post_date_gmt"] = nowTime
                rsp2 = requests.get(url=content_url.format(item["post_name"]))
            # if int(ind) < total:
            #     next_url = "http://api.med.wanfangdata.com.cn/Article/Search?startIndex={}&query=CreatorFirst={}%20and%20Date%3E=2018-01-01&DBID=WF_QK&pageSize=20&token=CMS"
            #     yield scrapy.Request(url=next_url.format(str(int(ind) + 1), user), callback=self.parse_detal,
            #                          dont_filter=True)
        with open("err_user_old", "a")as f:
            if user != "n":
                f.write(parse.unquote_plus(user) + "," + ind + "," + str(total) + "\n")
# 获取代理IP的线程类
class GetIpThread(threading.Thread):
    def __init__(self,fetchSecond):
        super(GetIpThread, self).__init__()
        self.fetchSecond=fetchSecond
    def run(self):
        global ips
        while True:
            # 获取IP列表
            res = requests.get(apiUrl).content.decode()
            # 按照\n分割获取到的IP
            ips = res.split('\n')
            # 利用每一个IP
            for proxyip in ips:
                # 开启一个线程
                CrawlThread(proxyip).start()

            # 休眠
            time.sleep(self.fetchSecond)



if __name__ == '__main__':
    with open("C:/Users\dachen\Desktop/nowscrawl/nowscrawl\spiders/user.txt", encoding="utf-8")as f:
        use_list = [i.strip() for i in f.readlines()]
    # 这里填写无忧代理IP提供的API订单号（请到用户中心获取）
    order = "e53b1e30e677dc45d8046b6681f655d6"
    # 获取IP的API接口
    apiUrl = "http://dynamic.goubanjia.com/dynamic/get/" + order + ".html"
    # 要抓取的目标网站地址
    for user in use_list:
        print(user.strip())
        targetUrl = "http://api.med.wanfangdata.com.cn/Article/Search?startIndex=1&query=CreatorFirst={} and Date>=2018-01-01&DBID=WF_QK&pageSize=20&token=CMS".format(user)
    # 获取IP时间间隔，建议为5秒
    fetchSecond = 5
    # 开始自动获取IP
    GetIpThread(fetchSecond).start()
