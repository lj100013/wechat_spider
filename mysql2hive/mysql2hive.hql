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

--插入:mysql2hive.circle_circle_member到pro.ods_circle_member
insert overwrite table pro.ods_circle_member PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(permanentFree,'\\n|\\r','')) as permanentFree,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(expirationTime,'\\n|\\r','')) as expirationTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(conversationGroupId,'\\n|\\r','')) as conversationGroupId,
trim(regexp_replace(noticeStatusTime,'\\n|\\r','')) as noticeStatusTime 
from mysql2hive.circle_circle_member;

--插入:mysql2hive.circle_circle_member_role到pro.ods_circle_member_role
insert overwrite table pro.ods_circle_member_role PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(`role`,'\\n|\\r','')) as `role`,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime 
from mysql2hive.circle_circle_member_role;



--运营分析二期中用到的表
--插入:mysql2hive.medicine_literature_articleInfo到pro.ods_articleInfo
insert overwrite table pro.ods_articleInfo PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id ,'\\n|\\r','')) as id,
trim(regexp_replace(articleID ,'\\n|\\r','')) as articleID,
trim(regexp_replace(type ,'\\n|\\r','')) as type,
trim(regexp_replace(title ,'\\n|\\r','')) as title,
trim(regexp_replace(creator ,'\\n|\\r','')) as creator,
trim(regexp_replace(source ,'\\n|\\r','')) as source,
trim(regexp_replace(keyWords ,'\\n|\\r','')) as keyWords,
trim(regexp_replace(`year` ,'\\n|\\r','')) as `year`,
trim(regexp_replace(dbid ,'\\n|\\r','')) as dbid,
trim(regexp_replace(directDownload ,'\\n|\\r','')) as directDownload,
trim(regexp_replace(url ,'\\n|\\r','')) as url,
trim(regexp_replace(createTime ,'\\n|\\r','')) as createTime 
from mysql2hive.medicine_literature_articleInfo;

--插入:mysql2hive.medicine_literature_pay_record到pro.ods_pay_record
insert overwrite table pro.ods_pay_record PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(articleInfoId,'\\n|\\r','')) as articleInfoId,
trim(regexp_replace(integral,'\\n|\\r','')) as integral,
trim(regexp_replace(credit,'\\n|\\r','')) as credit,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime 
from mysql2hive.medicine_literature_pay_record;

--插入:mysql2hive.medicine_literature_user_article到pro.ods_user_article
insert overwrite table pro.ods_user_article PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(userId ,'\\n|\\r','')) as userId,
trim(regexp_replace(articleInfoId ,'\\n|\\r','')) as articleInfoId,
trim(regexp_replace(createTime ,'\\n|\\r','')) as createTime 
from mysql2hive.medicine_literature_user_article;

--插入:mysql2hive.medicine_literature_user_integral到pro.ods_user_integral
insert overwrite table pro.ods_user_integral PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id ,'\\n|\\r','')) as id,
trim(regexp_replace(userId ,'\\n|\\r','')) as userId,
trim(regexp_replace(balance ,'\\n|\\r','')) as balance 
from mysql2hive.medicine_literature_user_integral;

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



