set hive.exec.parallel.thread.number=5;
set mapreduce.map.memory.mb=4096; 
set mapreduce.map.java.opts=-Xmx3600m;
set mapreduce.reduce.memory.mb=4096; 
set mapreduce.reduce.java.opts=-Xmx3600m;



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
answers
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
trim(regexp_replace(wxName,'\\n|\\r','')) as wxName,
trim(regexp_replace(userId,'\\n|\\r','')) as userId
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
trim(regexp_replace(phoneNumber,'\\n|\\r','')) as phoneNumber,
trim(regexp_replace(data,'\\n|\\r','')) as data
from mongo2hive.circleetl_circle_operation_info;


--插入：mongo2hive.health_t_meeting_share_record到pro.ods_t_meeting_share_record
insert overwrite table pro.ods_t_meeting_share_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(shareType,'\\n|\\r','')) as shareType,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(wxId,'\\n|\\r','')) as wxId,
trim(regexp_replace(wxName,'\\n|\\r','')) as wxName,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.health_t_meeting_share_record;



--插入：mongo2hive.health_t_meeting_pushflow到pro.ods_t_meeting_pushflow
insert overwrite table pro.ods_t_meeting_pushflow PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(rtmpPublishUrl,'\\n|\\r','')) as rtmpPublishUrl,
trim(regexp_replace(rtmpPlayUrl,'\\n|\\r','')) as rtmpPlayUrl,
trim(regexp_replace(hlsPlayUrl,'\\n|\\r','')) as hlsPlayUrl,
trim(regexp_replace(rtmpPlayUrl720,'\\n|\\r','')) as rtmpPlayUrl720,
trim(regexp_replace(hlsPlayUrl720,'\\n|\\r','')) as hlsPlayUrl720,
trim(regexp_replace(rtmpPlayUrl480,'\\n|\\r','')) as rtmpPlayUrl480,
trim(regexp_replace(hlsPlayUrl480,'\\n|\\r','')) as hlsPlayUrl480,
trim(regexp_replace(snapshotImg,'\\n|\\r','')) as snapshotImg,
trim(regexp_replace(testRtmpPublishUrl,'\\n|\\r','')) as testRtmpPublishUrl,
trim(regexp_replace(testRtmpPlayUrl,'\\n|\\r','')) as testRtmpPlayUrl,
trim(regexp_replace(testHlsPlayUrl,'\\n|\\r','')) as testHlsPlayUrl,
trim(regexp_replace(transCode,'\\n|\\r','')) as transCode,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(expireTime,'\\n|\\r','')) as expireTime
from mongo2hive.health_t_meeting_pushflow;




--插入：mongo2hive.health_t_meeting_pushflow_record到pro.ods_t_meeting_pushflow_record
insert overwrite table pro.ods_t_meeting_pushflow_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(pushflow,'\\n|\\r','')) as pushflow,
trim(regexp_replace(deviceType,'\\n|\\r','')) as deviceType,
trim(regexp_replace(appName,'\\n|\\r','')) as appName,
trim(regexp_replace(appVersion,'\\n|\\r','')) as appVersion,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.health_t_meeting_pushflow_record;




--插入：mongo2hive.module_t_faq_user_view_record到pro.ods_t_faq_user_view_record
insert overwrite table pro.ods_t_faq_user_view_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(dataType,'\\n|\\r','')) as dataType,
trim(regexp_replace(dataId,'\\n|\\r','')) as dataId,
trim(regexp_replace(viewType,'\\n|\\r','')) as viewType,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.module_t_faq_user_view_record;



--插入：mongo2hive.health_t_meeting_wxuser到pro.ods_t_meeting_wxuser
insert overwrite table pro.ods_t_meeting_wxuser PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(wxId,'\\n|\\r','')) as wxId,
trim(regexp_replace(wxName,'\\n|\\r','')) as wxName,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.health_t_meeting_wxuser;



