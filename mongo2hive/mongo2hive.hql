


--生产环境
add jar hdfs://nameservice1:8020//jar/mongo-java-driver-3.4.1.jar; 
add jar hdfs://nameservice1:8020//jar/mongo-hadoop-core-2.0.2.jar;
add jar hdfs://nameservice1:8020//jar/mongo-hadoop-hive-2.0.2.jar;

--运营分析一期中用到的表

--插入:mongo2hive.health_b_hospital到pro.ods_b_hospital
insert overwrite table pro.ods_b_hospital  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(province,'\\n|\\r','')) as province,
trim(regexp_replace(city,'\\n|\\r','')) as city,
trim(regexp_replace(country,'\\n|\\r','')) as country,
trim(regexp_replace(address,'\\n|\\r','')) as address,
trim(regexp_replace(level,'\\n|\\r','')) as level,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(lat,'\\n|\\r','')) as lat,
trim(regexp_replace(lng,'\\n|\\r','')) as lng,
trim(regexp_replace(lastUpdatorTime,'\\n|\\r','')) as lastUpdatorTime 
from mongo2hive.health_b_hospital;



--插入:mongo2hive.health_b_hospital_level到pro.ods_b_hospital_level
--insert overwrite table pro.ods_b_hospital_level  
--select 
--trim(regexp_replace(id,'\\n|\\r','')) as id,
--trim(regexp_replace(level,'\\n|\\r','')) as level 
--from mongo2hive.health_b_hospital_level;



--插入:mongo2hive.health_b_hospitaldept到pro.ods_b_hospitaldept
--insert overwrite table pro.ods_b_hospitaldept  
--select 
--trim(regexp_replace(id,'\\n|\\r','')) as id,
--trim(regexp_replace(name,'\\n|\\r','')) as name,
--trim(regexp_replace(parentId,'\\n|\\r','')) as parentId,
--trim(regexp_replace(isLeaf,'\\n|\\r','')) as isLeaf,
--trim(regexp_replace(enableStatus,'\\n|\\r','')) as enableStatus,
--trim(regexp_replace(dataStatus,'\\n|\\r','')) as dataStatus,
--trim(regexp_replace(weight,'\\n|\\r','')) as weight,
--trim(regexp_replace(tips_key,'\\n|\\r','')) as tips_key,
--trim(regexp_replace(lastUpdatorTime,'\\n|\\r','')) as lastUpdatorTime 
--from mongo2hive.health_b_hospitaldept;



--插入:mongo2hive.health_user到pro.ods_user
insert overwrite table pro.ods_user PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id ,'\\n|\\r','')) as id,
trim(regexp_replace(age ,'\\n|\\r','')) as age,
trim(regexp_replace(sex ,'\\n|\\r','')) as sex,
trim(regexp_replace(area ,'\\n|\\r','')) as area,
trim(regexp_replace(birthday ,'\\n|\\r','')) as birthday,
trim(regexp_replace(name ,'\\n|\\r','')) as name,
trim(regexp_replace(email ,'\\n|\\r','')) as email,
trim(regexp_replace(telephone ,'\\n|\\r','')) as telephone,
trim(regexp_replace(needResetPassword ,'\\n|\\r','')) as needResetPassword,
trim(regexp_replace(password ,'\\n|\\r','')) as password,
trim(regexp_replace(remarks ,'\\n|\\r','')) as remarks,
trim(regexp_replace(status ,'\\n|\\r','')) as status,
trim(regexp_replace(userLevel ,'\\n|\\r','')) as userLevel,
trim(regexp_replace(userType ,'\\n|\\r','')) as userType,
trim(regexp_replace(giveCoin ,'\\n|\\r','')) as giveCoin,
trim(regexp_replace(headPicFileName ,'\\n|\\r','')) as headPicFileName,
trim(regexp_replace(createTime ,'\\n|\\r','')) as createTime,
trim(regexp_replace(submitTime ,'\\n|\\r','')) as submitTime,
trim(regexp_replace(lastLoginTime ,'\\n|\\r','')) as lastLoginTime,
trim(regexp_replace(limitedPeriodTime ,'\\n|\\r','')) as limitedPeriodTime,
trim(regexp_replace(modifyTime ,'\\n|\\r','')) as modifyTime,
trim(regexp_replace(doctor_province ,'\\n|\\r','')) as doctor_province,
trim(regexp_replace(doctor_provinceId ,'\\n|\\r','')) as doctor_provinceId,
trim(regexp_replace(doctor_city ,'\\n|\\r','')) as doctor_city,
trim(regexp_replace(doctor_cityId ,'\\n|\\r','')) as doctor_cityId,
trim(regexp_replace(doctor_area ,'\\n|\\r','')) as doctor_area,
trim(regexp_replace(doctor_areaId ,'\\n|\\r','')) as doctor_areaId,
trim(regexp_replace(doctor_departments ,'\\n|\\r','')) as doctor_departments,
trim(regexp_replace(doctor_deptId ,'\\n|\\r','')) as doctor_deptId,
trim(regexp_replace(doctor_doctorNum ,'\\n|\\r','')) as doctor_doctorNum,
trim(regexp_replace(doctor_experience ,'\\n|\\r','')) as doctor_experience,
doctor_expertise,
trim(regexp_replace(doctor_hospital ,'\\n|\\r','')) as doctor_hospital,
trim(regexp_replace(doctor_hospitalId ,'\\n|\\r','')) as doctor_hospitalId,
trim(regexp_replace(doctor_introduction ,'\\n|\\r','')) as doctor_introduction,
trim(regexp_replace(doctor_scholarship ,'\\n|\\r','')) as doctor_scholarship,
trim(regexp_replace(doctor_skill ,'\\n|\\r','')) as doctor_skill,
trim(regexp_replace(doctor_title ,'\\n|\\r','')) as doctor_title,
trim(regexp_replace(doctor_check_checkTime ,'\\n|\\r','')) as doctor_check_checkTime,
trim(regexp_replace(doctor_check_checker ,'\\n|\\r','')) as doctor_check_checker,
trim(regexp_replace(doctor_check_checkerId ,'\\n|\\r','')) as doctor_check_checkerId,
trim(regexp_replace(doctor_check_departments ,'\\n|\\r','')) as doctor_check_departments,
trim(regexp_replace(doctor_check_deptId ,'\\n|\\r','')) as doctor_check_deptId,
trim(regexp_replace(doctor_check_hospital ,'\\n|\\r','')) as doctor_check_hospital,
trim(regexp_replace(doctor_check_hospitalId ,'\\n|\\r','')) as doctor_check_hospitalId,
trim(regexp_replace(doctor_check_licenseExpire ,'\\n|\\r','')) as doctor_check_licenseExpire,
trim(regexp_replace(doctor_check_licenseNum ,'\\n|\\r','')) as doctor_check_licenseNum,
trim(regexp_replace(doctor_check_remark ,'\\n|\\r','')) as doctor_check_remark,
trim(regexp_replace(doctor_check_title ,'\\n|\\r','')) as doctor_check_title,
trim(regexp_replace(loginLog_isFirstLogin ,'\\n|\\r','')) as loginLog_isFirstLogin,
trim(regexp_replace(loginLog_location ,'\\n|\\r','')) as loginLog_location,
trim(regexp_replace(loginLog_loginTime ,'\\n|\\r','')) as loginLog_loginTime,
trim(regexp_replace(loginLog_model ,'\\n|\\r','')) as loginLog_model,
trim(regexp_replace(loginLog_offlineTime ,'\\n|\\r','')) as loginLog_offlineTime,
trim(regexp_replace(settings_friendsVerify ,'\\n|\\r','')) as settings_friendsVerify,
trim(regexp_replace(settings_ispushflag ,'\\n|\\r','')) as settings_ispushflag,
trim(regexp_replace(source_inviterId ,'\\n|\\r','')) as source_inviterId,
trim(regexp_replace(source_sourceType ,'\\n|\\r','')) as source_sourceType,
trim(regexp_replace(source_terminal ,'\\n|\\r','')) as source_terminal,
trim(regexp_replace(userConfig_remindVoice ,'\\n|\\r','')) as userConfig_remindVoice,
trim(regexp_replace(suspend,'\\n|\\r','')) as suspend,
trim(regexp_replace(suspendInfo,'\\n|\\r','')) as suspendInfo,
trim(regexp_replace(passIdRec,'\\n|\\r','')) as passIdRec,
trim(regexp_replace(IDCardName,'\\n|\\r','')) as IDCardName,
trim(regexp_replace(IDNum,'\\n|\\r','')) as IDNum,
trim(regexp_replace(sysCheck,'\\n|\\r','')) as sysCheck
from mongo2hive.health_user;




