# -*- coding: utf-8 -*-

# Define here the models for your spider middleware
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/spider-middleware.html
import random
import time
import re
from scrapy import signals
import requests
from scrapy.middleware import logger

class NowscrawlDownloaderMiddleware(object):
    def __init__(self):
        self.header = {
            "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36",
            "Cookie": "UM_distinctid=1648c614ccf182-003374b8126d72-3c3c5d0c-1fa400-1648c614cd0dd8; JSESSIONID=A434CC3A3DF418B99DD28C5D5AB61D8E"}

    def get_ip(self):
        i = random.randint(0, 1)
        rsp = requests.post(url="http://dynamic.goubanjia.com/dynamic/get/334167123fb4db63d9ae36523fc20115.html?sep=1",
                            headers=self.header)
        if rsp.status_code == 200 and rsp.text:
            # try:
            #     proxy = [j.strip() for j in rsp.text.split("\r") if j][i]
            #     return proxy
            # except:
            #     pass
            proxy = rsp.text
            return proxy
        else:
            print("第一次请求失败继续尝试")
            self.get_ip()

    def process_request(self, request, spider):
        # if "http://firewall.med" in request.url:
        ip = self.get_ip()
        if ip is not None:
            try:
                request.meta['proxy'] = "http://" + ip
            except:
                pass
            logger.info('process_request  %s ' % ip)

    def process_response(self, request, response, spider):
        # y_url = "http://firewall.med"
        url_compile = re.compile("http://(.*?).med.wanfangdata.com.cn")
        url_p = ''.join(url_compile.findall(response.url))
        if response.status != 200 and url_p != "api":
            ip = self.get_ip()
            try:
                request.meta['proxy'] = ip
            except:
                pass
            logger.info('成功获取的ip为：  %s ' % ip)
            return request
        return response

    def spider_opened(self, spider):

        spider.logger.info('Spider opened: %s' % spider.name)
