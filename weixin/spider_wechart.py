# -*- coding:utf-8 -*-
from db import *
from setting import *
from utils import *
import time
import re
from multiprocessing.dummy import Pool as ThreadPool
import os
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium import webdriver
import math
import random
from urllib.parse import quote
import configparser
conf = configparser.ConfigParser()
#conf.read(r"E:\job_script\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
img_base_url=conf.get('weixin', 'img_base_url')
import urllib3
urllib3.disable_warnings()


ip_count = 0
article_count = 0

# 获取IP的API接口
def get_ip():
    time.sleep(2)
    # 获取IP时间间隔，建议为5秒
    res = requests.get(zhi_ma_apiUrl).text
    global ip_count
    ip_count = ip_count + 1
    print('代理ip数: ' + str(ip_count))
    return res


def parse_url(url, pads):
    b = math.floor(random.random() * 100) + 1
    a = url.find("url=")
    c = url.find("&k=")
    if a != -1 and c == -1:
        a = url[a + sum([int(i) for i in pads]) + b]
    return '{}&k={}&h={}'.format(url, b, a)


def format_url(url, main_url, cookie_jar, text, proxies):
    if url.startswith('/link?url='):
        url = 'https://weixin.sogou.com{}'.format(url)
        patt = r'href\.substr\(a\+(\d+)\+parseInt\("(\d+)"\)\+b,1\)'
        pads = re.findall(patt, text)
        url = parse_url(url, pads[0] if pads else [])
        headers = main_headers.copy()
        headers['Referer'] = main_url
        headers["Cookie"] = cookie_jar
        response = requests.get(url, headers=headers, verify=False, proxies=proxies)
        content = response.text
        pattern = r"'([\s\S]*?)'"
        id_node = re.findall(pattern, content)
        uri = ''.join(id_node)
        url = uri.replace('@', '')
    else:
        print("## get mail url wrong #")

    return url

