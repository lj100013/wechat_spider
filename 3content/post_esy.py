import pymysql
import logging
logging.basicConfig(level = logging.INFO,format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
import requests
from io import BytesIO
from PIL import Image
import base64
import  time
import configparser
from  dept_cfg import dept_all
import json

conf = configparser.ConfigParser()
conf.read("D://job_script/utils/config.ini")
secs = conf.sections()

post_url=conf.get('esy', 'post_url')
host=conf.get('esy', 'host')
user=conf.get('esy', 'user')
password=conf.get('esy', 'password')
db=conf.get('esy', 'db')
upload_url = conf.get('esy','upload_url')
qiniu_url = conf.get('esy','qiniu_url')

conn = pymysql.connect(host, user, password, db)
cursor = conn.cursor()
sql = "SELECT guid,source,dept,post_title,post_content,post_date FROM `wp_posts` where source in ('医脉通web','丁香园web')  and url is null"
cursor.execute(sql)
post_row = cursor.fetchall()

header = {"Content-Type": "application/json"}


def write2_qiniu(html_content, name):
    html = base64.b64encode(html_content.encode('utf-8'))
    qiniu_data = {"fileName": name, "contentBytes": html.decode(encoding='utf-8')}
    textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
    res = requests.post(url=upload_url, headers=header, data=textmod)
    if str(res.ok) == 'True':
        url = str(res.content,encoding='utf-8')
        return str(url)
    else:
        return 'error'

def parse2html(post_content):
    html_list=[]
    for line in open("content.html"):
        if line.strip() =='{{content}}':
            html_list.append(post_content)
        else:
            html_list.append(line)
    return ''.join(html_list)

def unix_time(dt):
    timeArray = time.strptime(str(dt), "%Y-%m-%d %H:%M:%S")
    timestamp = int(time.mktime(timeArray))*1000
    return timestamp

try:
    for row in post_row:
        p_data={}
        guid = row[0]
        source = row[1]
        dept = row[2]
        post_title = row[3]
        post_content = row[4]
        post_date = row[5]
        publishTime = unix_time(post_date)
        logging.info('start:'+source+':'+guid+':'+post_title)
        html_content = parse2html(post_content)
        newUrl = write2_qiniu(html_content,'esy_'+guid)
        if newUrl=='error':
            logging.error('上传七牛失败:'+post_title+':'+guid)
            continue
        logging.info('newUrl:'+newUrl)
        from lxml import etree
        rsp = etree.HTML(post_content)
        img_urls = rsp.xpath('//img/@src')
        if len(img_urls)>1:
            for i in range(1,len(img_urls)-1):
                response = requests.get(img_urls[i])
                tmpIm = BytesIO(response.content)
                im = Image.open(tmpIm)
                imgs = im.size
                lv = imgs[0]/imgs[1]
                if 1.1<lv<3.8 and imgs[0]>100:
                    p_data['newPicUrl']=str(img_urls[i])
                    break;
        if 'newPicUrl' not in p_data:
            p_data['newPicUrl']='http://community.dev.file.dachentech.com.cn/wechat_icon.png'

        p_data['newUrl'] = newUrl
        p_data['newsTitle'] = post_title
        p_data['publishTime'] = publishTime
        tag = []

        if dept in dept_all:
            dps=dept_all[dept].split(',')
            for post_dept in dps:
                tag.append(post_dept)
                p_data['tags']=tag
                logging.info('post_dept:'+post_dept)
                esy_data = []
                esy_data.append(p_data)

                res = requests.post(url=post_url, headers=header, data=json.dumps(esy_data))
                rtext=json.loads(res.text)
                if rtext['resultCode']==1:
                    sql = 'update `wp_posts` set url="%s" where guid="%s" ' % (newUrl,guid)
                    logging.info(sql)
                    cursor.execute(sql)
                    conn.commit()
                    logging.info('sucess end:'+guid)
                    logging.info('********************************************************************************************************************************************************')
except Exception as e :
    logging.error(e)
finally:
    cursor.close()
    conn.close()