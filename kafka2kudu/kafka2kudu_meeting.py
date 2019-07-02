# -*- coding:utf-8 -*-
from kafka import KafkaConsumer
import requests
import json
import sys
import pyodbc
import configparser
from requests.adapters import HTTPAdapter
import time

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

#建立impala连接
HOST=conf.get('impaladb', 'host')
PORT=int(conf.get('impaladb', 'port'))
cnxnstr = "Driver={/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so};HOST=%s;PORT=%s;UID=hive;AuthMech=3;PWD=hive;UseSasl=0" % (HOST,PORT)
conn = pyodbc.connect(cnxnstr, autocommit=True)
cursor = conn.cursor()


#建立kafkaConsumer连接
HOSTS=conf.get('kafka_meeting', 'hosts')
TOPIC=conf.get('kafka_meeting', 'topic')
print('======================CONFIG================================')
print('HOSTS is :'+HOSTS+'\n'+'TOPIC is :'+TOPIC)
print('AUTO_OFFSET_RESET is :'+AUTO_OFFSET_RESET+'\n'+'GROUP_ID is :'+GROUP_ID)
print('======================CONFIG================================')
hosts_arr=[]
if ',' in HOSTS:
  hostslist=HOSTS.split(',')
  for i in range(0,len(hostslist)):
    host=hostslist[i].strip()
    hosts_arr.append(host)
else:
  hosts_arr.append(HOSTS)
consumer = KafkaConsumer(TOPIC,auto_offset_reset=AUTO_OFFSET_RESET,group_id=GROUP_ID,bootstrap_servers=hosts_arr)


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
        if not '","' in value:
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
  
        #类型0的数据
        running_stats=[]
        #类型1的数据
        local_video_stats=[]
        #类型2的数据
        remote_video_stats=[]
        #类型3的数据
        local_action=[]
        #类型4和5的数据
        remote_action=[]
        #类型6的数据
        count_dpi=[]
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
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,role,duration,txbytes,rxbytes,txaudiokbitrate,rxaudiokbitrate,txvideokbitrate,rxvideokbitrate,cpuappusage,cputotalusage,deviceskunum)
            running_stats.append(output_data)
          elif datatype=='1':
            width=recordlist[5]
            height=recordlist[6]
            framerate=recordlist[7]
            bitrate=recordlist[8]
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,framerate,bitrate)
            local_video_stats.append(output_data)
          elif datatype=='2':
            width=recordlist[5]
            height=recordlist[6]
            bitrate=recordlist[7]
            framerate=recordlist[8]
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,bitrate,framerate)
            remote_video_stats.append(output_data)
          elif datatype=='3':
            action=recordlist[5]
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action)
            local_action.append(output_data)
          elif datatype=='4':
            action=recordlist[5]
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action)
            remote_action.append(output_data)
          elif datatype=='5':
            action=''
            if recordlist[5]=='0':
              action='2'
            elif recordlist[5]=='1':
              action='3'
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action)
            remote_action.append(output_data)
          elif datatype=='6':
            audiograde=recordlist[5]
            videosd=recordlist[6]
            videohd=recordlist[7]
            videohdp=recordlist[8]
            output_data='("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")' % (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,audiograde,videosd,videohd,videohdp)
            count_dpi.append(output_data)
        if len(running_stats)>0:
          data=','.join(running_stats)
          cursor.execute('UPSERT INTO ods.ods_meeting_running_stats_r (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,`role`,duration,txbytes,rxbytes,txaudiokbitrate,rxaudiokbitrate,txvideokbitrate,rxvideokbitrate,cpuappusage,cputotalusage,deviceskunum) values' + data)
        if len(local_video_stats)>0:
          data=','.join(local_video_stats)
          cursor.execute('UPSERT INTO ods.ods_meeting_local_video_stats_r (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,framerate,bitrate) values' + data)
        if len(remote_video_stats)>0:
          data=','.join(remote_video_stats)
          cursor.execute('UPSERT INTO ods.ods_meeting_remote_video_stats_r (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,bitrate,framerate) values' + data)
        if len(local_action)>0:
          data=','.join(local_action)
          cursor.execute('UPSERT INTO ods.ods_meeting_local_action_r (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action) values' + data)
        if len(remote_action)>0:
          data=','.join(remote_action)
          cursor.execute('UPSERT INTO ods.ods_meeting_remote_action_r (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action) values' + data)
        if len(count_dpi)>0:
          data=','.join(count_dpi)
          cursor.execute('UPSERT INTO ods.ods_meeting_count_dpi_r (id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,audiograde,videosd,videohd,videohdp) values' + data)

except Exception as e:
  print(e)
  print('*************The error record is : '+ str(error_record)+'*************')
  print('*************The error data is : '+str(error_data)+'*************')
#finally:
  #cursor.close()
  #conn.close()
  #consumer.close()