--推荐系统中用到的表
--插入:mysql2hive.circle_circle_living_video到pro.ods_circle_living_video
insert overwrite table pro.ods_circle_living_video PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(rId,'\\n|\\r','')) as rId,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(webcastId,'\\n|\\r','')) as webcastId,
trim(regexp_replace(coverUrl,'\\n|\\r','')) as coverUrl,
trim(regexp_replace(password,'\\n|\\r','')) as password,
trim(regexp_replace(subject,'\\n|\\r','')) as subject,
trim(regexp_replace(description,'\\n|\\r','')) as description,
trim(regexp_replace(number,'\\n|\\r','')) as number,
trim(regexp_replace(url,'\\n|\\r','')) as url,
trim(regexp_replace(plan,'\\n|\\r','')) as plan,
trim(regexp_replace(speakerInfo,'\\n|\\r','')) as speakerInfo,
trim(regexp_replace(recordStartTime,'\\n|\\r','')) as recordStartTime,
trim(regexp_replace(recordEndTime,'\\n|\\r','')) as recordEndTime,
trim(regexp_replace(size,'\\n|\\r','')) as size,
trim(regexp_replace(publishFlag,'\\n|\\r','')) as publishFlag,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(recommend,'\\n|\\r','')) as recommend,
trim(regexp_replace(recommendTime,'\\n|\\r','')) as recommendTime,
trim(regexp_replace(noticed,'\\n|\\r','')) as noticed,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(guestName,'\\n|\\r','')) as guestName,
trim(regexp_replace(webcastPlatform,'\\n|\\r','')) as webcastPlatform,
trim(regexp_replace(speakerIntroImg,'\\n|\\r','')) as speakerIntroImg 
from mysql2hive.circle_circle_living_video;

--插入:mysql2hive.circle_circle_living到pro.ods_circle_living
insert overwrite table pro.ods_circle_living PARTITION(dt='${hivevar:preday}')
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(webcastId,'\\n|\\r','')) as webcastId,
trim(regexp_replace(subject,'\\n|\\r','')) as subject,
trim(regexp_replace(coverUrl,'\\n|\\r','')) as coverUrl,
trim(regexp_replace(description,'\\n|\\r','')) as description,
trim(regexp_replace(number,'\\n|\\r','')) as number,
trim(regexp_replace(organizerJoinUrl,'\\n|\\r','')) as organizerJoinUrl,
trim(regexp_replace(organizerToken,'\\n|\\r','')) as organizerToken,
trim(regexp_replace(panelistJoinUrl,'\\n|\\r','')) as panelistJoinUrl,
trim(regexp_replace(panelistToken,'\\n|\\r','')) as panelistToken,
trim(regexp_replace(attendeeJoinUrl,'\\n|\\r','')) as attendeeJoinUrl,
trim(regexp_replace(attendeeToken,'\\n|\\r','')) as attendeeToken,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(plan,'\\n|\\r','')) as plan,
trim(regexp_replace(speakerInfo,'\\n|\\r','')) as speakerInfo,
trim(regexp_replace(maxAttendees,'\\n|\\r','')) as maxAttendees,
trim(regexp_replace(loginRequired,'\\n|\\r','')) as loginRequired,
trim(regexp_replace(opened,'\\n|\\r','')) as opened,
trim(regexp_replace(switchClient,'\\n|\\r','')) as switchClient,
trim(regexp_replace(realtime,'\\n|\\r','')) as realtime,
trim(regexp_replace(aac,'\\n|\\r','')) as aac,
trim(regexp_replace(telconf,'\\n|\\r','')) as telconf,
trim(regexp_replace(sec,'\\n|\\r','')) as sec,
trim(regexp_replace(action,'\\n|\\r','')) as action,
trim(regexp_replace(publishFlag,'\\n|\\r','')) as publishFlag,
trim(regexp_replace(deleteFlag,'\\n|\\r','')) as deleteFlag,
trim(regexp_replace(isSendSms,'\\n|\\r','')) as isSendSms,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(pushCount,'\\n|\\r','')) as pushCount,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(deptId,'\\n|\\r','')) as deptId,
trim(regexp_replace(deptName,'\\n|\\r','')) as deptName,
trim(regexp_replace(recommend,'\\n|\\r','')) as recommend,
trim(regexp_replace(recommendTime,'\\n|\\r','')) as recommendTime,
trim(regexp_replace(noticed,'\\n|\\r','')) as noticed,
trim(regexp_replace(hallFlag,'\\n|\\r','')) as hallFlag,
trim(regexp_replace(columnName,'\\n|\\r','')) as columnName,
trim(regexp_replace(extDesc,'\\n|\\r','')) as extDesc,
trim(regexp_replace(speakerId,'\\n|\\r','')) as speakerId,
trim(regexp_replace(guestName,'\\n|\\r','')) as guestName,
trim(regexp_replace(webcastPlatform,'\\n|\\r','')) as webcastPlatform,
trim(regexp_replace(speakerIntroImg,'\\n|\\r','')) as speakerIntroImg,
trim(regexp_replace(guestNumber,'\\n|\\r','')) as guestNumber
from mysql2hive.circle_circle_living;