--运营分析二期中用到的表

--插入:mongo2hive.module_t_faq_question到pro.ods_t_faq_question 
insert overwrite table pro.ods_t_faq_question PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(columnId,'\\n|\\r','')) as columnId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(deleted,'\\n|\\r','')) as deleted,
labelIds,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(sourceId,'\\n|\\r','')) as sourceId,
trim(regexp_replace(activityCount,'\\n|\\r','')) as activityCount,
trim(regexp_replace(open,'\\n|\\r','')) as open,
trim(regexp_replace(content_terminal,'\\n|\\r','')) as content_terminal,
trim(regexp_replace(content_type,'\\n|\\r','')) as content_type,
trim(regexp_replace(content_summary,'\\n|\\r','')) as content_summary,
trim(regexp_replace(content_coverUrl,'\\n|\\r','')) as content_coverUrl,
trim(regexp_replace(content_show,'\\n|\\r','')) as content_show,
trim(regexp_replace(content_mainBody,'\\n|\\r','')) as content_mainBody,
trim(regexp_replace(content_bodyId,'\\n|\\r','')) as content_bodyId,
trim(regexp_replace(content_pics,'\\n|\\r','')) as content_pics,
trim(regexp_replace(content_h5Url,'\\n|\\r','')) as content_h5Url,
content_supplements,
trim(regexp_replace(content_attachments,'\\n|\\r','')) as content_attachments,
trim(regexp_replace(content_freeTime,'\\n|\\r','')) as content_freeTime,
trim(regexp_replace(content_articleUrl,'\\n|\\r','')) as content_articleUrl,
trim(regexp_replace(content_articleTitle,'\\n|\\r','')) as content_articleTitle,
trim(regexp_replace(content_articleIcon,'\\n|\\r','')) as content_articleIcon,
trim(regexp_replace(content_commonCard,'\\n|\\r','')) as content_commonCard,
trim(regexp_replace(range_all,'\\n|\\r','')) as range_all,
range_userIds,
range_deptIds,
trim(regexp_replace(payInfo_amount,'\\n|\\r','')) as payInfo_amount,
trim(regexp_replace(payInfo_payerType,'\\n|\\r','')) as payInfo_payerType,
trim(regexp_replace(payInfo_payer,'\\n|\\r','')) as payInfo_payer,
trim(regexp_replace(publish_publisherType,'\\n|\\r','')) as publish_publisherType,
trim(regexp_replace(publish_publisher,'\\n|\\r','')) as publish_publisher,
trim(regexp_replace(publish_platformType,'\\n|\\r','')) as publish_platformType,
trim(regexp_replace(publish_platformId,'\\n|\\r','')) as publish_platformId,
trim(regexp_replace(check_status,'\\n|\\r','')) as check_status,
trim(regexp_replace(check_auditor,'\\n|\\r','')) as check_auditor,
trim(regexp_replace(check_updateTime,'\\n|\\r','')) as check_updateTime,
trim(regexp_replace(sort,'\\n|\\r','')) as sort,
trim(regexp_replace(stickTopTime,'\\n|\\r','')) as stickTopTime,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(bestAnswerIds,'\\n|\\r','')) as bestAnswerIds,
CASE 
WHEN content_commonCard is not null THEN if(get_json_object(content_commonCard,'$.type') is not null,CASE get_json_object(content_commonCard,'$.type') WHEN 'live' THEN '3' WHEN 'video' THEN '4' WHEN 'disease-discuss-post' THEN '5' WHEN 'disgnosis-path-post' THEN '6' END,'0')
WHEN content_supplements is not null THEN if(get_json_object(content_supplements[0],'$.extType') is not null,CASE get_json_object(content_supplements[0],'$.extType') WHEN 'live' THEN '1' WHEN 'video' THEN '2' END,'0')
ELSE '0' END as ctype,
CASE 
WHEN content_commonCard is not null 
THEN 
if(get_json_object(content_commonCard,'$.type') is not null,
CASE get_json_object(content_commonCard,'$.type') 
WHEN 'live' THEN get_json_object(content_commonCard,'$.id') 
WHEN 'video' THEN get_json_object(content_commonCard,'$.id') 
WHEN 'disease-discuss-post' THEN get_json_object(content_commonCard,'$.id') 
WHEN 'disgnosis-path-post' THEN get_json_object(content_commonCard,'$.id') END,'')
WHEN content_supplements is not null 
THEN 
if(get_json_object(content_supplements[0],'$.extType') is not null,
CASE get_json_object(content_supplements[0],'$.extType') 
WHEN 'live' THEN get_json_object(get_json_object(content_supplements[0],'$.extData'),'$.liveId') 
WHEN 'video' THEN get_json_object(get_json_object(content_supplements[0],'$.extData'),'$.liveId') END,'')
ELSE '' END as cid,
trim(regexp_replace(recommend,'\\n|\\r','')) as recommend,
trim(regexp_replace(grade,'\\n|\\r','')) as grade,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_faq_question;





--插入:mongo2hive.module_t_faq_label到pro.ods_t_faq_label
insert overwrite table pro.ods_t_faq_label PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(usageCount,'\\n|\\r','')) as usageCount,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime 
from mongo2hive.module_t_faq_label;


--插入:mongo2hive.module_t_faq_reply到pro.ods_t_faq_reply
insert overwrite table pro.ods_t_faq_reply PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(questionId,'\\n|\\r','')) as questionId,
trim(regexp_replace(questionType,'\\n|\\r','')) as questionType,
trim(regexp_replace(mainReplyId,'\\n|\\r','')) as mainReplyId,
trim(regexp_replace(toUserId,'\\n|\\r','')) as toUserId,
trim(regexp_replace(toUserName,'\\n|\\r','')) as toUserId,
trim(regexp_replace(replyId,'\\n|\\r','')) as replyId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(bestAnswer,'\\n|\\r','')) as bestAnswer,
trim(regexp_replace(stickTopTime,'\\n|\\r','')) as stickTopTime,
trim(regexp_replace(likeCount,'\\n|\\r','')) as likeCount,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(content_type,'\\n|\\r','')) as content_type,
trim(regexp_replace(content_summary,'\\n|\\r','')) as content_summary,
trim(regexp_replace(content_mainBody,'\\n|\\r','')) as content_mainBody,
trim(regexp_replace(content_bodyId,'\\n|\\r','')) as content_bodyId,
trim(regexp_replace(content_freeTime,'\\n|\\r','')) as content_freeTime,
trim(regexp_replace(check_status,'\\n|\\r','')) as check_status,
trim(regexp_replace(check_auditor,'\\n|\\r','')) as check_auditor,
trim(regexp_replace(check_updateTime,'\\n|\\r','')) as check_updateTime,
content_pics
from mongo2hive.module_t_faq_reply;


