#coding:utf-8
from meta_spider import Spider
import requests
from lxml import etree
import logging


class DxySpider(Spider):
    """DingXiangYuan spider"""
    def __init__(self,first_time):
        super(DxySpider, self).__init__(first_time)
        self.headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36"}

    def crawl_page_source(self, url_dept):
        url = url_dept[0]
        dept = url_dept[1]
        # proxies = {
        #     'http': '127.0.0.1:8080',
        #     'https': '127.0.0.1:8080'
        # }
        if self.first_time:
            deadLine = self.get_deadline(180)
        else:
            deadLine = self.get_deadline(1)
        createtime = self.get_deadline(0)
        for i in range(100):
            if createtime < deadLine:
                break
            try:
                url = url + '/p-' + str(i+1)
                response = requests.get(url,headers = self.headers)
                content = etree.HTML(response.text)
                url_list = content.xpath('//*[@id="main"]/div/div/div[1]/dl/dd/p[1]/a/@href')
                createtime_list = content.xpath('//*[@id="main"]/div/div/div[1]/dl/dd/p[1]/span/text()')
                if len(url_list) > 0 and len(url_list) == len(createtime_list):
                    for i in range(len(url_list)):
                        createtime = createtime_list[i].replace('.','-').strip('\n').strip()
                        if createtime < deadLine:
                            break
                        detail_url = url_list[i]
                        detail_response = requests.get(detail_url,headers = self.headers)
                        detail_content = etree.HTML(detail_response.text)
                        title = detail_content.xpath('//*[@id="j_article_desc"]/div[1]/h1/text()')
                        if len(title) > 0:
                            title = title[0].strip('\n').strip()
                            gid = self.parse_title(title)
                            if self.is_exists(gid):
                                logging.warning("this article already exists in db!!")
                                continue
                            author = '丁香园web'
                            source = '丁香园web'
                            content = detail_content.xpath('//*[@id="content"]')
                            if len(content) > 0:
                                content = etree.tostring(content[0], method='html').decode("utf-8")
                                img_urls = detail_content.xpath('//*[@id="content"]/p/img/@src')
                                if len(img_urls) > 0:
                                    content = self.replace_img_url(img_urls,content,source)
                                data = {'title':title,'author':author,'dept':dept,'source':source,'create_time':createtime,
                                        'gid':gid,'content':content}
                                self.save_data2db(data)
                            else:
                                logging.warning("the content is empty!!!")
                        else:
                            logging.warning("the title is empty!!!")
            except Exception as e:
                logging.error("failed to crawl dingxiangyuan:{}".format(e))