--插入:mysql2hive.circle_school_t_course到pro.ods_t_course_circle
insert overwrite table pro.ods_t_course_circle PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(theme,'\\n|\\r','')) as theme,
trim(regexp_replace(form,'\\n|\\r','')) as form,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(coverImgUrl,'\\n|\\r','')) as coverImgUrl,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(ownerName,'\\n|\\r','')) as ownerName,
trim(regexp_replace(ownerDeptId,'\\n|\\r','')) as ownerDeptId,
trim(regexp_replace(ownerDeptName,'\\n|\\r','')) as ownerDeptName,
trim(regexp_replace(ownerHospitalId,'\\n|\\r','')) as ownerHospitalId,
trim(regexp_replace(ownerHospitalName,'\\n|\\r','')) as ownerHospitalName,
trim(regexp_replace(ownerHeadPic,'\\n|\\r','')) as ownerHeadPic,
trim(regexp_replace(ownerAcademicTitle,'\\n|\\r','')) as ownerAcademicTitle,
trim(regexp_replace(beginTime,'\\n|\\r','')) as beginTime,
trim(regexp_replace(createId,'\\n|\\r','')) as createId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(publishType,'\\n|\\r','')) as publishType,
trim(regexp_replace(relateActivityCnt,'\\n|\\r','')) as relateActivityCnt,
trim(regexp_replace(createName,'\\n|\\r','')) as createName,
trim(regexp_replace(checkStatus,'\\n|\\r','')) as checkStatus,
trim(regexp_replace(checkId,'\\n|\\r','')) as checkId,
trim(regexp_replace(checkTime,'\\n|\\r','')) as checkTime,
trim(regexp_replace(grade,'\\n|\\r','')) as grade
from mysql2hive.circle_school_t_course;


--插入:mysql2hive.circle_school_t_course_dept到pro.ods_t_course_dept_circle
insert overwrite table pro.ods_t_course_dept_circle PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(deptName,'\\n|\\r','')) as deptName,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(deptCode,'\\n|\\r','')) as deptCode
from mysql2hive.circle_school_t_course_dept;



--插入:mysql2hive.circle_school_t_course_lable到pro.ods_t_course_label_circle
insert overwrite table pro.ods_t_course_label_circle PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(lable,'\\n|\\r','')) as lable
from mysql2hive.circle_school_t_course_lable;


--插入:mysql2hive.circle_school_t_course_range到pro.ods_t_course_range_circle
insert overwrite table pro.ods_t_course_range_circle PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(ownerId,'\\n|\\r','')) as ownerId,
trim(regexp_replace(circleId,'\\n|\\r','')) as circleId,
trim(regexp_replace(circleName,'\\n|\\r','')) as circleName,
trim(regexp_replace(circleAuditing,'\\n|\\r','')) as circleAuditing,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime
from mysql2hive.circle_school_t_course_range;


--插入:mysql2hive.health_p_image_data到pro.ods_p_image_data
insert overwrite table pro.ods_p_image_data PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(relation_id,'\\n|\\r','')) as relation_id,
trim(regexp_replace(user_id,'\\n|\\r','')) as user_id,
trim(regexp_replace(image_url,'\\n|\\r','')) as image_url,
trim(regexp_replace(image_type,'\\n|\\r','')) as image_type,
trim(regexp_replace(time_long,'\\n|\\r','')) as time_long
from mysql2hive.health_p_image_data;


