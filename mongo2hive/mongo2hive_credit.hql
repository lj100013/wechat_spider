--插入:mongo2hive.module_t_credit_dept_integral到pro.ods_t_credit_dept_integral
insert overwrite table pro.ods_t_credit_dept_integral PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(balance,'\\n|\\r','')) as balance,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.module_t_credit_dept_integral;



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