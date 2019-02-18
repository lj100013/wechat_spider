import pymysql
from scrapy.conf import settings
from urllib import request
import json
import time
import hashlib

def database_filter():
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
        _end.execute('SELECT post_name FROM wp_article_posts')
        result = _end.fetchall()
        return [i[0] for i in result]
    except Exception as e:
        print('Insert error:', e)
    finally:
        con.close()

def writeArticle(post_name, post_title, year, key_word, post_content, author, first_author, organization, source):

    # re_url = 'http://192.168.2.108:8076/doc/wfwriteArticle2'
    # 36e93fe6391d4e638635df2c286e73da
    re_url = 'http://xg.mediportal.com.cn/docapi/doc/wfwriteArticle2?access_token=36e93fe6391d4e638635df2c286e73da'

    datas = {
        "post_name": post_name,
        "post_title": post_title,
        "post_year": year,
        "key_word": key_word,
        "post_content": post_content,
        "author": author,
        "first_author": first_author,
        "organization": organization,
        "source": source
    }

    app_key = '25d3083948184bfc9e1e73f75fbc871a'
    app_secret = 'f88c8e674995445889613eb9b47fc940fxr7k705'
    str_sign =[]
    str_sign.append(app_key)
    str_sign.append(datas["post_name"])
    str_sign.append(datas["post_year"])
    str_time = str(int(time.time() * 1000))
    str_sign.append(str_time)
    str_sign.sort()
    str_sign.append(app_secret)
    xs = ''.join(str_sign)
    m = hashlib.md5()
    m.update(bytes(xs, encoding='utf-8'))
    sign = m.hexdigest()
    datas['app_key'] = app_key
    datas['sign'] = sign
    datas['post_time'] = str_time
    textmod = json.dumps(datas).encode(encoding='utf-8')
    header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
                   "Content-Type": "application/json"}
    try:
        req = request.Request(url=re_url, data=textmod, headers=header_dict)
        res = request.urlopen(req)
        result_str = res.read()
        return result_str.decode("utf-8")
    except Exception as e:
        print(e)

res = writeArticle('ylbjqj2012020041', '电视胸腔镜手术治疗青少年自发性气胸151例临床观察', '2012', '自发性气胸;胸腔镜;复发;生物蛋白胶',
                                 '目的 对电视胸腔镜手术治疗自发性气胸临床经验进行总结.方法 回顾分析2006年2月至2010年2月收治的151例自发性气胸病例.结果 151例全部治愈,无死亡病例.结论 用胸腔镜手术治疗自发性气胸,避免开胸手术,创伤可降至最低程度,具有创伤小、痛苦轻、恢复较快、住院时间短的优势;为降低术后复发率需行可靠的胸膜固定术.<a href="http://192.168.3.121:8076/qiniu/download/bigdata?filename=ylbjqj201202004">查看文献</a>',
                                '段俊峰|DUAN Junfeng', '段俊峰', '广州市番禺中心医院急诊科,广东广州,511400|', '临床医学工程')
print(res)