--插入:mysql2hive.medicine_literature_user_treatise到pro.ods_user_treatise
insert overwrite table pro.ods_user_treatise PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(user_id,'\\n|\\r','')) as user_id,
trim(regexp_replace(treatise_id,'\\n|\\r','')) as treatise_id,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(create_time,'\\n|\\r','')) as create_time
from mysql2hive.medicine_literature_user_treatise;



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


--插入:mysql2hive.excellent_class_j_class_exam到pro.ods_j_class_exam
insert overwrite table pro.ods_j_class_exam PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(relateId,'\\n|\\r','')) as relateId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(examinationId,'\\n|\\r','')) as examinationId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(totalScore,'\\n|\\r','')) as totalScore,
trim(regexp_replace(getScore,'\\n|\\r','')) as getScore,
trim(regexp_replace(answerJson,'\\n|\\r','')) as answerJson,
trim(regexp_replace(spentTime,'\\n|\\r','')) as spentTime,
trim(regexp_replace(rightCount,'\\n|\\r','')) as rightCount
from mysql2hive.excellent_class_j_class_exam;


--插入:mysql2hive.excellent_class_j_class_survey到pro.ods_j_class_survey
insert overwrite table pro.ods_j_class_survey PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(relateId,'\\n|\\r','')) as relateId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(surveyId,'\\n|\\r','')) as surveyId,
trim(regexp_replace(answerId,'\\n|\\r','')) as answerId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.excellent_class_j_class_survey;




--插入:mysql2hive.excellent_class_j_course到pro.ods_j_course
insert overwrite table pro.ods_j_course PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(courseUrl,'\\n|\\r','')) as courseUrl,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(introductionUrl,'\\n|\\r','')) as introductionUrl,
trim(regexp_replace(departmentLabels,'\\n|\\r','')) as departmentLabels,
trim(regexp_replace(diseaseLabels,'\\n|\\r','')) as diseaseLabels,
trim(regexp_replace(customLabels,'\\n|\\r','')) as customLabels,
trim(regexp_replace(purchaseNotes,'\\n|\\r','')) as purchaseNotes,
trim(regexp_replace(questionnaireId,'\\n|\\r','')) as questionnaireId,
trim(regexp_replace(examinationId,'\\n|\\r','')) as examinationId,
trim(regexp_replace(certificateTemplateId,'\\n|\\r','')) as certificateTemplateId,
trim(regexp_replace(system,'\\n|\\r','')) as system,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(topping,'\\n|\\r','')) as topping,
trim(regexp_replace(toppingTime,'\\n|\\r','')) as toppingTime,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(status,'\\n|\\r','')) as status
from mysql2hive.excellent_class_j_course;



--插入:mysql2hive.coupon_coupon_apply到pro.ods_coupon_apply
insert overwrite table pro.ods_coupon_apply PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(platform,'\\n|\\r','')) as platform,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(faceValue,'\\n|\\r','')) as faceValue,
trim(regexp_replace(guaranteeNum,'\\n|\\r','')) as guaranteeNum,
trim(regexp_replace(cappingNum,'\\n|\\r','')) as cappingNum,
trim(regexp_replace(cappingNumLeft,'\\n|\\r','')) as cappingNumLeft,
trim(regexp_replace(issueNum,'\\n|\\r','')) as issueNum,
trim(regexp_replace(issueNumLeft,'\\n|\\r','')) as issueNumLeft,
trim(regexp_replace(bizId,'\\n|\\r','')) as bizId,
trim(regexp_replace(bizName,'\\n|\\r','')) as bizName,
trim(regexp_replace(subBizId,'\\n|\\r','')) as subBizId,
trim(regexp_replace(subBizName,'\\n|\\r','')) as subBizName,
trim(regexp_replace(sponsorId,'\\n|\\r','')) as sponsorId,
trim(regexp_replace(sponsorName,'\\n|\\r','')) as sponsorName,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(freezeId,'\\n|\\r','')) as freezeId,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.coupon_coupon_apply;