--插入:mongo2hive.module_t_faq_data_count到pro.ods_t_faq_data_count
insert overwrite table pro.ods_t_faq_data_count PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(dataType,'\\n|\\r','')) as dataType,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(viewCount,'\\n|\\r','')) as viewCount,
trim(regexp_replace(rewardCount,'\\n|\\r','')) as rewardCount,
trim(regexp_replace(likeCount,'\\n|\\r','')) as likeCount,
trim(regexp_replace(replyCount,'\\n|\\r','')) as replyCount,
trim(regexp_replace(readingCount,'\\n|\\r','')) as readingCount,
trim(regexp_replace(class,'\\n|\\r','')) as class 
from mongo2hive.module_t_faq_data_count;



--插入:mongo2hive.module_t_faq_mainBody到pro.ods_t_faq_mainBody
insert overwrite table pro.ods_t_faq_mainBody PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(body,'\\n|\\r','')) as body,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime 
from mongo2hive.module_t_faq_mainBody;



--插入:mongo2hive.module_t_faq_business_detail到pro.ods_t_faq_business_detail
--insert overwrite table pro.ods_t_faq_business_detail PARTITION(dt='${hivevar:preday}')  
--select 
--trim(regexp_replace(id,'\\n|\\r','')) as id,
--trim(regexp_replace(userId,'\\n|\\r','')) as userId,
--trim(regexp_replace(type,'\\n|\\r','')) as type,
--trim(regexp_replace(value,'\\n|\\r','')) as value,
--trim(regexp_replace(dataType,'\\n|\\r','')) as dataType,
--trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
--trim(regexp_replace(replyId,'\\n|\\r','')) as replyId,
--trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
--trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime 
--from mongo2hive.module_t_faq_business_detail;



--插入:mongo2hive.module_t_faq_ad_reply到pro.ods_t_faq_ad_reply
--insert overwrite table pro.ods_t_faq_ad_reply PARTITION(dt='${hivevar:preday}')  
--select 
--trim(regexp_replace(id,'\\n|\\r','')) as id,
--trim(regexp_replace(userId,'\\n|\\r','')) as userId,
--trim(regexp_replace(type,'\\n|\\r','')) as type,
--trim(regexp_replace(materialId,'\\n|\\r','')) as materialId,
--trim(regexp_replace(materialType,'\\n|\\r','')) as materialType,
--trim(regexp_replace(mainReplyId,'\\n|\\r','')) as mainReplyId,
--trim(regexp_replace(toUserId,'\\n|\\r','')) as toUserId,
--trim(regexp_replace(parentReplayId,'\\n|\\r','')) as parentReplayId,
--trim(regexp_replace(content,'\\n|\\r','')) as content,
--trim(regexp_replace(status,'\\n|\\r','')) as status,
--trim(regexp_replace(likeCount,'\\n|\\r','')) as likeCount,
--trim(regexp_replace(replyCount,'\\n|\\r','')) as replyCount,
--trim(regexp_replace(rewardCount,'\\n|\\r','')) as rewardCount,
--trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
--trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime 
--from mongo2hive.module_t_faq_ad_reply;






--插入:mongo2hive.module_t_faq_column到pro.ods_t_faq_column
insert overwrite table pro.ods_t_faq_column PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(weight,'\\n|\\r','')) as weight,
trim(regexp_replace(owner,'\\n|\\r','')) as owner,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime 
from mongo2hive.module_t_faq_column;





--插入:mongo2hive.module_t_faq_like到pro.ods_t_faq_like
insert overwrite table pro.ods_t_faq_like PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime  
from mongo2hive.module_t_faq_like;







--插入:mongo2hive.diseasediscuss_disease_info到pro.ods_disease_info
insert overwrite table pro.ods_disease_info PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(userHeadPic,'\\n|\\r','')) as userHeadPic,
trim(regexp_replace(userAcademicTitle,'\\n|\\r','')) as userAcademicTitle,
trim(regexp_replace(userHospital,'\\n|\\r','')) as userHospital,
trim(regexp_replace(userDept,'\\n|\\r','')) as userDept,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
labelList,
trim(regexp_replace(shareUrl,'\\n|\\r','')) as shareUrl,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(recommend,'\\n|\\r','')) as recommend,
trim(regexp_replace(recommendTime,'\\n|\\r','')) as recommendTime,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(from_,'\\n|\\r','')) as from_,
trim(regexp_replace(diseaseFrom,'\\n|\\r','')) as diseaseFrom,
trim(regexp_replace(check,'\\n|\\r','')) as check,
trim(regexp_replace(hide,'\\n|\\r','')) as hide,
trim(regexp_replace(authCircleId,'\\n|\\r','')) as authCircleId,
trim(regexp_replace(authCircleName,'\\n|\\r','')) as authCircleName,
trim(regexp_replace(authCircleLogoUrl,'\\n|\\r','')) as authCircleLogoUrl,
trim(regexp_replace(publisherType,'\\n|\\r','')) as publisherType,
trim(regexp_replace(isprivate,'\\n|\\r','')) as isprivate,
trim(regexp_replace(grade,'\\n|\\r','')) as grade,
trim(regexp_replace(hall,'\\n|\\r','')) as hall
from mongo2hive.diseasediscuss_disease_info;






--插入:mongo2hive.diseasediscuss_disease_question到pro.ods_disease_question
insert overwrite table pro.ods_disease_question PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(questionId,'\\n|\\r','')) as questionId,
trim(regexp_replace(diseaseId,'\\n|\\r','')) as diseaseId,
trim(regexp_replace(questionTitle,'\\n|\\r','')) as questionTitle,
trim(regexp_replace(questionType,'\\n|\\r','')) as questionType,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(statusFlag,'\\n|\\r','')) as statusFlag,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(userHeadPic,'\\n|\\r','')) as userHeadPic,
trim(regexp_replace(userAcademicTitle,'\\n|\\r','')) as userAcademicTitle,
trim(regexp_replace(userHospital,'\\n|\\r','')) as userHospital,
trim(regexp_replace(userDept,'\\n|\\r','')) as userDept 
from mongo2hive.diseasediscuss_disease_question;








--插入:mongo2hive.online_marketing_t_promotion到pro.ods_t_promotion
insert overwrite table pro.ods_t_promotion PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(templateId,'\\n|\\r','')) as templateId,
trim(regexp_replace(template,'\\n|\\r','')) as template,
promotionItemList,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(drugCompanyId,'\\n|\\r','')) as drugCompanyId,
trim(regexp_replace(promotionType,'\\n|\\r','')) as promotionType,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(forwardRule,'\\n|\\r','')) as forwardRule,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(from1,'\\n|\\r','')) as from1,
trim(regexp_replace(shareCode,'\\n|\\r','')) as shareCode,
trim(regexp_replace(linkId,'\\n|\\r','')) as linkId,
trim(regexp_replace(linkType,'\\n|\\r','')) as linkType,
trim(regexp_replace(scheduledTime,'\\n|\\r','')) as scheduledTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.online_marketing_t_promotion;

--插入:mongo2hive.activity_t_meeting_activity到pro.ods_t_meeting_activity
insert overwrite table pro.ods_t_meeting_activity PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(extImageUrl,'\\n|\\r','')) as extImageUrl,
trim(regexp_replace(signFlag,'\\n|\\r','')) as signFlag,
trim(regexp_replace(groupFlag,'\\n|\\r','')) as groupFlag,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(lastUpdater,'\\n|\\r','')) as lastUpdater,
trim(regexp_replace(lastUpdateTime,'\\n|\\r','')) as lastUpdateTime,
trim(regexp_replace(recordFlag,'\\n|\\r','')) as recordFlag 
from mongo2hive.activity_t_meeting_activity;


--插入:mongo2hive.health_user_concern_dept到pro.ods_user_concern_dept
insert overwrite table pro.ods_user_concern_dept PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
deptIds 
from mongo2hive.health_user_concern_dept;



