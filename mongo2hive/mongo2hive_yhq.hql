
--医患圈pro.ods源表

--T1
--ods建表：pro.ods_yhq_t_disease_label_auth_record
--插入：mongo2hive.member_manage_t_disease_label_auth_record到pro.ods_yhq_t_disease_label_auth_record
insert overwrite table pro.ods_yhq_t_disease_label_auth_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(patientId,'\\n|\\r','')) as patientId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(auditTime,'\\n|\\r','')) as auditTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(auditor,'\\n|\\r','')) as auditor,
trim(regexp_replace(auditorId,'\\n|\\r','')) as auditorId,
trim(regexp_replace(auditorType,'\\n|\\r','')) as auditorType,
trim(regexp_replace(caseId,'\\n|\\r','')) as caseId,
trim(regexp_replace(caseName,'\\n|\\r','')) as caseName,
trim(regexp_replace(illnessDesc,'\\n|\\r','')) as illnessDesc,
trim(regexp_replace(caseCreateTime,'\\n|\\r','')) as caseCreateTime,
trim(regexp_replace(auditAdvise,'\\n|\\r','')) as auditAdvise,
trim(regexp_replace(remark,'\\n|\\r','')) as remark,
trim(regexp_replace(labels,'\\n|\\r','')) as labels,
trim(regexp_replace(sourceType,'\\n|\\r','')) as sourceType,
trim(regexp_replace(sourceId,'\\n|\\r','')) as sourceId,
trim(regexp_replace(sourceDesc,'\\n|\\r','')) as sourceDesc,
trim(regexp_replace(firstRecord,'\\n|\\r','')) as firstRecord,
trim(regexp_replace(rewardStatus,'\\n|\\r','')) as rewardStatus
from mongo2hive.member_manage_t_disease_label_auth_record;



--T2
--ods建表：pro.ods_yhq_t_join_record
--插入：mongo2hive.doctor_union_t_join_record到pro.ods_yhq_t_join_record
insert overwrite table pro.ods_yhq_t_join_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(`from`,'\\n|\\r','')) as `from`,
trim(regexp_replace(message,'\\n|\\r','')) as message,
trim(regexp_replace(invOrApply,'\\n|\\r','')) as invOrApply,
trim(regexp_replace(invitationer,'\\n|\\r','')) as invitationer,
trim(regexp_replace(applyDate,'\\n|\\r','')) as applyDate,
trim(regexp_replace(examineStatus,'\\n|\\r','')) as examineStatus,
trim(regexp_replace(examineDate,'\\n|\\r','')) as examineDate,
trim(regexp_replace(auditor,'\\n|\\r','')) as auditor,
trim(regexp_replace(refuseMessage,'\\n|\\r','')) as refuseMessage
from mongo2hive.doctor_union_t_join_record;


--T3
--ods建表：pro.ods_yhq_m_medicalrecord_process
--插入：mongo2hive.medicalrecord_m_medicalrecord_process到pro.ods_yhq_m_medicalrecord_process
insert overwrite table pro.ods_yhq_m_medicalrecord_process PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(mid,'\\n|\\r','')) as mid,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(secrecyFlag,'\\n|\\r','')) as secrecyFlag,
trim(regexp_replace(content,'\\n|\\r','')) as content,
trim(regexp_replace(creatorType,'\\n|\\r','')) as createrType,
trim(regexp_replace(creator,'\\n|\\r','')) as creater,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updater,'\\n|\\r','')) as updater,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.medicalrecord_m_medicalrecord_process;



--T4
--ods建表：pro.ods_yhq_t_union_info
--插入：mongo2hive.doctor_union_t_union_info到pro.ods_yhq_t_union_info
insert overwrite table pro.ods_yhq_t_union_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(logoUrl,'\\n|\\r','')) as logoUrl,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(examineStatus,'\\n|\\r','')) as examineStatus,
trim(regexp_replace(founder,'\\n|\\r','')) as founder,
trim(regexp_replace(isAcceptApply,'\\n|\\r',''))  as isAcceptApply,
trim(regexp_replace(allowInvitation,'\\n|\\r','')) as allowInvitation,
trim(regexp_replace(onlyMemberApply,'\\n|\\r','')) as onlyMemberApply,
trim(regexp_replace(openApply,'\\n|\\r','')) as openApply,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(memberCount,'\\n|\\r','')) as memberCount,
trim(regexp_replace(expertCount,'\\n|\\r','')) as expertCount,
trim(regexp_replace(recommendCount,'\\n|\\r','')) as recommendCount,
trim(regexp_replace(masterDoctorId,'\\n|\\r',''))  as masterDoctorId,
trim(regexp_replace(deleted,'\\n|\\r','')) as deleted,
trim(regexp_replace(openMember,'\\n|\\r','')) as openMember,
trim(regexp_replace(memberFree,'\\n|\\r','')) as memberFree,
trim(regexp_replace(founderName,'\\n|\\r','')) as founderName,
trim(regexp_replace(notice,'\\n|\\r','')) as notice,
trim(regexp_replace(columnId,'\\n|\\r','')) as columnId,
trim(regexp_replace(columnName,'\\n|\\r','')) as columnName,
trim(regexp_replace(upCount,'\\n|\\r','')) as upCount,
trim(regexp_replace(unionCover,'\\n|\\r','')) as unionCover
from mongo2hive.doctor_union_t_union_info;


