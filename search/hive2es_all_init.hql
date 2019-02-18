add jar hdfs://nameservice1:8020//jar/elasticsearch-hadoop-hive-5.4.0.jar;
add file hdfs://nameservice1:8020//jar/get_circle_masters.py;
add jar hdfs://nameservice1:8020//jar/udf-1.0.jar; 
CREATE TEMPORARY FUNCTION analysis_json_post_info as 'com.dachen.analysis_json_post_info';


--圈子 circle :hive2es.ods_circle
--drop table hive2es.ods_circle;
create external table if not exists hive2es.ods_circle(
circleid string comment '圈子id',
circlename string comment '圈子name',
src string comment '发布来源',
dept string comment '科室',
caption string comment '简介',
pic string comment '头像',
membercount string comment '成员数',
mastercount string comment '圈主数',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/circle', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'circleid',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');



 

--医生 user :hive2es.ods_user
--drop table hive2es.ods_user;
create external table if not exists hive2es.ods_user(
userid string comment '用户id',
src string comment '用户名',
title string comment '职称',
dept string comment '科室',
hospital string comment '医院',
expertise string comment '擅长',
pic string comment '头像',
updatetime string comment '更新时间'
)
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler'

TBLPROPERTIES(
'es.resource' = 'search/user',
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'userid',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true'
);


--帖子 faq :hive2es.ods_faq
--drop table hive2es.ods_faq;
create external table if not exists hive2es.ods_faq(
id string comment 'id',
circleid string comment '圈子id',
userid string comment '用户id',
src string comment '发布来源',
dept string comment '科室',
content string comment '正文',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/faq', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');




--提问 question :hive2es.ods_question
--drop table hive2es.ods_question;
create external table if not exists hive2es.ods_question(
id string comment 'id',
circleid string comment '圈子id',
userid string comment '用户id',
src string comment '发布来源',
dept string comment '科室',
content string comment '正文',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/question', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');


--悬赏 reward :hive2es.ods_reward
--drop table hive2es.ods_reward;
create external table if not exists hive2es.ods_reward(
id string comment 'id',
circleid string comment '圈子id',
userid string comment '用户id',
src string comment '发布来源',
dept string comment '科室',
content string comment '正文',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/reward', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');



--病例讨论 disease :hive2es.ods_disease
--drop table hive2es.ods_disease;
create external table if not exists hive2es.ods_disease(
id string comment 'id',
circleid string comment '圈子id',
userid string comment '用户id',
src string comment '发布来源',
dept string comment '科室',
label string comment '标签',
caption string comment '主题',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/disease', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');



--直播 living :hive2es.ods_living
--drop table hive2es.ods_living;
create external table if not exists hive2es.ods_living(
id string comment 'id',
circleid string comment '圈子id',
userid string comment '用户id',
src string comment '发布来源',
dept string comment '科室',
content string comment '正文',
caption string comment '主题',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/living', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');




--录播 video :hive2es.ods_video
--drop table hive2es.ods_video;
create external table if not exists hive2es.ods_video(
id string comment 'id',
livingid string comment '直播id',
circleid string comment '圈子id',
src string comment '发布来源',
dept string comment '科室',
content string comment '正文',
caption string comment '主题',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/video', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');




--词条 wanfang :hive2es.ods_wanfang
--drop table hive2es.ods_wanfang;
create external table if not exists hive2es.ods_wanfang(
id string comment 'id',
dept string comment '科室',
label string comment '标签',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/wanfang', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');





--医学文献 article :hive2es.ods_acticle
--drop table hive2es.ods_acticle;
create external table if not exists hive2es.ods_acticle(
id string comment 'id',
type string comment '资源类型(WF_QK：期刊论文,WF_XW：学位论文,WF_HY：会议论文)',
label string comment '正文',
caption string comment '主题',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/article', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');



--微学堂 course :hive2es.ods_course
--drop table hive2es.ods_course;
create external table if not exists hive2es.ods_course(
id string comment 'id',
classid string comment 'classid',
userid string comment '用户id',
src string comment '发布来源',
dept string comment '科室',
label string comment '标签',
caption string comment '标题',
pic string comment '头像',
updatetime string comment '数据更新时间'
) 
STORED BY 'org.elasticsearch.hadoop.hive.EsStorageHandler' 
TBLPROPERTIES(
'es.resource' = 'search/course', 
'es.nodes'='39.108.135.243',
'es.port'='9280',
'es.mapping.id' = 'id',
'es.index.auto.create' = 'true',
'es.write.operation'='upsert',
'es.nodes.wan.only'='true');





