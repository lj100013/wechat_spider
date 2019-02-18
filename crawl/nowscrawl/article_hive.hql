use pro; 

insert overwrite local directory '/data/job_pro/dataX/crawl/nowscrawl/nowscrawl/users' row format delimited fields terminated by ',' select name, doctor_hospital from ods_user where dt = '${hivevar:preday}' and from_unixtime(cast(ods_user.createtime/1000 as int),'yyyy-MM-dd') >= '${hivevar:preday}';

#insert overwrite local directory '/data/job_pro/dataX/crawl/nowscrawl/nowscrawl/users' row format delimited fields terminated by ',' select name, doctor_hospital from ods_user limit 100;