--插入:mongo2hive.health_c_doctor_follow到pro.ods_c_doctor_follow
insert overwrite table pro.ods_c_doctor_follow PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime 
from mongo2hive.health_c_doctor_follow;





--插入:mongo2hive.module_t_faq_user_label到pro.ods_t_faq_user_label
insert overwrite table pro.ods_t_faq_user_label PARTITION(dt='${hivevar:preday}')  
select 
trim(regexp_replace(id ,'\\n|\\r','')) as id,
trim(regexp_replace(userId ,'\\n|\\r','')) as userId,
trim(regexp_replace(labelId ,'\\n|\\r','')) as labelId,
trim(regexp_replace(createTime ,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime ,'\\n|\\r','')) as updateTime 
from mongo2hive.module_t_faq_user_label;



----插入:mongo2hive.activity_t_promotion_activity.ods_t_promotion_activity
--insert overwrite table pro.ods_t_promotion_activity PARTITION(dt='${hivevar:preday}')   
--select 
--trim(regexp_replace(id ,'\\n|\\r','')) as id,
--trim(regexp_replace(name ,'\\n|\\r','')) as name,
--trim(regexp_replace(rule_surveyId ,'\\n|\\r','')) as rule_surveyId,
--trim(regexp_replace(rule_surveyName ,'\\n|\\r','')) as rule_surveyName
--from mongo2hive.activity_t_promotion_activity;



--插入:mongo2hive.activity_t_meeting_activity_sign到pro.ods_t_meeting_activity_sign
insert overwrite table pro.ods_t_meeting_activity_sign PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(businessId,'\\n|\\r','')) as businessId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userJson,'\\n|\\r','')) as userJson,
trim(regexp_replace(signTime,'\\n|\\r','')) as signTime
from mongo2hive.activity_t_meeting_activity_sign;


--插入：mongo2hive.online_marketing_t_promotion_view到pro.ods_t_promotion_view
insert overwrite table pro.ods_t_promotion_view PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(promotionId,'\\n|\\r','')) as promotionId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.online_marketing_t_promotion_view;



--插入：mongo2hive.micro_school_t_course到pro.ods_t_course
insert overwrite table pro.ods_t_course PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(theme,'\\n|\\r','')) as theme,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(beginTime,'\\n|\\r','')) as beginTime,
trim(regexp_replace(form,'\\n|\\r','')) as form,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(publishType,'\\n|\\r','')) as publishType,
trim(regexp_replace(publishRangeDesc,'\\n|\\r','')) as publishRangeDesc,
trim(regexp_replace(coverImgUrl,'\\n|\\r','')) as coverImgUrl,
trim(regexp_replace(introduce,'\\n|\\r','')) as introduce
from mongo2hive.micro_school_t_course;



--插入：mongo2hive.micro_school_t_course_entry到pro.ods_t_course_entry
insert overwrite table pro.ods_t_course_entry PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(applyTime,'\\n|\\r','')) as applyTime,
trim(regexp_replace(applyStatus,'\\n|\\r','')) as applyStatus,
trim(regexp_replace(applyFrom,'\\n|\\r','')) as applyFrom
from mongo2hive.micro_school_t_course_entry;



--插入：mongo2hive.health_t_meeting到pro.ods_t_meeting
insert overwrite table pro.ods_t_meeting PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(company,'\\n|\\r','')) as company,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(subject,'\\n|\\r','')) as subject,
trim(regexp_replace(startDate,'\\n|\\r','')) as startDate,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(attendeesCount,'\\n|\\r','')) as attendeesCount,
trim(regexp_replace(price,'\\n|\\r','')) as price,
trim(regexp_replace(organizerToken,'\\n|\\r','')) as organizerToken,
trim(regexp_replace(panelistToken,'\\n|\\r','')) as panelistToken,
trim(regexp_replace(attendeeToken,'\\n|\\r','')) as attendeeToken,
trim(regexp_replace(organizerJoinUrl,'\\n|\\r','')) as organizerJoinUrl,
trim(regexp_replace(panelistJoinUrl,'\\n|\\r','')) as panelistJoinUrl,
trim(regexp_replace(attendeeJoinUrl,'\\n|\\r','')) as attendeeJoinUrl,
trim(regexp_replace(liveId,'\\n|\\r','')) as liveId,
trim(regexp_replace(number,'\\n|\\r','')) as number,
trim(regexp_replace(isStop,'\\n|\\r','')) as isStop,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId
from mongo2hive.health_t_meeting;


--插入：mongo2hive.health_t_meeting_joinrecord到pro.ods_t_meeting_joinrecord
insert overwrite table pro.ods_t_meeting_joinrecord PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(sysUpdateLeave,'\\n|\\r','')) as sysUpdateLeave,
trim(regexp_replace(class,'\\n|\\r','')) as class,
trim(regexp_replace(joinRole,'\\n|\\r','')) as joinRole,
trim(regexp_replace(appVersion,'\\n|\\r','')) as appVersion,
trim(regexp_replace(joinUserId,'\\n|\\r','')) as joinUserId,
trim(regexp_replace(joinNumber,'\\n|\\r','')) as joinNumber,
trim(regexp_replace(appName,'\\n|\\r','')) as appName,
trim(regexp_replace(meetingNumber,'\\n|\\r','')) as meetingNumber,
trim(regexp_replace(phoneType,'\\n|\\r','')) as phoneType,
trim(regexp_replace(joinTime,'\\n|\\r','')) as joinTime,
trim(regexp_replace(leaveTime,'\\n|\\r','')) as leaveTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(visitIp,'\\n|\\r','')) as visitIp
from mongo2hive.health_t_meeting_joinrecord;



--插入：mongo2hive.micro_school_t_comment到pro.ods_t_comment
insert overwrite table pro.ods_t_comment PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(content_msgType,'\\n|\\r','')) as content_msgType,
trim(regexp_replace(content_text,'\\n|\\r','')) as content_text,
trim(regexp_replace(sendUserId,'\\n|\\r','')) as sendUserId,
trim(regexp_replace(sendTime,'\\n|\\r','')) as sendTime,
trim(regexp_replace(clientMsgId,'\\n|\\r','')) as clientMsgId,
trim(regexp_replace(clientAppId,'\\n|\\r','')) as clientAppId
from mongo2hive.micro_school_t_comment;


--插入：mongo2hive.micro_school_t_courseware到pro.ods_t_courseware
insert overwrite table pro.ods_t_courseware PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(url,'\\n|\\r','')) as url,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(pageNumber,'\\n|\\r','')) as pageNumber,
trim(regexp_replace(deleted,'\\n|\\r','')) as deleted
from mongo2hive.micro_school_t_courseware;



--插入：mongo2hive.micro_school_t_pre_message到pro.ods_t_pre_message
insert overwrite table pro.ods_t_pre_message PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(content_msgType,'\\n|\\r','')) as content_msgType,
trim(regexp_replace(content_voice,'\\n|\\r','')) as content_voice,
trim(regexp_replace(content_text,'\\n|\\r','')) as content_text,
trim(regexp_replace(content_pic,'\\n|\\r','')) as content_pic,
trim(regexp_replace(content_video,'\\n|\\r','')) as content_video,
trim(regexp_replace(content_file,'\\n|\\r','')) as content_file,
trim(regexp_replace(coursewareId,'\\n|\\r','')) as coursewareId,
trim(regexp_replace(pageNum,'\\n|\\r','')) as pageNum,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(sendStatus,'\\n|\\r','')) as sendStatus,
trim(regexp_replace(clientAppId,'\\n|\\r','')) as clientAppId,
trim(regexp_replace(sendTime,'\\n|\\r','')) as sendTime
from mongo2hive.micro_school_t_pre_message;



