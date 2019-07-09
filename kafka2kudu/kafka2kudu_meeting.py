# -*- coding:utf-8 -*-
from kafka import KafkaConsumer
from kafka import KafkaProducer
import requests
import json
import sys
import configparser
from requests.adapters import HTTPAdapter
import time
from create_obj import *




def convert_to_dict(obj):
  '''把Object对象转换成Dict对象'''
  dict = {}
  dict.update(obj.__dict__)
  return dict


GROUP_ID=''
AUTO_OFFSET_RESET=''
if len(sys.argv)<2:
  AUTO_OFFSET_RESET='earliest'
  GROUP_ID='meeting'
else:
  AUTO_OFFSET_RESET=sys.argv[1].strip()
  GROUP_ID=sys.argv[2].strip()

conf = configparser.ConfigParser()
conf.read("/data/job_pro/utils/config.ini")


#建立kafkaConsumer连接
HOSTS_CONSUMER=conf.get('kafka_meeting', 'hosts')
TOPIC=conf.get('kafka_meeting', 'topic')
print('======================CONSUMER_CONFIG================================')
print('HOSTS_CONSUMER is :'+HOSTS_CONSUMER+'\n'+'TOPIC is :'+TOPIC)
print('AUTO_OFFSET_RESET is :'+AUTO_OFFSET_RESET+'\n'+'GROUP_ID is :'+GROUP_ID)
print('======================CONSUMER_CONFIG================================')


hosts_consumer_arr=[]
if ',' in HOSTS_CONSUMER:
  hostslist=HOSTS_CONSUMER.split(',')
  for i in range(0,len(hostslist)):
    host=hostslist[i].strip()
    hosts_consumer_arr.append(host)
else:
  hosts_consumer_arr.append(HOSTS_CONSUMER)
#消费者
consumer = KafkaConsumer(TOPIC,auto_offset_reset=AUTO_OFFSET_RESET,group_id=GROUP_ID,bootstrap_servers=hosts_consumer_arr)


HOSTS_PRODUCER=conf.get('kafka', 'hosts')
hosts_producer_arr=[]
if ',' in HOSTS_PRODUCER:
  hostslist=HOSTS_PRODUCER.split(',')
  for i in range(0,len(hostslist)):
    host=hostslist[i].strip()
    hosts_producer_arr.append(host)
else:
  hosts_producer_arr.append(HOSTS_PRODUCER)
#生产者
producer = KafkaProducer(bootstrap_servers =hosts_producer_arr)
print('======================PRODUCER_CONFIG================================')
print('HOSTS_PRODUCER is :'+HOSTS_PRODUCER)
print('======================PRODUCER_CONFIG================================')

#保持请求之间的Cookies
session=requests.session()
#get出错时，重试3次
session.mount('http://', HTTPAdapter(max_retries=3))
session.mount('https://', HTTPAdapter(max_retries=3))


#获取获取Url数据异常的数据存储目录，以及url里数据格式异常的数据存储目录
URL_ERROR_PATH=conf.get('meeting_log', 'url_error_path')
DATA_ERROR_PATH=conf.get('meeting_log', 'data_error_path')



error_record=''
error_data=''
try:
  #遍历获取到的kafka数据
  for message in consumer:
    r=message.value.decode('utf-8')
    rlist=json.loads(r)
    for k in range(0,len(rlist)):
      reslist_split=rlist[k].replace('["','').replace('"]','').split(',')
      apptype=reslist_split[0]
      clientappid=reslist_split[1]
      devicetype=reslist_split[2]
      deviceinfo=reslist_split[3]
      version=reslist_split[4]
      url=reslist_split[5]
      if url.startswith('http'):
        #获取url的数据
        session.keep_alive=False
        try:
          #第一个元素是连接超时（它允许客户端与服务器建立连接的时间），第二个元素是读取超时（一旦你的客户已建立连接而等待响应的时间）
          #如果请求在2秒内建立连接并在建立连接的5秒内接收数据，则响应将按原样返回。如果请求超时，则该函数将抛出 Timeout 异常
          response = session.get(url, timeout=(2, 5))
          #若状态码不是200，抛出HTTPError异常
          #如果你调用 .raise_for_status()，将针对某些状态码引发 HTTPError 异常。如果状态码指示请求成功，则程序将继续进行而不会引发该异常。
          response.raise_for_status()
        except Exception as e:
          t=time.time()
          with open(URL_ERROR_PATH, mode='a') as filename:
            filename.write(str(e)+'|'+rlist[k]+'|'+str(int(t))+'\n')
          print(e)
  
        value=response.text.replace('\n','').replace(',]',']')
        #过滤掉不符合规则的测试数据
        #if not value.startswith('["') or len(value)==0:
        #len(value)>100不过滤一个Url只有一条数据的情况
        if (not '","' in value) and len(value)>130:
          t=time.time()
          with open(DATA_ERROR_PATH,mode='a') as filename:
            filename.write(rlist[k]+'|'+str(int(t))+'\n')
          #print('=======>'+res)
          #print('ERROR DATA====================>'+str(url)+'===LEN==='+str(len(value)))
          continue
  
        error_record=rlist[k]
        error_data=value
        #string to list
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
            #生成ods_meeting_running_stats_r对象
            data=ods_meeting_running_stats_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,role,duration,txbytes,rxbytes,txaudiokbitrate,rxaudiokbitrate,txvideokbitrate,rxvideokbitrate,cpuappusage,cputotalusage,deviceskunum,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_running_stats_R2P3',res)
          elif datatype=='1':
            width=recordlist[5]
            height=recordlist[6]
            framerate=recordlist[7]
            bitrate=recordlist[8]
            dstype='ods_meeting_local_video_stats_r'
            data=ods_meeting_local_video_stats_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,framerate,bitrate,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_local_video_stats_R2P3',res)
          elif datatype=='2':
            width=recordlist[5]
            height=recordlist[6]
            bitrate=recordlist[7]
            framerate=recordlist[8]
            dstype='ods_meeting_remote_video_stats_r'
            data=ods_meeting_remote_video_stats_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,bitrate,framerate,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_remote_video_stats_R2P3',res)
          elif datatype=='3':
            action=recordlist[5]
            dstype='ods_meeting_local_action_r'
            data=ods_meeting_local_action_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_local_action_R2P3',res)
          elif datatype=='4':
            action=recordlist[5]
            dstype='ods_meeting_remote_action_r'
            data=ods_meeting_remote_action_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_remote_action_R2P3',res)
          elif datatype=='5':
            action=''
            if recordlist[5]=='0':
              action='2'
            elif recordlist[5]=='1':
              action='3'
            dstype='ods_meeting_remote_action_r'
            data=ods_meeting_remote_action_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_remote_action_R2P3',res)
          elif datatype=='6':
            audiograde=recordlist[5]
            videosd=recordlist[6]
            videohd=recordlist[7]
            videohdp=recordlist[8]
            dstype='ods_meeting_count_dpi_r'
            data=ods_meeting_count_dpi_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,audiograde,videosd,videohd,videohdp,dstype)
            res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
            producer.send('pro_meeting_count_dpi_R2P3',res)

except Exception as e:
  print(e)
  print('*************The error record is : '+ str(error_record)+'*************')
  print('*************The error data is : '+str(error_data)+'*************')
#finally:
  #cursor.close()
  #conn.close()
  #consumer.close()

