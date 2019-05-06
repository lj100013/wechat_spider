import pymysql
import json
import requests
import redis
from cfg import *
import time

import requests
from io import BytesIO
from PIL import Image
import configparser
conf = configparser.ConfigParser()
# conf.read("D://job_script/utils/config.ini")
conf.read("/data/job_pro/utils/config.ini")
secs = conf.sections()

host = conf.get('3content','host')
user = conf.get('3content','user')
passwd = conf.get('3content','passwd')
db = conf.get('3content','db')
post_faq_url = conf.get('3content','post_faq_url')
InfoId = conf.get('3content','InfoId')
MajorId = conf.get('3content','MajorId')
creator = conf.get('3content','creator')
columnId = conf.get('3content','columnId')
db = pymysql.connect(host, user, passwd, db)
cursor = db.cursor()

for key in dept_cfg:
    top=dept_cfg[key]
    sql = "SELECT post_name,source,dept,post_title,post_content,post_date FROM wp_posts  where dept='%s' and post_status='publish' and post_flag<>1 and source not in('中洪博元医学实验帮','丁香园web','医脉通web')  order by post_date desc limit %d" % (key,top)
    # sql = "SELECT post_name,source,dept,post_title,post_content,post_date FROM wp_posts  where post_name = '855495ae2943e272f360fc13f9dc6edb' "
    cursor.execute(sql)
    res = cursor.fetchall()
    try:
        for row in res:
            p_data={}
            post_name = row[0]
            source = row[1]
            dept = row[2]
            post_title = row[3]
            post_content = row[4]
            post_date = row[5]

            p_data['identify']=2
            if key=='INFO':
                p_data['identifyId']=InfoId
            else:
                p_data['identifyId']=MajorId
            p_data['creator']=creator
            p_data['platformType']=1
            p_data['terminal']=1
            # p_data['labelNames']=["三方内容"]
            p_data['columnId']=columnId
            p_data['amount']=0
            p_data['mainBody']=post_content
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
                    if 1.1<lv<3.8 and imgs[0]>100:
                        p_data['coverUrl']=img_urls[i]
                        break;
            if 'coverUrl' not in p_data:
                p_data['coverUrl']='http://community.dev.file.dachentech.com.cn/wechat_icon.png'
            p_data['summary']=post_title
            # p_data['coverUrl']=''
            p_data['show']='false'
            p_data['srcFlag']='1'
            p_data['src']=source
            # print(json.dumps(p_data,ensure_ascii=False))
            headers = {'Content-Type': 'application/json','x-forwarded-for':'120.236.22.62'}
            res = requests.post(url=post_faq_url, headers=headers, data=json.dumps(p_data))
            rtext=json.loads(res.text)
            print(rtext)
            if rtext['resultCode']==1:
                faq_id=rtext['data']['questionId']
                if len(faq_id)>5 :
                    usql="update wp_posts set post_flag=1 ,faq_id='%s' where post_name='%s'" %(faq_id,post_name)
                    print(key+':'+usql)
                    db.ping(reconnect=True)
                    cursor.execute(usql)
                    db.commit()
                    time.sleep(5)
    except:
        print ("Error: unable to fecth data:"+post_name)
db.close()