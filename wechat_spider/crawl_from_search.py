# -*- coding:utf-8 -*-
from urllib.parse import quote
import requests
from requests.exceptions import ProxyError
from utils.get_proxy_ip import get_ip
from utils.md5_title import parse_title
from utils.upload_pic2qiniu import upload_pic,img_base_url
from utils.fix_iframes import fix_iframe
from utils.data_2_mysql import is_exists,process_item
from utils.formate_date import formate_date
import logging
from lxml import etree
import re
import math
import random
# import traceback
# from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import urllib3
urllib3.disable_warnings()

class Spider(object):
    """
    crawl weixin gongzhonghao from sougou
    """
    def __init__(self):
        self.proxies,self.host,self.port = self._get_proxies()
        self.search_headers = {
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'max-age=0',
            'Connection': 'keep-alive',
            'Host': 'weixin.sogou.com',
            'Upgrade-Insecure-Requests': '1',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'
        }
        self.article_list_headers = {
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'max-age=0',
            'Connection': 'keep-alive',
            'Host': 'mp.weixin.qq.com',
            'Upgrade-Insecure-Requests': '1',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'
        }

    def _get_proxies(self):
        ip = get_ip(3)
        logging.warning("get proxy ip:{}".format(ip))
        if ip and ':' in ip:
            proxies = {
                'http': ip,
                'https': ip
            }
            host = ip.split(":")[0]
            port = ip.split(":")[1]
            return proxies,host,port
        return None,None,None

    def _parse_url(self,url, pads):
        b = math.floor(random.random() * 100) + 1
        a = url.find("url=")
        c = url.find("&k=")
        if a != -1 and c == -1:
            a = url[a + sum([int(i) for i in pads]) + b]
        return '{}&k={}&h={}'.format(url, b, a)

    def _process_url(self,url,search_url,cookie_jar,text):
        if url.startswith('/link?url='):
            url = 'https://weixin.sogou.com{}'.format(url)
            patt = r'href\.substr\(a\+(\d+)\+parseInt\("(\d+)"\)\+b,1\)'
            pads = re.findall(patt, text)
            url = self._parse_url(url, pads[0] if pads else [])
            headers = self.search_headers.copy()
            headers['Referer'] = search_url
            headers["Cookie"] = cookie_jar
            #time.sleep(random.uniform(0,3))
            response = requests.get(url, headers=headers, proxies = self.proxies)
            content = response.text
            pattern = r"'([\s\S]*?)'"
            id_node = re.findall(pattern, content)
            uri = ''.join(id_node)
            url = uri.replace('@', '')
        else:
            logging.warning("## get mail url wrong #")
        return url

    def _get_article_urls(self,name,deadline,wxid,retrytimes,page = 1,ft=None,et=None):
        """
        get url of search articles
        :param name:name of gongzhonghao
        deadline:所有时间，最近一天，一周，一月，一年,用户自定义时间段的文章。
        alltime,day,week,month,year,userset,当参数为userset时，需设置起始时间ft，截止时间et，格式为2019-08-01
        :return:url of gongzhonghao
        """
        tsn_deadline = {"alltime":"0","day":"1","week":"2","month":"3","year":"4","userset":"5"}
        name_s = quote(name)
        #tsn=2最近一周的文章
        tsn = tsn_deadline[deadline]
        article_urls = []
        dates = []
        num = 1
        if tsn != "5":
            search_url = 'https://weixin.sogou.com/weixin?type=2&ie=utf8&tsn={}&ft=&et=&interation=&wxid={}&usip={}&query={}&page={}'.format(tsn,wxid,name_s,name_s,page)
        else:
            search_url ='https://weixin.sogou.com/weixin?type=2&ie=utf8&tsn={}&ft={}&et={}&interation=&wxid={}&usip={}&query={}&page={}'.format(tsn,ft,et,wxid,name_s,name_s,page)
        while retrytimes >= 0:
            try:
                retrytimes -= 1
                #time.sleep(random.uniform(0, 3))
                self.search_headers["Referer"] = search_url
                response = requests.get(search_url,headers = self.search_headers,proxies = self.proxies)
                content = etree.HTML(response.text)
                num_st = content.xpath('//*[@id="pagebar_container"]/div/text()')
                if len(num_st) > 0 and page == 1:
                    logging.warning(name+"---"+num_st[0])
                    num = math.ceil(int(num_st[0].replace("找到约","").replace("条结果",""))/10)
                urls = content.xpath('//*[@class="txt-box"]/h3/a/@href')
                cookie_jar = ''
                if len(urls) > 0:
                    cookie = response.cookies
                    for coo in iter(cookie):
                        cooname = coo.name
                        value = coo.value
                        scoo = cooname + '=' + value + ';'
                        cookie_jar += scoo
                    if 'SNUID=' in cookie_jar:
                        dates = content.xpath('//*[@class="s2"]/script/text()')
                        for url in urls:
                            detail_url = self._process_url(url, search_url, cookie_jar, response.text)
                            if 'SNUID=1' not in detail_url:
                                article_urls.append(detail_url)
                            else:
                                logging.warning("SNUID=1 in detail_url")
                        return article_urls,dates,num
                    else:
                        logging.warning("fail to process url of {}:{}".format(name,cookie_jar))
                        self.proxies,self.host,self.port = self._get_proxies()
                        return self._get_article_urls(name,deadline,wxid,retrytimes-1,page,ft,et)
                else:
                    logging.warning("fail to get url of {}:{}".format(name,urls))
                    self.proxies, self.host, self.port = self._get_proxies()
                    return self._get_article_urls(name,deadline,wxid,retrytimes-1,page,ft,et)
            except ProxyError:
                logging.warning("proxyError,get new proxy ip!")
                self.proxies, self.host, self.port = self._get_proxies()
                return self._get_article_urls(name,deadline,wxid,retrytimes-1,page,ft,et)
            except Exception as e:
                logging.warning("happen exception,fail to get url of {}:{}".format(name,e))
                self.proxies, self.host, self.port = self._get_proxies()
                return self._get_article_urls(name,deadline,wxid,retrytimes-1,page,ft,et)
        logging.error("fail to get url of article list:{}".format(name))
        return article_urls,dates,num

    def _get_aticle_source(self,detail_url,name,retrytimes):
        while retrytimes >= 0:
            try:
                # logging.warning("do request to url:{}".format(detail_url))
                #time.sleep(random.uniform(0, 3))
                response = requests.get(detail_url, headers = self.article_list_headers,proxies = self.proxies)
                response.encoding = 'utf-8'
                content = response.text
                page = etree.HTML(content)
                content_nodes = page.xpath('//div[@class="rich_media_content "]')
                authors = page.xpath('//a[@id="js_name"]/text()')
                iframes = page.xpath('//iframe[@class="video_iframe"]/@data-src')
                title = page.xpath('//h2[@class="rich_media_title"]/text()')
                if len(title) > 0:
                    title = title[0].strip('\n').strip()
                if len(content_nodes) > 0 and len(authors) > 0:
                    node = content_nodes[0]
                    content = etree.tostring(node, method='html').decode("utf-8")
                    c_list = content.split("</p>")
                    if len(c_list) < 2:
                        return [],[],[],[],[]
                    str_content = c_list[0] + '</p>' + c_list[1] + '</p>' + '\n<!--more-->'
                    str_left = '</p>'.join(c_list[2:])
                    content = str_content + str_left
                    img_urls = page.xpath('//img/@data-src')
                    return content,authors,title,iframes,img_urls
                else:
                    logging.warning("content is empty")
                    detail_url = page.xpath('//*[@id="js_share_source"]/@href')
                    if len(detail_url) > 0:
                        detail_url = detail_url[0]
                        return self._get_aticle_source(detail_url, name, retrytimes - 1)
                    self.proxies, self.host, self.port = self._get_proxies()
                    return self._get_aticle_source(detail_url,name,retrytimes-1)
            except ProxyError:
                logging.warning("proxyError,get new proxy ip!")
                self.proxies, self.host, self.port = self._get_proxies()
                return self._get_aticle_source(detail_url,name,retrytimes-1)
            except Exception as e:
                # traceback.print_exc()
                logging.warning("fail to get article content:{},{},{}".format(name,detail_url,e))
                return self._get_aticle_source(detail_url, name, retrytimes - 1)
        return [],[],[],[],[]

    def pipeline2db(self,name_dept,deadline,retrytimes=3,ft=None,et=None):
        """
        :param name_dept: (weixin_name,dept,appname)
        :param deadline: 所有时间，最近一天，一周，一月，一年,用户自定义时间段的文章。alltime,day,week,month,year,userset,当参数为userset时，需设置起始时间ft，截止时间et，格式为2019-08-01
        :param retrytimes: 出错重试次数
        :return:
        """
        name = name_dept[0]
        dept = name_dept[1]
        appname = name_dept[2]
        wxid = name_dept[3]
        detail_urls,dates,num = self._get_article_urls(name,deadline,wxid,retrytimes,page = 1,ft=ft,et=et)
        if len(detail_urls) > 0:
            for page in range(1,num+1):
                if page > 1:
                    detail_urls,dates, num = self._get_article_urls(name,deadline,wxid,retrytimes,page = page,ft=ft,et=et)
                if len(detail_urls) == len(dates) and len(detail_urls) > 0:
                    for i in range(len(detail_urls)):
                        try:
                            #time.sleep(random.uniform(0, 1))
                            detail_url = detail_urls[i]
                            detail_url = "https://mp.weixin.qq.com"+detail_url
                            detail_url = detail_url.replace("http://mp.weixin.qq.com", "")
                            content, authors, title, iframes, img_urls = self._get_aticle_source(detail_url, name, retrytimes)
                            if len(title) > 0:
                                gid = parse_title(title)
                                if is_exists(gid,appname):
                                    continue
                                if len(img_urls) > 0:
                                    for pic_url in img_urls:
                                        is_upload,content = upload_pic(content,pic_url)
                                        if len(is_upload) == 0:
                                            continue
                                blank_pattern = "background-image: url([\s\S]*?);background"
                                if len(authors) > 0:
                                    wxname = authors[0].strip()
                                    if wxname == '中洪博元医学实验帮':
                                        blank_pattern = "-webkit-border-image: url([\s\S]*?) 20 fill"
                                    blank_urls = re.findall(blank_pattern, content)
                                    blank_jpeg_img = "NzKkzoeG5s2FcdXyTKYAErrs5QNBXGVS75aQnxYX1RmPQTRwN3CsZw5Dfjb3oiaYLjgNaWrFck8rJJRoqHxuItA.jpeg"
                                    for blank_img in blank_urls:
                                        file_name = blank_jpeg_img
                                        first_string = img_base_url + file_name
                                        blank_img = blank_img.replace('(', '')
                                        blank_img = blank_img.replace(')', '')
                                        content = content.replace(blank_img, first_string)
                                    content = fix_iframe(content,iframes)
                                    wechat_data = {}
                                    wechat_data['title'] = title
                                    wechat_data['author'] = wxname
                                    wechat_data['key_word'] = dept
                                    wechat_data['wxname'] = wechat_data['author']
                                    create_date = formate_date(dates[i])
                                    wechat_data['create_time'] = create_date
                                    wechat_data['content'] = content
                                    wechat_data['gid'] = gid
                                    # print(wechat_data["title"],  wechat_data['author'])
                                    process_item(wechat_data,appname)
                        except Exception as e:
                            logging.warning("发生错误:{}".format(e))
        else:
            logging.warning("fail to get detail article url!!")

if __name__ == "__main__":
    logging.basicConfig(level=logging.WARNING,
                        format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                        datefmt='%a, %d %b %Y %H:%M:%S')
    spider = Spider()
    spider.pipeline2db(("平安健康保险","INFO","yyr","oIWsFtxgIwpnTF8RUnxZOfnvQj3k"),'month',retrytimes=3)