--圈子 circle :hive2es.ods_circle
insert overwrite table hive2es.ods_circle 
select 
transform(id,name,mastername,deptnames,introduction,logo,membercount,mastercount,from_unixtime(unix_timestamp())) 
using "python get_circle_masters.py" 
as (circleid,circlename,src,dept,caption,pic,membercount,mastercount,updatetime) 
from pro.ods_circle where dt='${PREDAY}' and type='1' and flag='1' and isprivate='0';





--医生 user :hive2es.ods_user
INSERT OVERWRITE table hive2es.ods_user
SELECT u.id,
       u.name,
       u.doctor_title,
       u.doctor_departments,
       u.doctor_hospital,
       concat_ws('、',collect_set(c.name)) AS expertises,
       if(u.headpicfilename is not null,u.headpicfilename,(if(u.sex='2','https://default.file.dachentech.com.cn/user/head_icon_women.png','https://default.file.dachentech.com.cn/user/head_icon_men.png'))) as pic,
       from_unixtime(unix_timestamp()) as updatetime
FROM (select * from pro.ods_user where dt='${PREDAY}' and usertype='3' and suspend<>'4' and doctor_departments is not null and doctor_departments<>'') u
LEFT JOIN
  (SELECT a.id,
          b.name
   FROM
     (SELECT id,
             deptId
      FROM pro.ods_user LATERAL VIEW explode(doctor_expertise) myTable AS deptId where dt='${PREDAY}' and usertype='3')a
   LEFT JOIN pro.ods_b_disease_type b ON a.deptId=b.id)c ON u.id=c.id
GROUP BY u.id,
         u.name,
         u.doctor_title,
         u.doctor_departments,
         u.doctor_hospital,
         u.headpicfilename,
         u.sex;

--帖子 faq :hive2es.ods_faq
insert overwrite table hive2es.ods_faq  
select 
a.id as id,
a.publish_platformid as circleid,
a.userid as userid,
if(get_json_object(get_json_object(content_supplements[0],'$.extData'),'$.livingChannel')='1','医生圈平台',(if(a.publish_publishertype='1',b.name,c.name))) as src,
d.name as dept,
a.content_summary as content,
case when a.content_pics is not null then a.content_pics when a.content_coverurl is not null then a.content_coverurl when get_json_object(a.content_supplements[0],'$.firstFrame') is not null then get_json_object(a.content_supplements[0],'$.firstFrame') end as pic,
from_unixtime(unix_timestamp()) as updatetime
from
(select * from pro.ods_t_faq_question where dt='${PREDAY}' and type='1' and deleted<>'true' and (recommend='true' or publish_platformid='10000')) a
left join pro.ods_user b on b.dt='${PREDAY}' and a.publish_publisher=b.id
left join pro.ods_circle c on c.dt='${PREDAY}' and a.publish_publisher=c.id
left join pro.ods_b_hospitaldept d on a.deptid=d.id;



--提问 question :hive2es.ods_question
insert overwrite table hive2es.ods_question  
select 
a.id as id,
a.publish_platformid as circleid,
a.userid as userid,
if(a.publish_publishertype='1',b.name,c.name) as src,
d.name as dept,
a.content_summary as content,
case when a.content_pics is not null then a.content_pics when a.content_coverurl is not null then a.content_coverurl when get_json_object(a.content_supplements[0],'$.firstFrame') is not null then get_json_object(a.content_supplements[0],'$.firstFrame') end as pic,
from_unixtime(unix_timestamp()) as updatetime
from
(select * from pro.ods_t_faq_question where dt='${PREDAY}' and type='2' and deleted<>'true' and (recommend='true' or publish_platformid='10000')) a
left join pro.ods_user b on b.dt='${PREDAY}' and a.publish_publisher=b.id
left join pro.ods_circle c on c.dt='${PREDAY}' and a.publish_publisher=c.id
left join pro.ods_b_hospitaldept d on a.deptid=d.id;


