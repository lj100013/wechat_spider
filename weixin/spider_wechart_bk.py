# -*- coding:utf-8 -*-
from db import *
from utils import *
import random
import setting
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

import os
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium import webdriver

def get_ip():
    # 获取IP的API接口
    apiUrl = "http://webapi.http.zhimacangku.com/getip?num=1&type=1&pro=&city=0&yys=0&port=1&pack=34734&ts=0&ys=0&cs=0&lb=1&sb=0&pb=4&mr=1&regions="
    # 获取IP时间间隔，建议为5秒
    res = requests.get(apiUrl).text
    return res

def spider_url():
    base_url = "https://weixin.sogou.com/weixin?type=1&s_from=input&query="
    urls = [["每日医学资讯", "医学资讯"], ["医师报", "医学资讯"], ["医脉通", "医学资讯"], ["健康界", "医学资讯"], ["生物谷", "医学资讯"], ["看医界", "医学资讯"], ["看医界", "医学资讯"], ["好医生", "全科"], 
        ["丁香园", "全科"], ["儿科时间", "儿科"], ["医学界消化肝病频道", "消化内科"], ["小大夫漫画", "全科"], ["消化界", "消化内科"],["MedSci梅斯", "全科"],
        ["华医网", "全科"], ["IBD学术情报官", "消化内科"], ["爱肝联盟", "肝病科"], ["临床肝胆病杂志", "肝胆外科"], ["消化时间", "消化内科"], ["医脉通消化科", "消化内科"], ["孙锋医生", "肛肠外科"],
        ["基层医师公社", "全科"], ["医学界","全科"], ["医学界心血管频道", "心血管内科"], ["心血管时间", "心血管内科"], ["心在线", "心血管内科"], ["中国循环杂志", "心血管内科"], ["医脉通心内频道", "心血管内科"],
        ["哈特瑞姆心脏之声", "心血管内科"], ["医学之声", "全科"], ["医学界急诊与重症频道", "急诊科"], ["医路向前巍子", "急诊科"], ["医学界神经病学频道", "神经内科"], ["神经时间", "神经内科"],
        ["神经病学俱乐部", "神经内科"], ["医脉通神经科", "神经内科"], ["国际眼科时讯", "眼科"], ["医信眼科", "眼科"], ["眼视光观察", "眼科"], ["视远惟明▪惟视眼科", "眼科"], ["医脉通泌尿外科", "泌尿外科"],
        ["泌尿科那点事儿", "泌尿外科"], #["肝胆外科","肝胆外科"], ["泌尿外科郭医生","泌尿外科"],
        ["医学界外科频道", "普外科"], ["中国实用外科杂志", "肛肠外科"], ["医学界儿科频道","儿科"], ["国际儿科学杂志", "儿科"], ["医学界精神病学频道","精神心理科"], ["儿科学大查房", "小儿内科"],
        ["人卫儿科", "小儿内科"], ["中国儿科前沿论坛", "小儿内科"], ["皮肤时间","皮肤科"], ["实用皮肤病学杂志", "皮肤科"], ["肾内时间", "肾内科"], ["医脉通肾内频道", "肾内科"], ["透析圈", "肾内科"],
        ["感染时间", "感染科"], ["SIFIC感染官微", "感染科"], ["医脉通抗感染", "感染科"], ["医学界感染频道", "感染科"], ["中华医学网", "普内科"], ["海上柳叶刀", "普内科"], ["医学内刊", "普内科"],
        ["内分泌时间", "内分泌科"], ["神经科技", "神经外科"], ["医学界风湿免疫频道", "风湿免疫科"],  ["医学界临床药学频道", "全科"], ["老虎讲骨", "骨科"]
    ]

    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36",
        "Host": "weixin.sogou.com"
    }

    proxies = {}
    host = ""
    port = ""
    index = 0
    wechat_len = len(urls)
    wechat_urls = []
    num_count = []
    for i in range(10000):
        if index == wechat_len:
            break

        mail_url = base_url + urls[index][0]
        try:
            response0 = requests.get(mail_url, headers=headers, proxies=proxies)
            content0 = etree.HTML(response0.text)
            urlst0 = content0.xpath('//*[@id="sogou_vr_11002301_box_0"]/div/div[2]/p[1]/a/@href')
        except Exception as e:
            print(e)
            ips = get_ip().strip()
            print("重新获取代理ip：{}".format(ips))
            proxies = {
                "https": "https://" + ips}
            print(proxies)
            host = ips.split(":")[0]
            port = ips.split(":")[1]
            continue

        print(index)
        print(urlst0)
        if len(urlst0) > 0:
            url1 = urlst0[0]
            phantomJSdriver = '/data/program/phantomjs-2.1.1-linux-x86_64/bin/phantomjs'
            os.environ["webdriver.phantomjs.driver"] = phantomJSdriver
            dcap = dict(DesiredCapabilities.PHANTOMJS)
            dcap["phantomjs.page.settings.userAgent"] = (
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36")
            service_args = ["--proxy-type=https", "--proxy=%s:%s" % (host, port)]
            driver = webdriver.PhantomJS(phantomJSdriver, desired_capabilities=dcap, service_args=service_args)
            driver.set_page_load_timeout(20)
            driver.set_script_timeout(20)
            try:
                driver.get(url1)
                content = driver.page_source
                page = etree.HTML(content)
                n_urls = page.xpath('//h4[@class="weui_media_title"]/@hrefs')
                if len(n_urls) > 0:
                    index += 1
                    head_url = "https://mp.weixin.qq.com"
                    if len(n_urls) > 10:
                        n_urls = n_urls[:10]
                    for n_url in n_urls:
                        n_url = n_url.replace("http://mp.weixin.qq.com", "")
                        detail_url = head_url + n_url
                        wechat_urls.append(detail_url)
                else:
                    ips = get_ip().strip()
                    print("重新获取代理ip：{}".format(ips))
                    proxies = {
                        "https": "https://" + ips}
                    print(proxies)
                    host = ips.split(":")[0]
                    port = ips.split(":")[1]
            except Exception as e:
                print(e)
            finally:
                driver.quit()
        else:
            if num_count:
                if num_count[0] == urls[index][0]:
                    num_count[1] = num_count[1] + 1
                else:
                    num_count[1] = 1
                    num_count[0] = urls[index][0]
                if num_count[1] > 3:
                    index += 1
            else:
                num_count.append(urls[index][0])
                num_count.append(1)

            ips = get_ip().strip()
            print("重新获取代理ip：{}".format(ips))
            proxies = {
                "https": "https://" + ips}
            print(proxies)
            host = ips.split(":")[0]
            port = ips.split(":")[1]
    with open("url.txt", "w+") as f:
        url_datas = '\n'.join(wechat_urls)
        f.write(url_datas)

def start_spider():
    # ids = database_filter("26", "13", "3", "12", "11", "15", "29","16","17","18","19","20","21", "22", "23", "24", "25", "48", "49", "50", "51", "52", "53", "54",
    #                       "45", "46", "47", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78",
    #                       "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96")
    #ids = database_filter()

    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36",
        "Host": "mp.weixin.qq.com"
    }

    name_keyword = {
        "好医生": "QK", "丁香园": "QK", "看医界": "INFO", "医学界消化肝病频道": "NKAC", "小大夫漫画": "QK", "消化界": "NKAC", "MedSci梅斯": "QK",
        "华医网": "QK", "IBD学术情报官": "NKAC", "爱肝联盟": "CRAC", "临床肝胆病杂志": "WKAB", "消化时间": "NKAC", "医脉通消化科": "NKAC",
        "孙锋医生": "WKAC", "基层医师公社": "QK", "医学界": "QK", "医学界心血管频道": "NKAA", "心血管时间": "NKAA", "心在线": "NKAA",
        "中国循环杂志": "NKAA", "医脉通心内频道": "NKAA", "哈特瑞姆心脏之声": "NKAA", "医学之声": "QK", "医学界急诊与重症频道": "JZ",
        "医路向前巍子": "JZ", "医学界神经病学频道": "NKAB", "神经时间": "NKAB", "神经病学俱乐部": "NKAB", "医脉通神经科": "NKAB", "国际眼科时讯": "YK",
        "医信眼科": "YK", "眼视光观察": "YK", "视远惟明▪惟视眼科": "YK", "医脉通泌尿外科": "WKAA", "泌尿科那点事儿": "WKAA", "泌尿外科郭医生": "WKAA",
        "医学界外科频道": "WKAG", "中国实用外科杂志": "WKAC", "儿科时间": "EK", "医学界儿科频道": "EK", "国际儿科学杂志": "EK", "医学界精神病学频道": "JS",
        "儿科学大查房": "EKAB", "人卫儿科": "EKAB", "中国儿科前沿论坛": "EKAB", "皮肤时间": "PFAB", "实用皮肤病学杂志": "PFAB",
        "肝胆外科": "WKAB", "肾内时间": "NKAL", "医脉通肾内频道": "NKAL", "透析圈": "NKAL", "感染时间": "NKAJ", "SIFIC感染官微": "NKAJ", "医脉通抗感染": "NKAJ",
        "医学界感染频道": "NKAJ", "中华医学网": "NKAM", "海上柳叶刀": "NKAM", "医学内刊": "NKAM", "每日医学资讯": "INFO", "医师报": "INFO",
        "医脉通": "INFO", "健康界": "INFO", "生物谷": "INFO", "看医界": "INFO", "内分泌时间": "NKAD", "神经科技": "WKAH", "医学界风湿免疫频道": "NKAE",
        "医学界临床药学频道": "QK", "老虎讲骨": "WKAR"
    }

    proxies = {}
    ips = get_ip().strip()
    print("获取代理ip：{}".format(ips))
    proxies = {"https": "https://" + ips}
    print(proxies)

    with open("url.txt", "r") as f:
        datas = f.readlines()

        for line in datas:
            detail_url = line.strip()
            if len(detail_url) < 30:
                continue

            # 使用post方法进行提交
            try:
                result = requests.get(url=detail_url, headers=headers, proxies=proxies)
                result.encoding = 'utf-8'
                url_content = result.text
            except Exception as e:
                print(e)
                ips = get_ip().strip()
                print("重新获取代理ip：{}".format(ips))
                proxies = {"https": "https://" + ips}
                print(proxies)
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

                if setting.debug:
                    first_string = 'src="http://bigdata.dev.file.dachentech.com.cn/' + fname + img_format
                else:
                    first_string = 'src="http://content.file.mediportal.com.cn/' + fname + img_format

                #first_string = 'src="http://bigdata.dev.file.dachentech.com.cn/' + fname + img_format
                origian_first = 'data-src="' + link
                content = content.replace(origian_first, first_string)

                file_name = fname + img_format
                write2_qiniu(link, file_name)

            # permission blank wechart picture
            blank_pattern = "background-image: url([\s\S]*?);background"
            blank_urls = re.findall(blank_pattern, content)
            for blank_img in blank_urls:
                file_name = "NzKkzoeG5s2FcdXyTKYAErrs5QNBXGVS75aQnxYX1RmPQTRwN3CsZw5Dfjb3oiaYLjgNaWrFck8rJJRoqHxuItA.jpeg"
                if setting.debug:
                    first_string = 'http://bigdata.dev.file.dachentech.com.cn/' + file_name
                else:
                    first_string = 'http://content.file.mediportal.com.cn/' + file_name
                blank_img = blank_img.replace('(', '')
                blank_img = blank_img.replace(')', '')
                content = content.replace(blank_img, first_string)

            # video picture
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
            datas = re.sub(r"\s+", "", url_content.replace("\xa5", ""))
            date_re = re.compile('varpublish_time="(.*?)"')
            tmp = date_re.findall(datas)[0]
            wechat_data['create_time'] = tmp
            wechat_data['content'] = content
            wechat_data['gid'] = gid
            process_item(wechat_data)

if __name__ == '__main__':
    spider_url()
    start_spider()