--插入:mysql2hive.excellent_class_j_class到pro.ods_j_class
insert overwrite table pro.ods_j_class PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(introduction,'\\n|\\r','')) as introduction,
trim(regexp_replace(introductionUrl,'\\n|\\r','')) as introductionUrl,
trim(regexp_replace(beginTime,'\\n|\\r','')) as beginTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(term,'\\n|\\r','')) as term,
trim(regexp_replace(signupStartTime,'\\n|\\r','')) as signupStartTime,
trim(regexp_replace(signupEndTime,'\\n|\\r','')) as signupEndTime,
trim(regexp_replace(managerIds,'\\n|\\r','')) as managerIds,
trim(regexp_replace(numberLimit,'\\n|\\r','')) as numberLimit,
trim(regexp_replace(price,'\\n|\\r','')) as price,
trim(regexp_replace(practiceUrl,'\\n|\\r','')) as practiceUrl,
trim(regexp_replace(practice,'\\n|\\r','')) as practice,
trim(regexp_replace(notice,'\\n|\\r','')) as notice,
trim(regexp_replace(noticeTime,'\\n|\\r','')) as noticeTime,
trim(regexp_replace(guaranteeNum,'\\n|\\r','')) as guaranteeNum,
trim(regexp_replace(seq,'\\n|\\r','')) as seq,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createId,'\\n|\\r','')) as createId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.excellent_class_j_class;




--插入:mysql2hive.excellent_class_j_class_schedule到pro.ods_j_class_schedule
insert overwrite table pro.ods_j_class_schedule PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(classId,'\\n|\\r','')) as classId,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(objectId,'\\n|\\r','')) as objectId,
trim(regexp_replace(isfree,'\\n|\\r','')) as isfree,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(tutor,'\\n|\\r','')) as tutor,
trim(regexp_replace(tutorName,'\\n|\\r','')) as tutorName,
trim(regexp_replace(answerStartTime,'\\n|\\r','')) as answerStartTime,
trim(regexp_replace(answerEndTime,'\\n|\\r','')) as answerEndTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(subject,'\\n|\\r','')) as subject,
trim(regexp_replace(ispublish,'\\n|\\r','')) as ispublish,
trim(regexp_replace(ischangeAnswer,'\\n|\\r','')) as ischangeAnswer
from mysql2hive.excellent_class_j_class_schedule;




--插入:mysql2hive.excellent_class_j_courseware到pro.ods_j_courseware
insert overwrite table pro.ods_j_courseware PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(coverUrl,'\\n|\\r','')) as coverUrl,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(lecturerId,'\\n|\\r','')) as lecturerId,
trim(regexp_replace(lecturerIntroduction,'\\n|\\r','')) as lecturerIntroduction,
trim(regexp_replace(questionnaireId,'\\n|\\r','')) as questionnaireId,
trim(regexp_replace(examinationId,'\\n|\\r','')) as examinationId,
trim(regexp_replace(materialId,'\\n|\\r','')) as materialId,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(enableTime,'\\n|\\r','')) as enableTime,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.excellent_class_j_courseware;


--插入:mysql2hive.excellent_class_j_course_rate到pro.ods_j_course_rate
insert overwrite table pro.ods_j_course_rate PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(grade,'\\n|\\r','')) as grade,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime
from mysql2hive.excellent_class_j_course_rate;




--插入:mysql2hive.excellent_class_j_course_courseware到pro.ods_j_course_courseware
insert overwrite table pro.ods_j_course_courseware PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(courseId,'\\n|\\r','')) as courseId,
trim(regexp_replace(courseWareId,'\\n|\\r','')) as courseWareId,
trim(regexp_replace(sort,'\\n|\\r','')) as sort,
trim(regexp_replace(createUserId,'\\n|\\r','')) as createUserId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime,
trim(regexp_replace(isfree,'\\n|\\r','')) as isfree
from mysql2hive.excellent_class_j_course_courseware;