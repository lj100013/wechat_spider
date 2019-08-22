# -*- coding:utf-8 -*-
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


conf = configparser.ConfigParser()
conf.read("/data/job_pro/utils/config.ini")

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

error_record=''
error_data=''

try:
  with open(URL_ERROR_PATH,'r',encoding='utf-8') as f:
    lines=f.readlines()
    for line in lines:
      result=line.split('|')
      r=result[1].strip()
      rlist=r.split(',')
      apptype=rlist[0].strip()
      clientappid=rlist[1].strip()
      devicetype=rlist[2].strip()
      deviceinfo=rlist[3].strip()
      version=rlist[4].strip()
      url=rlist[5].strip()

      session.keep_alive=False
      try:
        #第一个元素是连接超时（它允许客户端与服务器建立连接的时间），第二个元素是读取超时（一旦你的客户已建立连接而等待响应的时间）
        #如果请求在2秒内建立连接并在建立连接的5秒内接收数据，则响应将按原样返回。如果请求超时，则该函数将抛出 Timeout 异常
        response = session.get(url, timeout=(2, 5))
        #若状态码不是200，抛出HTTPError异常
        #如果你调用 .raise_for_status()，将针对某些状态码引发 HTTPError 异常。如果状态码指示请求成功，则程序将继续进行而不会引发该异常。
        response.raise_for_status()
      except Exception as e:
        print('url获取异常的数据：'+r)
        print(e)
      value=response.text.replace('\n','').replace(',]',']').strip()
      #过滤掉不符合规则的测试数据
      #if not value.startswith('["') or len(value)==0:
      #len(value)>100不过滤一个Url只有一条数据的情况
      if ((not '","' in value) and len(value)>130) or len(value)<10:
        print('数据格式异常的数据：'+r)
        continue
      error_record=r
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
          #生成ods_meeting_running_stats_r对象
          #data=ods_meeting_running_stats_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,role,duration,txbytes,rxbytes,txaudiokbitrate,rxaudiokbitrate,txvideokbitrate,rxvideokbitrate,cpuappusage,cputotalusage,deviceskunum,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_running_stats_R2P3',res)
          result=(dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+role+','+duration+','+txbytes+','+rxbytes+','+txaudiokbitrate+','+rxaudiokbitrate+','+txvideokbitrate+','+rxvideokbitrate+','+cpuappusage+','+cputotalusage+','+deviceskunum)
          result=result.encode('utf-8')
          producer.send('pro_meeting_running_stats_R2P3',result)
        elif datatype=='1':
          width=recordlist[5]
          height=recordlist[6]
          framerate=recordlist[7]
          bitrate=recordlist[8]
          dstype='ods_meeting_local_video_stats_r'
          #data=ods_meeting_local_video_stats_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,framerate,bitrate,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_local_video_stats_R2P3',res)
          result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+width+','+height+','+framerate+','+bitrate
          result=result.encode('utf-8')
          producer.send('pro_meeting_local_video_stats_R2P3',result)
        elif datatype=='2':
          width=recordlist[5]
          height=recordlist[6]
          bitrate=recordlist[7]
          framerate=recordlist[8]
          dstype='ods_meeting_remote_video_stats_r'
          #data=ods_meeting_remote_video_stats_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,bitrate,framerate,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_remote_video_stats_R2P3',res)
          result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+width+','+height+','+bitrate+','+framerate
          result=result.encode('utf-8')
          producer.send('pro_meeting_remote_video_stats_R2P3',result)
        elif datatype=='3':
          action=recordlist[5]
          dstype='ods_meeting_local_action_r'
          #data=ods_meeting_local_action_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_local_action_R2P3',res)
          result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+action
          result=result.encode('utf-8')
          producer.send('pro_meeting_local_action_R2P3',result)
        elif datatype=='4':
          action=recordlist[5]
          dstype='ods_meeting_remote_action_r'
          #data=ods_meeting_remote_action_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_remote_action_R2P3',res)
          result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+action
          result=result.encode('utf-8')
          producer.send('pro_meeting_remote_action_R2P3',result)
        elif datatype=='5':
          action=''
          if recordlist[5]=='0':
            action='2'
          elif recordlist[5]=='1':
            action='3'
          dstype='ods_meeting_remote_action_r'
          #data=ods_meeting_remote_action_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_remote_action_R2P3',res)
          result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+action
          result=result.encode('utf-8')
          producer.send('pro_meeting_remote_action_R2P3',result)
        elif datatype=='6':
          audiograde=recordlist[5]
          videosd=recordlist[6]
          videohd=recordlist[7]
          videohdp=recordlist[8]
          dstype='ods_meeting_count_dpi_r'
          #data=ods_meeting_count_dpi_r(id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,audiograde,videosd,videohd,videohdp,dstype)
          #res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
          #producer.send('pro_meeting_count_dpi_R2P3',res)
          result=dstype+','+url+','+id+','+uid+','+createtime+','+apptype+','+clientappid+','+devicetype+','+deviceinfo+','+version+','+meetingid+','+audiograde+','+videosd+','+videohd+','+videohdp
          result=result.encode('utf-8')
          producer.send('pro_meeting_count_dpi_R2P3',result)
  sys.exit(0)


except Exception as e:
  print(e)
  print('*************The error record is : '+ str(error_record)+'*************')
  print('*************The error data is : '+str(error_data)+'*************')
finally:
  producer.close()