--插入：mongo2hive.circledaq_circle_heat_value_type_day到pro.ods_circle_heat_value_type_day
insert overwrite table pro.ods_circle_heat_value_type_day PARTITION(dt='${hivevar:preday}')   
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(`year`,'\\n|\\r','')) as `year`,
trim(regexp_replace(`month`,'\\n|\\r','')) as `month`,
trim(regexp_replace(typeValue,'\\n|\\r','')) as typeValue,
trim(regexp_replace(grossScore,'\\n|\\r','')) as grossScore,
trim(regexp_replace(`date`,'\\n|\\r','')) as `date`,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.circledaq_circle_heat_value_type_day;



--插入:mongo2hive.modulet_credit_company_integral到pro.ods_t_credit_company_integral
insert overwrite table pro.ods_t_credit_company_integral PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(balance,'\\n|\\r','')) as balance,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.modulet_credit_company_integral;


--插入:mongo2hive.dominos_dominos_record到pro.ods_dominos_record
insert overwrite table pro.ods_dominos_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(dominosId,'\\n|\\r','')) as dominosId,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(joinUserId,'\\n|\\r','')) as joinUserId,
trim(regexp_replace(joinNo,'\\n|\\r','')) as joinNo,
trim(regexp_replace(joinTime,'\\n|\\r','')) as joinTime,
trim(regexp_replace(deliveryUserId,'\\n|\\r','')) as deliveryUserId,
trim(regexp_replace(awardType,'\\n|\\r','')) as awardType,
trim(regexp_replace(awardNumber,'\\n|\\r','')) as awardNumber,
trim(regexp_replace(cashingTime,'\\n|\\r','')) as cashingTime
from mongo2hive.dominos_dominos_record;



--插入:mongo2hive.dominos_dominos_info到pro.ods_dominos_info
insert overwrite table pro.ods_dominos_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(deliveryContent,'\\n|\\r','')) as deliveryContent,
trim(regexp_replace(goalJoinNumber,'\\n|\\r','')) as goalJoinNumber,
trim(regexp_replace(joinNubmer,'\\n|\\r','')) as joinNubmer,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.dominos_dominos_info;




--插入:mongo2hive.exhibitionmarketing_t_promotion到pro.ods_t_promotion_exhibition
insert overwrite table pro.ods_t_promotion_exhibition PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(rewardsType,'\\n|\\r','')) as rewardsType,
trim(regexp_replace(promotionItemList,'\\n|\\r','')) as promotionItemList,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(promotionEnterpriseLogo,'\\n|\\r','')) as promotionEnterpriseLogo,
trim(regexp_replace(activityRule,'\\n|\\r','')) as activityRule,
trim(regexp_replace(longitude,'\\n|\\r','')) as longitude,
trim(regexp_replace(latitude,'\\n|\\r','')) as latitude,
trim(regexp_replace(locationSwitch,'\\n|\\r','')) as locationSwitch,
trim(regexp_replace(concatAddress,'\\n|\\r','')) as concatAddress,
trim(regexp_replace(effectiveRange,'\\n|\\r','')) as effectiveRange,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.exhibitionmarketing_t_promotion;




--插入:mongo2hive.exhibitionmarketing_t_redPaper_record到pro.ods_t_redPaper_record_exhibition
insert overwrite table pro.ods_t_redPaper_record_exhibition PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(promotionId,'\\n|\\r','')) as promotionId,
trim(regexp_replace(redPaperId,'\\n|\\r','')) as redPaperId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(dept,'\\n|\\r','')) as dept,
trim(regexp_replace(telephone,'\\n|\\r','')) as telephone,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(haveDone,'\\n|\\r','')) as haveDone,
trim(regexp_replace(exportType,'\\n|\\r','')) as exportType,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.exhibitionmarketing_t_redPaper_record;