def spider_wechat(name):
    url_name = quote(name)
    mail_url = base_url + url_name
    print(mail_url)
    ips = get_ip().strip()
    proxies = {'http': ips, 'https': ips}
    print(proxies)
    host = ips.split(":")[0]
    port = ips.split(":")[1]
    null_url = True
    a_url = ''
    wechat_ip_count = 0

    while null_url:
        try:
            time.sleep(3)
            response = requests.get(mail_url, headers=main_headers, proxies=proxies)
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
                    time.sleep(2)
                    a_url = format_url(urls[0], mail_url, cookie_jar, response.text, proxies)
                    if 'SNUID=1' not in a_url:
                        null_url = False
                else:
                    return 1
            else:
                new_ips = get_ip().strip()
                print("重新获取代理ip：{}".format(new_ips))
                wechat_ip_count += 1
                proxies = {"https": "https://" + new_ips}
                online_ips = new_ips.split(":")
                if len(online_ips) > 1:
                    host = online_ips[0]
                    port = online_ips[1]
        except Exception as e:
            print(e)
            new_ips = get_ip().strip()
            print("重新获取代理ip：{}".format(new_ips))
            wechat_ip_count += 1
            proxies = {"https": "https://" + new_ips}
            online_ips = new_ips.split(":")
            if len(online_ips) > 1:
                host = online_ips[0]
                port = online_ips[1]

        if wechat_ip_count > 15 or ip_count > 500:
            return 1

    phantomJSdriver = phantomJS_path
    os.environ["webdriver.phantomjs.driver"] = phantomJSdriver
    dcap = dict(DesiredCapabilities.PHANTOMJS)
    dcap["phantomjs.page.settings.userAgent"] = (driver_user_agent)
    no_article = True
    wechart_urls = []
    url_date = {}
    wechat_ip_count = 0

    while no_article:
        if not a_url:
            break

        service_args = ["--proxy-type=https", "--proxy=%s:%s" % (host, port)]
        driver = webdriver.PhantomJS(phantomJSdriver, desired_capabilities=dcap, service_args=service_args)
        driver.set_page_load_timeout(20)
        driver.set_script_timeout(20)

        try:
            driver.get(a_url)
            time.sleep(2)
            content = driver.page_source
            page = etree.HTML(content)
            n_urls = page.xpath('//h4[@class="weui_media_title"]/@hrefs')
            dates = page.xpath('//p[@class="weui_media_extra_info"]/text()')
            if len(n_urls) > 0:
                head_url = "https://mp.weixin.qq.com"
                index = 0
                if len(n_urls) > 10:
                    n_urls = n_urls[:10]
                    dates = dates[:10]

                for n_url in n_urls:
                    n_url = n_url.replace("http://mp.weixin.qq.com", "")
                    detail_url = head_url + n_url
                    wechart_urls.append(detail_url)
                    url_date[detail_url] = dates[index]
                    index += 1
                    no_article = False
            else:
                new_ips = get_ip().strip()
                print("重新获取代理ip：{}".format(new_ips))
                wechat_ip_count += 1
                proxies = {"https": "https://" + new_ips}
                online_ips = new_ips.split(":")
                if len(online_ips) > 1:
                    host = online_ips[0]
                    port = online_ips[1]
        except Exception as e:
            print(e)
            new_ips = get_ip().strip()
            print("重新获取代理ip：{}".format(new_ips))
            wechat_ip_count += 1
            proxies = {"https": "https://" + new_ips}
            online_ips = new_ips.split(":")
            if len(online_ips) > 1:
                host = online_ips[0]
                port = online_ips[1]
        finally:
            driver.quit()

        if wechat_ip_count > 12:
            return 1

    for line in wechart_urls:
        detail_url = line.strip()
        if len(detail_url) < 30:
            continue

        try:
            result = requests.get(url=detail_url, headers=weixin_header, proxies=proxies)
            result.encoding = 'utf-8'
            url_content = result.text
        except Exception as e:
            print(e)
            new_ips = get_ip().strip()
            print("重新获取代理ip：{}".format(new_ips))
            proxies = {"https": "https://" + new_ips}
            continue

        rsp = etree.HTML(url_content)
        content_nodes = rsp.xpath('//div[@class="rich_media_content "]')
        if len(content_nodes) == 0:
            continue

        authors = rsp.xpath('//a[@id="js_name"]/text()')
        if len(authors) < 1:
            print(authors)
            print("author not exist")
            continue
        wxname = authors[0].strip()
        iframes = rsp.xpath('//iframe[@class="video_iframe"]/@data-src')
        title = rsp.xpath('//h2[@class="rich_media_title"]/text()')[0].strip('\n').strip()
        print("spidering " + title)
        gid = parse_title(title)
        if is_exists(gid):
            continue

        node = content_nodes[0]
        content = etree.tostring(node, method='html').decode("utf-8")
        c_list = content.split("</p>")
        if len(c_list) < 2:
            continue
        str_content = c_list[0] + '</p>' + c_list[1] + '</p>' + '\n<!--more-->'
        str_left = '</p>'.join(c_list[2:])
        content = str_content + str_left
        img_urls = rsp.xpath('//img/@data-src')
        img_not_post = False

        for link in img_urls:
            link_list = link.split("/")
            if len(link_list) != 6:
                continue

            print(link)
            strName = link_list[4]
            fname = base64.b64encode(strName.encode('utf-8'))
            fname = fname.decode('utf-8')
            img_format = '.png'
            if '=jpeg' in link:
                img_format = '.jpeg'
            elif '=gif' in link:
                img_format = '.gif'
            first_string = 'src="' + img_base_url + fname + img_format
            origian_first = 'data-src="' + link
            content = content.replace(origian_first, first_string)
            file_name = fname + img_format
            writed = write2_qiniu(link, file_name)
            if writed == '':
                img_not_post = True
                print(wxname + ": " + gid +" no spider for picture reason")
                break

        if img_not_post:
            continue
        blank_pattern = "background-image: url([\s\S]*?);background"
        if wxname == '中洪博元医学实验帮':
            blank_pattern = "-webkit-border-image: url([\s\S]*?) 20 fill"

        blank_urls = re.findall(blank_pattern, content)
        for blank_img in blank_urls:
            file_name = blank_jpeg_img
            first_string = img_base_url + file_name
            blank_img = blank_img.replace('(', '')
            blank_img = blank_img.replace(')', '')
            content = content.replace(blank_img, first_string)

        for frame in iframes:
            vids = frame.split("&")
            if len(vids) < 1:
                continue
            vid = vids[-1]
            frame = frame.replace("&", "&amp;")
            vedios = frame.split("?")
            if len(vedios) < 1:
                continue
            vedio_str = vedios[1]
            original_str = 'data-src="https://v.qq.com/iframe/preview.html?' + vedio_str + '"'
            replace_str = 'src="https://v.qq.com/txp/iframe/player.html?' + vid + '" ' + 'width="580" height="280"'
            content = content.replace(original_str, replace_str)

        wechat_data = {}
        wechat_data['title'] = title
        wechat_data['author'] = wxname
        if wxname in name_keyword:
            wechat_data['key_word'] = name_keyword[wxname]
        elif '视远惟明' in wxname:
            wechat_data['key_word'] = name_keyword['视远惟明▪惟视眼科']

        wechat_data['wxname'] = wechat_data['author']
        if line in url_date:
            create_date = url_date[line]
            tmp = formate_date(create_date)
            wechat_data['create_time'] = tmp
            wechat_data['content'] = content
            wechat_data['gid'] = gid
            process_item(wechat_data)
            global article_count
            article_count = article_count + 1
            print("article count:" + str(article_count))


if __name__ == '__main__':
    pool = ThreadPool(4)
    pool.map(spider_wechat, urls)
    pool.close()
    pool.join()