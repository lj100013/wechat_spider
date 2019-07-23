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



search_headers = {
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Cache-Control': 'max-age=0',
    'Connection': 'keep-alive',
    'Host': 'weixin.sogou.com',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'
}
article_list_headers = {
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Cache-Control': 'max-age=0',
    'Connection': 'keep-alive',
    'Host': 'mp.weixin.qq.com',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'
}

def get_proxies():
    ip = get_ip(3)
    logging.info("get proxy ip:{}".format(ip))
    if ip and ':' in ip:
        proxies = {
            'http': ip,
            'https': ip
        }
        host = ip.split(":")[0]
        port = ip.split(":")[1]
        return proxies,host,port
    return None

def parse_url(url, pads):
    b = math.floor(random.random() * 100) + 1
    a = url.find("url=")
    c = url.find("&k=")
    if a != -1 and c == -1:
        a = url[a + sum([int(i) for i in pads]) + b]
    return '{}&k={}&h={}'.format(url, b, a)

def process_url(url,search_url,cookie_jar,text,proxies):
    if url.startswith('/link?url='):
        url = 'https://weixin.sogou.com{}'.format(url)
        patt = r'href\.substr\(a\+(\d+)\+parseInt\("(\d+)"\)\+b,1\)'
        pads = re.findall(patt, text)
        url = parse_url(url, pads[0] if pads else [])
        headers = search_headers.copy()
        headers['Referer'] = search_url
        headers["Cookie"] = cookie_jar
        #time.sleep(random.uniform(0,3))
        response = requests.get(url, headers=headers, proxies = proxies)
        content = response.text
        pattern = r"'([\s\S]*?)'"
        id_node = re.findall(pattern, content)
        uri = ''.join(id_node)
        url = uri.replace('@', '')
    else:
        logging.warning("## get mail url wrong #")
    return url

def get_gzh_url(name,proxies,retrytimes):
    """
    get url of gongzhonghao
    :param name:name of gongzhonghao
    :return:url of gongzhonghao
    """
    name_s = quote(name)
    search_url = 'https://weixin.sogou.com/weixin?type=1&s_from=input&query='+name_s
    while retrytimes >= 0:
        try:
            retrytimes -= 1
            #time.sleep(random.uniform(0, 3))
            response = requests.get(search_url,headers = search_headers,proxies = proxies)
            content = etree.HTML(response.text)
            urls = content.xpath('//*[@id="sogou_vr_11002301_box_0"]/div/div[2]/p[1]/a/@href')
            if len(urls) > 0:
                cookie = response.cookies
                cookie_jar = ''
                for coo in iter(cookie):
                    name = coo.name
                    value = coo.value
                    scoo = name + '=' + value + ';'
                    cookie_jar += scoo
                if 'SNUID=' in cookie_jar:
                    detail_url = process_url(urls[0], search_url, cookie_jar, response.text,proxies)
                    if 'SNUID=1' not in detail_url:
                        return detail_url
                else:
                    logging.info("fail to process url of {}:{}".format(name,cookie_jar))
                    proxies,host,port = get_proxies()
                    return get_gzh_url(name, proxies,retrytimes - 1)
            else:
                logging.info("fail to get url of {}:{}".format(name,urls))
                proxies, host, port = get_proxies()
                return get_gzh_url(name,proxies,retrytimes-1)
        except ProxyError:
            logging.info("proxyError,get new proxy ip!")
            proxies, host, port = get_proxies()
            return get_gzh_url(name, proxies,retrytimes - 1)
        except Exception as e:
            logging.info("happen exception,fail to get url of {}:{}".format(name,e))
            proxies, host, port = get_proxies()
            return get_gzh_url(name, proxies,retrytimes - 1)
    logging.error("fail to get url of {} after try three times".format(name))
    return []

