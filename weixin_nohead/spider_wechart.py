# -*- coding:utf-8 -*-
from db import *
from utils import *
from weixin_nohead import *
import time
from multiprocessing.dummy import Pool as ThreadPool
import os
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium import webdriver
import urllib3
urllib3.disable_warnings()

base_url = "https://weixin.sogou.com/weixin?type=1&s_from=input&query="
headers0 = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36",
    "Host": "weixin.sogou.com"
}

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
    "肝胆外科": "WKAB", "肾内时间": "NKAL", "医脉通肾内频道": "NKAL", "透析圈": "NKAL", "感染时间": "NKAJ", "SIFIC感染官微": "NKAJ",
    "医脉通抗感染": "NKAJ",
    "医学界感染频道": "NKAJ", "中华医学网": "NKAM", "海上柳叶刀": "NKAM", "医学内刊": "NKAM", "每日医学资讯": "INFO", "医师报": "INFO",
    "医脉通": "INFO", "健康界": "INFO", "生物谷": "INFO", "看医界": "INFO", "内分泌时间": "NKAD", "神经科技": "WKAH", "医学界风湿免疫频道": "NKAE",
    "医学界临床药学频道": "QK", "老虎讲骨": "WKAR", "放疗时空":"JY", "医学界检验频道":"JY", "医学界影像诊断与介入频道":"JY", "放射沙龙":"JY", "健康点healthpoint":"WKAT",
    "肿瘤时间":"WKAT", "医学界肿瘤频道":"WKAT", "感染科空间":"NKAJ", "SIFIC感染科普笔记":"NKAJ", "下夜班":"QK", "医闻速递":"INFO", "三甲传真":"INFO", "创新医学网":"QK",
    "爱肝一生微课堂": "CRAC", "国际肝胆胰疾病杂志": "CRAC", "胃肠肿瘤外科": "WKAC", "儿科助手":"EK", "中华儿科杂志":"EKAB", "儿科空间":"EK", "中国实用儿科杂志":"EK",
    "皮肤科钟华":"PFAB", "CSDCMA皮科时讯论坛":"PFAB", "医生汇心血管论坛": "NKAA", "医脉通急诊重症科": "JZ", "急诊医学资讯": "JZ", "中国急救医学杂志": "JZ",
    "急诊时间": "JZ", "中国小儿急救医学": "JZ", "重症医学": "JZ", "精神时间":"JS", "精神康复":"JS", "医脉通精神科":"JS", "大话精神":"JS", "神经科的那些事":"NKAB",
    "神经医学社区":"NKAB", "神经脊柱时讯": "NKAB", "医学界呼吸频道": "NKAF", "中国眼科医生": "YK", "SIFIC感染循证资讯": "NKAJ", "中华消化外科杂志": "NKAC",
    "朝阳心脏超声": "NKAA", "危重症文献学习": "ZZ", "中华重症医学电子杂志": "ZZ", "神经现实": "SJ", "神经介入资讯": "SJ",
    "医药魔方": "INFO", "赛博蓝": "INFO", "中洪博元医学实验帮": "INFO", "医咖会": "INFO", "生物学霸": "INFO"
}


ip_count = 0
article_count = 0


def get_ip():
    # 获取IP的API接口
    time.sleep(2)
    apiUrl = "http://webapi.http.zhimacangku.com/getip?num=1&type=1&pro=&city=0&yys=0&port=1&pack=34734&ts=0&ys=0&cs=0&lb=1&sb=0&pb=4&mr=1&regions="
    # 获取IP时间间隔，建议为5秒
    res = requests.get(apiUrl).text
    global ip_count
    ip_count = ip_count + 1
    print('代理ip数: ' + str(ip_count))
    return res