--T5
--ods建表：pro.ods_yhq_t_care_plan_record
--插入：mongo2hive.careplan_t_care_plan_record到pro.ods_yhq_t_care_plan_record
insert overwrite table pro.ods_yhq_t_care_plan_record PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(carePlanId,'\\n|\\r','')) as carePlanId,
trim(regexp_replace(carePlanName,'\\n|\\r','')) as carePlanName,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(patientId,'\\n|\\r','')) as patientId,
cast(size(orderIds) as string) as orderNum,
orderIds as orderIds,
orderid as orderid
from mongo2hive.careplan_t_care_plan_record 
LATERAL VIEW explode(orderids) table_tmp AS orderId;





--T9
--ods建表：pro.ods_yhq_t_post_info
--插入：mongo2hive.dap_basepost_t_post_info到pro.ods_yhq_t_post_info
insert overwrite table pro.ods_yhq_t_post_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(source,'\\n|\\r','')) as source,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(charge,'\\n|\\r','')) as charge,
trim(regexp_replace(isVipFree,'\\n|\\r','')) as isVipFree,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(platformId,'\\n|\\r','')) as platformId,
trim(regexp_replace(platformName,'\\n|\\r','')) as platformName,
trim(regexp_replace(platformPic,'\\n|\\r','')) as platformPic,
trim(regexp_replace(platform,'\\n|\\r','')) as platform,
trim(regexp_replace(platformType,'\\n|\\r','')) as platformType,
trim(regexp_replace(columnId,'\\n|\\r','')) as columnId,
trim(regexp_replace(columnName,'\\n|\\r','')) as columnName,
trim(regexp_replace(topicNames,'\\n|\\r','')) as topicNames,
trim(regexp_replace(content,'\\n|\\r','')) as content,
trim(regexp_replace(contentType,'\\n|\\r','')) as contentType,
trim(regexp_replace(statistics,'\\n|\\r','')) as statistics,
trim(regexp_replace(attachments,'\\n|\\r','')) as attachments,
trim(regexp_replace(createId,'\\n|\\r','')) as createId,
trim(regexp_replace(tag,'\\n|\\r','')) as tag,
trim(regexp_replace(top,'\\n|\\r','')) as top,
trim(regexp_replace(topTime,'\\n|\\r','')) as topTime,
trim(regexp_replace(authorId,'\\n|\\r','')) as authorId,
trim(regexp_replace(author,'\\n|\\r','')) as author,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.dap_basepost_t_post_info;



--T11
--ods建表：pro.ods_yhq_t_comment_info
--插入：mongo2hive.dap_basepost_t_comment_info到pro.ods_yhq_t_comment_info
insert overwrite table pro.ods_yhq_t_comment_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(postId,'\\n|\\r','')) as postId,
trim(regexp_replace(text,'\\n|\\r','')) as text,
trim(regexp_replace(pics,'\\n|\\r','')) as pics,
trim(regexp_replace(statistics,'\\n|\\r','')) as statistics,
trim(regexp_replace(replyList,'\\n|\\r','')) as replyList,
trim(regexp_replace(thumbUpList,'\\n|\\r','')) as thumbUpList,
trim(regexp_replace(enable,'\\n|\\r','')) as enable,
trim(regexp_replace(userType,'\\n|\\r','')) as userType,
trim(regexp_replace(authorId,'\\n|\\r','')) as authorId,
trim(regexp_replace(author,'\\n|\\r','')) as author,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.dap_basepost_t_comment_info;


--T12
--ods建表：pro.ods_yhq_t_thumb_up_info
--插入：mongo2hive.dap_basepost_t_thumb_up_info到pro.ods_yhq_t_thumb_up_info
insert overwrite table pro.ods_yhq_t_thumb_up_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(modifyTime,'\\n|\\r','')) as modifyTime
from mongo2hive.dap_basepost_t_thumb_up_info;


