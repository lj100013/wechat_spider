# -*- coding:utf-8 -*-
from kafka import KafkaConsumer
from kafka import KafkaProducer
import json
import sys
import configparser
import time
from create_obj import *



GROUP_ID=''
AUTO_OFFSET_RESET=''
if len(sys.argv)<2:
  AUTO_OFFSET_RESET='earliest'
  GROUP_ID='getUrl'
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



try:
  #遍历获取到的kafka数据
  for message in consumer:
    r=message.value.decode('utf-8')
    rlist=json.loads(r)
    for k in range(0,len(rlist)):
      reslist_split=rlist[k].replace('["','').replace('"]','').split(',')
      createtime=str(int(time.time()* 1000))
      apptype=reslist_split[0]
      clientappid=reslist_split[1]
      devicetype=reslist_split[2]
      deviceinfo=reslist_split[3]
      version=reslist_split[4]
      url=reslist_split[5]
      data=ods_meeting_url_r(createtime,apptype,clientappid,devicetype,deviceinfo,version,url)
      res=json.dumps(convert_to_dict(data),separators=(',',':')).encode('utf-8')
      producer.send('pro_meeting_url_R2P3',res)

except Exception as e:
  print(e)
#finally:
  #cursor.close()
  #conn.close()
  #consumer.close()