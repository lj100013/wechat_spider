--活动-用户行为中用的表
--插入:mysql2hive.activitywwh_activity_config到pro.ods_activity_config
insert overwrite table pro.ods_activity_config PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(application,'\\n|\\r','')) as application,
trim(regexp_replace(ifDispark,'\\n|\\r','')) as ifDispark,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(beginTime,'\\n|\\r','')) as beginTime,
trim(regexp_replace(disparkTime,'\\n|\\r','')) as disparkTime,
trim(regexp_replace(participationType,'\\n|\\r','')) as participationType,
trim(regexp_replace(slogan,'\\n|\\r','')) as slogan,
trim(regexp_replace(sponsorLogo,'\\n|\\r','')) as sponsorLogo,
trim(regexp_replace(screenUrl,'\\n|\\r','')) as screenUrl,
trim(regexp_replace(totalIntegral,'\\n|\\r','')) as totalIntegral,
trim(regexp_replace(prizewinnerType,'\\n|\\r','')) as prizewinnerType,
trim(regexp_replace(prizewinner,'\\n|\\r','')) as prizewinner,
trim(regexp_replace(highestIntegral,'\\n|\\r','')) as highestIntegral,
trim(regexp_replace(lowestIntegral,'\\n|\\r','')) as lowestIntegral,
trim(regexp_replace(warmUpTime,'\\n|\\r','')) as warmUpTime,
trim(regexp_replace(warmUpBeforeUrl,'\\n|\\r','')) as warmUpBeforeUrl,
trim(regexp_replace(warmUpUrl,'\\n|\\r','')) as warmUpUrl,
trim(regexp_replace(warmUpLaterUrl,'\\n|\\r','')) as warmUpLaterUrl,
trim(regexp_replace(answerAtTime,'\\n|\\r','')) as answerAtTime,
trim(regexp_replace(answerAsTime,'\\n|\\r','')) as answerAsTime,
trim(regexp_replace(answerId,'\\n|\\r','')) as answerId,
trim(regexp_replace(passMark,'\\n|\\r','')) as passMark,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(updateUserId,'\\n|\\r','')) as updateUserId,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(bonusAllot,'\\n|\\r','')) as bonusAllot,
trim(regexp_replace(display,'\\n|\\r','')) as display,
trim(regexp_replace(levelJson,'\\n|\\r','')) as levelJson,
trim(regexp_replace(command,'\\n|\\r','')) as command,
trim(regexp_replace(manageUser,'\\n|\\r','')) as manageUser,
trim(regexp_replace(createCompanyId,'\\n|\\r','')) as createCompanyId,
trim(regexp_replace(beFrom,'\\n|\\r','')) as beFrom,
trim(regexp_replace(linkType,'\\n|\\r','')) as linkType,
trim(regexp_replace(linkId,'\\n|\\r','')) as linkId
from mysql2hive.activitywwh_activity_config;



--插入:mysql2hive.activitywwh_activity_user到pro.ods_activity_user
insert overwrite table pro.ods_activity_user PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(markTotal,'\\n|\\r','')) as markTotal,
trim(regexp_replace(time,'\\n|\\r','')) as time,
trim(regexp_replace(applyTime,'\\n|\\r','')) as applyTime,
trim(regexp_replace(ifPass,'\\n|\\r','')) as ifPass,
trim(regexp_replace(redPacket,'\\n|\\r','')) as redPacket,
trim(regexp_replace(questionJson,'\\n|\\r','')) as questionJson 
from mysql2hive.activitywwh_activity_user;



--运营分析一期中用到的表
--插入:mysql2hive.circle_circle到pro.ods_circle


insert overwrite table pro.ods_circle PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(sortName,'\\n|\\r','')) as sortName,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(logo,'\\n|\\r','')) as logo,
trim(regexp_replace(label,'\\n|\\r','')) as label,
trim(regexp_replace(auditing,'\\n|\\r','')) as auditing,
trim(regexp_replace(charge,'\\n|\\r','')) as charge,
trim(regexp_replace(freeTime,'\\n|\\r','')) as freeTime,
trim(regexp_replace(invite,'\\n|\\r','')) as invite,
trim(regexp_replace(hasChildren,'\\n|\\r','')) as hasChildren,
trim(regexp_replace(flag,'\\n|\\r','')) as flag,
trim(regexp_replace(memberCount,'\\n|\\r','')) as memberCount,
trim(regexp_replace(masterCount,'\\n|\\r','')) as masterCount,
trim(regexp_replace(managerCount,'\\n|\\r','')) as managerCount,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateUserId,'\\n|\\r','')) as updateUserId,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(masterAreaName,'\\n|\\r','')) as masterAreaName,
trim(regexp_replace(masterName,'\\n|\\r','')) as masterName,
trim(regexp_replace(masterSpeciality,'\\n|\\r','')) as masterSpeciality,
trim(regexp_replace(deptIds,'\\n|\\r','')) as deptIds,
trim(regexp_replace(deptNames,'\\n|\\r','')) as deptNames,
trim(regexp_replace(isprivate,'\\n|\\r','')) as isprivate 
from mysql2hive.circle_circle;