--插入：mongo2hive.diseasediscuss_expert_comment到pro.ods_expert_comment
insert overwrite table pro.ods_expert_comment PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(questionId,'\\n|\\r','')) as questionId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(commentUser,'\\n|\\r','')) as commentUser,
trim(regexp_replace(commentId,'\\n|\\r','')) as commentId,
trim(regexp_replace(diseaseId,'\\n|\\r','')) as diseaseId
from mongo2hive.diseasediscuss_expert_comment;


--插入：mongo2hive.diseasediscuss_expert_reward到pro.ods_expert_reward
insert overwrite table pro.ods_expert_reward PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(diseaseId,'\\n|\\r','')) as diseaseId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(rewardUserId,'\\n|\\r','')) as rewardUserId,
trim(regexp_replace(rewardType,'\\n|\\r','')) as rewardType,
trim(regexp_replace(rewardNumber,'\\n|\\r','')) as rewardNumber,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(commentId,'\\n|\\r','')) as commentId,
trim(regexp_replace(rewardTime,'\\n|\\r','')) as rewardTime
from mongo2hive.diseasediscuss_expert_reward;


--插入：mongo2hive.module_t_faq_business_detail到pro.ods_t_faq_business_detail
insert overwrite table pro.ods_t_faq_business_detail PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(value,'\\n|\\r','')) as value,
trim(regexp_replace(dataType,'\\n|\\r','')) as dataType,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(replyId,'\\n|\\r','')) as replyId,
trim(regexp_replace(rewardedUserId,'\\n|\\r','')) as rewardedUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_faq_business_detail;






--插入：mongo2hive.health_t_meeting_info到pro.ods_t_meeting_info
insert overwrite table pro.ods_t_meeting_info PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(class,'\\n|\\r','')) as class,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(meetingNumber,'\\n|\\r','')) as meetingNumber,
trim(regexp_replace(beginTime,'\\n|\\r','')) as beginTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(comperes,'\\n|\\r','')) as comperes,
trim(regexp_replace(audiences,'\\n|\\r','')) as audiences,
trim(regexp_replace(joinType,'\\n|\\r','')) as joinType,
trim(regexp_replace(publicType,'\\n|\\r','')) as publicType,
trim(regexp_replace(meetingModel,'\\n|\\r','')) as meetingModel,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(creatorId,'\\n|\\r','')) as creatorId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(createFrom,'\\n|\\r','')) as createFrom,
trim(regexp_replace(agoraRtcVideoProfile,'\\n|\\r','')) as agoraRtcVideoProfile,
trim(regexp_replace(shareFiles,'\\n|\\r','')) as shareFiles,
trim(regexp_replace(speakerId,'\\n|\\r','')) as speakerId,
trim(regexp_replace(speakerName,'\\n|\\r','')) as speakerName,
trim(regexp_replace(speakerIntroImg,'\\n|\\r','')) as speakerIntroImg,
trim(regexp_replace(intro,'\\n|\\r','')) as intro,
trim(regexp_replace(planDesc,'\\n|\\r','')) as planDesc,
trim(regexp_replace(imgCover,'\\n|\\r','')) as imgCover,
trim(regexp_replace(realBeginTime,'\\n|\\r','')) as realBeginTime,
trim(regexp_replace(realEndTime,'\\n|\\r','')) as realEndTime
from mongo2hive.health_t_meeting_info;



--插入：mongo2hive.health_t_meeting_detail到pro.ods_t_meeting_detail
insert overwrite table pro.ods_t_meeting_detail PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(class,'\\n|\\r','')) as class,
trim(regexp_replace(channelId,'\\n|\\r','')) as channelId,
trim(regexp_replace(inviter,'\\n|\\r','')) as inviter,
trim(regexp_replace(invitees,'\\n|\\r','')) as invitees,
trim(regexp_replace(inviteTime,'\\n|\\r','')) as inviteTime,
trim(regexp_replace(joinTime,'\\n|\\r','')) as joinTime,
trim(regexp_replace(exitTime,'\\n|\\r','')) as exitTime,
trim(regexp_replace(joinWay,'\\n|\\r','')) as joinWay
from mongo2hive.health_t_meeting_detail;



--插入：mongo2hive.health_t_phone_conference到pro.ods_t_phone_conference
insert overwrite table pro.ods_t_phone_conference PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(creater,'\\n|\\r','')) as creater,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(channelId,'\\n|\\r','')) as channelId,
trim(regexp_replace(recordUrl,'\\n|\\r','')) as recordUrl,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(gid,'\\n|\\r','')) as gid
from mongo2hive.health_t_phone_conference;



--插入：mongo2hive.health_t_phone_conference_record到pro.ods_t_phone_conference_record
insert overwrite table pro.ods_t_phone_conference_record PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(crId,'\\n|\\r','')) as crId,
trim(regexp_replace(memberId,'\\n|\\r','')) as memberId,
trim(regexp_replace(joinTime,'\\n|\\r','')) as joinTime,
trim(regexp_replace(unJoinTime,'\\n|\\r','')) as unJoinTime,
trim(regexp_replace(isNow,'\\n|\\r','')) as isNow
from mongo2hive.health_t_phone_conference_record;




--插入：mongo2hive.health_t_meeting_record到pro.ods_t_meeting_record
insert overwrite table pro.ods_t_meeting_record PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(class,'\\n|\\r','')) as class,
trim(regexp_replace(sponsor,'\\n|\\r','')) as sponsor,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(channelId,'\\n|\\r','')) as channelId,
trim(regexp_replace(meetingType,'\\n|\\r','')) as meetingType,
trim(regexp_replace(gid,'\\n|\\r','')) as gid,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(ender,'\\n|\\r','')) as ender,
trim(regexp_replace(recordUrl,'\\n|\\r','')) as recordUrl
from mongo2hive.health_t_meeting_record;




--插入：mongo2hive.module_t_faq_report到pro.ods_t_faq_report
insert overwrite table pro.ods_t_faq_report PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(dataType,'\\n|\\r','')) as dataType,
trim(regexp_replace(reason,'\\n|\\r','')) as reason,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(auditor,'\\n|\\r','')) as auditor,
trim(regexp_replace(auditorTime,'\\n|\\r','')) as auditorTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_faq_report;



--插入：mongo2hive.module_t_faq_shareUrl到pro.ods_t_faq_shareUrl
insert overwrite table pro.ods_t_faq_shareUrl PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(url,'\\n|\\r','')) as url,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(cover,'\\n|\\r','')) as cover,
trim(regexp_replace(desc,'\\n|\\r','')) as desc,
trim(regexp_replace(documentUrl,'\\n|\\r','')) as documentUrl,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.module_t_faq_shareUrl;



--插入：mongo2hive.module_t_faq_favorites到pro.ods_t_faq_favorites
insert overwrite table pro.ods_t_faq_favorites PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(labels,'\\n|\\r','')) as labels,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_faq_favorites;



--插入：mongo2hive.module_t_credit_record到pro.ods_t_credit_record
insert overwrite table pro.ods_t_credit_record PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(accountType,'\\n|\\r','')) as accountType,
trim(regexp_replace(accountId,'\\n|\\r','')) as accountId,
trim(regexp_replace(value,'\\n|\\r','')) as value,
trim(regexp_replace(currentBalance,'\\n|\\r','')) as currentBalance,
trim(regexp_replace(remark,'\\n|\\r','')) as remark,
trim(regexp_replace(reason,'\\n|\\r','')) as reason,
trim(regexp_replace(creater,'\\n|\\r','')) as creater,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(businessType,'\\n|\\r','')) as businessType,
trim(regexp_replace(returnId,'\\n|\\r','')) as returnId,
trim(regexp_replace(eventId,'\\n|\\r','')) as eventId,
trim(regexp_replace(callbackUrl,'\\n|\\r','')) as callbackUrl,
trim(regexp_replace(callbackStatus,'\\n|\\r','')) as callbackStatus,
trim(regexp_replace(callbackTime,'\\n|\\r','')) as callbackTime,
trim(regexp_replace(callbackCount,'\\n|\\r','')) as callbackCount,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_credit_record;


