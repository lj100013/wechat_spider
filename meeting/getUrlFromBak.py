# -*- coding:utf-8 -*-
from kafka import KafkaProducer
import pyodbc
import requests
import json
import sys
import configparser
from requests.adapters import HTTPAdapter
import time
from create_obj import *

conf = configparser.ConfigParser()
conf.read("/data/job_pro/utils/config.ini")
HOST=conf.get('impaladb', 'host')
PORT=int(conf.get('impaladb', 'port'))
HOSTS_PRODUCER=conf.get('kafka', 'hosts')

#kafka生产者hosts
hosts_producer_arr=[]
if ',' in HOSTS_PRODUCER:
  hostslist=HOSTS_PRODUCER.split(',')
  for i in range(0,len(hostslist)):
    host=hostslist[i].strip()
    hosts_producer_arr.append(host)
else:
  hosts_producer_arr.append(HOSTS_PRODUCER)
#kafka生产者
producer = KafkaProducer(bootstrap_servers =hosts_producer_arr)
print('======================PRODUCER_CONFIG================================')
print('HOSTS_PRODUCER is :'+HOSTS_PRODUCER)
print('======================PRODUCER_CONFIG================================')


#保持请求之间的Cookies
session=requests.session()
#get出错时，重试3次
session.mount('http://', HTTPAdapter(max_retries=3))
session.mount('https://', HTTPAdapter(max_retries=3))


cnxnstr = "Driver={/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so};HOST=%s;PORT=%s;UID=hive;AuthMech=3;PWD=hive;UseSasl=0" % (HOST,PORT) 
conn = pyodbc.connect(cnxnstr, autocommit=True)
cursor = conn.cursor()


urlbakHql="select * from ods.ods_meeting_url_r where id in('e4513b21a63f47d6adc5c0f1abd1c1ee','9853c5b634df435fa34f8bb8c4c96a37','2d34958c75bf48e7a56914ff8e83104d','6fa977153b944310ae5f9c8b5364e525','dd2b1abad86540d9806825e7a4936c84','ba8c112f945b4e22bbf3c56755349a07','745c54566d094fcc8019b06e01a8b925','6517834449574511a931655c494b75d7','ff04cd98276b4093ae6b9e2abfc2e591','01f71fb376374435bc441ead598b67e3','7e065d97952d4aa68574c411597b9672','9c6fe9a6bb8a40c2a23c85304ec49826','8db745b6f7234d7aa0df6350f3019d8a','3a0f4d9a55c742a5b1ef345c64e0675a','5cd70828c61b474fba43ec2845f61254','4031ff3a77cd46b58931900bbed810d9','47688763bafe4f2ea967703564772c9c','3d1886edd3a740de868ab525dcde492c','c26fe5aa4d0b446a81ed2f762ec0dda0','e95093c9c644472aa4c86bcaeb4757c0','e4a6fc007d214fdc9093136fd6278c38','0182b5a27b864c1ba1fc3662b3708161','5092e0e55ba049e890d0577714e7e85b','ae11e4c74c0848b9b7451f927de41bea','0419c71c08eb4dda8e01f7c4ac58e50a','39bc97518fbc45e2a3806bd29fc859fe','e6780c8f3e0f4bc4aa6727e762c720a9','c642ed87811c4b358633762519cea5db','ee385fed9d78488282945e1f242f73ed')"
cursor.execute(urlbakHql)
res=cursor.fetchall()

error_record=''
error_data=''

try:
  for row in res:
    apptype=row[2].strip()
    clientappid=row[3].strip()
    devicetype=row[4].strip()
    deviceinfo=row[5].strip()
    version=row[6].strip()
    url=row[7].strip()
    url=url.replace('dachentech','mediportal')
    session.keep_alive=False

    try:
      #第一个元素是连接超时（它允许客户端与服务器建立连接的时间），第二个元素是读取超时（一旦你的客户已建立连接而等待响应的时间）
      #如果请求在2秒内建立连接并在建立连接的5秒内接收数据，则响应将按原样返回。如果请求超时，则该函数将抛出 Timeout 异常
      response = session.get(url, timeout=(2, 5))
      #若状态码不是200，抛出HTTPError异常
      #如果你调用 .raise_for_status()，将针对某些状态码引发 HTTPError 异常。如果状态码指示请求成功，则程序将继续进行而不会引发该异常。
      response.raise_for_status()
    except Exception as e:
      print('url获取异常的数据：'+url)
      print(e)
    value=response.text.replace('\n','').replace(',]',']').strip()
    #过滤掉不符合规则的测试数据
    #if not value.startswith('["') or len(value)==0:
    #len(value)>100不过滤一个Url只有一条数据的情况
    if ((not '","' in value) and len(value)>130) or len(value)<10:
      print('数据格式异常的数据：'+url)
      continue
    error_record=url
    error_data=value
    valuelist=json.loads(value)
    #遍历url获取到的list
    for i in range(0,len(valuelist)):
      record=valuelist[i]
      recordlist=record.split(',')
      id=recordlist[0]
      createtime=recordlist[1]
      datatype=recordlist[2]
      meetingid=recordlist[3]
      uid=recordlist[4]
      if datatype=='0':
        role=recordlist[5]
        duration=recordlist[6]
        txbytes=recordlist[7]
        rxbytes=recordlist[8]
        txaudiokbitrate=recordlist[9]
        rxaudiokbitrate=recordlist[10]
        txvideokbitrate=recordlist[11]
        rxvideokbitrate=recordlist[12]
        cpuappusage=recordlist[13]
        cputotalusage=recordlist[14]
        deviceskunum=recordlist[15]
        dstype='ods_meeting_running_stats_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+role+','+duration+','+txbytes+','+rxbytes+','+txaudiokbitrate+','+rxaudiokbitrate+','+txvideokbitrate+','+rxvideokbitrate+','+cpuappusage+','+cputotalusage+','+deviceskunum
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_running_stats_R2P3',result)
      elif datatype=='1':
        width=recordlist[5]
        height=recordlist[6]
        framerate=recordlist[7]
        bitrate=recordlist[8]
        dstype='ods_meeting_local_video_stats_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+width+','+height+','+framerate+','+bitrate
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_local_video_stats_R2P3',result)
      elif datatype=='2':
        width=recordlist[5]
        height=recordlist[6]
        bitrate=recordlist[7]
        framerate=recordlist[8]
        dstype='ods_meeting_remote_video_stats_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+width+','+height+','+bitrate+','+framerate
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_remote_video_stats_R2P3',result)
      elif datatype=='3':
        action=recordlist[5]
        dstype='ods_meeting_local_action_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+action
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_local_action_R2P3',result)
      elif datatype=='4':
        action=recordlist[5]
        dstype='ods_meeting_remote_action_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+action
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_remote_action_R2P3',result)
      elif datatype=='5':
        action=''
        if recordlist[5]=='0':
          action='2'
        elif recordlist[5]=='1':
          action='3'
        dstype='ods_meeting_remote_action_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+action
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_remote_action_R2P3',result)
      elif datatype=='6':
        audiograde=recordlist[5]
        videosd=recordlist[6]
        videohd=recordlist[7]
        videohdp=recordlist[8]
        dstype='ods_meeting_count_dpi_r'
        result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+audiograde+','+videosd+','+videohd+','+videohdp
        #print(result)
        result=result.encode('utf-8')
        producer.send('pro_meeting_count_dpi_R2P3',result)
except Exception as e:
  print(e)
  print('*************The error record is : '+ str(error_record)+'*************')
  print('*************The error data is : '+str(error_data)+'*************')
finally:
  producer.close()