--插入:mysql2hive.excellent_class_j_class_signup到pro.ods_j_class_signup
insert overwrite table pro.ods_j_class_signup PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(isadmin,'\\n|\\r','')) as isadmin,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(telephone,'\\n|\\r','')) as telephone,
trim(regexp_replace(headPicFileName,'\\n|\\r','')) as headPicFileName,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(companyName,'\\n|\\r','')) as companyName,
trim(regexp_replace(departments,'\\n|\\r','')) as departments,
trim(regexp_replace(userStatus,'\\n|\\r','')) as userStatus,
trim(regexp_replace(payType,'\\n|\\r','')) as payType,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(preferentialId,'\\n|\\r','')) as preferentialId,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(payTime,'\\n|\\r','')) as payTime,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(payVoJson,'\\n|\\r','')) as payVoJson,
trim(regexp_replace(payUserJson,'\\n|\\r','')) as payUserJson,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(isrefund,'\\n|\\r','')) as isrefund,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.excellent_class_j_class_signup;






--插入:mysql2hive.circle_circle_activity到pro.ods_circle_activity
insert overwrite table pro.ods_circle_activity PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(agreement,'\\n|\\r','')) as agreement,
trim(regexp_replace(commitLocation,'\\n|\\r','')) as commitLocation,
trim(regexp_replace(imageUrl,'\\n|\\r','')) as imageUrl,
trim(regexp_replace(simageUrl,'\\n|\\r','')) as simageUrl,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(rule,'\\n|\\r','')) as rule,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(businessType,'\\n|\\r','')) as businessType,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(ruleStartTime,'\\n|\\r','')) as ruleStartTime,
trim(regexp_replace(ruleEndTime,'\\n|\\r','')) as ruleEndTime,
trim(regexp_replace(eid,'\\n|\\r','')) as eid,
trim(regexp_replace(companyName,'\\n|\\r','')) as companyName,
trim(regexp_replace(companyId,'\\n|\\r','')) as companyId,
trim(regexp_replace(unFreezeFlag,'\\n|\\r','')) as unFreezeFlag,
trim(regexp_replace(rewardType,'\\n|\\r','')) as rewardType
from mysql2hive.circle_circle_activity;



--插入:mysql2hive.circle_circle_activity_redpaper到pro.ods_circle_activity_redpaper
insert overwrite table pro.ods_circle_activity_redpaper PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(rule,'\\n|\\r','')) as rule,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(grade,'\\n|\\r','')) as grade,
trim(regexp_replace(`sum`,'\\n|\\r','')) as `sum`,
trim(regexp_replace(mayOptNum,'\\n|\\r','')) as mayOptNum,
trim(regexp_replace(probability,'\\n|\\r','')) as probability,
trim(regexp_replace(businessType,'\\n|\\r','')) as businessType,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(activityId,'\\n|\\r','')) as activityId,
trim(regexp_replace(activityFlag,'\\n|\\r','')) as activityFlag,
trim(regexp_replace(rewardType,'\\n|\\r','')) as rewardType
from mysql2hive.circle_circle_activity_redpaper;




--插入:mysql2hive.circle_circle_activity_redenvelopes到pro.ods_circle_activity_redenvelopes
insert overwrite table pro.ods_circle_activity_redenvelopes PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(aid,'\\n|\\r','')) as aid,
trim(regexp_replace(sid,'\\n|\\r','')) as sid,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(randomNum,'\\n|\\r','')) as randomNum,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(receiveTime,'\\n|\\r','')) as receiveTime,
trim(regexp_replace(user,'\\n|\\r','')) as user
from mysql2hive.circle_circle_activity_redenvelopes;



--插入:mysql2hive.credit_circle_recharge到pro.ods_circle_recharge
insert overwrite table pro.ods_circle_recharge PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(payNo,'\\n|\\r','')) as payNo,
trim(regexp_replace(amount,'\\n|\\r','')) as amount,
trim(regexp_replace(integral,'\\n|\\r','')) as integral,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(rechargeType,'\\n|\\r','')) as rechargeType,
trim(regexp_replace(targerType,'\\n|\\r','')) as targerType,
trim(regexp_replace(targerId,'\\n|\\r','')) as targerId,
trim(regexp_replace(targerName,'\\n|\\r','')) as targerName,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(payTime,'\\n|\\r','')) as payTime,
trim(regexp_replace(prepayId,'\\n|\\r','')) as prepayId,
trim(regexp_replace(openId,'\\n|\\r','')) as openId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(remark,'\\n|\\r','')) as remark
from mysql2hive.credit_circle_recharge;



--插入:mysql2hive.coupon_user_coupon_detail到pro.ods_user_coupon_detail
insert overwrite table pro.ods_user_coupon_detail PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(applyId,'\\n|\\r','')) as applyId,
trim(regexp_replace(couponId,'\\n|\\r','')) as couponId,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(description,'\\n|\\r','')) as description,
trim(regexp_replace(faceValue,'\\n|\\r','')) as faceValue,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(subBizId,'\\n|\\r','')) as subBizId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.coupon_user_coupon_detail;