--插入:mongo2hive.congress_t_congress_info到pro.ods_t_congress_info
insert overwrite table pro.ods_t_congress_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(url,'\\n|\\r','')) as url,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(labelList,'\\n|\\r','')) as labelList,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(location,'\\n|\\r','')) as location,
trim(regexp_replace(associationType,'\\n|\\r','')) as associationType,
trim(regexp_replace(associationId,'\\n|\\r','')) as associationId,
trim(regexp_replace(associationName,'\\n|\\r','')) as associationName,
trim(regexp_replace(associationLink,'\\n|\\r','')) as associationLink,
trim(regexp_replace(adBannerList,'\\n|\\r','')) as adBannerList,
trim(regexp_replace(flickerAdvertisement,'\\n|\\r','')) as flickerAdvertisement,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(columnList,'\\n|\\r','')) as columnList,
trim(regexp_replace(link,'\\n|\\r','')) as link,
trim(regexp_replace(format,'\\n|\\r','')) as format,
trim(regexp_replace(formatUrl,'\\n|\\r','')) as formatUrl,
trim(regexp_replace(branchCongressList,'\\n|\\r','')) as branchCongressList,
trim(regexp_replace(recordedBroadcastList,'\\n|\\r','')) as recordedBroadcastList,
trim(regexp_replace(agendaList,'\\n|\\r','')) as agendaList,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(state,'\\n|\\r','')) as state,
trim(regexp_replace(equivalenceType,'\\n|\\r','')) as equivalenceType,
trim(regexp_replace(qrcode,'\\n|\\r','')) as qrcode
from mongo2hive.congress_t_congress_info;



--插入:mongo2hive.congress_t_credit_record到pro.ods_t_credit_record_congress
insert overwrite table pro.ods_t_credit_record_congress PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(companyName,'\\n|\\r','')) as companyName,
trim(regexp_replace(congressId,'\\n|\\r','')) as congressId,
trim(regexp_replace(congressName,'\\n|\\r','')) as congressName,
trim(regexp_replace(adId,'\\n|\\r','')) as adId,
trim(regexp_replace(adType,'\\n|\\r','')) as adType,
trim(regexp_replace(adName,'\\n|\\r','')) as adName,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(freezeState,'\\n|\\r','')) as freezeState,
trim(regexp_replace(freezeDesc,'\\n|\\r','')) as freezeDesc,
trim(regexp_replace(freezeId,'\\n|\\r','')) as freezeId,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mongo2hive.congress_t_credit_record;




--插入:mongo2hive.activity_t_red_packet到pro.ods_t_red_packet
insert overwrite table pro.ods_t_red_packet PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userName,'\\n|\\r','')) as userName,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(haveDone,'\\n|\\r','')) as haveDone,
trim(regexp_replace(redEnvelopeId,'\\n|\\r','')) as redEnvelopeId
from mongo2hive.activity_t_red_packet;


--插入:mongo2hive.h5marketing_t_promotion到pro.ods_t_promotion_h5marketing
insert overwrite table pro.ods_t_promotion_h5marketing PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(rewardsType,'\\n|\\r','')) as rewardsType,
trim(regexp_replace(promotionItemList,'\\n|\\r','')) as promotionItemList,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(popupWindowFlag,'\\n|\\r','')) as popupWindowFlag,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.h5marketing_t_promotion;




--插入:mongo2hive.h5marketing_t_redPaper_record到pro.ods_t_redPaper_record_h5marketing
insert overwrite table pro.ods_t_redPaper_record_h5marketing PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(promotionId,'\\n|\\r','')) as promotionId,
trim(regexp_replace(redPaperId,'\\n|\\r','')) as redPaperId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(haveDone,'\\n|\\r','')) as haveDone,
trim(regexp_replace(exportType,'\\n|\\r','')) as exportType,
trim(regexp_replace(shareImgUrl,'\\n|\\r','')) as shareImgUrl,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.h5marketing_t_redPaper_record;