def spider_wechat(name):
    mail_url = base_url + name
    print(mail_url)
    ips = get_ip().strip()
    proxies = {"https": "https://" + ips}
    print(proxies)
    host = ips.split(":")[0]
    port = ips.split(":")[1]
    null_url = True
    wechart_url = ''

    while null_url:
        try:
            response = requests.get(mail_url, headers=headers0, proxies=proxies)
            content = etree.HTML(response.text)
            urls = content.xpath('//*[@id="sogou_vr_11002301_box_0"]/div/div[2]/p[1]/a/@href')
            if len(urls) > 0:
                wechart_url = urls[0]
                null_url = False
            else:
                new_ips = get_ip().strip()
                print("重新获取代理ip：{}".format(new_ips))
                proxies = {"https": "https://" + new_ips}
                host = new_ips.split(":")[0]
                port = new_ips.split(":")[1]
        except Exception as e:
            print(e)
            new_ips = get_ip().strip()
            print("重新获取代理ip：{}".format(new_ips))
            proxies = {"https": "https://" + new_ips}
            host = new_ips.split(":")[0]
            port = new_ips.split(":")[1]

    phantomJSdriver = '/data/program/phantomjs-2.1.1-linux-x86_64/bin/phantomjs'
    os.environ["webdriver.phantomjs.driver"] = phantomJSdriver
    dcap = dict(DesiredCapabilities.PHANTOMJS)
    dcap["phantomjs.page.settings.userAgent"] = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36")
    no_article = True
    wechart_urls = []

    while no_article:
        service_args = ["--proxy-type=https", "--proxy=%s:%s" % (host, port)]
        driver = webdriver.PhantomJS(phantomJSdriver, desired_capabilities=dcap, service_args=service_args)
        driver.set_page_load_timeout(20)
        driver.set_script_timeout(20)

        try:
            driver.get(wechart_url)
            time.sleep(5)
            content = driver.page_source
            page = etree.HTML(content)
            n_urls = page.xpath('//h4[@class="weui_media_title"]/@hrefs')
            if len(n_urls) > 0:
                head_url = "https://mp.weixin.qq.com"
                if len(n_urls) > 10:
                    n_urls = n_urls[:10]
                for n_url in n_urls:
                    n_url = n_url.replace("http://mp.weixin.qq.com", "")
                    detail_url = head_url + n_url
                    wechart_urls.append(detail_url)
                    no_article = False
            else:
                new_ips = get_ip().strip()
                print("重新获取代理ip：{}".format(new_ips))
                proxies = {
                    "https": "https://" + new_ips}
                host = new_ips.split(":")[0]
                port = new_ips.split(":")[1]
        except Exception as e:
            print(e)
            new_ips = get_ip().strip()
            print("重新获取代理ip：{}".format(new_ips))
            proxies = {
                "https": "https://" + new_ips}
            host = new_ips.split(":")[0]
            port = new_ips.split(":")[1]
        finally:
            driver.quit()

    for line in wechart_urls:
        detail_url = line.strip()
        if len(detail_url) < 30:
            continue

        try:
            result = requests.get(url=detail_url, headers=headers, proxies=proxies)
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

            if setting.debug:
                first_string = 'src="http://bigdata.dev.file.dachentech.com.cn/' + fname + img_format
            else:
                first_string = 'src="http://content.file.mediportal.com.cn/' + fname + img_format
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
            file_name = "NzKkzoeG5s2FcdXyTKYAErrs5QNBXGVS75aQnxYX1RmPQTRwN3CsZw5Dfjb3oiaYLjgNaWrFck8rJJRoqHxuItA.jpeg"
            if setting.debug:
                first_string = 'http://bigdata.dev.file.dachentech.com.cn/' + file_name
            else:
                first_string = 'http://content.file.mediportal.com.cn/' + file_name
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

        content = replace_content(gid, wxname, content)
        wechat_data['wxname'] = wechat_data['author']
        datas = re.sub(r"\s+", "", url_content.replace("\xa5", ""))
        date_re = re.compile('varpublish_time="(.*?)"')
        temp_datas = date_re.findall(datas)
        if len(temp_datas) > 0:
            tmp = temp_datas[0]
            wechat_data['create_time'] = tmp
            wechat_data['content'] = content
            wechat_data['gid'] = gid
            process_item(wechat_data)
            global article_count
            article_count = article_count + 1
            print("article count:" + str(article_count))


if __name__ == '__main__':
    urls = ["每日医学资讯", "医师报", "医脉通", "健康界", "生物谷", "看医界",
            "丁香园", "好医生", "儿科时间", "医学界消化肝病频道", "小大夫漫画", "消化界", "MedSci梅斯",
            "华医网", "IBD学术情报官", "爱肝联盟", "临床肝胆病杂志", "消化时间", "医脉通消化科",
            "孙锋医生", "基层医师公社", "医学界", "医学界心血管频道", "心血管时间","心在线", "中国循环杂志", "医脉通心内频道",
            "哈特瑞姆心脏之声","医学之声", "医学界急诊与重症频道", "医路向前巍子", "医学界神经病学频道",
            "神经时间","神经病学俱乐部", "医脉通神经科", "国际眼科时讯", "医信眼科", "眼视光观察","视远惟明▪惟视眼科", "医脉通泌尿外科","泌尿科那点事儿",
            "医学界外科频道", "中国实用外科杂志", "医学界儿科频道", "国际儿科学杂志", "医学界精神病学频道", "儿科学大查房",
            "人卫儿科", "中国儿科前沿论坛", "皮肤时间", "实用皮肤病学杂志", "肾内时间", "医脉通肾内频道", "透析圈", "感染时间", "SIFIC感染官微", "医脉通抗感染",
            "医学界感染频道", "中华医学网","海上柳叶刀", "医学内刊", "内分泌时间", "神经科技", "医学界风湿免疫频道", "医学界临床药学频道", "老虎讲骨", 
            "放疗时空", "医学界检验频道", "医学界影像诊断与介入频道", "放射沙龙", "健康点healthpoint", "肿瘤时间", "医学界肿瘤频道", "感染科空间", "SIFIC感染科普笔记",
            "下夜班", "医闻速递", "三甲传真", "创新医学网", "爱肝一生微课堂", "国际肝胆胰疾病杂志", "胃肠肿瘤外科", "中华儿科杂志", "儿科空间", "中国实用儿科杂志",
            "皮肤科钟华", "CSDCMA皮科时讯论坛", "医生汇心血管论坛", "医脉通急诊重症科", "急诊医学资讯", "中国急救医学杂志", "急诊时间", "中国小儿急救医学",
            "重症医学", "精神时间", "精神康复", "医脉通精神科", "大话精神", "神经科的那些事", "神经医学社区", "神经脊柱时讯", "医学界呼吸频道", "中国眼科医生",
            "SIFIC感染循证资讯", "中华消化外科杂志", "朝阳心脏超声", "危重症文献学习", "中华重症医学电子杂志", "神经现实", "神经介入资讯",
            "医药魔方", "赛博蓝", "中洪博元医学实验帮", "医咖会", "生物学霸"
            ]

    pool = ThreadPool(8)
    pool.map(spider_wechat, urls)
    pool.close()
    pool.join()