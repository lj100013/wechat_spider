#coding:utf-8
from meta_spider import Spider
import requests
from lxml import etree
import logging
import json
from utils import get_ip
import traceback
class YmtSpider(Spider):
    """YiMaiTong spider"""
    def __init__(self, first_time):
        super(YmtSpider, self).__init__(first_time)
        self.proxies = self.get_proxies()

    def get_proxies(self):
        ip = get_ip(3)
        if len(ip) > 0 and ':' in ip:
            proxies = {
                'http': ip,
                'https': ip
            }
            return proxies

        return None

    def doRequest(self,url,headers,data,retrytimes,method):
        if retrytimes >= 0:
            try:
                if method == 'get':
                    response = requests.get(url,headers=headers,proxies = self.proxies)
                else:
                    response = requests.post(url, headers=headers, data = data,proxies=self.proxies)
                if response.status_code == 200:
                    return response
                return self.doRequest(self,url,headers,data,retrytimes-1,method)
            except Exception as e:
                self.proxies = self.get_proxies()
                logging.WARNING('出错重试{}'.format(e))
                return self.doRequest(self,url,headers,data,retrytimes-1,method)
        return None

    def crawl_page_source(self, url_dept):
        url = url_dept[0]
        dept = url_dept[1]
        div_type = url_dept[2]
        # proxies = {
        #     'http': '127.0.0.1:8080',
        #     'https': '127.0.0.1:8080'
        # }
        if self.first_time:
            deadLine = self.get_deadline(180)
        else:
            deadLine = self.get_deadline(1)
        createtime = self.get_deadline(0)
        post_form = {'submit_type': 'ajax','ac': 'research_branch','div_type': 1, 'model_type': 'info','cat_type': 'research','div_type':div_type}
        post_url = 'http://news.medlive.cn/cms.php'
        host_url = 'http://news.medlive.cn'
        headers0 = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36"}
        headers1 = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36",
                   "Host": "news.medlive.cn",
                   "Origin": "http://news.medlive.cn",
                   "Referer": url}
        for i in range(100):
            if createtime < deadLine:
                break
            try:
                if i == 0:
                    response = self.doRequest(url,headers=headers0,data= None,retrytimes=3,method = 'get')
                    if response:
                        content = etree.HTML(response.text)
                        url_list = content.xpath('//*[@id="more"]/div/div[2]/div[1]/a/@href')
                        createtime_list = content.xpath('//*[@id="more"]/div/div[2]/div[3]/span[1]/span/text()')
                    else:
                        logging.error("爬虫失败请求失败")
                        break
                else:
                    post_form['page'] = i
                    response = self.doRequest(post_url, headers=headers1, data=post_form, retrytimes=3, method='post')
                    if response:
                        html = json.loads(response.text).get("html")
                        content = etree.HTML(html)
                        url_list = content.xpath('/html/body/div/div[2]/div[1]/a/@href')
                        createtime_list = content.xpath('/html/body/div/div[2]/div[3]/span[1]/span/text()')
                    else:
                        logging.error("爬虫失败请求失败")
                        break
                url_list = [url for url in url_list if 'promotion' not in url]
                if len(url_list) > 0 and len(url_list) == len(createtime_list):
                    for i in range(len(url_list)):
                        createtime = createtime_list[i].strip('\n').strip()
                        if createtime < deadLine:
                            break
                        detail_url = host_url + url_list[i]
                        #detail_response = requests.get(detail_url, headers=headers0)
                        detail_response = self.doRequest(detail_url, headers=headers0,data=None,retrytimes=3,method='get')
                        detail_content = etree.HTML(detail_response.text)
                        title = detail_content.xpath('//*[@id="content"]/div[1]/div[1]/div/h1/text()')
                        if len(title) > 0:
                            title = title[0].strip('\n').strip()
                            gid = self.parse_title(title)
                            if self.is_exists(gid):
                                logging.warning("this article already exists in db!!")
                                continue
                            author = '医脉通web'
                            source = '医脉通web'
                            content = detail_content.xpath('//div[@class="content_body"]')
                            if len(content) > 0:
                                content = etree.tostring(content[0], method='html').decode("utf-8")
                                img_urls = detail_content.xpath('//img/@src')
                                if len(img_urls) > 0:
                                    content = self.replace_img_url(img_urls, content, source)
                                data = {'title': title, 'author': author, 'dept': dept, 'source': source,
                                        'create_time': createtime,
                                        'gid': gid, 'content': content}
                                self.save_data2db(data)
                            else:
                                logging.warning("the content is empty!!!")
                        else:
                            logging.warning("the title is empty!!!")
            except Exception as e:
                traceback.print_exc()
                logging.error("failed to crawl yimaitong:{}".format(e))
