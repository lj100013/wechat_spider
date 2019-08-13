insert overwrite table pro.ods_b_full_burialpoint_event PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(page,'\\n|\\r','')) as page,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(businessDataItem,'\\n|\\r','')) as businessDataItem,
trim(regexp_replace(eventId,'\\n|\\r','')) as eventId,
trim(regexp_replace(iosMode,'\\n|\\r','')) as iosMode,
trim(regexp_replace(androidMode,'\\n|\\r','')) as androidMode,
trim(regexp_replace(iosFillFlag,'\\n|\\r','')) as iosFillFlag,
trim(regexp_replace(androidFillFlag,'\\n|\\r','')) as androidFillFlag,
trim(regexp_replace(appName,'\\n|\\r','')) as appName,
trim(regexp_replace(appVersion,'\\n|\\r','')) as appVersion,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(androidStatusFlag,'\\n|\\r','')) as androidStatusFlag 
from mongo2hive.integration_b_full_burialpoint_event;

insert overwrite table pro.ods_b_full_burialpoint_config PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(page,'\\n|\\r','')) as page,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(eventId,'\\n|\\r','')) as eventId,
trim(regexp_replace(uid,'\\n|\\r','')) as uid,
trim(regexp_replace(identifyId,'\\n|\\r','')) as identifyId,
trim(regexp_replace(businessDataItem,'\\n|\\r','')) as businessDataItem,
trim(regexp_replace(identifyName,'\\n|\\r','')) as identifyName,
trim(regexp_replace(eventParam,'\\n|\\r','')) as eventParam,
trim(regexp_replace(cacheCount,'\\n|\\r','')) as cacheCount,
trim(regexp_replace(clientType,'\\n|\\r','')) as clientType,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime ,
trim(regexp_replace(appVersion,'\\n|\\r','')) as appVersion ,
trim(regexp_replace(appName,'\\n|\\r','')) as appName 
from mongo2hive.integration_b_full_burialpoint_config;