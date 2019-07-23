#coding:utf-8
import logging
import base64
import configparser
import requests
import json
from urllib import request

conf = configparser.ConfigParser()
#conf.read(r"F:\bigdata_project\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
img_base_url=conf.get('weixin', 'img_base_url')
qiniu_service_url=conf.get('weixin', 'qiniu_service_url')

def upload_pic(content,pic_url):
    link_list = pic_url.split("/")
    if len(link_list) != 6:
        logging.warning("pic_url format is error:{}".format(pic_url))
    strName = link_list[4]
    fname = base64.b64encode(strName.encode('utf-8'))
    fname = fname.decode('utf-8')
    img_format = '.png'
    if '=jpeg' in pic_url:
        img_format = '.jpeg'
    elif '=gif' in pic_url:
        img_format = '.gif'
    first_string = 'src="' + img_base_url + fname + img_format
    origian_first = 'data-src="' + pic_url
    content = content.replace(origian_first, first_string)
    file_name = fname + img_format
    writed = write2_qiniu(pic_url, file_name)
    return writed,content


def write2_qiniu(url, name):
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}
        img = requests.get(url=url, headers = headers)
        pic = base64.b64encode(img.content)
        qiniu_data = {"fileName": name, "contentBytes": pic.decode(encoding='utf-8')}
        textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
        header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
                   "Content-Type": "application/json"}
        re_url = qiniu_service_url
        req = request.Request(url=re_url, data=textmod, headers=header_dict)
        res = request.urlopen(req)
        n_url = res.read()
        return n_url
    except Exception as e:
        logging.error("fail to upload picture into qiniu:{},{}".format(e,url))
        return ''