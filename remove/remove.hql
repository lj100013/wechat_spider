set hive.exec.dynamic.partition=true; 
set hive.exec.dynamic.partition.mode=nonstrict;


--mongo分区数据迁移
insert overwrite table pro.ods_user partition(dt)
select id,age,sex,area,birthday,name,email,telephone,needresetpassword,password,remarks,status,userlevel,usertype,givecoin,headpicfilename,createtime,submittime,lastlogintime,limitedperiodtime,modifytime,doctor_province,doctor_provinceid,doctor_city,doctor_cityid,doctor_area,doctor_areaid,doctor_departments,doctor_deptid,doctor_doctornum,doctor_experience,doctor_expertise,doctor_hospital,doctor_hospitalid,doctor_introduction,doctor_scholarship,doctor_skill,doctor_title,doctor_check_checktime,doctor_check_checker,doctor_check_checkerid,doctor_check_departments,doctor_check_deptid,doctor_check_hospital,doctor_check_hospitalid,doctor_check_licenseexpire,doctor_check_licensenum,doctor_check_remark,doctor_check_title,loginlog_isfirstlogin,loginlog_location,loginlog_logintime,loginlog_model,loginlog_offlinetime,settings_friendsverify,settings_ispushflag,source_inviterid,source_sourcetype,source_terminal,userconfig_remindvoice,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_user;


insert overwrite table pro.ods_t_faq_question partition(dt)
select id,columnid,type,userid,status,deleted,labelids,deptid,sourceid,activitycount,content_terminal,open,content_type,content_summary,content_bodyid,content_mainbody,content_freetime,range_all,range_userids,range_deptids,payinfo_amount,payinfo_payertype,payinfo_payer,publish_publishertype,publish_publisher,publish_platformtype,publish_platformid,check_status,check_auditor,check_updatetime,sort,sticktoptime,orderid,bestanswerids,createtime,updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_question;


insert overwrite table pro.ods_t_faq_label partition(dt)
select id,name,usagecount,createtime,updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_label;


insert overwrite table pro.ods_t_faq_reply partition(dt)
select id,userid,username,type,questionid,questiontype,mainreplyid,touserid,tousername,replyid,status,bestanswer,sticktoptime,likecount,createtime,updatetime,content_type,content_summary,content_mainbody,content_bodyid,content_freetime,check_status,check_auditor,check_updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_reply;


insert overwrite table pro.ods_t_faq_data_count partition(dt)
select id,datatype,dataid,viewcount,rewardcount,likecount,replycount,readingcount,class,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_data_count;


insert overwrite table pro.ods_t_faq_mainBody partition(dt)
select id,body,createtime,updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_mainBody;


insert overwrite table pro.ods_t_faq_column partition(dt)
select id,name,weight,owner,createtime,updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_column;


insert overwrite table pro.ods_t_faq_like partition(dt)
select id,userid,dataid,type,createtime,updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_like;


insert overwrite table pro.ods_disease_info partition(dt)
select id,circleid,type,userid,username,userheadpic,useracademictitle,userhospital,userdept,createtime,status,shareurl,title,deptid,recommend,recommendtime,relateactivitycnt,from_,labellist,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_disease_info;


insert overwrite table pro.ods_disease_question partition(dt)
select id,questionid,diseaseid,questiontitle,questiontype,createtime,statusflag,userid,username,userheadpic,useracademictitle,userhospital,userdept,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_disease_question;


--insert overwrite table pro.ods_t_promotion partition(dt)
--select id,title,status,templateid,relateactivitycnt,drugcompanyid,promotiontype,userid,bgurlforiphonex,updatetime,createtime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_promotion;


--insert overwrite table pro.ods_t_meeting_activity partition(dt)
--select id,name,type,starttime,endtime,extimageurl,signflag,groupflag,creator,createtime,lastupdater,lastupdatetime,recordflag,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_meeting_activity;


insert overwrite table pro.ods_user_concern_dept partition(dt)
select id,deptids,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_user_concern_dept;


insert overwrite table pro.ods_c_doctor_follow partition(dt)
select id,userid,doctorid,createtime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_c_doctor_follow;


insert overwrite table pro.ods_t_faq_user_label partition(dt)
select id,userid,labelid,createtime,updatetime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_t_faq_user_label;

--mysql分区数据迁移

insert overwrite table pro.ods_circle partition(dt)
select id,userid,sortname,name,type,introduction,logo,label,auditing,charge,freetime,invite,haschildren,flag,membercount,mastercount,managercount,createtime,updateuserid,updatetime,masterareaname,mastername,masterspeciality,deptids,deptnames,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_circle;


insert overwrite table pro.ods_circle_member partition(dt)
select id,circleid,userid,permanentfree,status,expirationtime,createtime,updatetime,conversationgroupid,noticestatustime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_circle_member;


insert overwrite table pro.ods_circle_member_role partition(dt)
select id,circleid,userid,role,createtime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_circle_member_role;


insert overwrite table pro.ods_articleInfo partition(dt)
select id,articleid,type,title,creator,source,keywords,year,dbid,directdownload,url,createtime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_articleInfo;


insert overwrite table pro.ods_pay_record partition(dt)
select id,userid,articleinfoid,integral,credit,createtime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_pay_record;


insert overwrite table pro.ods_user_article partition(dt)
select userid,articleinfoid,createtime,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_user_article;


insert overwrite table pro.ods_user_integral partition(dt)
select id,userid,balance,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_user_integral;


--insert overwrite table pro.ods_activity_config partition(dt)
--select id,name,application,ifdispark,status,companyid,begintime,disparktime,participationtype,slogan,sponsorlogo,screenurl,totalintegral,prizewinnertype,prizewinner,highestintegral,lowestintegral,warmuptime,warmupbeforeurl,warmupurl,warmuplaterurl,answerattime,answerastime,answerid,passmark,createtime,createuserid,updateuserid,updatetime,bonusallot,display,leveljson,command,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_activity_config;


--insert overwrite table pro.ods_activity_user partition(dt)
--select id,activityid,userid,marktotal,time,applytime,ifpass,redpacket,questionjson,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_activity_user;


insert overwrite table pro.ods_circle_living_video partition(dt)
select id,rid,circleid,webcastid,coverurl,password,subject,description,number,url,plan,speakerinfo,recordstarttime,recordendtime,size,publishflag,userid,updatetime,createtime,deptid,recommend,recommendtime,noticed,relateactivitycnt,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_circle_living_video;


insert overwrite table pro.ods_circle_living partition(dt)
select id,circleid,webcastid,subject,coverurl,description,number,organizerjoinurl,organizertoken,panelistjoinurl,panelisttoken,attendeejoinurl,attendeetoken,starttime,endtime,plan,speakerinfo,maxattendees,loginrequired,opened,switchclient,realtime,aac,telconf,sec,action,publishflag,deleteflag,issendsms,userid,updatetime,createtime,pushcount,relateactivitycnt,deptid,deptname,recommend,recommendtime,noticed,hallflag,columnname,extdesc,speakerid,concat_ws('-',substr(dt,1,4),substr(dt,5,2),substr(dt,7,2)) as dt from pro.ods_circle_living;

