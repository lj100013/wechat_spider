import pymysql
import json
import requests
import redis
from cfg import *
import time
import random
import requests
from io import BytesIO
from PIL import Image
import traceback
import configparser
conf = configparser.ConfigParser()
#conf.read(r"F:\bigdata_project\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
secs = conf.sections()

host = conf.get('3content','host')
user = conf.get('3content','user')
passwd = conf.get('3content','passwd')
db = conf.get('3content','db')
yyr_post_url = conf.get('3content','yyr_post_info_url')
db = pymysql.connect(host, user, passwd, db)
cursor = db.cursor()

columnids = ["5d52301d913bfa0c1aaa041d","5d52302d913bfa0c1aaa041e","5d52303a913bfa0c1aaa041f","5d523040913bfa0c1aaa0420"]

sql = "SELECT post_name,source,dept,post_title,post_content,post_date FROM wp_posts  where yyr = 'Y' and post_flag = '' order by post_date desc limit 200;"
# sql = "SELECT post_name,source,dept,post_title,post_content,post_date FROM wp_posts  where post_name = '855495ae2943e272f360fc13f9dc6edb' "
try:
    cursor.execute(sql)
    res = cursor.fetchall()
    for row in res:
        p_data={}
        post_name = row[0]
        source = row[1]
        dept = row[2]
        post_title = row[3]
        post_content = row[4]
        post_date = row[5]
        #栏目类型
        p_data["authorName"] = source
        p_data['columnId'] = random.choice(columnids)
        p_data['contentType'] = 6
        p_data['richText'] = post_content
        p_data['title'] = post_title
        p_data['type'] = 1
        from lxml import etree
        # print(type(post_content))
        rsp = etree.HTML(post_content)
        img_urls = rsp.xpath('//img/@src')
        if len(img_urls)>2:
            for i in range(1,len(img_urls)-1):
                response = requests.get(img_urls[i])
                tmpIm = BytesIO(response.content)
                im = Image.open(tmpIm)
                imgs = im.size
                lv = imgs[0]/imgs[1]
                if 0.8<lv<4.8 and imgs[0]>100:
                    p_data['coverUrl']=img_urls[i]
                    break
        if 'coverUrl' not in p_data:
            p_data['coverUrl']='http://community.test.file.dachentech.com.cn/wechat_icon.png'
        # p_data['summary']=post_title
        # # p_data['coverUrl']=''
        # p_data['show']='false'
        # p_data['srcFlag']='1'
        # p_data['src']=source
        # print(json.dumps(p_data,ensure_ascii=False))
        #print(json.dumps(p_data))
        headers = {'Content-Type': 'application/json','x-forwarded-for':'120.236.22.62'}
        #headers = {'Content-Type': 'application/json'}
        res = requests.post(url=yyr_post_url, headers=headers, data=json.dumps(p_data))
        rtext=json.loads(res.text)
        if rtext['resultCode']==1:
            faq_id=rtext['data']['id']
            if len(faq_id)>5 :
                usql="update wp_posts set post_flag=1 ,faq_id='%s' where post_name='%s'" %(faq_id,post_name)
                print(key+':'+usql)
                db.ping(reconnect=True)
                cursor.execute(usql)
                db.commit()
                time.sleep(5)
except:
    traceback.print_exc()
    print ("Error: unable to fecth data:"+post_name)
db.close()