--悬赏 reward :hive2es.ods_reward
insert overwrite table hive2es.ods_reward  
select 
a.id as id,
a.publish_platformid as circleid,
a.userid as userid,
if(a.publish_publishertype='1',b.name,c.name) as src,
d.name as dept,
a.content_summary as content,
case when a.content_pics is not null then a.content_pics when a.content_coverurl is not null then a.content_coverurl when get_json_object(a.content_supplements[0],'$.firstFrame') is not null then get_json_object(a.content_supplements[0],'$.firstFrame') end as pic,
from_unixtime(unix_timestamp()) as updatetime
from
(select * from pro.ods_t_faq_question where dt='${PREDAY}' and type='3' and deleted<>'true' and (recommend='true' or publish_platformid='10000')) a
left join pro.ods_user b on b.dt='${PREDAY}' and a.publish_publisher=b.id
left join pro.ods_circle c on c.dt='${PREDAY}' and a.publish_publisher=c.id
left join pro.ods_b_hospitaldept d on a.deptid=d.id;



--病例讨论 disease :hive2es.ods_disease
insert overwrite table hive2es.ods_disease  
select 
a.id as id,
if(a.circleid is null,'10000',a.circleid) as circleid,
a.userid as userid,
if(a.authcirclename is null,a.username,a.authcirclename) as src,
a.userdept as dept,
b.labels as label,
a.title as caption,
if(get_json_object(c.cards[0], '$.attachmentList') is null,'',analysis_json_post_info(get_json_object(c.cards[0], '$.attachmentList'))) as pic,
from_unixtime(unix_timestamp()) as updatetime
from (select * from pro.ods_disease_info where dt='${PREDAY}' and status='1' and hide is null and (circleid is null or recommend='true')) a 
left join 
(
select id,concat_ws(',', collect_set(label)) as labels
from 
(
select id,label.name as label from
(
select id,label 
from pro.ods_disease_info LATERAL VIEW explode(labellist) myTabl as label where dt='${PREDAY}'
) a
) b group by id
) b on a.id=b.id
left join pro.ods_post_info c on c.dt='${PREDAY}' and a.id=c.id;

--直播 living :hive2es.ods_living
insert overwrite table hive2es.ods_living  
select 
id as id,
circleid as circleid,
speakerid as userid,
speakerinfo as src,
deptname as dept,
description as content,
subject as caption,
speakerintroimg as pic,
from_unixtime(unix_timestamp()) as updatetime
from pro.ods_circle_living where dt='${PREDAY}' and deleteFlag<>'1' and action<>'105' and recommend='true';

--录播 video :hive2es.ods_video
insert overwrite table hive2es.ods_video  
select 
a.id as id,
b.id as livingid,
a.circleid as circleid,
a.speakerinfo as src,
c.name as dept,
a.description as content,
a.subject as caption,
a.speakerintroimg as pic,
from_unixtime(unix_timestamp()) as updatetime
from 
(select * from pro.ods_circle_living_video where dt='${PREDAY}' and recommend='true') a 
left join pro.ods_b_hospitaldept c on a.deptid=c.id
join pro.ods_circle_living b on b.dt='${PREDAY}' and a.webcastid=b.webcastid;

--词条 wanfang :hive2es.ods_wanfang
insert overwrite table hive2es.ods_wanfang  
select 
id as id,
dept as dept,
word as label,
from_unixtime(unix_timestamp()) as updatetime
from pro.ods_wanfang_words_info;

--医学文献 article :hive2es.ods_acticle
insert overwrite table hive2es.ods_acticle  
select 
articleid as id,
type as type,
keywords as label,
title as caption,
from_unixtime(unix_timestamp()) as updatetime
from pro.ods_articleInfo  where dt='${PREDAY}';


--微学堂 course :hive2es.ods_course
insert overwrite table hive2es.ods_course  
select 
a.courseid as id,
a.classid as classid,
a.ownerid as userid,
a.ownername as src,
a.ownerdeptname as dept,
b.lable as label,
a.theme as caption,
a.coverimgurl as pic,
from_unixtime(unix_timestamp()) as updatetime
from
(select * from pro.ods_t_course_circle where dt='${PREDAY}' and status in('1','2','9')) a
left join pro.ods_t_course_label_circle b on b.dt='${PREDAY}' and a.courseid=b.courseid;