def get_article_list(gzh_url,name,host,port,retrytimes):
    while retrytimes >= 0:
        # phantomJSdriver = r'D:\Program Files\phantomjs-2.1.1-windows\bin\phantomjs.exe'
        # os.environ["webdriver.phantomjs.driver"] = phantomJSdriver
        # dcap = dict(DesiredCapabilities.PHANTOMJS)
        # dcap["phantomjs.page.settings.userAgent"] = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36")
        # service_args = ["--proxy-type=https", "--proxy=%s:%s" % (host, port)]
        # driver = webdriver.PhantomJS(phantomJSdriver, desired_capabilities=dcap, service_args=service_args)
        # driver.set_page_load_timeout(20)
        # driver.set_script_timeout(20)
        # driver.set_window_size(800, 600)
        chrome_options = Options()
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument("--proxy-server=http://{}:{}".format(host,port))
        chrome_options.add_argument('user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36"')
        # prefs = {"profile.managed_default_content_settings.images": 2}#禁止图片加载
        # chrome_options.add_experimental_option("prefs", prefs)
        driver = webdriver.Chrome(chrome_options=chrome_options)
        driver.implicitly_wait(5)  # 操作、获取元素时的隐式等待时间
        driver.set_page_load_timeout(20)  # 页面加载超时等待时间
        driver.set_script_timeout(20)
        try:
            #time.sleep(random.uniform(0, 3))
            driver.get(gzh_url)
            content = driver.page_source
            page = etree.HTML(content)
            detailUrls = page.xpath('//h4[@class="weui_media_title"]/@hrefs')
            dates = page.xpath('//p[@class="weui_media_extra_info"]/text()')
            if len(detailUrls) > 10:
                detailUrls = detailUrls[:10]
                dates = dates[:10]
                driver.quit()
                return detailUrls,dates
            else:
                logging.info("fail to get url of article list:{}".format(name))
                proxies, host, port = get_proxies()
                driver.quit()
                return get_article_list(gzh_url,name,host,port,retrytimes-1)
        except ProxyError:
            logging.info("proxyError,get new proxy ip!")
            proxies, host, port = get_proxies()
            driver.quit()
            return get_article_list(gzh_url,name, host,port,retrytimes - 1)
        except Exception as e:
            logging.info("fail to get url of article list:{},{}".format(name,e))
            driver.quit()
            proxies, host, port = get_proxies()
            return get_article_list(gzh_url,name, host,port,retrytimes - 1)
    logging.error("fail to get url of article list:{}".format(name))
    return [],[]

def get_aticle_source(detail_url,name,proxies,retrytimes):
    while retrytimes >= 0:
        try:
            # logging.info("do request to url:{}".format(detail_url))
            #time.sleep(random.uniform(0, 3))
            response = requests.get(detail_url, headers = article_list_headers,proxies = proxies)
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
                logging.info("content is empty")
                detail_url = page.xpath('//*[@id="js_share_source"]/@href')
                if len(detail_url) > 0:
                    detail_url = detail_url[0]
                    return get_aticle_source(detail_url, name, proxies,retrytimes - 1)
                proxies, host, port = get_proxies()
                return get_aticle_source(detail_url,name,proxies,retrytimes-1)
        except ProxyError:
            logging.info("proxyError,get new proxy ip!")
            proxies, host, port = get_proxies()
            return get_aticle_source(detail_url,name,proxies,retrytimes-1)
        except Exception as e:
            # traceback.print_exc()
            logging.warning("fail to get article content:{},{},{}".format(name,detail_url,e))
            return get_aticle_source(detail_url, name, proxies,retrytimes - 1)
    return [],[],[],[],[]

def pipeline2db(name_dept,retrytimes=3):
    name = name_dept[0]
    dept = name_dept[1]
    appname = name_dept[2]
    proxies, host, port = get_proxies()
    gzh_url = get_gzh_url(name,proxies,retrytimes)
    if len(gzh_url) > 0:
        logging.warning("sucess to get gzh_url!{}".format(name))
        logging.info(gzh_url)
        detail_urls,dates = get_article_list(gzh_url,name,host,port,retrytimes)
        if len(detail_urls) == len(dates) and len(detail_urls) > 0:
            for i in range(len(detail_urls)):
                #time.sleep(random.uniform(0, 1))
                detail_url = detail_urls[i]
                detail_url = "https://mp.weixin.qq.com"+detail_url
                detail_url = detail_url.replace("http://mp.weixin.qq.com", "")
                content, authors, title, iframes, img_urls = get_aticle_source(detail_url, name, proxies,retrytimes)
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
                        process_item(wechat_data,appname)
        else:
            logging.warning("fail to get detail article url!!")
    else:
        logging.warning("fail to get gzh{} url!!".format(name))