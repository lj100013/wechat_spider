# -*- coding:utf-8 -*-
class ods_meeting_running_stats_r:
  id=str
  uid=str
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  meetingid=str
  role=str
  duration=str
  txbytes=str
  rxbytes=str
  txaudiokbitrate=str
  rxaudiokbitrate=str
  txvideokbitrate=str
  rxvideokbitrate=str
  cpuappusage=str
  cputotalusage=str
  deviceskunum=str
  dstype=str
  def __init__(self,id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,role,duration,txbytes,rxbytes,txaudiokbitrate,rxaudiokbitrate,txvideokbitrate,rxvideokbitrate,cpuappusage,cputotalusage,deviceskunum,dstype):
    self.id=id
    self.uid=uid
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.meetingid=meetingid
    self.role=role
    self.duration=duration
    self.txbytes=txbytes
    self.rxbytes=rxbytes
    self.txaudiokbitrate=txaudiokbitrate
    self.rxaudiokbitrate=rxaudiokbitrate
    self.txvideokbitrate=txvideokbitrate
    self.rxvideokbitrate=rxvideokbitrate
    self.cpuappusage=cpuappusage
    self.cputotalusage=cputotalusage
    self.deviceskunum=deviceskunum
    self.dstype=dstype

class ods_meeting_local_video_stats_r:
  id=str
  uid=str
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  meetingid=str
  width=str
  height=str
  framerate=str
  bitrate=str
  dstype=str
  def __init__(self,id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,framerate,bitrate,dstype):
    self.id=id
    self.uid=uid
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.meetingid=meetingid
    self.width=width
    self.height=height
    self.framerate=framerate
    self.bitrate=bitrate
    self.dstype=dstype

class ods_meeting_remote_video_stats_r:
  id=str
  uid=str
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  meetingid=str
  width=str
  height=str
  bitrate=str
  framerate=str
  dstype=str
  def __init__(self,id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,width,height,bitrate,framerate,dstype):
    self.id=id
    self.uid=uid
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.meetingid=meetingid
    self.width=width
    self.height=height
    self.bitrate=bitrate
    self.framerate=framerate
    self.dstype=dstype

class ods_meeting_local_action_r:
  id=str
  uid=str
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  meetingid=str
  action=str
  dstype=str
  def __init__(self,id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype):
    self.id=id
    self.uid=uid
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.meetingid=meetingid
    self.action=action
    self.dstype=dstype


class ods_meeting_remote_action_r:
  id=str
  uid=str
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  meetingid=str
  action=str
  dstype=str
  def __init__(self,id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,action,dstype):
    self.id=id
    self.uid=uid
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.meetingid=meetingid
    self.action=action
    self.dstype=dstype


class ods_meeting_count_dpi_r:
  id=str
  uid=str
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  meetingid=str
  audiograde=str
  videosd=str
  videohd=str
  videohdp=str
  dstype=str
  def __init__(self,id,uid,createtime,apptype,clientappid,devicetype,deviceinfo,version,meetingid,audiograde,videosd,videohd,videohdp,dstype):
    self.id=id
    self.uid=uid
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.meetingid=meetingid
    self.audiograde=audiograde
    self.videosd=videosd
    self.videohd=videohd
    self.videohdp=videohdp
    self.dstype=dstype

class ods_meeting_url_r:
  createtime=str
  apptype=str
  clientappid=str
  devicetype=str
  deviceinfo=str
  version=str
  url=str
  def __init__(self,createtime,apptype,clientappid,devicetype,deviceinfo,version,url):
    self.createtime=createtime
    self.apptype=apptype
    self.clientappid=clientappid
    self.devicetype=devicetype
    self.deviceinfo=deviceinfo
    self.version=version
    self.url=url