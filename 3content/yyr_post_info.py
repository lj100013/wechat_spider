import pymysql
import json
import requests
from io import BytesIO
from PIL import Image
import traceback
from utils.parse_config import *
from utils.column_classify import column_classification,query_column
import time

db = pymysql.connect(host=mysql_host, port=mysql_port, user=mysql_user, password=mysql_password, db=mysql_db)
cursor = db.cursor()

#查询栏目名称和id的映射关系
column_id = query_column()

sql = "SELECT post_name,source,dept,post_title,post_content,post_date FROM wp_posts  where yyr = 'Y' and post_flag_yyr = '' order by post_date;"
# sql = "SELECT post_name,source,dept,post_title,post_content,post_date FROM wp_posts  where post_name = '855495ae2943e272f360fc13f9dc6edb' "
j = 0
try:
    cursor.execute(sql)
    res = cursor.fetchall()
    for row in res:
        try:
            j+=1
            print("发布第{}篇内容".format(j))
            p_data={}
            post_name = row[0]
            source = row[1]
            dept = row[2]
            post_title = row[3]
            post_content = row[4]
            post_date = row[5]
            #栏目类型
            p_data["authorName"] = source
            p_data['contentType'] = 6
            p_data['richText'] = post_content
            column_name = column_classification(post_content)
            p_data['columnId'] = column_id[column_name]
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
            headers = {'Content-Type': 'application/json','x-forwarded-for':'120.236.22.62'}
            res = requests.post(url=yyr_post_url, headers=headers, data=json.dumps(p_data))
            rtext=json.loads(res.text)
            if rtext['resultCode']==1:
                faq_id=rtext['data']['id']
                if len(faq_id)>5 :
                    print(faq_id)
                    usql="update wp_posts set post_flag_yyr=1 ,faq_id='%s' where post_name='%s'" %(faq_id,post_name)
                    db.ping(reconnect=True)
                    cursor.execute(usql)
                    db.commit()
                    time.sleep(5)
        except Exception as e:
            traceback.print_exc()
            print(e)
except:
    traceback.print_exc()
    print ("Error: unable to fecth data:"+post_name)
db.close()