--插入：mongo2hive.circledaq_circle_operation_log到pro.ods_circle_operation_log
insert overwrite table pro.ods_circle_operation_log PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(`date`,'\\n|\\r','')) as `date`
from mongo2hive.circledaq_circle_operation_log;


--插入：mongo2hive.online_marketing_t_redPaper_record到pro.ods_t_redPaper_record
insert overwrite table pro.ods_t_redPaper_record PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(promotionId,'\\n|\\r','')) as promotionId,
trim(regexp_replace(redPaperId,'\\n|\\r','')) as redPaperId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(haveDone,'\\n|\\r','')) as haveDone,
trim(regexp_replace(drugOrCircle,'\\n|\\r','')) as drugOrCircle,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.online_marketing_t_redPaper_record;



--插入：mongo2hive.health_t_survey_answer到pro.ods_t_survey_answer
insert overwrite table pro.ods_t_survey_answer PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(appName,'\\n|\\r','')) as appName,
trim(regexp_replace(surveyId,'\\n|\\r','')) as surveyId,
trim(regexp_replace(surveyTitle,'\\n|\\r','')) as surveyTitle,
trim(regexp_replace(surveyDesc,'\\n|\\r','')) as surveyDesc,
trim(regexp_replace(surveyUnionId,'\\n|\\r','')) as surveyUnionId,
trim(regexp_replace(surveyVersion,'\\n|\\r','')) as surveyVersion,
answerList,
trim(regexp_replace(activeUserId,'\\n|\\r','')) as activeUserId,
trim(regexp_replace(activeTime,'\\n|\\r','')) as activeTime
from mongo2hive.health_t_survey_answer;


--插入：mongo2hive.online_marketing_t_survey_record到pro.ods_t_survey_record
insert overwrite table pro.ods_t_survey_record PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(promotionId,'\\n|\\r','')) as promotionId,
trim(regexp_replace(surveyId,'\\n|\\r','')) as surveyId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(answerId,'\\n|\\r','')) as answerId,
trim(regexp_replace(`desc`,'\\n|\\r','')) as `desc`,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(version,'\\n|\\r','')) as version,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.online_marketing_t_survey_record;


--插入：mongo2hive.micro_school_t_learn_record到pro.ods_t_learn_record
insert overwrite table pro.ods_t_learn_record PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(normal,'\\n|\\r','')) as normal,
trim(regexp_replace(courseBeginTime,'\\n|\\r','')) as courseBeginTime,
trim(regexp_replace(learnSeconds,'\\n|\\r','')) as learnSeconds,
trim(regexp_replace(clientAppId,'\\n|\\r','')) as clientAppId
from mongo2hive.micro_school_t_learn_record;



--插入：mongo2hive.module_t_credit_user_integral到pro.ods_t_credit_user_integral
insert overwrite table pro.ods_t_credit_user_integral PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(balance,'\\n|\\r','')) as balance,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_credit_user_integral;



--插入：mongo2hive.health_u_doctor_friend到pro.ods_u_doctor_friend
insert overwrite table pro.ods_u_doctor_friend PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(toUserId,'\\n|\\r','')) as toUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(setting,'\\n|\\r','')) as setting
from mongo2hive.health_u_doctor_friend;


--插入：mongo2hive.basepost_statistic_info到pro.ods_statistic_info
insert overwrite table pro.ods_statistic_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(readCount,'\\n|\\r','')) as readCount,
trim(regexp_replace(praiseCount,'\\n|\\r','')) as praiseCount,
trim(regexp_replace(rewardCount,'\\n|\\r','')) as rewardCount,
trim(regexp_replace(collectCount,'\\n|\\r','')) as collectCount,
trim(regexp_replace(commentCount,'\\n|\\r','')) as commentCount,
trim(regexp_replace(replyCount,'\\n|\\r','')) as replyCount
from mongo2hive.basepost_statistic_info;



--插入：mongo2hive.basepost_comment_info到pro.ods_comment_info
insert overwrite table pro.ods_comment_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(postId,'\\n|\\r','')) as postId,
trim(regexp_replace(cards,'\\n|\\r','')) as cards,
trim(regexp_replace(content,'\\n|\\r','')) as content,
trim(regexp_replace(sortIndex,'\\n|\\r','')) as sortIndex,
trim(regexp_replace(authorId,'\\n|\\r','')) as authorId,
trim(regexp_replace(authorName,'\\n|\\r','')) as authorName,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(updateUser,'\\n|\\r','')) as updateUser,
trim(regexp_replace(statusFlag,'\\n|\\r','')) as statusFlag
from mongo2hive.basepost_comment_info;

--插入：mongo2hive.basepost_reward_info到pro.ods_reward_info
insert overwrite table pro.ods_reward_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(rewardType,'\\n|\\r','')) as rewardType,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(receiveRewardUser,'\\n|\\r','')) as receiveRewardUser
from mongo2hive.basepost_reward_info;

--插入:mongo2hive.module_t_faq_label到pro.ods_t_auth_user
insert overwrite table pro.ods_t_auth_user PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activeTime,'\\n|\\r','')) as activeTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userType,'\\n|\\r','')) as userType,
trim(regexp_replace(accountId,'\\n|\\r','')) as accountId,
trim(regexp_replace(active,'\\n|\\r','')) as active,
trim(regexp_replace(openId,'\\n|\\r','')) as openId,
trim(regexp_replace(lastLoginTime,'\\n|\\r','')) as lastLoginTime
from mongo2hive.auth2_t_auth_user;


--插入:mongo2hive.drugorg_d_user到pro.ods_d_user
insert overwrite table pro.ods_d_user PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(drugCompanyId,'\\n|\\r','')) as drugCompanyId,
trim(regexp_replace(openId,'\\n|\\r','')) as openId,
trim(regexp_replace(employeeId,'\\n|\\r','')) as employeeId,
trim(regexp_replace(jobType,'\\n|\\r','')) as jobType,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(entryDate,'\\n|\\r','')) as entryDate,
trim(regexp_replace(active,'\\n|\\r','')) as active,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(pinYin,'\\n|\\r','')) as pinYin,
trim(regexp_replace(fullPinYin,'\\n|\\r','')) as fullPinYin,
trim(regexp_replace(telephone,'\\n|\\r','')) as telephone,
trim(regexp_replace(hidePhone,'\\n|\\r','')) as hidePhone,
trim(regexp_replace(headPicUrl,'\\n|\\r','')) as headPicUrl,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(orgId,'\\n|\\r','')) as orgId,
trim(regexp_replace(orgName,'\\n|\\r','')) as orgName,
trim(regexp_replace(treePath,'\\n|\\r','')) as treePath,
trim(regexp_replace(creatorDate,'\\n|\\r','')) as creatorDate,
trim(regexp_replace(updatorDate,'\\n|\\r','')) as updatorDate,
trim(regexp_replace(bizRoleCode,'\\n|\\r','')) as bizRoleCode,
trim(regexp_replace(roleCodes,'\\n|\\r','')) as roleCodes,
trim(regexp_replace(deptManager,'\\n|\\r','')) as deptManager,
trim(regexp_replace(sysManager,'\\n|\\r','')) as sysManager,
trim(regexp_replace(rootManager,'\\n|\\r','')) as rootManager,
trim(regexp_replace(weight,'\\n|\\r','')) as weight,
trim(regexp_replace(pinYinOrderType,'\\n|\\r','')) as pinYinOrderType,
trim(regexp_replace(from1,'\\n|\\r','')) as from1,
trim(regexp_replace(fromId,'\\n|\\r','')) as fromId,
trim(regexp_replace(updator,'\\n|\\r','')) as updator,
trim(regexp_replace(creator,'\\n|\\r','')) as creator
from mongo2hive.drugorg_d_user;