--插入：mongo2hive.module_t_business_ad到pro.ods_t_business_ad
insert overwrite table pro.ods_t_business_ad PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(adTitle,'\\n|\\r','')) as bizType,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(companyName,'\\n|\\r','')) as companyName,
trim(regexp_replace(adType,'\\n|\\r','')) as adType,
trim(regexp_replace(businessInfo_businessType,'\\n|\\r','')) as businessInfo_businessType,
trim(regexp_replace(businessInfo_courseId,'\\n|\\r','')) as businessInfo_courseId,
trim(regexp_replace(businessInfo_minutes,'\\n|\\r','')) as businessInfo_minutes,
trim(regexp_replace(businessInfo_bannerImg,'\\n|\\r','')) as businessInfo_bannerImg,
trim(regexp_replace(businessInfo_classId,'\\n|\\r','')) as businessInfo_classId,
trim(regexp_replace(businessInfo_classTitle,'\\n|\\r','')) as businessInfo_classTitle,
trim(regexp_replace(businessInfo_courseName,'\\n|\\r','')) as businessInfo_courseName,
trim(regexp_replace(businessInfo_lessonId,'\\n|\\r','')) as businessInfo_lessonId,
trim(regexp_replace(businessInfo_lessonName,'\\n|\\r','')) as businessInfo_lessonName,
trim(regexp_replace(businessInfo_materialTime,'\\n|\\r','')) as businessInfo_materialTime,
trim(regexp_replace(businessInfo_meetingId,'\\n|\\r','')) as businessInfo_meetingId,
trim(regexp_replace(businessInfo_meetingName,'\\n|\\r','')) as businessInfo_meetingName,
trim(regexp_replace(surveyType,'\\n|\\r','')) as surveyType,
trim(regexp_replace(surveyOnePoint,'\\n|\\r','')) as surveyOnePoint,
trim(regexp_replace(surveyTotalPoint,'\\n|\\r','')) as surveyTotalPoint,
trim(regexp_replace(surveyLeftPoint,'\\n|\\r','')) as surveyLeftPoint,
trim(regexp_replace(surveyEndTime,'\\n|\\r','')) as surveyEndTime,
trim(regexp_replace(range_rangeType,'\\n|\\r','')) as range_rangeType,
trim(regexp_replace(range_userCheck,'\\n|\\r','')) as range_userCheck,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(surveys,'\\n|\\r','')) as surveys,
trim(regexp_replace(freezeId,'\\n|\\r','')) as freezeId,
trim(regexp_replace(transactionIds,'\\n|\\r','')) as transactionIds
from mongo2hive.module_t_business_ad;



--插入：mongo2hive.module_t_business_ad_survey_record到pro.ods_t_business_ad_survey_record
insert overwrite table pro.ods_t_business_ad_survey_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(adId,'\\n|\\r','')) as adId,
trim(regexp_replace(answers,'\\n|\\r','')) as answers,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_business_ad_survey_record;




--插入：mongo2hive.health_t_survey到pro.ods_t_survey
insert overwrite table pro.ods_t_survey PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(appName,'\\n|\\r','')) as appName,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(des,'\\n|\\r','')) as des,
trim(regexp_replace(groupId,'\\n|\\r','')) as groupId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(createUserType,'\\n|\\r','')) as createUserType,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(updateUserId,'\\n|\\r','')) as updateUserId,
trim(regexp_replace(updateUserType,'\\n|\\r','')) as updateUserType,
trim(regexp_replace(deleteTime,'\\n|\\r','')) as deleteTime,
trim(regexp_replace(deleteUserId,'\\n|\\r','')) as deleteUserId,
trim(regexp_replace(deleteUserType,'\\n|\\r','')) as deleteUserType,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(versions,'\\n|\\r','')) as versions,
trim(regexp_replace(range,'\\n|\\r','')) as range,
questionList
from mongo2hive.health_t_survey;




--插入:mongo2hive.module_t_credit_company到pro.ods_t_credit_company
insert overwrite table pro.ods_t_credit_company PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(companyName,'\\n|\\r','')) as companyName,
trim(regexp_replace(manager,'\\n|\\r','')) as manager,
trim(regexp_replace(managerTel,'\\n|\\r','')) as managerTel,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_credit_company;



--插入:mongo2hive.esy_equipment_manage_t_location_info到pro.ods_t_location_info
insert overwrite table pro.ods_t_location_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(longitude,'\\n|\\r','')) as longitude,
trim(regexp_replace(latitude,'\\n|\\r','')) as latitude,
trim(regexp_replace(location,'\\n|\\r','')) as location,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(eqId,'\\n|\\r','')) as eqId,
trim(regexp_replace(eqNo,'\\n|\\r','')) as eqNo
from mongo2hive.esy_equipment_manage_t_location_info;



--插入:mongo2hive.activity_t_doctor_share到pro.ods_t_doctor_share
insert overwrite table pro.ods_t_doctor_share PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(shareCode,'\\n|\\r','')) as shareCode,
trim(regexp_replace(shareType,'\\n|\\r','')) as shareType,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(assistantId,'\\n|\\r','')) as assistantId,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(shareContent,'\\n|\\r','')) as shareContent,
trim(regexp_replace(shareTime,'\\n|\\r','')) as shareTime
from mongo2hive.activity_t_doctor_share;