--T13
--ods建表：pro.ods_yhq_t_collection
--插入：mongo2hive.collection_t_collection到pro.ods_yhq_t_collection
insert overwrite table pro.ods_yhq_t_collection PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userType,'\\n|\\r','')) as userType,
trim(regexp_replace(source,'\\n|\\r','')) as source,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId,
trim(regexp_replace(targetCreatorId,'\\n|\\r','')) as targetCreatorId,
trim(regexp_replace(targetCreatorName,'\\n|\\r','')) as targetCreatorName,
trim(regexp_replace(targetCreatorType,'\\n|\\r','')) as targetCreatorType,
trim(regexp_replace(targetCreateTime,'\\n|\\r','')) as targetCreateTime,
trim(regexp_replace(cardType,'\\n|\\r','')) as cardType,
trim(regexp_replace(card,'\\n|\\r','')) as card,
trim(regexp_replace(topics,'\\n|\\r','')) as topics,
trim(regexp_replace(labels,'\\n|\\r','')) as labels,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.collection_t_collection;


--T14
--ods建表：pro.ods_yhq_t_reward_info
--插入：mongo2hive.dap_basepost_t_reward_info到pro.ods_yhq_t_reward_info
insert overwrite table pro.ods_yhq_t_reward_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(note,'\\n|\\r','')) as note,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(fromUserId,'\\n|\\r','')) as fromUserId,
trim(regexp_replace(fromUserType,'\\n|\\r','')) as fromUserType,
trim(regexp_replace(toUserId,'\\n|\\r','')) as toUserId,
trim(regexp_replace(toUserType,'\\n|\\r','')) as toUserType,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.dap_basepost_t_reward_info;










--T15
--ods建表：pro.ods_yhq_t_charge_info
--插入：mongo2hive.dap_basepost_t_charge_info到pro.ods_yhq_t_charge_info
insert overwrite table pro.ods_yhq_t_charge_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(targetId,'\\n|\\r','')) as targetId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(fromUserId,'\\n|\\r','')) as fromUserId,
trim(regexp_replace(fromUserType,'\\n|\\r','')) as fromUserType,
trim(regexp_replace(toUserId,'\\n|\\r','')) as toUserId,
trim(regexp_replace(toUserType,'\\n|\\r','')) as toUserType,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(modifyTime,'\\n|\\r','')) as modifyTimes
from mongo2hive.dap_basepost_t_charge_info;



--T16
--ods建表：pro.ods_yhq_t_union_pack_setting
--插入：mongo2hive.pack_t_union_pack_setting到pro.ods_yhq_t_union_pack_setting
insert overwrite table pro.ods_yhq_t_union_pack_setting PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(packType,'\\n|\\r','')) as packType,
trim(regexp_replace(packName,'\\n|\\r','')) as packName,
trim(regexp_replace(region,'\\n|\\r','')) as region,
trim(regexp_replace(unionCutRatio,'\\n|\\r','')) as unionCutRatio,
trim(regexp_replace(superiorCutRatio,'\\n|\\r','')) as superiorCutRatio,
trim(regexp_replace(lastUpdateUserId,'\\n|\\r','')) as lastUpdateUserId,
trim(regexp_replace(lastUpdateTime,'\\n|\\r','')) as lastUpdateTime,
trim(regexp_replace(enable,'\\n|\\r','')) as enable
from mongo2hive.pack_t_union_pack_setting;


--T17
--ods建表：pro.ods_yhq_t_follow_info
--插入：mongo2hive.dap_basepost_t_follow_info到pro.ods_yhq_t_follow_info
insert overwrite table pro.ods_yhq_t_follow_info PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(userType,'\\n|\\r','')) as userType,
trim(regexp_replace(followId,'\\n|\\r','')) as followId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(enable,'\\n|\\r','')) as enable,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mongo2hive.dap_basepost_t_follow_info;