--插入:mongo2hive.module_t_credit_freeze到pro.ods_t_credit_freeze
insert overwrite table pro.ods_t_credit_freeze PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(accountId,'\\n|\\r','')) as accountId,
trim(regexp_replace(accountType,'\\n|\\r','')) as accountType,
trim(regexp_replace(value,'\\n|\\r','')) as value,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(eventIds,'\\n|\\r','')) as eventIds
from mongo2hive.module_t_credit_freeze;



--插入:mongo2hive.module_t_credit_freeze到pro.ods_t_credit_freeze_record
insert overwrite table pro.ods_t_credit_freeze_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(accountId,'\\n|\\r','')) as accountId,
trim(regexp_replace(accountType,'\\n|\\r','')) as accountType,
trim(regexp_replace(value,'\\n|\\r','')) as value,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(reason,'\\n|\\r','')) as reason,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_credit_freeze_record;



--插入:mongo2hive.health_b_disease_type到pro.ods_b_disease_type
insert overwrite table pro.ods_b_disease_type PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(enable1,'\\n|\\r','')) as enable1,
trim(regexp_replace(isLeaf,'\\n|\\r','')) as isLeaf,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(parent,'\\n|\\r','')) as parent,
trim(regexp_replace(remark,'\\n|\\r','')) as remark,
trim(regexp_replace(weight,'\\n|\\r','')) as weight,
trim(regexp_replace(alias,'\\n|\\r','')) as alias,
trim(regexp_replace(attention,'\\n|\\r','')) as attention,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(docNum,'\\n|\\r','')) as docNum,
trim(regexp_replace(weights,'\\n|\\r','')) as weights
from mongo2hive.health_b_disease_type;


--插入:mongo2hive.module_t_credit_dept_integral到pro.ods_t_credit_dept_integral
insert overwrite table pro.ods_t_credit_dept_integral PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(balance,'\\n|\\r','')) as balance,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_credit_dept_integral;



--插入:mongo2hive.module_t_credit_dept_integral到pro.ods_t_promotion_activity
insert overwrite table pro.ods_t_promotion_activity PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(rule1,'\\n|\\r','')) as rule1,
trim(regexp_replace(rule_surveyId ,'\\n|\\r','')) as rule_surveyId,
trim(regexp_replace(rule_surveyName ,'\\n|\\r','')) as rule_surveyName,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(rewardWay,'\\n|\\r','')) as rewardWay,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(limit_,'\\n|\\r','')) as limit_,
trim(regexp_replace(signed,'\\n|\\r','')) as signed,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(aidIntroduction,'\\n|\\r','')) as aidIntroduction,
trim(regexp_replace(creation,'\\n|\\r','')) as creation,
trim(regexp_replace(deleted,'\\n|\\r','')) as deleted,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(ownerCompanyId,'\\n|\\r','')) as ownerCompanyId,
trim(regexp_replace(ownerCompany,'\\n|\\r','')) as ownerCompany,
trim(regexp_replace(objectIds,'\\n|\\r','')) as objectIds
from mongo2hive.activity_t_promotion_activity;




--插入:mongo2hive.activity_t_invitation到pro.ods_t_invitation
insert overwrite table pro.ods_t_invitation PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(bizType,'\\n|\\r','')) as bizType,
trim(regexp_replace(rewardWay,'\\n|\\r','')) as rewardWay,
trim(regexp_replace(inviterId,'\\n|\\r','')) as inviterId,
trim(regexp_replace(inviterName,'\\n|\\r','')) as inviterName,
trim(regexp_replace(inviteeId,'\\n|\\r','')) as inviteeId,
trim(regexp_replace(inviteeName,'\\n|\\r','')) as inviteeName,
trim(regexp_replace(received,'\\n|\\r','')) as received,
trim(regexp_replace(inviteTime,'\\n|\\r','')) as inviteTime,
trim(regexp_replace(credit,'\\n|\\r','')) as credit,
trim(regexp_replace(bizTitle,'\\n|\\r','')) as bizTitle,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(invalid,'\\n|\\r','')) as invalid,
trim(regexp_replace(invalidTime,'\\n|\\r','')) as invalidTime,
trim(regexp_replace(msgId,'\\n|\\r','')) as msgId,
trim(regexp_replace(gid,'\\n|\\r','')) as gid,
trim(regexp_replace(read,'\\n|\\r','')) as read,
trim(regexp_replace(joinedCircles,'\\n|\\r','')) as joinedCircles,
trim(regexp_replace(addCredit,'\\n|\\r','')) as addCredit,
trim(regexp_replace(addCreditTime,'\\n|\\r','')) as addCreditTime,
trim(regexp_replace(addCredited,'\\n|\\r','')) as addCredited
from mongo2hive.activity_t_invitation;




--插入:mongo2hive.activity_t_assistant到pro.ods_t_assistant
insert overwrite table pro.ods_t_assistant PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(haveDone,'\\n|\\r','')) as haveDone,
trim(regexp_replace(surveyId,'\\n|\\r','')) as surveyId,
trim(regexp_replace(answerId,'\\n|\\r','')) as answerId,
trim(regexp_replace(answers,'\\n|\\r','')) as answers
from mongo2hive.activity_t_assistant;



--插入:mongo2hive.module_t_ad_ready_material到pro.ods_t_ad_ready_material
insert overwrite table pro.ods_t_ad_ready_material PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(putCompany,'\\n|\\r','')) as putCompany,
trim(regexp_replace(putCompanyName,'\\n|\\r','')) as putCompanyName,
trim(regexp_replace(putSource,'\\n|\\r','')) as putSource,
trim(regexp_replace(range,'\\n|\\r','')) as range,
trim(regexp_replace(timelyPush,'\\n|\\r','')) as timelyPush,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(rawMaterialId,'\\n|\\r','')) as rawMaterialId,
trim(regexp_replace(coverUrl,'\\n|\\r','')) as coverUrl,
trim(regexp_replace(surveyRange,'\\n|\\r','')) as surveyRange,
trim(regexp_replace(surveyEndTime,'\\n|\\r','')) as surveyEndTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(freezeId,'\\n|\\r','')) as freezeId,
trim(regexp_replace(isShowCoverUrl,'\\n|\\r','')) as isShowCoverUrl,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(shareUrl,'\\n|\\r','')) as shareUrl,
trim(regexp_replace(outerLinkTitle,'\\n|\\r','')) as outerLinkTitle,
trim(regexp_replace(otherUrl,'\\n|\\r','')) as otherUrl,
trim(regexp_replace(otherId,'\\n|\\r','')) as otherId,
trim(regexp_replace(otherType,'\\n|\\r','')) as otherType,
trim(regexp_replace(otherTitle,'\\n|\\r','')) as otherTitle,
trim(regexp_replace(aggPoint,'\\n|\\r','')) as aggPoint,
trim(regexp_replace(surplusPoint,'\\n|\\r','')) as surplusPoint,
trim(regexp_replace(onePoint,'\\n|\\r','')) as onePoint,
trim(regexp_replace(aggSurveyPoint,'\\n|\\r','')) as aggSurveyPoint,
trim(regexp_replace(surplusSurveyPoint,'\\n|\\r','')) as surplusSurveyPoint,
trim(regexp_replace(oneSurveyPoint,'\\n|\\r','')) as oneSurveyPoint,
trim(regexp_replace(coverStyle,'\\n|\\r','')) as coverStyle,
trim(regexp_replace(sortTime,'\\n|\\r','')) as sortTime,
trim(regexp_replace(oldNewFlag,'\\n|\\r','')) as oldNewFlag,
trim(regexp_replace(title,'\\n|\\r','')) as title
from mongo2hive.module_t_ad_ready_material;




