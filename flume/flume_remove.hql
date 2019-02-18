set hive.exec.dynamic.partition=true; 
set hive.exec.dynamic.partition.mode=nonstrict;
use pro;

--flume采集到hdfs的数据静态分区
--pro.ods_doctor_register
INSERT OVERWRITE TABLE pro.ods_doctor_register PARTITION(dt='${hivevar:dt}') 
SELECT dsType,userId,username,telephone,email,birthday,hospitalId,deptId,title,provinceId,cityId,areaId,status,userLevel,inviterId,skill,sex,desc,regfrom,model,createTime,lastUploadTime from pro.ods_doctor_register WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_doctor_login
INSERT OVERWRITE TABLE pro.ods_doctor_login PARTITION(dt='${hivevar:dt}') 
SELECT dsType,userId,loginType,loginTime,apiVersion,osVersion,model,serial,latitude,longitude,provinceId,cityId,areaId,location,address,lastUploadTime,departments,title,hospital,status,deptId,hospitalId from pro.ods_doctor_login WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_doctor_certify
INSERT OVERWRITE TABLE pro.ods_doctor_certify PARTITION(dt='${hivevar:dt}') 
SELECT dsType,userId,status,certifyTime,lastUploadTime from pro.ods_doctor_certify WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_doctor_check
INSERT OVERWRITE TABLE pro.ods_doctor_check PARTITION(dt='${hivevar:dt}') 
SELECT dsType,userId,hospital,hospitalId,departments,deptId,title,checkTime,checker,checkerId,status,remark,certifyTime,licenseNum,licenseExpire,lastUploadTime from pro.ods_doctor_check WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_doctor_change
INSERT OVERWRITE TABLE pro.ods_doctor_change PARTITION(dt='${hivevar:dt}') 
SELECT dsType,userId,username,telephone,email,birthday,hospitalId,deptId,title,provinceId,cityId,areaId,status,userLevel,inviterId,skill,sex,desc,regfrom,model,lastUploadTime from pro.ods_doctor_change WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_circle_create
INSERT OVERWRITE TABLE pro.ods_circle_create PARTITION(dt='${hivevar:dt}') 
SELECT dsType,id,userId,name,introduction,logo,label,auditing,charge,freeTime,invite,flag,createTime,updateUserId,updateTime,deptIds,deptNames,lastUploadTime from pro.ods_circle_create WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_circle_change
INSERT OVERWRITE TABLE pro.ods_circle_change PARTITION(dt='${hivevar:dt}') 
SELECT dsType,id,name,introduction,logo,label,auditing,invite,updateUserId,updateTime,deptIds,deptNames,lastUploadTime from pro.ods_circle_change WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_circle_memberChange
INSERT OVERWRITE TABLE pro.ods_circle_memberChange PARTITION(dt='${hivevar:dt}') 
SELECT dsType,id,tableId,userId,type,remarks,creatorId,role,createTime,lastUploadTime from pro.ods_circle_memberChange WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(lastUploadTime,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';
--pro.ods_user_behavior
INSERT OVERWRITE TABLE pro.ods_user_behavior PARTITION(dt='${hivevar:dt}') 
SELECT userId,clientIp,deviceInfo,network,appName,appVersion,sessionId,moduleName,moduleItemID,pageStep,pageStepDesc,eventType,eventParam,timestamp,buryingPointType,statType,statValue,hour from pro.ods_user_behavior WHERE dt='2018-05-22' and 
from_unixtime(cast(substring(timestamp,0,10) AS bigint),'yyyy-MM-dd')='${hivevar:dt}';