with t as (select * from pro.ods_t_promotion where dt='${hivevar:preday}')
insert overwrite table dim.dim_promotion_survey
select 
id,
title,
status,
get_json_object(promotion, '$.surveyId')
from t lateral view outer explode(promotionitemlist) p as promotion where get_json_object(promotion, '$.surveyId') is not null;

insert OVERWRITE table pro.ods_t_business_ad_survey
select 
id,
userid,
businessadid,
point,
updatetime,
surveytype,
name,
surveyid,
createtime from mongo2hive.module_t_business_ad_survey;




--插入：mongo2hive.health_t_meeting_upload_record到pro.ods_t_meeting_upload_record
insert overwrite table pro.ods_t_meeting_upload_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(recordId,'\\n|\\r','')) as recordId,
trim(regexp_replace(recordUrl,'\\n|\\r','')) as recordUrl,
trim(regexp_replace(createFrom,'\\n|\\r','')) as createFrom,
trim(regexp_replace(recordDuration,'\\n|\\r','')) as recordDuration,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(channelId,'\\n|\\r','')) as channelId,
trim(regexp_replace(recordTime,'\\n|\\r','')) as recordTime,
trim(regexp_replace(recordEndTime,'\\n|\\r','')) as recordEndTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(persistentId,'\\n|\\r','')) as persistentId,
trim(regexp_replace(persistentStu,'\\n|\\r','')) as persistentStu
from mongo2hive.health_t_meeting_upload_record;




--插入:mongo2hive.esy_equipment_manage_t_equipment_info到pro.ods_t_equipment_info
insert overwrite table pro.ods_t_equipment_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(eqNo,'\\n|\\r','')) as eqNo,
trim(regexp_replace(eqCoded,'\\n|\\r','')) as eqCoded,
trim(regexp_replace(eqName,'\\n|\\r','')) as eqName,
trim(regexp_replace(eqRomId,'\\n|\\r','')) as eqRomId,
trim(regexp_replace(eqRomType,'\\n|\\r','')) as eqRomType,
trim(regexp_replace(eqRomVersion,'\\n|\\r','')) as eqRomVersion,
trim(regexp_replace(eqSpecId,'\\n|\\r','')) as eqSpecId,
trim(regexp_replace(eqSpecification,'\\n|\\r','')) as eqSpecification,
trim(regexp_replace(eqMacAddress,'\\n|\\r','')) as eqMacAddress,
trim(regexp_replace(flowCardNo,'\\n|\\r','')) as flowCardNo,
trim(regexp_replace(eqPassword,'\\n|\\r','')) as eqPassword,
trim(regexp_replace(eqStatus,'\\n|\\r','')) as eqStatus,
trim(regexp_replace(registerType,'\\n|\\r','')) as registerType,
trim(regexp_replace(registerTime,'\\n|\\r','')) as registerTime,
trim(regexp_replace(stockStatus,'\\n|\\r','')) as stockStatus,
trim(regexp_replace(logisticsStatus,'\\n|\\r','')) as logisticsStatus,
trim(regexp_replace(esyAccountId,'\\n|\\r','')) as esyAccountId,
trim(regexp_replace(esyAccountNo,'\\n|\\r','')) as esyAccountNo,
trim(regexp_replace(eqSize,'\\n|\\r','')) as eqSize,
trim(regexp_replace(eqType,'\\n|\\r','')) as eqType,
trim(regexp_replace(motherboardType,'\\n|\\r','')) as motherboardType,
trim(regexp_replace(sourceType,'\\n|\\r','')) as sourceType,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.esy_equipment_manage_t_equipment_info;




--插入：mongo2hive.health_t_meeting_apply_compere到pro.ods_t_meeting_apply_compere
insert overwrite table pro.ods_t_meeting_apply_compere PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(meetingId,'\\n|\\r','')) as meetingId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(applyStatus,'\\n|\\r','')) as applyStatus,
trim(regexp_replace(verifyUserId,'\\n|\\r','')) as verifyUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(verifyTime,'\\n|\\r','')) as verifyTime
from mongo2hive.health_t_meeting_apply_compere;