--插入:mongo2hive.module_t_ad_material_point到pro.ods_t_ad_material_point
insert overwrite table pro.ods_t_ad_material_point PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(businessType,'\\n|\\r','')) as businessType,
trim(regexp_replace(businessId,'\\n|\\r','')) as businessId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(surveyId,'\\n|\\r','')) as surveyId,
trim(regexp_replace(changePoint,'\\n|\\r','')) as changePoint,
trim(regexp_replace(materialId,'\\n|\\r','')) as materialId,
trim(regexp_replace(answerId,'\\n|\\r','')) as answerId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(transactionId,'\\n|\\r','')) as transactionId,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_ad_material_point;




--插入：mongo2hive.health_t_meeting_h5_watched_log到pro.ods_t_meeting_h5_watched_log
insert overwrite table pro.ods_t_meeting_h5_watched_log PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(class,'\\n|\\r','')) as class,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(chunkID,'\\n|\\r','')) as chunkID,
trim(regexp_replace(recordId,'\\n|\\r','')) as recordId,
trim(regexp_replace(watchedLength,'\\n|\\r','')) as watchedLength,
trim(regexp_replace(count1,'\\n|\\r','')) as count1,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(wxName,'\\n|\\r','')) as wxName
from mongo2hive.health_t_meeting_h5_watched_log;


--插入：mongo2hive.health_c_doctor_follow到pro.ods_c_doctor_follow
insert overwrite table pro.ods_c_doctor_follow PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.health_c_doctor_follow;


--插入:mongo2hive.auth2_t_auth_account到pro.ods_t_auth_account
insert overwrite table pro.ods_t_auth_account PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(accountId,'\\n|\\r','')) as accountId,
trim(regexp_replace(accountNum,'\\n|\\r','')) as accountNum,
trim(regexp_replace(accountType,'\\n|\\r','')) as accountType,
trim(regexp_replace(password,'\\n|\\r','')) as password,
trim(regexp_replace(userType,'\\n|\\r','')) as userType,
trim(regexp_replace(deleteFlag,'\\n|\\r','')) as deleteFlag,
trim(regexp_replace(deviceType,'\\n|\\r','')) as deviceType,
trim(regexp_replace(deviceId,'\\n|\\r','')) as deviceId,
trim(regexp_replace(deleteTime,'\\n|\\r','')) as deleteTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.auth2_t_auth_account;


--插入：mongo2hive.basepost_post_info到pro.ods_post_info
insert overwrite table pro.ods_post_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(authorId,'\\n|\\r','')) as authorId,
trim(regexp_replace(authorName,'\\n|\\r','')) as authorName,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(updateUser,'\\n|\\r','')) as updateUser,
trim(regexp_replace(statusFlag,'\\n|\\r','')) as statusFlag,
cards,
trim(regexp_replace(content,'\\n|\\r','')) as content
from mongo2hive.basepost_post_info;



--插入:mongo2hive.module_t_faq_question_activity到pro.ods_t_faq_question_activity
insert overwrite table pro.ods_t_faq_question_activity PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(questionId,'\\n|\\r','')) as questionId,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(activityName,'\\n|\\r','')) as activityName,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(`limit`,'\\n|\\r','')) as `limit`,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(rewardWay,'\\n|\\r','')) as rewardWay,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime
from mongo2hive.module_t_faq_question_activity;



--插入：mongo2hive.health_t_pushflow_record到pro.ods_t_pushflow_record
insert overwrite table pro.ods_t_pushflow_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(callbackType,'\\n|\\r','')) as callbackType,
trim(regexp_replace(callbackData,'\\n|\\r','')) as callbackData,
trim(regexp_replace(callbackTime,'\\n|\\r','')) as callbackTime,
trim(regexp_replace(pushflowPublishUrl,'\\n|\\r','')) as pushflowPublishUrl,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(streamKey,'\\n|\\r','')) as streamKey
from mongo2hive.health_t_pushflow_record;



--插入:mongo2hive.activity_t_activity_business到pro.ods_t_activity_business
insert overwrite table pro.ods_t_activity_business PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(redActivityId,'\\n|\\r','')) as redActivityId,
trim(regexp_replace(`limit`,'\\n|\\r','')) as `limit`,
trim(regexp_replace(signed,'\\n|\\r','')) as signed,
trim(regexp_replace(received,'\\n|\\r','')) as received
from mongo2hive.activity_t_activity_business;




--插入：mongo2hive.basepost_praise_info到pro.ods_praise_info
insert overwrite table pro.ods_praise_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(praiseUser,'\\n|\\r','')) as praiseUser,
trim(regexp_replace(statusFlag,'\\n|\\r','')) as statusFlag,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId
from mongo2hive.basepost_praise_info;



--插入：mongo2hive.health_t_no_check_reason到pro.ods_t_no_check_reason
insert overwrite table pro.ods_t_no_check_reason PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(reasons,'\\n|\\r','')) as reasons,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(modifyTime,'\\n|\\r','')) as modifyTime
from mongo2hive.health_t_no_check_reason;



--插入：mongo2hive.chat_t_chat_online到pro.ods_t_chat_online
insert overwrite table pro.ods_t_chat_online PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(bizType,'\\n|\\r','')) as bizType,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userPic,'\\n|\\r','')) as userPic,
trim(regexp_replace(onlineTime,'\\n|\\r','')) as onlineTime,
trim(regexp_replace(offlineTime,'\\n|\\r','')) as offlineTime
from mongo2hive.chat_t_chat_online;



--插入：mongo2hive.chat_t_chat_message到pro.ods_t_chat_message
insert overwrite table pro.ods_t_chat_message PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(bizType,'\\n|\\r','')) as bizType,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(content_msgType,'\\n|\\r','')) as content_msgType,
trim(regexp_replace(content_text,'\\n|\\r','')) as content_text,
trim(regexp_replace(content_params,'\\n|\\r','')) as content_params,
trim(regexp_replace(sendUserId,'\\n|\\r','')) as sendUserId,
trim(regexp_replace(sendTime,'\\n|\\r','')) as sendTime,
trim(regexp_replace(clientMsgId,'\\n|\\r','')) as clientMsgId,
trim(regexp_replace(clientAppId,'\\n|\\r','')) as clientAppId
from mongo2hive.chat_t_chat_message;




--插入：mongo2hive.health_ScoreSheetPO到pro.ods_ScoreSheetPO
insert overwrite table pro.ods_ScoreSheetPO PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(appName,'\\n|\\r','')) as appName,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(version,'\\n|\\r','')) as version,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(`desc`,'\\n|\\r','')) as `desc`,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(questions_seq,'\\n|\\r','')) as questions_seq,
trim(regexp_replace(questions_name,'\\n|\\r','')) as questions_name,
trim(regexp_replace(questions_score,'\\n|\\r','')) as questions_score,
trim(regexp_replace(questions_options,'\\n|\\r','')) as questions_options,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(range,'\\n|\\r','')) as range
from mongo2hive.health_ScoreSheetPO;


--插入:mongo2hive.module_t_faq_no_share_pop到pro.ods_t_faq_no_share_pop
insert overwrite table pro.ods_t_faq_no_share_pop PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(dataType,'\\n|\\r','')) as dataType,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_faq_no_share_pop;


--插入：mongo2hive.circleetl_circle_operation_info到pro.ods_circle_operation_info
insert overwrite table pro.ods_circle_operation_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(scene,'\\n|\\r','')) as scene,
trim(regexp_replace(vid,'\\n|\\r','')) as vid,
trim(regexp_replace(step,'\\n|\\r','')) as step,
trim(regexp_replace(adddress,'\\n|\\r','')) as adddress,
trim(regexp_replace(browerMessage,'\\n|\\r','')) as browerMessage,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(phoneNumber,'\\n|\\r','')) as phoneNumber
from mongo2hive.circleetl_circle_operation_info;