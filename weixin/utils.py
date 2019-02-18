import base64
import hashlib
import json
import re
import time
import pymysql
import requests
from requests import HTTPError
from lxml import etree
from urllib import request
import urllib3
import setting
urllib3.disable_warnings()

def du(url, name):
    print(url)
    body = requests.get(url=url, verify=False)
    rsps = base64.b64encode(body.content)
    header_dict = {
        'User-Agent': "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
        "Content-Type": "application/json"}
    img_url = setting.QING_NIU_IMG
    pdf_url = setting.QING_NIU_PDF
    id = base64.b64encode(name.encode())
    name = id.decode()
    qiniu_data = {"fileName": name, "contentBytes": rsps.decode(encoding='utf-8')}
    textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
    if ".pdf" in url:
        req = requests.post(url=pdf_url, data=textmod, headers=header_dict)
        return req.text
    else:
        try:
            req = requests.post(url=img_url, data=textmod, headers=header_dict).text
            if "http://" not in req:
                return url
            else:
                return req
        # 当出现500异常
        except HTTPError as e:
            print("************", e)
            url_ = url, m = hashlib.md5()
            m.update(bytes(str(time.clock()), encoding='utf-8'))
            name_ = m.hexdigest()
            du(url_, name_)


# 标题+sourseMD5
def parse_title(title):
    ids = title
    if len(title) < 2:
        print("传入的标题不能为空！！！")
        return ""
    try:
        post_name = hashlib.md5(ids.encode(encoding='UTF-8')).hexdigest()
        return post_name
    except:
        print("标题存在非法符号！！！")


# 改变图片链接
def sub_img_url(response):
    if type(response) is str:
        url_content = response
    else:
        url_content = response.text

    rsp = etree.HTML(url_content)
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
        content = url_content.replace(origian_first, first_string)

        file_name = fname + img_format
        write2_qiniu(link, file_name)
        return content
    # imgs = re.compile('.*?<img.*?=("http.*?").*?>', re.S).findall(rsp)
    # if imgs:
    #     img_url = list(set([i.replace('"', "") for i in imgs if len(i) > 40]))
    #     for url in img_url:
    #         old_img_url = "src=" + '"' + url + '"'
    #         iid = max(url.split("/"), key=lambda x: len(x))
    #         if "mmbiz.qpic.cn" in url:
    #             url = url + "&tp=webp&wxfrom=5&wx_lazy=1"
    #             old_img_url = "data-src=" + '"' + url.replace("&tp=webp&wxfrom=5&wx_lazy=1", "") + '"'
    #         if "academic.oup.com" not in url:
    #             now_img_url = "src=" + du(url, iid)
    #             print("原始图片链接为：", old_img_url)
    #             print("返回的url：", now_img_url)
    #             rsp = rsp.replace(old_img_url, now_img_url)
    #     return rsp
    # else:
    #     return rsp


# 隐藏更多信息需要传入html文本字符串和xpath规则(文本内容)，对哪个标签进行隐藏
def hide_data(datas, content_xpath, hide_xpath="</p>"):
    try:
        node = etree.HTML(datas).xpath(content_xpath)[0]
        content = etree.tostring(node, method='html').decode("utf-8")
        c_list = content.split(hide_xpath)
        if len(c_list) > 2:
            str_content = c_list[0] + hide_xpath + c_list[1] + hide_xpath + '\n<!--more-->'
            str_left = hide_xpath.join(c_list[2:])
            content = str_content + str_left
        return content
    except:
        pass


# 默认参数hide是以p标签作为隐藏标签
# def hide_and_sub(response, xpath, hide_xpath):
#     tmp = sub_img_url(response)
#     content = hide_data(tmp, xpath, hide_xpath)
#     return content

def hide_content(response, content_xpath, hide_xpath="</p>"):
    try:
        response.encoding = 'utf-8'
        url_content = response.text
        rsp = etree.HTML(url_content)
        content = ''
        content_nodes = rsp.xpath('//div[@class="rich_media_content "]')
        if len(content_nodes) > 0:
            node = content_nodes[0]
            content = etree.tostring(node, method='html').decode("utf-8")
            c_list = content.split("</p>")
            if len(c_list) >= 2:
                str_content = c_list[0] + '</p>' + c_list[1] + '</p>' + '\n<!--more-->'
                str_left = '</p>'.join(c_list[2:])
                content = str_content + str_left
        return content
    except:
        pass

def replace_img_url(response, content):
    response.encoding = 'utf-8'
    url_content = response.text
    rsp = etree.HTML(url_content)
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


        first_string = 'src="http://bigdata.dev.file.dachentech.com.cn/' + fname + img_format

        origian_first = 'data-src="' + link
        content = content.replace(origian_first, first_string)

        file_name = fname + img_format
        write2_qiniu(link, file_name)
        return content

def write2_qiniu(url, name):
    try:
        img = requests.get(url=url)
        pic = base64.b64encode(img.content)
        qiniu_data = {"fileName": name, "contentBytes": pic.decode(encoding='utf-8')}
        textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
        header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
                   "Content-Type": "application/json"}
        if setting.debug:
            re_url = 'http://192.168.2.108:8076/qiniu/upload/bigdata'
        else:
            re_url = 'http://xg.mediportal.com.cn/docapi/qiniu/upload/content?access_token=36e93fe6391d4e638635df2c286e73da'

        req = request.Request(url=re_url, data=textmod, headers=header_dict)
        res = request.urlopen(req)
        n_url = res.read()
        print(name)
        return n_url
    except Exception as e:
        print(e)
        return ''
        

# 默认参数hide是以p标签作为隐藏标签
def hide_and_sub(response, xpath, hide_xpath):
    #tmp = sub_img_url(response)
    #content = hide_data(tmp, xpath, hide_xpath)
    content = hide_content(response, xpath, hide_xpath)
    if content == '':
        print("************** content is null")
    content = replace_img_url(response, content)
    return content


# 数据库去重操作(传入postname)
def database_filter():
    '''
    :param type(args) == str
    :return: 存在是[id]
    '''
    host = setting.MYSQL_HOST
    user = setting.MYSQL_USER
    psd = setting.MYSQL_PASSWORD
    db = setting.MYSQL_DB
    c = setting.CHARSET
    port = setting.MYSQL_PORT
    # 数据库连接
    con = pymysql.connect(host=host, user=user, passwd=psd, db=db, charset=c, port=port)
    # 数据库游标
    _end = con.cursor()
    print("mysql connect succes")
    try:
        _end.execute("SELECT guid FROM wp_posts")
        result = _end.fetchall()
        return [i[0] for i in result]
    except Exception as e:
        print('Insert error:', e)
    finally:
        con.close()

# 数据库去重操作(传入guid)
def is_exists(guid):
    host = setting.MYSQL_HOST
    user = setting.MYSQL_USER
    psd = setting.MYSQL_PASSWORD
    db = setting.MYSQL_DB
    c = setting.CHARSET
    port = setting.MYSQL_PORT
    # 数据库连接
    con = pymysql.connect(host=host, user=user, passwd=psd, db=db, charset=c, port=port)
    # 数据库游标
    _end = con.cursor()
    print("mysql connect succes")
    try:
        _end.execute("SELECT post_name FROM wp_posts where guid = '%s'" % (guid))
        result = _end.fetchall()

        if len(result) > 0:
            return True
        else:
            return False
    except Exception as e:
        print('Insert error:', e)
    finally:
        con.close()