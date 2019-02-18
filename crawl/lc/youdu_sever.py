import base64
import hashlib
import json
import re
import time
# from tkinter import _flatten
import pymysql
import requests
from requests import HTTPError
from scrapy.conf import settings
from lxml import etree
from requests.packages import urllib3
from urllib import request

urllib3.disable_warnings()


def dududududu(url, name):
    img = requests.get(url=url, verify=False)
    pic = base64.b64encode(img.content)
    qiniu_data = {"fileName": name, "contentBytes": pic.decode(encoding='utf-8')}
    textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
    header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
                   "Content-Type": "application/json"}

    re_url = 'http://192.168.3.121:8076/qiniu/upload/bigdata'

    try:
        req = request.Request(url=re_url, data=textmod, headers=header_dict)
        res = request.urlopen(req)
        res.read()
    except Exception as e:
        print(e)
    finally:
        print(name)


# 清流云网址替换,pdf可以单独调用
def du(url, name):
    body = requests.get(url=url, verify=False)
    rsps = base64.b64encode(body.content)
    header_dict = {
        'User-Agent': "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
        "Content-Type": "application/json"}
    img_url = settings["QING_NIU_IMG"]
    pdf_url = settings["QING_NIU_PDF"]
    id = base64.b64encode(name.encode())
    name = id.decode()
    qiniu_data = {"fileName": name, "contentBytes": rsps.decode(encoding='utf-8')}
    textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
    if ".pdf" in url:
        req = requests.post(url=pdf_url, data=textmod, headers=header_dict)
        return req.text
    else:
        try:
            req = requests.post(url=img_url, data=textmod, headers=header_dict)
            return req.text
        # 当出现500异常
        except HTTPError as e:
            print("************", e)
            url_ = url, m = hashlib.md5()
            m.update(bytes(str(time.clock()), encoding='utf-8'))
            name_ = m.hexdigest()
            du(url_, name_)


# 标题+sourseMD5
def parse_title(title, sourse):
    ids = title + sourse
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
        rsp = response
    else:
        rsp = response.text
    imgs = re.compile('.*?<img.*?=("http.*?").*?>', re.S).findall(rsp)
    if imgs:
        img_url = list(set([i.replace('"', "") for i in imgs if len(i) > 40]))
        for url in img_url:
            old_img_url = "src=" + '"' + url + '"'
            iid = max(url.split("/"), key=lambda x: len(x))
            if "mmbiz.qpic.cn" in url:
                url = url + "&tp=webp&wxfrom=5&wx_lazy=1"
                old_img_url = "data-src=" + '"' + url.replace("&tp=webp&wxfrom=5&wx_lazy=1", "") + '"'
            now_img_url = "src=" + du(url, iid)
            rsp = rsp.replace(old_img_url, now_img_url)
        return rsp
    else:
        return rsp


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
def hide_and_sub(response, xpath, hide_xpath):
    tmp = sub_img_url(response)
    content = hide_data(tmp, xpath, hide_xpath)
    return content


# 数据库去重操作(传入postname)
def database_filter(*args):
    '''
    :param type(args) == str
    :return: 存在是[id]
    '''
    host = settings['MYSQL_HOST']
    user = settings['MYSQL_USER']
    psd = settings['MYSQL_PASSWORD']
    db = settings['MYSQL_DB']
    c = settings['CHARSET']
    port = settings['MYSQL_PORT']
    # 数据库连接
    con = pymysql.connect(host=host, user=user, passwd=psd, db=db, charset=c, port=port)
    # 数据库游标
    _end = con.cursor()
    print("mysql connect succes")
    try:
        if len(args) != 1:
            _end.execute(
                "SELECT a.post_name FROM wp_posts a INNER JOIN wp_term_relationships b ON a.id = b.object_id AND b.term_taxonomy_id in{}".format(
                    args))
        else:
            id = args[0]
            _end.execute(
                "SELECT a.post_name FROM wp_posts a INNER JOIN wp_term_relationships b ON a.id = b.object_id AND b.term_taxonomy_id ={}".format(
                    id))
        result = _end.fetchall()
        return [i[0] for i in result]
    except Exception as e:
        print('Insert error:', e)
    finally:
        con.close()