--T18
--ods建表：pro.ods_yhq_user
--插入：mongo2hive.health_user到pro.ods_yhq_health_user
insert overwrite table pro.ods_yhq_user PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(password,'\\n|\\r','')) as password,
trim(regexp_replace(telephone,'\\n|\\r','')) as telephone,
trim(regexp_replace(nickname,'\\n|\\r','')) as nickname,
trim(regexp_replace(createtime,'\\n|\\r','')) as createtime,
trim(regexp_replace(modifyTime,'\\n|\\r','')) as modifyTime,
trim(regexp_replace(isAuth,'\\n|\\r','')) as isAuth,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(settings_allowAtt,'\\n|\\r','')) as settings_allowAtt,
trim(regexp_replace(settings_allowGreet,'\\n|\\r','')) as settings_allowGreet,
trim(regexp_replace(settings_friendsVerify,'\\n|\\r','')) as settings_friendsVerify,
trim(regexp_replace(settings_ispushflag,'\\n|\\r','')) as settings_ispushflag,
trim(regexp_replace(loginLog_isFirstLogin,'\\n|\\r','')) as loginLog_isFirstLogin,
trim(regexp_replace(loginLog_location,'\\n|\\r','')) as loginLog_location,
trim(regexp_replace(loginLog_loginTime,'\\n|\\r','')) as loginLog_loginTime,
trim(regexp_replace(loginLog_model,'\\n|\\r','')) as loginLog_model,
trim(regexp_replace(loginLog_offlineTime,'\\n|\\r','')) as loginLog_offlineTime,
trim(regexp_replace(headPicFileName,'\\n|\\r','')) as headPicFileName,
trim(regexp_replace(area,'\\n|\\r','')) as area,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(lastLoginTime,'\\n|\\r','')) as lastLoginTime,
trim(regexp_replace(loginLog,'\\n|\\r','')) as loginLog,
trim(regexp_replace(loc,'\\n|\\r','')) as loc,
trim(regexp_replace(sex,'\\n|\\r','')) as sex,
trim(regexp_replace(province,'\\n|\\r','')) as province,
trim(regexp_replace(userConfig,'\\n|\\r','')) as userConfig,
trim(regexp_replace(activeTime,'\\n|\\r','')) as activeTime,
trim(regexp_replace(isActive,'\\n|\\r','')) as isActive,
trim(regexp_replace(followDiseases,'\\n|\\r','')) as followDiseases,
trim(regexp_replace(sourceType,'\\n|\\r','')) as sourceType,
trim(regexp_replace(birthday,'\\n|\\r','')) as birthday,
trim(regexp_replace(city,'\\n|\\r','')) as city,
trim(regexp_replace(userConfig_newMsgRemind,'\\n|\\r','')) as userConfig_newMsgRemind
from mongo2hive.health_yhq_user
where userType='1';


--T19
--ods建表：pro.ods_yhq_t_care_plan
--插入：mongo2hive.careplan_t_care_plan到pro.ods_yhq_t_care_plan
insert overwrite table pro.ods_yhq_t_care_plan PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(diseaseTypes,'\\n|\\r','')) as diseaseTypes,
trim(regexp_replace(price,'\\n|\\r','')) as price,
trim(regexp_replace(helpTimes,'\\n|\\r','')) as helpTimes,
trim(regexp_replace(replyCount,'\\n|\\r','')) as replyCount,
trim(regexp_replace(executeTime,'\\n|\\r','')) as executeTime,
trim(regexp_replace(titlePic,'\\n|\\r','')) as titlePic,
trim(regexp_replace(digest,'\\n|\\r','')) as digest,
trim(regexp_replace(content,'\\n|\\r','')) as content,
trim(regexp_replace(groupId,'\\n|\\r','')) as groupId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(tmpType,'\\n|\\r','')) as tmpType,
trim(regexp_replace(sourceId,'\\n|\\r','')) as sourceId,
trim(regexp_replace(fromPlanId,'\\n|\\r','')) as fromPlanId,
trim(regexp_replace(recipeId,'\\n|\\r','')) as recipeId,
trim(regexp_replace(ifLeaveMessage,'\\n|\\r','')) as ifLeaveMessage,
trim(regexp_replace(recordId,'\\n|\\r','')) as recordId,
trim(regexp_replace(schedulePlans,'\\n|\\r','')) as schedulePlans,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId
from mongo2hive.careplan_t_care_plan;




--T20
--ods建表：pro.ods_yhq_t_union_member
--插入：mongo2hive.doctor_union_t_union_member到pro.ods_yhq_t_union_member
insert overwrite table pro.ods_yhq_t_union_member PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(role,'\\n|\\r','')) as role,
trim(regexp_replace(operationDate,'\\n|\\r','')) as operationDate,
trim(regexp_replace(superiorId,'\\n|\\r','')) as superiorId,
trim(regexp_replace(isExpert,'\\n|\\r','')) as isExpert,
trim(regexp_replace(recommend,'\\n|\\r','')) as recommend,
trim(regexp_replace(followUrl,'\\n|\\r','')) as followUrl,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(telephone,'\\n|\\r','')) as telephone,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(titleRank,'\\n|\\r','')) as titleRank,
trim(regexp_replace(headPicFileName,'\\n|\\r','')) as headPicFileName,
trim(regexp_replace(doctorNum,'\\n|\\r','')) as doctorNum,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(departments,'\\n|\\r','')) as departments,
trim(regexp_replace(hospital,'\\n|\\r','')) as hospital,
trim(regexp_replace(namePinyin,'\\n|\\r','')) as namePinyin,
trim(regexp_replace(sex,'\\n|\\r','')) as sex,
trim(regexp_replace(oftenUnion,'\\n|\\r','')) as oftenUnion
from mongo2hive.doctor_union_t_union_member;