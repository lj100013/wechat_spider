--运营分析一期中用到的表
--health.b_hospital
--hive映射mongo2hive.health_b_hospital:mongodb中的health.b_hospital
drop table mongo2hive.health_b_hospital;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_b_hospital
(
id string comment "医院id",
name string comment "医院名称",
province string comment "所在省份",
city string comment "所在城市",
country string comment "所在区域",
address string comment "联系地址",
level string comment "医院等级",
status string comment "状态",
lat string comment "医院纬度",
lng string comment "医院经度",
lastUpdatorTime string comment "最后修改时间"
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"name":"name",
"province":"province",
"city":"city",
"country":"country",
"address":"address",
"level":"level",
"status":"status",
"lat":"lat",
"lng":"lng",
"lastUpdatorTime":"lastUpdatorTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.b_hospital?authSource=admin');  

--health.b_hospital_level
--hive映射mongo2hive.health_b_hospital_level:mongodb中的health.b_hospital_level
drop table mongo2hive.health_b_hospital_level;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_b_hospital_level
(
id string comment "医院id",
level string comment "医院等级"
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"level":"level"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.b_hospital_level?authSource=admin');

--health.b_hospitaldept
--hive映射mongo2hive.health_b_hospitaldept:mongodb中的health.b_hospitaldept
drop table mongo2hive.health_b_hospitaldept;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_b_hospitaldept
(
id string comment "科室Id",
name string comment "科室名",
parentId string comment "上级科室",
isLeaf string,
enableStatus string comment "启用状态：1、启动,2、禁用",
dataStatus string comment "数据状态：1、正常,2、冻结",
weight string comment "权重",
tips_key string,
lastUpdatorTime string comment "最后操作时间"
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"name":"name",
"parentId":"parentId",
"isLeaf":"isLeaf",
"enableStatus":"enableStatus",
"dataStatus":"dataStatus",
"weight":"weight",
"tips_key":"tips_key",
"lastUpdatorTime":"lastUpdatorTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.b_hospitaldept?authSource=admin');


--health.user
--hive映射mongo2hive.health_user:mongodb中的health.user
drop table mongo2hive.health_user;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_user
(
id string comment '用户ID',
age string comment '年龄',
sex string comment '性别：男，2女 3 保密',
area string comment '区域',
birthday string comment '生日',
name string comment '姓名',
email string comment '邮箱',
telephone string comment '电话号码',
needResetPassword string comment '是否需要重置密码（true表示是，false表示否）',
password string comment '密码',
remarks string comment '意见',
status string comment '认证状态:正常(即审核通过)/2待审核/3审核未通过/4暂时禁用/5永久禁用/6未激活/7未认证/8离职/9注销 /此处:刚注册status为:7未认证.该字段值为数字.',
userLevel string comment '用户级别 0到期 游客 2临时用户 3认证用户',
userType string comment '用户类型',
giveCoin string comment '是否赠送00学币 第一次认证通过赠送  :已赠送',
headPicFileName string comment '头像名称',
createTime string comment '创建时间',
submitTime string comment '医生提交认证的时间',
lastLoginTime string comment '最后一次登录的时间',
limitedPeriodTime string comment '用户级别有效期',
modifyTime string comment '修改时间',
doctor_province string comment '省份',
doctor_provinceId string comment '职业区域，根据医生审核医院确定',
doctor_city string comment '城市',
doctor_cityId string comment '城市Id',
doctor_area string comment '区域',
doctor_areaId string comment '区域Id',
doctor_departments string comment '所属科室',
doctor_deptId string comment '所属科室Id',
doctor_doctorNum string comment '医生号',
doctor_experience string comment '社会任职',
doctor_expertise ARRAY<string> comment '专长:用户选择的专长',
doctor_hospital string comment '所属医院',
doctor_hospitalId string comment '所属医院Id',
doctor_introduction string comment '个人介绍',
doctor_scholarship string comment '学术成就',
doctor_skill string comment '擅长领域 :用户手工输入的专长',
doctor_title string comment '职称',
doctor_check_checkTime string comment '审核时间',
doctor_check_checker string comment '审核人员',
doctor_check_checkerId string comment '审核人员Id',
doctor_check_departments string comment '审核中的所属科室',
doctor_check_deptId string comment '审核中的所属科室Id',
doctor_check_hospital string comment '审核中的所属医院',
doctor_check_hospitalId string comment '审核中的所属医院Id',
doctor_check_licenseExpire string comment '证书有效期',
doctor_check_licenseNum string comment '证书编号',
doctor_check_remark string comment '审核意见',
doctor_check_title string comment '审核中的职称',
loginLog_isFirstLogin string comment '是否首次登陆（是0否）',
loginLog_location string comment '位置',
loginLog_loginTime string comment '登陆时间',
loginLog_model string comment '',
loginLog_offlineTime string comment '登出时间',
settings_friendsVerify string comment '好友添加验证(改为默认需要验证)',
settings_ispushflag string comment '是否接收通知：正常接收，2不接收',
source_inviterId string comment '邀请人 id',
source_sourceType string comment '用户来源类型',
source_terminal string comment '用戶的端來源',
userConfig_remindVoice string,
suspend string comment '区别于用户审核,挂起或禁用用户（0表示正常状态，1表示挂起状态，4表示暂时禁用状态）',
suspendInfo string comment '禁用相关信息',
passIdRec string comment '人像与身份证识别是否一致',
IDCardName string comment '身份证名字',
IDNum string comment '身份证号码',
sysCheck string comment '系统审核标记 1 系统审核 2或空 人工审核确认 ',
circleId string comment '圈子id',
doctor_titleRank string comment '职称id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"age":"age",
"sex":"sex",
"area":"area",
"birthday":"birthday",
"name":"name",
"email":"email",
"telephone":"telephone",
"needResetPassword":"needResetPassword",
"password":"password",
"remarks":"remarks",
"status":"status",
"userLevel":"userLevel",
"userType":"userType",
"giveCoin":"giveCoin",
"headPicFileName":"headPicFileName",
"createTime":"createTime",
"submitTime":"submitTime",
"lastLoginTime":"lastLoginTime",
"limitedPeriodTime":"limitedPeriodTime",
"modifyTime":"modifyTime",
"doctor_province":"doctor.province",
"doctor_provinceId":"doctor.provinceId",
"doctor_city":"doctor.city",
"doctor_cityId":"doctor.cityId",
"doctor_area":"doctor.country",
"doctor_areaId":"doctor.countryId",
"doctor_departments":"doctor.departments",
"doctor_deptId":"doctor.deptId",
"doctor_doctorNum":"doctor.doctorNum",
"doctor_experience":"doctor.experience",
"doctor_expertise":"doctor.expertise",
"doctor_hospital":"doctor.hospital",
"doctor_hospitalId":"doctor.hospitalId",
"doctor_introduction":"doctor.introduction",
"doctor_scholarship":"doctor.scholarship",
"doctor_skill":"doctor.skill",
"doctor_title":"doctor.title",
"doctor_check_checkTime":"doctor.check.checkTime",
"doctor_check_checker":"doctor.check.checker",
"doctor_check_checkerId":"doctor.check.checkerId",
"doctor_check_departments":"doctor.check.departments",
"doctor_check_deptId":"doctor.check.deptId",
"doctor_check_hospital":"doctor.check.hospital",
"doctor_check_hospitalId":"doctor.check.hospitalId",
"doctor_check_licenseExpire":"doctor.check.licenseExpire",
"doctor_check_licenseNum":"doctor.check.licenseNum",
"doctor_check_remark":"doctor.check.remark",
"doctor_check_title":"doctor.check.title",
"loginLog_isFirstLogin":"loginLog.isFirstLogin",
"loginLog_location":"loginLog.location",
"loginLog_loginTime":"loginLog.loginTime",
"loginLog_model":"loginLog.model",
"loginLog_offlineTime":"loginLog.offlineTime",
"settings_friendsVerify":"settings.friendsVerify",
"settings_ispushflag":"settings.ispushflag",
"source_inviterId":"source.inviterId",
"source_sourceType":"source.sourceType",
"source_terminal":"source.terminal",
"userConfig_remindVoice":"userConfig.remindVoice",
"suspend":"suspend",
"suspendInfo":"suspendInfo",
"passIdRec":"passIdRec",
"IDCardName":"IDCardName",
"IDNum":"IDNum",
"sysCheck":"sysCheck",
"circleId":"source.circleId",
"doctor_titleRank":"doctor.titleRank"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.user?authSource=admin');


--运营分析二期中用到的表
--module.t_faq_question 
--hive映射mongo2hive.module_t_faq_question:mongodb中的module.t_faq_question 
drop table mongo2hive.module_t_faq_question;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_question
(
id string comment 'id',
columnId string,
type string comment '提问类型(1.帖子,2.提问,3.悬赏)',
userId string comment '用户id',
status string comment '状态(1.待审核,2.待支付,3.待回答,4.已解决,5.超时无人应答)',
deleted string comment '是否删除',
labelIds ARRAY<string>,
deptId string comment '帖子所属的科室ID',
sourceId string comment '复制来源',
activityCount string comment '关联的活动数',
open string comment '',
content_terminal  string comment '来源终端',
content_type  string comment '类型 1纯文本 2富文本 3转载 4通用卡片',
content_summary  string comment '摘要',
content_coverUrl  string comment '封面地址',
content_show  string comment '封面是否显示',
content_mainBody  string comment '正文内容',
content_bodyId  string comment '正文内容id, 忽视该值',
content_pics  string comment '图片地址',
content_h5Url  string comment 'h5地址',
content_supplements  ARRAY<string> comment '补充说明',
content_attachments  string comment '附件',
content_freeTime  string comment '免费时长, 单位秒',
content_articleUrl  string comment '转发文章地址',
content_articleTitle  string comment '文章标题',
content_articleIcon  string comment '文章icon',
content_commonCard  string comment '通用卡片数据',
range_all string comment '提问范围,如果是提问未flase',
range_userIds ARRAY<string> comment '被提问人id',
range_deptIds ARRAY<string> comment '被提问圈子id',
payInfo_amount string,
payInfo_payerType string comment '支付人类型(1.personal,2.dept)',
payInfo_payer string,
publish_publisherType string comment '发布者类型 1个人 2科室',
publish_publisher string comment '发布人',
publish_platformType string comment '发布平台类型 1大厅 2圈子',
publish_platformId string comment '平台id 大厅时该值为10000',
check_status string comment '审核状态(1.待审核,2.已审核,3.已删除)',
check_auditor string,
check_updateTime string,
sort string,
stickTopTime string,
orderId string,
bestAnswerIds string,
recommend string ,
grade string comment '内容评级A.B.C.D',
createTime string comment '创建时间',
updateTime string comment '更新时间',
safeLabel string comment '内容安全建议',
gradeSuggest string comment '内容等级建议 A、B、C'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"columnId":"columnId",
"type":"type",
"userId":"userId",
"open":"open",
"content_terminal":"content.terminal",
"content_type":"content.type",
"content_summary":"content.summary",
"content_coverUrl":"content.coverUrl",
"content_show":"content.show",
"content_mainBody":"content.mainBody",
"content_bodyId":"content.bodyId",
"content_pics":"content.pics",
"content_h5Url":"content.h5Url",
"content_supplements":"content.supplements",
"content_attachments":"content.attachments",
"content_freeTime":"content.freeTime",
"content_articleUrl":"content.articleUrl",
"content_articleTitle":"content.articleTitle",
"content_articleIcon":"content.articleIcon",
"content_commonCard":"content.commonCard",
"range_all":"range.all",
"range_userIds":"range.userIds",
"range_deptIds":"range.deptIds",
"status":"status",
"deleted":"deleted",
"payInfo_amount":"payInfo.amount",
"payInfo_payerType":"payInfo.payerType",
"payInfo_payer":"payInfo.payer",
"labelIds":"labelIds",
"publish_publisherType":"publish.publisherType",
"publish_publisher":"publish.publisher",
"publish_platformType":"publish.platformType",
"publish_platformId":"publish.platformId",
"check_status":"check.status",
"check_auditor":"check.auditor",
"check_updateTime":"check.updateTime",
"sort":"sort",
"stickTopTime":"stickTopTime",
"deptId":"deptId",
"orderId":"orderId",
"bestAnswerIds":"bestAnswerIds",
"sourceId":"sourceId",
"activityCount":"activityCount",
"recommend":"recommend",
"grade":"grade",
"createTime":"createTime",
"updateTime":"updateTime",
"safeLabel":"safeLabel",
"gradeSuggest":"gradeSuggest"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_question?authSource=admin');  


--module.t_faq_label
--hive映射mongo2hive.module_t_faq_label:mongodb中的module.t_faq_label
drop table mongo2hive.module_t_faq_label;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_label
(
id string comment '话题id',
name string comment '话题名',
usageCount string comment '话题数目',
createTime string comment '创建时间',
updateTime string comment '修改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"name":"name",
"usageCount":"usageCount",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_label?authSource=admin'); 


--module.t_faq_reply
--hive映射mongo2hive.module_t_faq_reply:mongodb中的module.t_faq_reply
drop table mongo2hive.module_t_faq_reply;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_reply
(
id string comment 'id',
userId string comment '用户id',
userName string comment '用户名',
type string comment '回复类型（1、回复问题,2、回复评论,3、回复回复）',
questionId string,
questionType string,
mainReplyId string,
toUserId string,
toUserName string,
replyId string,
status string comment '回复状态（1、正常,2、删除）',
bestAnswer string,
stickTopTime string comment '置顶时间',
likeCount string,
createTime string comment '创建时间',
updateTime string comment '修改时间',
content_type string comment '类型 1纯文本 2富文本 3转载 4通用卡片',
content_summary string comment '摘要',
content_mainBody string comment '正文内容',
content_bodyId string comment '正文内容id, 忽视该值',
content_freeTime string comment '免费时长, 单位秒',
check_status string comment '审核状态(1.待审核,2.已审核,3.已删除)',
check_auditor string,
check_updateTime string,
content_pics ARRAY<string> comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"userName":"userName",
"type":"type",
"questionId":"questionId",
"questionType":"questionType",
"mainReplyId":"mainReplyId",
"toUserId":"toUserId",
"toUserName":"toUserName",
"replyId":"replyId",
"status":"status",
"bestAnswer":"bestAnswer",
"stickTopTime":"stickTopTime",
"likeCount":"likeCount",
"createTime":"createTime",
"updateTime":"updateTime",
"content_type":"content.type",
"content_summary":"content.summary",
"content_mainBody":"content.mainBody",
"content_bodyId":"content.bodyId",
"content_freeTime":"content.freeTime",
"check_status":"check.status",
"check_auditor":"check.auditor",
"check_updateTime":"check.updateTime",
"content_pics":"content.pics"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_reply?authSource=admin');  


--module.t_faq_data_count
--hive映射mongo2hive.module_t_faq_data_count:mongodb中的module.t_faq_data_count
drop table mongo2hive.module_t_faq_data_count;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_data_count
(
id string comment 'id',
dataType string,
dataId string,
viewCount string comment '付费查看量',
rewardCount string,
likeCount string,
replyCount string,
readingCount string comment '帖子的查看量,点击就算的那种',
class string comment '包名类名'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"dataType":"dataType",
"dataId":"dataId",
"viewCount":"viewCount",
"rewardCount":"rewardCount",
"likeCount":"likeCount",
"replyCount":"replyCount",
"readingCount":"readingCount",
"class":"_class"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_data_count?authSource=admin');  



--module.t_faq_mainBody
--hive映射mongo2hive.module_t_faq_mainBody:mongodb中的module.t_faq_mainBody
drop table mongo2hive.module_t_faq_mainBody;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_mainBody
(
id string comment 'id',
body string,
createTime string comment '创建时间',
updateTime string comment '修改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"body":"body",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_mainBody?authSource=admin');




--module.t_faq_ad_reply
--hive映射mongo2hive.module_t_faq_ad_reply:mongodb中的module.t_faq_ad_reply
drop table mongo2hive.module_t_faq_ad_reply;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_ad_reply
(
id string comment 'id',
userId string comment '回复id',
type string comment '回复类型（1、回复问题,2、回复评论,3、回复回复）',
materialId string,
materialType string,
mainReplyId string comment '主评论ID',
toUserId string comment '给谁回复',
parentReplayId string comment '父回复id',
content string comment '回复内容',
status string comment '回复状态 1、正常,2、删除',
likeCount string comment '点赞数量',
replyCount string comment '回复数量',
rewardCount string comment '打赏数量',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"type":"type",
"materialId":"materialId",
"materialType":"materialType",
"mainReplyId":"mainReplyId",
"toUserId":"toUserId",
"parentReplayId":"parentReplayId",
"content":"content",
"picUrls":"picUrls",
"status":"status",
"likeCount":"likeCount",
"replyCount":"replyCount",
"rewardCount":"rewardCount",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_ad_reply?authSource=admin');  


--module.t_faq_column
--hive映射mongo2hive.module_t_faq_column:mongodb中的module.t_faq_column
drop table mongo2hive.module_t_faq_column;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_column
(
id string comment 'id',
name string comment '栏目名称	',
weight string comment '权重排序',
owner string comment '归属,如圈子id',
createTime string comment '创建时间',
updateTime string comment '修改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"name":"name",
"weight":"weight",
"owner":"owner",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_column?authSource=admin');  



--module.t_faq_like
--hive映射mongo2hive.module_t_faq_like:mongodb中的module.t_faq_like
drop table mongo2hive.module_t_faq_like;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_like
(
id string comment 'id',
userId string comment '用户id',
dataId string comment '',
type string comment '1对问题点赞2对评论点赞',
createTime string comment '创建时间',
updateTime string comment '修改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"dataId":"dataId",
"type":"type",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_like?authSource=admin');  



--diseasediscuss.disease_info
--hive映射mongo2hive.diseasediscuss_disease_info:mongodb中的diseasediscuss.disease_info
drop table mongo2hive.diseasediscuss_disease_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.diseasediscuss_disease_info
(
id string comment 'id',
circleId string comment '圈子Id',
type string comment '病理类型',
userId string comment '创建人',
userName string comment '用户名',
userHeadPic string comment '用户图片地址',
userAcademicTitle string comment '用户职称',
userHospital string comment '用户所在医院',
userDept string comment '用户科室',
createTime string comment '创建时间',
status string comment '状态标识',
labelList ARRAY<STRUCT<id:string,name:string>> comment '病例标签',
shareUrl string,
title string,
deptId string comment '科室Id',
recommend string comment '是否推荐到大厅（默认否）',
recommendTime string comment '推荐时间',
relateActivityCnt string comment '关联活动数量',
from_ string comment '病例发布来源',
diseaseFrom string comment '病例来源',
check string comment '平台管理员是否审核 未审核-null 审核-true',
hide string comment '平台管理员是否屏蔽该内容 未屏蔽-null 屏蔽-true',
authCircleId string comment '圈子的ID',
authCircleName string comment '圈子的名称',
authCircleLogoUrl string comment '圈子的Logo图片路径',
publisherType string comment '发布身份类型 1 个人  2 圈子身份发布',
isprivate string comment '1私密话题0非私密话题',
grade string comment '内容评级A.B.C.D',
hall string comment '是否大厅发布，老版本不存在该字段，仅大厅发布的保存',
safeLabel string comment '内容安全建议',
gradeSuggest string comment '内容等级建议 A、B、C',
admindel string comment '管理员删除'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"circleId":"circleId",
"type":"type",
"userId":"userId",
"userName":"userName",
"userHeadPic":"userHeadPic",
"userAcademicTitle":"userAcademicTitle",
"userHospital":"userHospital",
"userDept":"userDept",
"createTime":"createTime",
"status":"status",
"labelList":"labelList",
"shareUrl":"shareUrl",
"title":"title",
"deptId":"deptId",
"recommend":"recommend",
"recommendTime":"recommendTime",
"relateActivityCnt":"relateActivityCnt",
"from_":"from",
"diseaseFrom":"diseaseFrom",
"check":"check",
"hide":"hide",
"authCircleId":"authCircleId",
"authCircleName":"authCircleName",
"authCircleLogoUrl":"authCircleLogoUrl",
"publisherType":"publisherType",
"isprivate":"isprivate",
"grade":"grade",
"hall":"hall",
"safeLabel":"safeLabel",
"gradeSuggest":"gradeSuggest",
"adminDel:adminDel"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/diseasediscuss.disease_info?authSource=admin'); 




--diseasediscuss.disease_question
--hive映射mongo2hive.diseasediscuss_disease_question:mongodb中的diseasediscuss.disease_question
drop table mongo2hive.diseasediscuss_disease_question;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.diseasediscuss_disease_question
(
id string comment 'id',
questionId string,
diseaseId string,
questionTitle string comment '问题标题',
questionType string comment '问题类型（1选择题2问答题）',
createTime string comment '创建时间',
statusFlag string,
userId string comment '创建人',
userName string comment '用户名',
userHeadPic string comment '用户图片地址',
userAcademicTitle string comment '用户职称',
userHospital string comment '用户所在医院',
userDept string comment '用户科室'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"questionId":"questionId",
"diseaseId":"diseaseId",
"questionTitle":"questionTitle",
"questionType":"questionType",
"createTime":"createTime",
"statusFlag":"statusFlag",
"userId":"userId",
"userName":"userName",
"userHeadPic":"userHeadPic",
"userAcademicTitle":"userAcademicTitle",
"userHospital":"userHospital",
"userDept":"userDept"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/diseasediscuss.disease_question?authSource=admin'); 




--活动-用户行为中用到的表
--online-marketing.t_promotion
--hive映射mongo2hive.online_marketing_t_promotion:mongodb中的online-marketing.t_promotion
drop table mongo2hive.online_marketing_t_promotion;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.online_marketing_t_promotion
(
id string comment 'id',
title string comment '名称',
status string comment '状态 1-已上架  2-已下架 3-草稿 4-手动过期',
templateId string comment '基础配置:关联的模板',
template string comment '模版配置信息',
promotionItemList ARRAY<string> comment '推广项具体模块:可以包含串场词+视频+调查表+红包的自由组合',
relateActivityCnt string comment '关联活动数量',
drugCompanyId string comment '药企ID(如果是药企圈则此参数必填)',
promotionType string comment '推广会类型 1-药企圈推广会 2-医生圈推广会',
userId string comment '当前操作人id',
forwardRule string comment '跳转页面的规则',
userName string comment '创建人名称',
from1 string comment '来自哪个平台 1：运营平台 2：药企圈',
shareCode string comment '推广会分享码',
linkId string comment '被关联id',
linkType string comment '被关联类型 meeting会议管理 activity活动',
scheduledTime string comment '预计时长 秒数',
updateTime string comment '修改时间',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"title":"title",
"status":"status",
"templateId":"templateId",
"template":"template",
"promotionItemList":"promotionItemList",
"relateActivityCnt":"relateActivityCnt",
"drugCompanyId":"drugCompanyId",
"promotionType":"promotionType",
"userId":"userId",
"forwardRule":"forwardRule",
"userName":"userName",
"from1":"from",
"shareCode":"shareCode",
"linkId":"linkId",
"linkType":"linkType",
"scheduledTime":"scheduledTime",
"updateTime":"updateTime",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/online-marketing.t_promotion?authSource=admin'); 





--activity.t_meeting_activity
--hive映射mongo2hive.activity_t_meeting_activity:mongodb中的activity.t_meeting_activity
drop table mongo2hive.activity_t_meeting_activity;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_meeting_activity
(
id string comment 'id',
name string comment '会议的名称',
type string comment '会议的类型',
startTime string comment '会议的开始时间',
endTime string comment '会议的结束时间',
extImageUrl string comment '宣传图',
signFlag string comment '1--会议必须签到 缺省0',
groupFlag string comment '1--可以创建讨论组 缺省0不创建',
creator string comment '创建人',
createTime string comment '创建时间',
lastUpdater string comment '最后修改人',
lastUpdateTime string comment '最后修改时间',
recordFlag string comment '0--草稿 1--发布 2--结束'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"name":"name",
"type":"type",
"startTime":"startTime",
"endTime":"endTime",
"extImageUrl":"extImageUrl",
"signFlag":"signFlag",
"groupFlag":"groupFlag",
"creator":"creator",
"createTime":"createTime",
"lastUpdater":"lastUpdater",
"lastUpdateTime":"lastUpdateTime",
"recordFlag":"recordFlag"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_meeting_activity?authSource=admin'); 





--推荐系统中用到的表
--health.user_concern_dept
--hive映射mongo2hive.health_user_concern_dept:mongodb中的health.user_concern_dept
drop table mongo2hive.health_user_concern_dept;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_user_concern_dept
(
id string comment '医生id',
deptIds ARRAY<string> comment '关注科室(领域)id列表'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"deptIds":"deptIds"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.user_concern_dept?authSource=admin'); 



--health.c_doctor_follow
--hive映射mongo2hive.health_c_doctor_follow:mongodb中的health.c_doctor_follow
drop table mongo2hive.health_c_doctor_follow;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_c_doctor_follow
(
id string comment 'id',
userId string comment '用户id',
doctorId string comment '被关注人id',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"doctorId":"doctorId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.c_doctor_follow?authSource=admin'); 





--module.t_faq_user_label
--hive映射mongo2hive.module_t_faq_user_label:mongodb中的module.t_faq_user_label
drop table mongo2hive.module_t_faq_user_label;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_user_label
(
id string comment 'id',
userId string comment '用户id',
labelId string comment '话题id',
createTime string  comment '创建时间',
updateTime string  comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"labelId":"labelId",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_user_label?authSource=admin'); 



----用户活动行为分析：视频帖
----mongo2hive.activity_t_promotion_activity
--drop table mongo2hive.activity_t_promotion_activity;
--CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_promotion_activity
--(
--id string comment '活动id',
--name string comment '活动名',
--rule_surveyId string comment '调查表id',
--rule_surveyName string comment '调查表名'
--)
--STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
--WITH SERDEPROPERTIES('mongo.columns.mapping'='{
--"id":"_id",
--"name":"name",
--"rule_surveyId":"rule.surveyId",
--"rule_surveyName":"rule.surveyName"
--}')
--TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_promotion_activity?authSource=admin');



--用户活跃分析新增（20180531）
--会议活动
--activity.t_meeting_activity_sign
--hive映射mongo2hive.activity_t_meeting_activity_sign:mongodb中的activity.t_meeting_activity_sign
drop table mongo2hive.activity_t_meeting_activity_sign;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_meeting_activity_sign
(
id string  comment 'Id',
businessId string  comment '会议的Id',
type string  comment '会议人员类型YSQ还是YQQ',
userId string  comment '参会人userId',
userJson string  comment '参会人简单json信息',
signTime string  comment '签到时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"businessId":"businessId",
"type":"type",
"userId":"userId",
"userJson":"userJson",
"signTime":"signTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_meeting_activity_sign?authSource=admin'); 


--网络推广会
--online-marketing.t_promotion_view
--hive映射mongo2hive.online_marketing_t_promotion_view:mongodb中的online-marketing.t_promotion_view
drop table mongo2hive.online_marketing_t_promotion_view;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.online_marketing_t_promotion_view
(
id string  comment 'id',
userId string  comment '用户id',
promotionId string  comment '推广会id',
createTime string  comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"promotionId":"promotionId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/online-marketing.t_promotion_view?authSource=admin'); 



--微学堂
--micro-school.t_course
--hive映射mongo2hive.micro_school_t_course:mongodb中的micro-school.t_course
drop table mongo2hive.micro_school_t_course;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_course
(
id string  comment '课程id',
classId string  comment '讲堂id',
ownerId string  comment '讲师id',
theme string  comment '课程主题',
createTime string  comment '创建时间',
beginTime string  comment '开始时间',
form string  comment '课程形式 0-幻灯片形式 1-聊天形式',
type string  comment '课程类型 0-公开课 1-收费课',
creator string  comment '创建者',
status string  comment '课程状态,0草稿1发布9结束',
publishType string  comment '课程发布类型,0全员公开,1指定圈子范围,2讲师所在科室',
publishRangeDesc string  comment '',
coverImgUrl string  comment '课程封面图',
introduce string  comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"classId":"classId",
"ownerId":"ownerId",
"theme":"theme",
"createTime":"createTime",
"beginTime":"beginTime",
"form":"form",
"type":"type",
"creator":"creator",
"status":"status",
"publishType":"publishType",
"publishRangeDesc":"publishRangeDesc",
"coverImgUrl":"coverImgUrl",
"introduce":"introduce"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_course?authSource=admin'); 


--micro-school.t_course_entry
--hive映射mongo2hive.micro_school_t_course_entry:mongodb中的micro-school.t_course_entry
drop table mongo2hive.micro_school_t_course_entry;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_course_entry
(
id string  comment 'id',
classId string  comment '讲堂id',
courseId string  comment '课程id',
ownerId string  comment '讲师id',
userId string  comment '报名人',
applyTime string  comment '申请时间',
applyStatus string  comment '',
applyFrom string  comment '申请平台'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"classId":"classId",
"courseId":"courseId",
"ownerId":"ownerId",
"userId":"userId",
"applyTime":"applyTime",
"applyStatus":"applyStatus",
"applyFrom":"applyFrom"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_course_entry?authSource=admin'); 


--线上会议
--health.t_meeting
--hive映射mongo2hive.health_t_meeting:mongodb中的health.t_meeting
drop table mongo2hive.health_t_meeting;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting
(
id string  comment 'id',
company string  comment '公司',
companyId string  comment '公司id',
subject string  comment '',
startDate string  comment '开始日期',
startTime string  comment '开始时间',
endTime string  comment '结束时间',
attendeesCount string  comment '观看人数',
price string  comment '',
organizerToken string  comment '组织者加入直播口令',
panelistToken string  comment '嘉宾加入直播口令',
attendeeToken string  comment '普通参加者加入直播口令',
organizerJoinUrl string  comment '组织者加入URL',
panelistJoinUrl string  comment '嘉宾加入URL',
attendeeJoinUrl string  comment '普通参加者加入URL',
liveId string  comment '直播id',
number string  comment '',
isStop string  comment '是否取消或结束（0：未取消{默认}，1：已取消或结束）',
updateTime string  comment '更新时间',
createUserId string  comment '创建者ID'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"company":"company",
"companyId":"companyId",
"subject":"subject",
"startDate":"startDate",
"startTime":"startTime",
"endTime":"endTime",
"attendeesCount":"attendeesCount",
"price":"price",
"organizerToken":"organizerToken",
"panelistToken":"panelistToken",
"attendeeToken":"attendeeToken",
"organizerJoinUrl":"organizerJoinUrl",
"panelistJoinUrl":"panelistJoinUrl",
"attendeeJoinUrl":"attendeeJoinUrl",
"liveId":"liveId",
"number":"number",
"isStop":"isStop",
"updateTime":"updateTime",
"createUserId":"createUserId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting?authSource=admin'); 


--health.t_meeting_joinrecord
--hive映射mongo2hive.health_t_meeting_joinrecord:mongodb中的health.t_meeting_joinrecord
drop table mongo2hive.health_t_meeting_joinrecord;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_joinrecord
(
id string comment 'id',
meetingId string comment '会议id',
sysUpdateLeave string comment '系统更新的离开',
class string comment '包名类名',
joinRole string comment '加入角色',
appVersion string comment 'app版本',
joinUserId string comment '加入用户id',
joinNumber string comment '加入时在线听众数',
appName string comment 'app名',
meetingNumber string comment '会议号',
phoneType string comment 'ios/android/pc',
joinTime string comment '加入时间',
leaveTime string comment '离开时间',
createTime string comment '创建时间',
visitIp string comment '访问的Ip'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"joinTime":"joinTime",
"sysUpdateLeave":"sysUpdateLeave",
"class":"_class",
"leaveTime":"leaveTime",
"joinRole":"joinRole",
"appVersion":"appVersion",
"joinUserId":"joinUserId",
"joinNumber":"joinNumber",
"appName":"appName",
"meetingNumber":"meetingNumber",
"phoneType":"phoneType",
"createTime":"createTime",
"visitIp":"visitIp"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_joinrecord?authSource=admin'); 


--微学堂详情
--micro-school.t_comment
--hive映射mongo2hive.micro_school_t_comment:mongodb中的micro-school.t_comment
drop table mongo2hive.micro_school_t_comment;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_comment
(
id string  comment 'id',
classId string comment '讲堂id',
courseId string comment '课程id',
ownerId string comment '讲师id',
content_msgType string comment '消息类型:0=文本,1=语音,2=图片,3=文件,4=视频,5=回复(文本),6=回复(语音)',
content_text string comment '消息内容',
sendUserId string comment '发送消息的用户id',
sendTime string comment '发送时间',
clientMsgId string comment '客户端发送消息时，可以预先生产一个id，用以处理发送失败时候的重发逻辑',
clientAppId string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"classId":"classId",
"courseId":"courseId",
"ownerId":"ownerId",
"content_msgType":"content.msgType",
"content_text":"content.text",
"sendUserId":"sendUserId",
"sendTime":"sendTime",
"clientMsgId":"clientMsgId",
"clientAppId":"clientAppId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_comment?authSource=admin'); 



--micro-school.t_courseware
--hive映射mongo2hive.micro_school_t_courseware:mongodb中的micro-school.t_courseware
drop table mongo2hive.micro_school_t_courseware;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_courseware
(
id string comment 'id',
courseId string comment '课程ID',
type string comment '课件类型 0-文本 1-语音 2-图片 3-文件 4-视频',
url string comment '课件url',
name string comment '课件名称',
pageNumber string comment '页码',
deleted string comment '删除标记 1-删除 0-正常'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"courseId":"courseId",
"type":"type",
"url":"url",
"name":"name",
"pageNumber":"pageNumber",
"deleted":"deleted"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_courseware?authSource=admin'); 





--micro-school.t_pre_message
--hive映射mongo2hive.micro_school_t_pre_message:mongodb中的micro-school.t_pre_message
drop table mongo2hive.micro_school_t_pre_message;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_pre_message
(
id string comment 'id',
classId string comment '讲堂id',
courseId string comment '课程id',
ownerId string comment '课程所属用户id',
content_msgType string comment '消息类型:0=文本,1=语音,2=图片,3=文件,4=视频,5=回复(文本),6=回复(语音)',
content_voice string comment '音频消息',
content_text string comment '文本内容【文本消息，回复消息的回复内容】',
content_pic string comment '图片消息',
content_video string comment '视频消息',
content_file string comment '文件消息',
coursewareId string comment '关联的课件id',
pageNum string comment '关联的课件页码数',
createTime string comment '创建时间',
creator string comment '创建者',
sendStatus string comment '发送状态：0=待发送，1=已发送',
clientAppId string comment '',
sendTime string comment '发送时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"classId":"classId",
"courseId":"courseId",
"ownerId":"ownerId",
"content_msgType":"content.msgType",
"content_voice":"content.voice",
"content_text":"content.text",
"content_pic":"content.pic",
"content_video":"content.video",
"content_file":"content.file",
"coursewareId":"coursewareId",
"pageNum":"pageNum",
"createTime":"createTime",
"creator":"creator",
"sendStatus":"sendStatus",
"clientAppId":"clientAppId",
"sendTime":"sendTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_pre_message?authSource=admin'); 











--diseasediscuss.expert_comment
--hive映射mongo2hive.diseasediscuss_expert_comment:mongodb中的diseasediscuss.expert_comment
drop table mongo2hive.diseasediscuss_expert_comment;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.diseasediscuss_expert_comment
(
id string comment 'id',
questionId string comment '问题id',
type string comment '专家点评类型 0-专家病例点评 1-专家问题点评2-作者追加评论',
commentUser string comment '评论人',
commentId string comment '评论id',
diseaseId string comment '病例id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"questionId":"questionId",
"type":"type",
"commentUser":"commentUser",
"commentId":"commentId",
"diseaseId":"diseaseId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/diseasediscuss.expert_comment?authSource=admin'); 


--diseasediscuss.expert_reward
--hive映射mongo2hive.diseasediscuss_expert_reward:mongodb中的diseasediscuss.expert_reward
drop table mongo2hive.diseasediscuss_expert_reward;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.diseasediscuss_expert_reward
(
id string comment 'id',
diseaseId string comment '病例id',
userId string comment '打赏人',
rewardUserId string comment '被打赏人',
rewardType string comment '打赏类型',
rewardNumber string comment '打赏打赏数量',
createTime string comment '记录创建时间',
orderId string comment '',
commentId string comment '',
rewardTime string comment '打赏时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"diseaseId":"diseaseId",
"userId":"userId",
"rewardUserId":"rewardUserId",
"rewardType":"rewardType",
"rewardNumber":"rewardNumber",
"createTime":"createTime",
"orderId":"orderId",
"commentId":"commentId",
"rewardTime":"rewardTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/diseasediscuss.expert_reward?authSource=admin');



--module.t_faq_business_detail
--hive映射mongo2hive.module_t_faq_business_detail:mongodb中的module.t_faq_business_detail
drop table mongo2hive.module_t_faq_business_detail;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_business_detail
(
id string comment 'id',
userId string comment '',
type string comment '',
value string comment '',
dataType string comment '',
dataId string comment '',
replyId string comment '',
rewardedUserId string comment '被打赏的用户Id',
createTime string comment '创建时间',
updateTime string comment '修改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"type":"type",
"value":"value",
"dataType":"dataType",
"dataId":"dataId",
"replyId":"replyId",
"rewardedUserId":"rewardedUserId",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_business_detail?authSource=admin');




--新直播会议
--health.t_meeting_info
--hive映射mongo2hive.health_t_meeting_info:mongodb中的health.t_meeting_info
drop table mongo2hive.health_t_meeting_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_info
(
id string comment 'id',
class string comment '包名+类名',
name string comment '会议名称',
meetingNumber string comment '会议号',
beginTime string comment '会议开始时间',
endTime string comment '会议结束时间',
comperes string comment '嘉宾列表',
audiences string comment '邀请听众列表',
joinType string comment '入会模式',
publicType string comment '公开类型',
meetingModel string comment '会议模式',
status string comment '会议状态',
creatorId string comment '创建人id',
createTime string comment '创建时间',
createFrom string comment '创建来源',
agoraRtcVideoProfile string comment '分辨率，默认720P',
shareFiles string comment '文档的地址列表',
speakerId string comment '主讲人id',
speakerName string comment '主讲人名称',
speakerIntroImg string comment '主讲人简介图片',
intro string comment '会议简介',
planDesc string comment '会议议程',
imgCover string comment '会议封面',
realBeginTime string comment '真正的开始时间',
realEndTime string comment '真正的结束时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"class":"_class",
"name":"name",
"meetingNumber":"meetingNumber",
"beginTime":"beginTime",
"endTime":"endTime",
"comperes":"comperes",
"audiences":"audiences",
"joinType":"joinType",
"publicType":"publicType",
"meetingModel":"meetingModel",
"status":"status",
"creatorId":"creatorId",
"createTime":"createTime",
"createFrom":"createFrom",
"agoraRtcVideoProfile":"agoraRtcVideoProfile",
"shareFiles":"shareFiles",
"speakerId":"speakerId",
"speakerName":"speakerName",
"speakerIntroImg":"speakerIntroImg",
"intro":"intro",
"planDesc":"planDesc",
"imgCover":"imgCover",
"realBeginTime":"realBeginTime",
"realEndTime":"realEndTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_info?authSource=admin');




--视频会议
--health.t_meeting_detail
--hive映射mongo2hive.health_t_meeting_detail:mongodb中的health.t_meeting_detail
drop table mongo2hive.health_t_meeting_detail;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_detail
(
id string comment 'id',
class string comment '包名+类名',
channelId string comment '房间号',
inviter string comment '邀请者',
invitees string comment '被邀请者',
inviteTime string comment '邀请时间',
joinTime string comment '加入时间',
exitTime string comment '退出时间',
joinWay string comment '加入方式，主动active，被动passive，主动，从悬浮条主动点击加入，被动，别人邀请点击接受加入'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"class":"_class",
"channelId":"channelId",
"inviter":"inviter",
"invitees":"invitees",
"inviteTime":"inviteTime",
"joinTime":"joinTime",
"exitTime":"exitTime",
"joinWay":"joinWay"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_detail?authSource=admin');




--电话会议
--health.t_phone_conference
--hive映射mongo2hive.health_t_phone_conference:mongodb中的health.t_phone_conference
drop table mongo2hive.health_t_phone_conference;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_phone_conference
(
id string comment 'id',
creater string comment '发起者',
createTime string comment '会议开始时间',
endTime string comment '会议实际结束时间',
channelId string comment '会议频道ID',
recordUrl string comment '会议录音地址',
status string comment '会议状态',
gid string comment 'IM会话组id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"creater":"creater",
"createTime":"createTime",
"endTime":"endTime",
"channelId":"channelId",
"recordUrl":"recordUrl",
"status":"status",
"gid":"gid"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_phone_conference?authSource=admin');





--电话会议
--health.t_phone_conference_record
--hive映射mongo2hive.health_t_phone_conference_record:mongodb中的health.t_phone_conference_record
drop table mongo2hive.health_t_phone_conference_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_phone_conference_record
(
id string comment 'id',
crId string comment '会议ID',
memberId string comment '参会成员Id',
joinTime string comment '加入时间',
unJoinTime string comment '退出时间',
isNow string comment '是否当前纪录'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"crId":"crId",
"memberId":"memberId",
"joinTime":"joinTime",
"unJoinTime":"unJoinTime",
"isNow":"isNow"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_phone_conference_record?authSource=admin');



--视频会议
--health.t_meeting_record
--hive映射mongo2hive.health_t_meeting_record:mongodb中的health.t_meeting_record
drop table mongo2hive.health_t_meeting_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_record
(
id string comment 'id',
class string comment '包名+类名',
sponsor string comment '会议发起人',
startTime string comment '会议开始时间',
channelId string comment '会议房间号',
meetingType string comment '会议类型（1=视频会议；2=音频会议）',
gid string comment '会话组ID',
endTime string comment '会议结束时间',
ender string comment '会议结束者',
recordUrl string comment '录音地址'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"class":"_class",
"sponsor":"sponsor",
"startTime":"startTime",
"channelId":"channelId",
"meetingType":"meetingType",
"gid":"gid",
"endTime":"endTime",
"ender":"ender",
"recordUrl":"recordUrl"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_record?authSource=admin');


--运营分析三期
--消费内容
--module.t_faq_report
--hive映射mongo2hive.module_t_faq_report:mongodb中的module.t_faq_report
drop table mongo2hive.module_t_faq_report;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_report
(
id string,
userId string,
dataId string,
dataType string,
reason string,
status string,
auditor string,
auditorTime string,
createTime string,
updateTime string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"dataId":"dataId",
"dataType":"dataType",
"reason":"reason",
"status":"status",
"auditor":"auditor",
"auditorTime":"auditorTime",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_report?authSource=admin');



--module.t_faq_shareUrl
--hive映射mongo2hive.module_t_faq_shareUrl:mongodb中的module.t_faq_shareUrl
drop table mongo2hive.module_t_faq_shareUrl;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_shareUrl
(
id string,
url string,
title string,
cover string,
`desc` string,
documentUrl string,
createTime string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"url":"url",
"title":"title",
"cover":"cover",
"desc":"desc",
"documentUrl":"documentUrl",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_shareUrl?authSource=admin');



--module.t_faq_favorites
--hive映射mongo2hive.module_t_faq_favorites:mongodb中的module.t_faq_favorites
drop table mongo2hive.module_t_faq_favorites;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_favorites
(
id string,
userId string,
type string,
dataId string,
labels string,
createTime string,
updateTime string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"type":"type",
"dataId":"dataId",
"labels":"labels",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_favorites?authSource=admin');



--module.t_credit_record
--hive映射mongo2hive.module_t_credit_record:mongodb中的module.t_credit_record
drop table mongo2hive.module_t_credit_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_credit_record
(
id  string comment 'id',
accountType  string comment '积分账户类型0 平台、1 个人、2 企业、3 科室',
accountId  string comment '积分账户的id',
value  string comment '变化值',
direction string comment 'in/out',
currentBalance  string comment '当前剩余学币',
businesscode string comment '业务码',
businessid string comment '业务id',
transid string comment '交易标识id',
remark  string comment '备注',
reason  string comment '原因',
creater  string comment '创建人',
orderId  string comment '订单号',
businessType  string comment '个类型信息，后面应该又学币自己定义某个值，然后进行配，81 双旦限时认证活动奖励，82 双旦摇一摇活动奖励，10 商城消费学币，11 万方内部接口消费学币，12 运营平台调整用户学币，13 运营平台调整圈子学币，14 红鸟网络科技集成游戏，15 用户通过活动推广领取学币，16 用户通过医生圈创建的周周乐互动领取学币，17 用户通过药企圈创建的推广活动获得学币(直接增加用户学币并写用户流水)，18 用户通过玄关创建的活动领取学币',
returnId  string comment '该字段用于多次退还用户学币',
eventId  string comment '',
callbackUrl  string comment '回调使用的URL',
callbackStatus  string comment '回调状态1表示成功，0表示失败',
callbackTime  string comment '回调时间',
callbackCount  string comment '回调次数',
createTime  string comment '创建时间',
updateTime  string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"accountType":"accountType",
"accountId":"accountId",
"value":"value",
"direction":"direction",
"currentBalance":"currentBalance",
"businesscode":"businesscode",
"businessid":"businessid",
"transid":"transid",
"remark":"remark",
"reason":"reason",
"creater":"creater",
"orderId":"orderId",
"businessType":"businessType",
"returnId":"returnId",
"eventId":"eventId",
"callbackUrl":"callbackUrl",
"callbackStatus":"callbackStatus",
"callbackTime":"callbackTime",
"callbackCount":"callbackCount",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_record?authSource=admin');




--circledaq.circle_operation_log
--hive映射mongo2hive.circledaq_circle_operation_log:mongodb中的circledaq.circle_operation_log
drop table mongo2hive.circledaq_circle_operation_log;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.circledaq_circle_operation_log
(
id  string comment 'id',
type  string comment '操作类型',
userId  string comment '用户id',
circleId  string comment '圈子id',
createTime  string comment '创建时间',
`date`  string comment '日期 年-月-日'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"type":"type",
"userId":"userId",
"circleId":"circleId",
"createTime":"createTime",
"date":"date"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/circledaq.circle_operation_log?authSource=admin');


--网络推广会红包
--online-marketing.t_redPaper_record
--hive映射mongo2hive.online_marketing_t_redPaper_record:mongodb中的online-marketing.t_redPaper_record
drop table mongo2hive.online_marketing_t_redPaper_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.online_marketing_t_redPaper_record
(
id string comment 'id',
promotionId string comment '推广会ID',
redPaperId string comment '红包ID',
userId string comment '用户ID',
userName string comment '用户姓名',
amount string comment '领取数额 >0  中奖 , <=0其他情况',
haveDone string comment '是否参加',
drugOrCircle string comment '1-医生圈 2-药企圈',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"promotionId":"promotionId",
"redPaperId":"redPaperId",
"userId":"userId",
"userName":"userName",
"amount":"amount",
"haveDone":"haveDone",
"drugOrCircle":"drugOrCircle",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/online-marketing.t_redPaper_record?authSource=admin');




--网络推广会调查表
--health.t_survey_answer
--hive映射mongo2hive.health_t_survey_answer:mongodb中的health.t_survey_answer
drop table mongo2hive.health_t_survey_answer;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_survey_answer
(
id string comment '答题id',
userId string comment '用户id',
status string comment '调查表状态，0无效，1有效，9已删除',
createTime string comment '创建时间',
createUserId string comment '创建者id',
appName string comment '应用来源->FAQ：医生圈, material：药企圈',
surveyId string comment '调查表id',
surveyTitle string comment '调查表名称',
surveyDesc string comment '指导语',
surveyUnionId string comment '调查表联合ID，因为调查表是可以更新的,每次更新,就是一份新的调查表,此时有个版本号,会自动+1,而unionId用于标识不同版本的调查表其实是从一个调查表演进过来的',
surveyVersion string comment '调查表版本，当编辑时，版本会加1',
type string comment '类型->0和空:普通、1：附加题',
activeUserId string comment '',
activeTime string comment '',
answerList string comment '答题列表'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"status":"status",
"createTime":"createTime",
"createUserId":"createUserId",
"appName":"appName",
"surveyId":"surveyId",
"surveyTitle":"surveyTitle",
"surveyDesc":"surveyDesc",
"surveyUnionId":"surveyUnionId",
"surveyVersion":"surveyVersion",
"type":"type",
"activeUserId":"activeUserId",
"activeTime":"activeTime",
"answerList":"answerList"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_survey_answer?authSource=admin');



--网络推广会调查表
--online-marketing.t_survey_record
--hive映射mongo2hive.online_marketing_t_survey_record:mongodb中的online-marketing.t_survey_record
drop table mongo2hive.online_marketing_t_survey_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.online_marketing_t_survey_record
(
id string comment 'id',
promotionId string comment '推广会ID',
surveyId string comment '调查表ID',
userId string comment '答题人ID',
answerId string comment '答卷ID',
`desc` string comment '描述',
unionId string comment '联合ID,因为调查表是可以更新的,每次更新,就是一份新的调查表,此时有个版本号,会自动+1,而unionId用于标识不同版本的调查表其实是从一个调查表演进过来的',
version string comment '版本',
title string comment '调查表名称',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"promotionId":"promotionId",
"surveyId":"surveyId",
"userId":"userId",
"answerId":"answerId",
"desc":"desc",
"unionId":"unionId",
"version":"version",
"title":"title",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/online-marketing.t_survey_record?authSource=admin');



--微学堂学习记录
--micro-school.t_learn_record
--hive映射mongo2hive.micro_school_t_learn_record:mongodb中的micro-school.t_learn_record
drop table mongo2hive.micro_school_t_learn_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_learn_record
(
id string comment 'id',
classId string comment '讲堂id',
courseId string comment '课程id',
ownerId string comment '课程所属用户id',
userId string comment '操作人',
startTime string comment '开始时间',
endTime string comment '结束时间',
normal string comment '是否正常退出',
courseBeginTime string comment '课程开始时间',
learnSeconds string comment '学习时长：单位秒',
clientAppId string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"classId":"classId",
"courseId":"courseId",
"ownerId":"ownerId",
"userId":"userId",
"startTime":"startTime",
"endTime":"endTime",
"normal":"normal",
"courseBeginTime":"courseBeginTime",
"learnSeconds":"learnSeconds",
"clientAppId":"clientAppId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_learn_record?authSource=admin');



--用户账户信息
--module.t_credit_user_integral
--hive映射mongo2hive.module_t_credit_user_integral:mongodb中的module.t_credit_user_integral
drop table mongo2hive.module_t_credit_user_integral;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_credit_user_integral
(
id string comment 'id',
userId string comment '用户id',
balance string comment '余额',
status string comment '账户的状态',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"balance":"balance",
"status":"status",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_user_integral?authSource=admin');



--用户账户信息
--health.u_doctor_friend
--hive映射mongo2hive.health_u_doctor_friend:mongodb中的health.u_doctor_friend
drop table mongo2hive.health_u_doctor_friend;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_u_doctor_friend
(
id  string comment 'id',
userId  string comment '用户id',
toUserId  string comment '添加的好友id',
createTime  string comment '创建时间',
status  string comment '状态，1正常，2删除',
setting  string comment 'setting的json，defriend拉黑  1:否，2:是、topNews消息置顶 1:否，2：是、messageMasking消息屏蔽 1：否，2：是、collection收藏 1：否，2：是'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"toUserId":"toUserId",
"createTime":"createTime",
"status":"status",
"setting":"setting"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.u_doctor_friend?authSource=admin');



--帖子、评论、回复各项统计数据信息
--basepost.statistic_info
--hive映射mongo2hive.basepost_statistic_info:mongodb中的basepost.statistic_info
drop table mongo2hive.basepost_statistic_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.basepost_statistic_info
(
id string comment 'id',
targetId string comment '帖子、评论、回复的主键id',
type string comment '1：帖子    2：评论    3：回复',
readCount string comment '阅读数量',
praiseCount string comment '点赞数量',
rewardCount string comment '打赏数量',
collectCount string comment '收藏数量',
commentCount string comment '评论数量',
replyCount string comment '回复数量'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"targetId":"targetId",
"type":"type",
"readCount":"readCount",
"praiseCount":"praiseCount",
"rewardCount":"rewardCount",
"collectCount":"collectCount",
"commentCount":"commentCount",
"replyCount":"replyCount"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/basepost.statistic_info?authSource=admin');


--评论信息
--basepost.comment_info
--hive映射mongo2hive.basepost_comment_info:mongodb中的basepost.comment_info
drop table mongo2hive.basepost_comment_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.basepost_comment_info
(
id string comment 'id',
postId string comment '帖子主键',
cards string comment '卡片信息',
content string comment '评论内容',
sortIndex string comment '排序索引',
authorId string comment '作者id',
authorName string comment '作者名称',
createTime string comment '创建时间',
updateTime string comment '更新时间',
updateUser string comment '更新人',
statusFlag string comment '状态标识:0删除    1正常'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"postId":"postId",
"cards":"cards",
"content":"content",
"sortIndex":"sortIndex",
"authorId":"authorId",
"authorName":"authorName",
"createTime":"createTime",
"updateTime":"updateTime",
"updateUser":"updateUser",
"statusFlag":"statusFlag"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/basepost.comment_info?authSource=admin');

--帖子、评论、回复打赏信息
--basepost.reward_info
--hive映射mongo2hive.basepost_reward_info:mongodb中的basepost.reward_info
drop table mongo2hive.basepost_reward_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.basepost_reward_info
(
id string comment 'id',
targetId string comment '病例id',
type string comment '类型 1 帖子 2 评论',
userId string comment '用户ID',
createTime string comment '发帖时间',
rewardType string comment '打赏类型',
amount string comment '打赏金额',
receiveRewardUser string comment '被打赏者ID'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"targetId":"targetId",
"type":"type",
"userId":"userId",
"createTime":"createTime",
"rewardType":"rewardType",
"amount":"amount",
"receiveRewardUser":"receiveRewardUser"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/basepost.reward_info?authSource=admin');


--auth2.t_auth_user
--hive映射mongo2hive.auth2_t_auth_user:mongodb中的auth2.t_auth_user
drop table mongo2hive.auth2_t_auth_user;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.auth2_t_auth_user
(
id string ,
activeTime string ,
createTime string ,
userId string ,
userType string ,
accountId string ,
active string ,
openId string ,
lastLoginTime string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"activeTime":"activeTime",
"createTime":"createTime",
"userId":"userId",
"userType":"userType",
"accountId":"accountId",
"active":"active",
"openId":"openId",
"lastLoginTime":"lastLoginTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/auth2.t_auth_user?authSource=admin');



--药企圈用户表
--drugOrg.d_user
--hive映射mongo2hive.drugorg_d_user:mongodb中的drugOrg.d_user
drop table mongo2hive.drugorg_d_user;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.drugorg_d_user
(
id string comment 'id',
userId string comment '用户id',
drugCompanyId string comment '药企id',
openId string comment 'openId（用于对接轻应用或其他第三方系统的id）',
employeeId string comment '职员id',
jobType string comment '兼职类型  1=主职，2=兼职',
status string comment '职员状态 1=在职，2=离职',
entryDate string comment '最近入职时间,主职兼职同步更新',
active string comment '激活状态 1=已激活，2=未激活,主职兼职同步更新',
name string comment '职员名称,主职兼职同步更新',
pinYin string comment '职员名称拼音（将中文转成拼音的第一个字母）,主职兼职同步更新',
fullPinYin string comment '职员名称全拼（将中文名称转成拼音）,主职兼职同步更新',
telephone string comment '手机号',
hidePhone string comment '是否隐藏手机号  2=显示，1=隐藏',
headPicUrl string comment '职员头像',
title string comment '职称',
orgId string comment '所属组织id',
orgName string comment '所属组织名称',
treePath string comment '所属组织的id路径',
creatorDate string comment '创建时间',
updatorDate string comment '最后更新时间',
bizRoleCode string comment '业务角色编码，多个code用逗号分隔',
roleCodes string comment '角色编码',
deptManager string comment '是否是部门主管（1=是，2=不是）',
sysManager string comment '是否是系统管理员（1=是，2=不是）',
rootManager string comment '超级管理员（1=是，2=不是）',
weight string comment '排序权重',
pinYinOrderType string comment '排序类型（名称中已中文开头的=1，非中文开头的=2）',
from1 string comment '是否来自ERP的系统 1 - ERP null - 药企圈系统',
fromId string comment 'ERP那边的Id',
updator string comment '最后更新人',
creator string comment '创建人'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"drugCompanyId":"drugCompanyId",
"openId":"openId",
"employeeId":"employeeId",
"jobType":"jobType",
"status":"status",
"entryDate":"entryDate",
"active":"active",
"name":"name",
"pinYin":"pinYin",
"fullPinYin":"fullPinYin",
"telephone":"telephone",
"hidePhone":"hidePhone",
"headPicUrl":"headPicUrl",
"title":"title",
"orgId":"orgId",
"orgName":"orgName",
"treePath":"treePath",
"creatorDate":"creatorDate",
"updatorDate":"updatorDate",
"bizRoleCode":"bizRoleCode",
"roleCodes":"roleCodes",
"deptManager":"deptManager",
"sysManager":"sysManager",
"rootManager":"rootManager",
"weight":"weight",
"pinYinOrderType":"pinYinOrderType",
"from1":"from",
"fromId":"fromId",
"updator":"updator",
"creator":"creator"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/drugOrg.d_user?authSource=admin');


--运营分析三期
--module.t_credit_freeze
--hive映射mongo2hive.module_t_credit_freeze:mongodb中的module.t_credit_freeze
drop table mongo2hive.module_t_credit_freeze;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_credit_freeze
(
id string,
accountId string,
accountType string,
value string,
type string,
orderId string,
createTime string,
updateTime string,
eventIds string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"accountId":"accountId",
"accountType":"accountType",
"value":"value",
"type":"type",
"orderId":"orderId",
"createTime":"createTime",
"updateTime":"updateTime",
"eventIds":"eventIds"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_freeze?authSource=admin');


--运营分析三期
--module.t_credit_freeze_record
--hive映射mongo2hive.module_t_credit_freeze_record:mongodb中的module.t_credit_freeze_record
drop table mongo2hive.module_t_credit_freeze_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_credit_freeze_record
(
id string comment 'id',
accountId string comment '账户ID',
accountType string comment '账户类型',
value string comment '冻结、解冻或用户领取的值',
type string comment '冻结或解冻的类型',
orderId string comment '订单号',
userId string comment '用户id',
reason string comment '冻结或解冻的原因',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"accountId":"accountId",
"accountType":"accountType",
"value":"value",
"type":"type",
"orderId":"orderId",
"userId":"userId",
"reason":"reason",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_freeze_record?authSource=admin');



--运营分析三期
--health.b_disease_type
--hive映射mongo2hive.health_b_disease_type:mongodb中的health.b_disease_type
drop table mongo2hive.health_b_disease_type;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_b_disease_type
(
id string comment 'id',
enable1 string comment '',
isLeaf string comment '',
name string comment '名称',
parent string comment '',
remark string comment '',
weight string comment '',
alias string comment '',
attention string comment '注意事项',
introduction string comment '疾病简介',
docNum string comment '医生数量',
weights string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"enable1":"enable",
"isLeaf":"isLeaf",
"name":"name",
"parent":"parent",
"remark":"remark",
"weight":"weight",
"alias":"alias",
"attention":"attention",
"introduction":"introduction",
"docNum":"docNum",
"weights":"weights"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.b_disease_type?authSource=admin');


--运营分析三期
--module.t_credit_dept_integral
--hive映射mongo2hive.module_t_credit_dept_integral:mongodb中的module.t_credit_dept_integral
drop table mongo2hive.module_t_credit_dept_integral;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_credit_dept_integral
(
id string comment 'id',
deptId string comment '科室id',
balance string comment '余额',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"deptId":"deptId",
"balance":"balance",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_dept_integral?authSource=admin');




--运营分析四期
--activity.t_promotion_activity
--hive映射mongo2hive.activity_t_promotion_activity:mongodb中的activity.t_promotion_activity
drop table mongo2hive.activity_t_promotion_activity;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_promotion_activity
(
id string comment 'Id',
rule1 string comment '活动规则',
rule_surveyId string comment '调查表id',
rule_surveyName string comment '调查表名',
type string comment '活动类型：【1直播/2录播/3微学堂/4病历讨论/5诊疗路径/6帖子/7广告文章/8网络推广会】',
rewardWay string comment '奖励方式：【1评论抽奖/2邀请评论/3代表推广/4, 评论规则奖励】',
name string comment '活动名称',
limit_ string comment '人数限制',
signed string comment '已报名人数',
introduction string comment '活动简介-给医生看',
aidIntroduction string comment '活动简介-给医药代表看',
creation string comment '创建信息',
deleted string comment '是否删除',
startTime string comment '活动开始时间',
endTime string comment '活动结束时间',
ownerCompanyId string comment '所属企业Id',
ownerCompany string comment '所属企业',
objectIds string comment '参与活动的业务对象Ids'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"rule1":"rule",
"rule_surveyId":"rule.surveyId",
"rule_surveyName":"rule.surveyName",
"type":"type",
"rewardWay":"rewardWay",
"name":"name",
"limit_":"limit",
"signed":"signed",
"introduction":"introduction",
"aidIntroduction":"aidIntroduction",
"creation":"creation",
"deleted":"deleted",
"startTime":"startTime",
"endTime":"endTime",
"ownerCompanyId":"ownerCompanyId",
"ownerCompany":"ownerCompany",
"objectIds":"objectIds"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_promotion_activity?authSource=admin');



--运营分析四期
--activity.t_invitation
--hive映射mongo2hive.activity_t_invitation:mongodb中的activity.t_invitation
drop table mongo2hive.activity_t_invitation;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_invitation
(
id string comment 'id',
activityId string comment '活动id',
bizId string comment '业务id',
bizType string comment '业务类型',
rewardWay string comment '奖励方式：【1评论抽奖/2邀请评论/3代表推广】',
inviterId string comment '邀请人id',
inviterName string comment '邀请人',
inviteeId string comment '被邀请人id',
inviteeName string comment '被邀请人',
received string comment '被邀请人是否领取福利',
inviteTime string comment '邀请时间',
credit string comment '学币',
bizTitle string comment '业务标题',
status string comment '状态',
invalid string comment '',
invalidTime string comment '',
msgId string comment '消息id',
gid string comment '会话id',
read string comment '被邀请人是否已读',
joinedCircles string comment '加入的圈子列表',
addCredit string comment '被邀请人赠送的学币',
addCreditTime string comment '领取学币时间',
addCredited string comment '被邀请人是否赠送学币'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"activityId":"activityId",
"bizId":"bizId",
"bizType":"bizType",
"rewardWay":"rewardWay",
"inviterId":"inviterId",
"inviterName":"inviterName",
"inviteeId":"inviteeId",
"inviteeName":"inviteeName",
"received":"received",
"inviteTime":"inviteTime",
"credit":"credit",
"bizTitle":"bizTitle",
"status":"status",
"invalid":"invalid",
"invalidTime":"invalidTime",
"msgId":"msgId",
"gid":"gid",
"read":"read",
"joinedCircles":"joinedCircles",
"addCredit":"addCredit",
"addCreditTime":"addCreditTime",
"addCredited":"addCredited"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_invitation?authSource=admin');


--运营分析四期
--activity.t_assistant
--hive映射mongo2hive.activity_t_assistant:mongodb中的activity.t_assistant
drop table mongo2hive.activity_t_assistant;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_assistant
(
id string comment 'id',
activityId string comment '活动id',
bizId string comment '业务id',
userId string comment '用户Id',
userName string comment '用户姓名',
amount string comment '奖励学币',
createTime string comment '创建时间',
haveDone string comment '是否已参加',
surveyId string comment '调查表Id',
answerId string comment '答卷Id',
answers ARRAY<string> comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"activityId":"activityId",
"bizId":"bizId",
"userId":"userId",
"userName":"userName",
"amount":"amount",
"createTime":"createTime",
"haveDone":"haveDone",
"surveyId":"surveyId",
"answerId":"answerId",
"answers":"answers"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_assistant?authSource=admin');


--运营分析四期
--module.t_ad_ready_material
--hive映射mongo2hive.module_t_ad_ready_material:mongodb中的module.t_ad_ready_material
drop table mongo2hive.module_t_ad_ready_material;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_ad_ready_material
(
id string comment 'id',
createUserId string comment '广告创建人',
putCompany string comment '投放企业',
putCompanyName string comment '投放企业的名称',
putSource string comment '发放来源，医生圈等',
range string comment '广告可读范围',
timelyPush string comment '是否及时推送',
type string comment '0广告文章,1大咖推荐,2药品资讯,3链接,4其他',
rawMaterialId string comment '广告文章id',
coverUrl string comment '封面url',
surveyRange string comment '调查表的可见范围（是range的子集）',
surveyEndTime string comment '调查表可填写最终时间',
status string comment '状态',
createTime string comment '创建时间',
updateTime string comment '更新时间',
freezeId string comment '冻结账户id',
isShowCoverUrl string comment '',
relateActivityCnt string comment '关联活动数量',
shareUrl string comment '保存分享的URL',
outerLinkTitle string comment '外链标题',
otherUrl string comment '跳转其他业务url',
otherId string comment '其他业务id',
otherType string comment '其他业务标识：1-直播(已去掉),2-诊疗路径(已去掉),3-病例讨论,4-视频(已去掉),5-帖子',
otherTitle string comment '其他业务title',
aggPoint string comment '资料总积分',
surplusPoint string comment '资料剩余积分',
onePoint string comment '单个用户可领取积分',
aggSurveyPoint string comment '调查表总积分',
surplusSurveyPoint string comment '调查表剩余积分',
oneSurveyPoint string comment '单个用户调查表可领取积分',
coverStyle string comment '广告样式',
sortTime string comment '广告文章排序字段，用于web端上移的操作，和updateTime同步修改',
oldNewFlag string comment '新老数据标志位0：老数据，1新数据，用于新广告系统',
title string comment '标题'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"createUserId":"createUserId",
"putCompany":"putCompany",
"putCompanyName":"putCompanyName",
"putSource":"putSource",
"range":"range",
"timelyPush":"timelyPush",
"type":"type",
"rawMaterialId":"rawMaterialId",
"coverUrl":"coverUrl",
"surveyRange":"surveyRange",
"surveyEndTime":"surveyEndTime",
"status":"status",
"createTime":"createTime",
"updateTime":"updateTime",
"freezeId":"freezeId",
"isShowCoverUrl":"isShowCoverUrl",
"relateActivityCnt":"relateActivityCnt",
"shareUrl":"shareUrl",
"outerLinkTitle":"outerLinkTitle",
"otherUrl":"otherUrl",
"otherId":"otherId",
"otherType":"otherType",
"otherTitle":"otherTitle",
"aggPoint":"aggPoint",
"surplusPoint":"surplusPoint",
"onePoint":"onePoint",
"aggSurveyPoint":"aggSurveyPoint",
"surplusSurveyPoint":"surplusSurveyPoint",
"oneSurveyPoint":"oneSurveyPoint",
"coverStyle":"coverStyle",
"sortTime":"sortTime",
"oldNewFlag":"oldNewFlag",
"title":"title"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_ad_ready_material?authSource=admin');



--运营分析四期
--module.t_ad_material_point
--hive映射mongo2hive.module_t_ad_material_point:mongodb中的module.t_ad_material_point
drop table mongo2hive.module_t_ad_material_point;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_ad_material_point
(
id string comment 'id',
createTime string comment '时间',
businessType string comment '业务类型',
businessId string comment '业务id',
userId string comment '用户id',
surveyId string comment '真实调查表id',
changePoint string comment '积分变动值',
materialId string comment '广告文章id',
answerId string comment '调查表回答问题返回的answerId',
status string comment '积分的状态 1-成功 2-失效',
transactionId string comment '',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"createTime":"createTime",
"businessType":"businessType",
"businessId":"businessId",
"userId":"userId",
"surveyId":"surveyId",
"changePoint":"changePoint",
"materialId":"materialId",
"answerId":"answerId",
"status":"status",
"transactionId":"transactionId",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_ad_material_point?authSource=admin');


--H5直播观看记录
--health.t_meeting_h5_watched_log
--hive映射mongo2hive.health_t_meeting_h5_watched_log:mongodb中的health.t_meeting_h5_watched_log
drop table mongo2hive.health_t_meeting_h5_watched_log;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_h5_watched_log
(
id string comment 'id',
class string comment '',
meetingId string comment '会议id',
chunkID string comment '段id标识代表一个连续的时间段|代表用户一次进入',
recordId string comment '用户id标识',
watchedLength string comment '观看时长',
count1 string comment '浏览次数',
createTime string comment '创建时间',
wxName string comment '微信名',
userId string comment '用户id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"class":"_class",
"meetingId":"meetingId",
"chunkID":"chunkID",
"recordId":"recordId",
"watchedLength":"watchedLength",
"count1":"count",
"createTime":"createTime",
"wxName":"wxName",
"userId":"userId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_h5_watched_log?authSource=admin');




--医生粉丝详情
--health.c_doctor_follow
--hive映射mongo2hive.health_c_doctor_follow:mongodb中的health.c_doctor_follow
drop table mongo2hive.health_c_doctor_follow;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_c_doctor_follow
(
id string comment 'id',
userId string comment '关注人id',
doctorId string comment '我关注医生id（被关注人）',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"doctorId":"doctorId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.c_doctor_follow?authSource=admin');


--auth2.t_auth_account
--hive映射mongo2hive.auth2_t_auth_account:mongodb中的auth2.t_auth_account
drop table mongo2hive.auth2_t_auth_account;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.auth2_t_auth_account
(
id string comment 'id',
accountId string comment '账号id使用uuid,旧数据使用之前关联的userId',
accountNum string comment 'telephone 或 微信号',
accountType string comment '账号类型 （tel,wechat）',
password string comment '密码',
userType string comment '户类型 (医生、患者...)',
deleteFlag string comment 'True ： 删除，false：未删除',
deviceType string comment '设备类型',
deviceId string comment '设备ID',
deleteTime string comment '账号删除/恢复时间',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"accountId":"accountId",
"accountNum":"accountNum",
"accountType":"accountType",
"password":"password",
"userType":"userType",
"deleteFlag":"deleteFlag",
"deviceType":"deviceType",
"deviceId":"deviceId",
"deleteTime":"deleteTime",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/auth2.t_auth_account?authSource=admin');




--帖子信息
--basepost.post_info
--hive映射mongo2hive.basepost_post_info:mongodb中的basepost.post_info
drop table mongo2hive.basepost_post_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.basepost_post_info
(
id string comment 'id',
authorId string comment '作者id',
authorName string comment '作者名称',
createTime string comment '创建时间',
updateTime string comment '更新时间',
updateUser string comment '更新人',
statusFlag string comment '状态标识:0删除 1正常',
cards ARRAY<string> comment '附件列表',
content string comment '帖子内容'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"authorId":"authorId",
"authorName":"authorName",
"createTime":"createTime",
"updateTime":"updateTime",
"updateUser":"updateUser",
"statusFlag":"statusFlag",
"cards":"cards",
"content":"content"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/basepost.post_info?authSource=admin');



--帖子关联活动
--module.t_faq_question_activity
--hive映射mongo2hive.module_t_faq_question_activity:mongodb中的module.t_faq_question_activity
drop table mongo2hive.module_t_faq_question_activity;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_question_activity
(
id string comment '',
questionId string comment '帖子ID',
title string comment '帖子标题',
activityId string comment '活动ID',
activityName string comment '活动名称',
circleId string comment '帖子所在圈子ID',
deptId string comment '帖子科室ID',
`limit` string comment '人数限制',
createTime string comment '创建时间',
rewardWay string comment '奖励方式：【1评论抽奖/2邀请评论/3代表推广】',
startTime string comment '活动开始时间',
endTime string comment '活动结束时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"questionId":"questionId",
"title":"title",
"activityId":"activityId",
"activityName":"activityName",
"circleId":"circleId",
"deptId":"deptId",
"limit":"limit",
"createTime":"createTime",
"rewardWay":"rewardWay",
"startTime":"startTime",
"endTime":"endTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_question_activity?authSource=admin');




--直播推送相关数据
--health.t_pushflow_record
--hive映射mongo2hive.health_t_pushflow_record:mongodb中的health.t_pushflow_record
drop table mongo2hive.health_t_pushflow_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_pushflow_record
(
id string comment 'id',
meetingId string comment '会议id',
callbackType string comment '回调类型：pushflow开始推流,pushflow_stop推流停止',
callbackData string comment '回调参数',
callbackTime string comment '回调时间',
pushflowPublishUrl string comment '推流地址',
createTime string comment '创建时间',
streamKey string comment '流名'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"callbackType":"callbackType",
"callbackData":"callbackData",
"callbackTime":"callbackTime",
"pushflowPublishUrl":"pushflowPublishUrl",
"createTime":"createTime",
"streamKey":"streamKey"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_pushflow_record?authSource=admin');




--活动分享信息
--activity.t_activity_business
--hive映射mongo2hive.activity_t_activity_business:mongodb中的activity.t_activity_business
drop table mongo2hive.activity_t_activity_business;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_activity_business
(
id string comment 'Id',
activityId string comment '活动id',
bizId string comment '业务id',
redActivityId string comment '红包活动Id',
`limit` string comment '人数限制',
signed string comment '已报名人数',
received string comment '已领取福利数'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"activityId":"activityId",
"bizId":"bizId",
"redActivityId":"redActivityId",
"limit":"limit",
"signed":"signed",
"received":"received"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_activity_business?authSource=admin');



--病例点赞
--basepost.praise_info
--hive映射mongo2hive.basepost_praise_info:mongodb中的basepost.praise_info
drop table mongo2hive.basepost_praise_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.basepost_praise_info
(
id string comment 'id',
type string comment '1：帖子    2：评论    3：回复',
userId string comment '点赞用户id',
createTime string comment '点赞时间',
praiseUser string comment '被点赞人',
statusFlag string comment '0取消点赞    1点赞',
targetId string comment '帖子、评论、回复的主键id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"type":"type",
"userId":"userId",
"createTime":"createTime",
"praiseUser":"praiseUser",
"statusFlag":"statusFlag",
"targetId":"targetId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/basepost.praise_info?authSource=admin');


--用户无认证原因
--health.t_no_check_reason
--hive映射mongo2hive.health_t_no_check_reason:mongodb中的health.t_no_check_reason
drop table mongo2hive.health_t_no_check_reason;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_no_check_reason
(
id string comment 'id',
userId string comment '用户id',
reasons string comment '离开验证的原因',
createTime string comment '创建时间',
modifyTime string comment '修改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"reasons":"reasons",
"createTime":"createTime",
"modifyTime":"modifyTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_no_check_reason?authSource=admin');




--精品课堂上线表
--chat.t_chat_online
--hive映射mongo2hive.chat_t_chat_online:mongodb中的chat.t_chat_online
drop table mongo2hive.chat_t_chat_online;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.chat_t_chat_online
(
id string comment 'id',
bizType string comment 'jpkt_class_live_discuss：提问  jpkt_class_live_tech：回复',
bizId string comment '课件id',
userId string comment '用户id',
userName string comment '用户名',
userPic string comment '用户图片',
onlineTime string comment '上线时间',
offlineTime string comment '下线时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"bizType":"bizType",
"bizId":"bizId",
"userId":"userId",
"userName":"userName",
"userPic":"userPic",
"onlineTime":"onlineTime",
"offlineTime":"offlineTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/chat.t_chat_online?authSource=admin');




--精品课堂答疑表
--chat.t_chat_message
--hive映射mongo2hive.chat_t_chat_message:mongodb中的chat.t_chat_message
drop table mongo2hive.chat_t_chat_message;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.chat_t_chat_message
(
id string comment 'id',
bizType string comment 'jpkt_class_live_discuss：提问    jpkt_class_live_tech：回复',
bizId string comment '课件id',
content_msgType string comment '提问消息类型，文本 语音 图片',
content_text string comment '提问消息内容',
content_params string comment '提问消息参数',
sendUserId string comment '发送消息者ID',
sendTime string comment '发送消息时间',
clientMsgId string comment '消息ID',
clientAppId string comment 'app id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"bizType":"bizType",
"bizId":"bizId",
"content_msgType":"content.msgType",
"content_text":"content.text",
"content_params":"content.params",
"sendUserId":"sendUserId",
"sendTime":"sendTime",
"clientMsgId":"clientMsgId",
"clientAppId":"clientAppId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/chat.t_chat_message?authSource=admin');




--精品课堂答案表
--health.ScoreSheetPO
--hive映射mongo2hive.health_ScoreSheetPO:mongodb中的health.ScoreSheetPO
drop table mongo2hive.health_ScoreSheetPO;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_ScoreSheetPO
(
id string comment 'id',
appName string comment 'app name',
title string comment '标题',
version string comment '版本',
unionId string comment '独立id',
`desc` string comment '描述',
status string comment '状态',
questions_seq string,
questions_name string,
questions_score string,
questions_options string,
createTime string,
createUserId string,
range string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"appName":"appName",
"title":"title",
"version":"version",
"unionId":"unionId",
"desc":"desc",
"status":"status",
"questions_seq":"questions.seq",
"questions_name":"questions.name",
"questions_score":"questions.score",
"questions_options":"questions.options",
"createTime":"createTime",
"createUserId":"createUserId",
"range":"range"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.ScoreSheetPO?authSource=admin');



--分享相关
--module.t_faq_no_share_pop
--hive映射mongo2hive.module_t_faq_no_share_pop:mongodb中的module.t_faq_no_share_pop
drop table mongo2hive.module_t_faq_no_share_pop;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_no_share_pop
(
id string comment 'id',
dataType string comment '1问题、2评论',
dataId string comment 'faqId',
type string comment '1分享过，被分享、2拒绝分享',
userId string comment '用户id',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"dataType":"dataType",
"dataId":"dataId",
"type":"type",
"userId":"userId",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_no_share_pop?authSource=admin');




--精品课堂H5埋点表
--circleetl.circle_operation_info
--hive映射mongo2hive.circleetl_circle_operation_info:mongodb中的circleetl.circle_operation_info
drop table mongo2hive.circleetl_circle_operation_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.circleetl_circle_operation_info
(
id string comment 'id',
scene string comment '场景',
vid string comment 'ID',
step string comment '步骤',
adddress string comment '地址',
browerMessage string comment '浏览器信息',
createTime string comment '操作时间',
phoneNumber string comment '用户手机号',
data string comment '数据'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"scene":"scene",
"vid":"vid",
"step":"step",
"adddress":"adddress",
"browerMessage":"browerMessage",
"createTime":"createTime",
"phoneNumber":"phoneNumber",
"data":"data"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/circleetl.circle_operation_info?authSource=admin');




--分享记录
--health.t_meeting_share_record
--hive映射mongo2hive.health_t_meeting_share_record:mongodb中的health.t_meeting_share_record
drop table mongo2hive.health_t_meeting_share_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_share_record
(
id string comment 'id',
meetingId string comment '会议id',
shareType string comment '分享类型:wx=微信',
userId string comment '用户id',
wxId string comment '微信id',
wxName string comment '微信名',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"shareType":"shareType",
"userId":"userId",
"wxId":"wxId",
"wxName":"wxName",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_share_record?authSource=admin');




--推流地址信息
--health.t_meeting_pushflow
--hive映射mongo2hive.health_t_meeting_pushflow:mongodb中的health.t_meeting_pushflow
drop table mongo2hive.health_t_meeting_pushflow;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_pushflow
(
id string comment 'id',
meetingId string comment '会议id',
userId string comment '获取地址的用户id',
rtmpPublishUrl string comment '推流地址',
rtmpPlayUrl string comment '推流rtmp播放地址',
hlsPlayUrl string comment '推流hls播放地址',
rtmpPlayUrl720 string comment '720推流rtmp播放地址',
hlsPlayUrl720 string comment '720推流hls播放地址',
rtmpPlayUrl480 string comment '480推流rtmp播放地址',
hlsPlayUrl480 string comment '480推流hls播放地址',
snapshotImg string comment '推流封面地址',
testRtmpPublishUrl string comment '测试推流地址',
testRtmpPlayUrl string comment '测试推流rtmp播放地址',
testHlsPlayUrl string comment '测试推流hls播放地址',
transCode string comment '转码分辨率',
createTime string comment '创建时间',
updateTime string comment '更新时间',
expireTime string comment '到期时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"userId":"userId",
"rtmpPublishUrl":"rtmpPublishUrl",
"rtmpPlayUrl":"rtmpPlayUrl",
"hlsPlayUrl":"hlsPlayUrl",
"rtmpPlayUrl720":"rtmpPlayUrl720",
"hlsPlayUrl720":"hlsPlayUrl720",
"rtmpPlayUrl480":"rtmpPlayUrl480",
"hlsPlayUrl480":"hlsPlayUrl480",
"snapshotImg":"snapshotImg",
"testRtmpPublishUrl":"testRtmpPublishUrl",
"testRtmpPlayUrl":"testRtmpPlayUrl",
"testHlsPlayUrl":"testHlsPlayUrl",
"transCode":"transCode",
"createTime":"createTime",
"updateTime":"updateTime",
"expireTime":"expireTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_pushflow?authSource=admin');



--用户操作推流记录
--health.t_meeting_pushflow_record
--hive映射mongo2hive.health_t_meeting_pushflow_record:mongodb中的health.t_meeting_pushflow_record
drop table mongo2hive.health_t_meeting_pushflow_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_pushflow_record
(
id string comment 'id',
meetingId string comment '会议id',
userId string comment '获取地址的用户id',
pushflow string comment '推流类型',
deviceType string comment '设备类型',
appName string comment '应用名称',
appVersion string comment '应用版本',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"userId":"userId",
"pushflow":"pushflow",
"deviceType":"deviceType",
"appName":"appName",
"appVersion":"appVersion",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_pushflow_record?authSource=admin');



--查询用户访问记录
--module.t_faq_user_view_record
--hive映射mongo2hive.module_t_faq_user_view_record:mongodb中的module.t_faq_user_view_record
drop table mongo2hive.module_t_faq_user_view_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_faq_user_view_record
(
id string comment 'id',
dataType string comment '数据类型',
dataId string comment '数据id',
viewType string comment '阅读记录=reading',
userId string comment '用户id',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"dataType":"dataType",
"dataId":"dataId",
"viewType":"viewType",
"userId":"userId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_faq_user_view_record?authSource=admin');



--直播微信用户表
--health.t_meeting_wxuser
--hive映射mongo2hive.health_t_meeting_wxuser:mongodb中的health.t_meeting_wxuser
drop table mongo2hive.health_t_meeting_wxuser;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_wxuser
(
id string comment 'id',
wxId string comment '微信id',
wxName string comment '微信名',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"wxId":"wxId",
"wxName":"wxName",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_wxuser?authSource=admin');


--circledaq.circle_heat_value_type_day
--hive映射mongo2hive.circledaq_circle_heat_value_type_day:mongodb中的circledaq.circle_heat_value_type_day
drop table mongo2hive.circledaq_circle_heat_value_type_day;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.circledaq_circle_heat_value_type_day
(
id string comment 'id',
circleId string comment '圈子id',
`year` string comment '年',
`month` string comment '月',
typeValue string comment '数据类型',
grossScore string comment '得分',
`date` string comment '日期 年-月-日',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"circleId":"circleId",
"year":"year",
"month":"month",
"typeValue":"typeValue",
"grossScore":"grossScore",
"date":"date",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/circledaq.circle_heat_value_type_day?authSource=admin');


--企业学币账户表
--module.t_credit_company_integral
--hive映射mongo2hive.modulet_credit_company_integral:mongodb中的module.t_credit_company_integral
drop table mongo2hive.modulet_credit_company_integral;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.modulet_credit_company_integral
(
id string comment 'id',
companyId string comment '企业id',
balance string comment '余额',
status string comment '状态：1正常、2废弃',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"companyId":"companyId",
"balance":"balance",
"status":"status",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_company_integral?authSource=admin');


--接龙活动记录表
--dominos.dominos_record
--hive映射mongo2hive.dominos_dominos_record:mongodb中的dominos.dominos_record
drop table mongo2hive.dominos_dominos_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.dominos_dominos_record
(
id string comment 'id',
dominosId string comment '接龙id',
activityId string comment '活动id',
joinUserId string comment '加入接龙用户id',
joinNo string comment '加入接龙序号',
joinTime string comment '加入接龙时间',
deliveryUserId string comment '传递接龙用户id',
awardType string comment '奖励类型:1现金、2学币',
awardNumber string comment '奖励数量',
cashingTime string comment '奖励领取时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"dominosId":"dominosId",
"activityId":"activityId",
"joinUserId":"joinUserId",
"joinNo":"joinNo",
"joinTime":"joinTime",
"deliveryUserId":"deliveryUserId",
"awardType":"awardType",
"awardNumber":"awardNumber",
"cashingTime":"cashingTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/dominos.dominos_record?authSource=admin');



--接龙活动配置表
--dominos.dominos_info
--hive映射mongo2hive.dominos_dominos_info:mongodb中的dominos.dominos_info
drop table mongo2hive.dominos_dominos_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.dominos_dominos_info
(
id string comment '接龙id',
activityId string comment '活动id',
userId string comment '用户id',
deliveryContent string comment '祝福语',
goalJoinNumber string comment '目标接龙数',
joinNubmer string comment '实际接龙数',
endTime string comment '接龙结束时间',
status string comment '状态:-1删除、1未开始、2已开始、9已停止',
createTime string comment '记录创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"activityId":"activityId",
"userId":"userId",
"deliveryContent":"deliveryContent",
"goalJoinNumber":"goalJoinNumber",
"joinNubmer":"joinNubmer",
"endTime":"endTime",
"status":"status",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/dominos.dominos_info?authSource=admin');



--展台乐活动配置表
--exhibitionmarketing.t_promotion
--hive映射mongo2hive.exhibitionmarketing_t_promotion:mongodb中的exhibitionmarketing.t_promotion
drop table mongo2hive.exhibitionmarketing_t_promotion;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.exhibitionmarketing_t_promotion
(
id string comment 'id',
title string comment '名称',
status string comment '状态 1-已上架  2-已下架 3-草稿 4-手动过期',
rewardsType string comment '1 随机领奖模式 2得分领奖模式',
promotionItemList string comment '推广项具体模块:可以包含视频+调查表+红包的自由组合',
userId string comment '当前操作人id',
promotionEnterpriseLogo string comment '推广企业logo',
activityRule string comment '活动规则',
longitude string comment '经度',
latitude string comment '纬度',
locationSwitch string comment '定位判断开关0=开启,1=关闭',
concatAddress string comment '联系地址',
effectiveRange string comment '有效范围',
updateTime string comment '更新时间',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"title":"title",
"status":"status",
"rewardsType":"rewardsType",
"promotionItemList":"promotionItemList",
"userId":"userId",
"promotionEnterpriseLogo":"promotionEnterpriseLogo",
"activityRule":"activityRule",
"longitude":"longitude",
"latitude":"latitude",
"locationSwitch":"locationSwitch",
"concatAddress":"concatAddress",
"effectiveRange":"effectiveRange",
"updateTime":"updateTime",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/exhibitionmarketing.t_promotion?authSource=admin');



--展台乐获取红包记录表
--exhibitionmarketing.t_redPaper_record
--hive映射mongo2hive.exhibitionmarketing_t_redPaper_record:mongodb中的exhibitionmarketing.t_redPaper_record
drop table mongo2hive.exhibitionmarketing_t_redPaper_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.exhibitionmarketing_t_redPaper_record
(
id string comment 'id',
promotionId string comment '推广会ID',
redPaperId string comment '红包ID',
userId string comment '用户ID',
userName string comment '用户名称',
dept string comment '用户科室',
telephone string comment '用户手机号码',
amount string comment '领取数额>0 红包金额,0 未及格,-1 已领完, -2 未摇中, -3 无红包',
haveDone string comment '是否参加',
exportType string comment '红包类别:1-档次红包 2-随机红包',
updateTime string comment '更新时间',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"promotionId":"promotionId",
"redPaperId":"redPaperId",
"userId":"userId",
"userName":"userName",
"dept":"dept",
"telephone":"telephone",
"amount":"amount",
"haveDone":"haveDone",
"exportType":"exportType",
"updateTime":"updateTime",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/exhibitionmarketing.t_redPaper_record?authSource=admin');



--会议信息
--congress.t_congress_info
--hive映射mongo2hive.congress_t_congress_info:mongodb中的congress.t_congress_info
drop table mongo2hive.congress_t_congress_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.congress_t_congress_info
(
id string comment '',
title string comment '',
url string comment '',
type string comment '',
labelList string comment '',
startTime string comment '',
endTime string comment '',
location string comment '',
associationType string comment '',
associationId string comment '',
associationName string comment '',
associationLink string comment '',
adBannerList string comment '',
flickerAdvertisement string comment '',
introduction string comment '',
columnList string comment '',
link string comment '',
format string comment '',
formatUrl string comment '',
branchCongressList string comment '',
recordedBroadcastList string comment '',
agendaList string comment '',
createTime string comment '',
updateTime string comment '',
createUserId string comment '',
state string comment '0上架，1下架',
equivalenceType string comment '',
qrcode string comment '会议二维码'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"title":"title",
"url":"url",
"type":"type",
"labelList":"labelList",
"startTime":"startTime",
"endTime":"endTime",
"location":"location",
"associationType":"associationType",
"associationId":"associationId",
"associationName":"associationName",
"associationLink":"associationLink",
"adBannerList":"adBannerList",
"flickerAdvertisement":"flickerAdvertisement",
"introduction":"introduction",
"columnList":"columnList",
"link":"link",
"format":"format",
"formatUrl":"formatUrl",
"branchCongressList":"branchCongressList",
"recordedBroadcastList":"recordedBroadcastList",
"agendaList":"agendaList",
"createTime":"createTime",
"updateTime":"updateTime",
"createUserId":"createUserId",
"state":"state",
"equivalenceType":"equivalenceType",
"qrcode":"qrcode"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/congress.t_congress_info?authSource=admin');



--扣除企业学币流水记录
--congress.t_credit_record
--hive映射mongo2hive.congress_t_credit_record:mongodb中的congress.t_credit_record
drop table mongo2hive.congress_t_credit_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.congress_t_credit_record
(
id string comment '',
type string comment '类型：1-冻结  2-解冻',
companyId string comment '',
companyName string comment '',
congressId string comment '',
congressName string comment '',
adId string comment '广告id',
adType string comment '广告类型',
adName string comment '',
amount string comment '冻结金额',
freezeState string comment '冻结/解冻状态',
freezeDesc string comment '描述',
freezeId string comment '学币id',
createUserId string comment '',
createTime string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"type":"type",
"companyId":"companyId",
"companyName":"companyName",
"congressId":"congressId",
"congressName":"congressName",
"adId":"adId",
"adType":"adType",
"adName":"adName",
"amount":"amount",
"freezeState":"freezeState",
"freezeDesc":"freezeDesc",
"freezeId":"freezeId",
"createUserId":"createUserId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/congress.t_credit_record?authSource=admin');



--促活-红包领取记录表
--activity.t_red_packet
--hive映射mongo2hive.activity_t_red_packet:mongodb中的activity.t_red_packet
drop table mongo2hive.activity_t_red_packet;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_red_packet
(
id string comment 'id',
activityId string comment '活动id',
bizId string comment '业务id',
userId string comment '用户Id',
userName string comment '用户姓名',
amount string comment '红包金额',
createTime string comment '创建时间',
haveDone string comment '是否参加',
redEnvelopeId string comment '红包Id'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"activityId":"activityId",
"bizId":"bizId",
"userId":"userId",
"userName":"userName",
"amount":"amount",
"createTime":"createTime",
"haveDone":"haveDone",
"redEnvelopeId":"redEnvelopeId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_red_packet?authSource=admin');







--h5网络推广
--h5marketing.t_promotion
--hive映射mongo2hive.h5marketing_t_promotion:mongodb中的h5marketing.t_promotion
drop table mongo2hive.h5marketing_t_promotion;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.h5marketing_t_promotion
(
id string comment 'id',
title string comment '名称',
status string comment '状态 1-已上架  2-已下架 3-草稿 4-手动过期5-抽奖中',
rewardsType string comment '1 随机领奖模式 2得分领奖模式 3时间领奖模式',
promotionItemList string comment '推广项具体模块:可以包含视频+调查表+红包的自由组合',
relateActivityCnt string comment '关联活动数量',
userId string comment '当前操作人id',
popupWindowFlag string comment '弹窗标识1=开启0=不开启',
createTime string comment '创建时间',
updateTime string comment '更改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"title":"title",
"status":"status",
"rewardsType":"rewardsType",
"promotionItemList":"promotionItemList",
"relateActivityCnt":"relateActivityCnt",
"userId":"userId",
"popupWindowFlag":"popupWindowFlag",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/h5marketing.t_promotion?authSource=admin');





--h5用户领取红包记录
--h5marketing.t_redPaper_record
--hive映射mongo2hive.h5marketing_t_redPaper_record:mongodb中的h5marketing.t_redPaper_record
drop table mongo2hive.h5marketing_t_redPaper_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.h5marketing_t_redPaper_record
(
id string comment 'id',
promotionId string comment '推广会ID',
redPaperId string comment '红包ID',
userId string comment '用户ID',
amount string comment '领取数额 >0  中奖 , <=0其他情况',
haveDone string comment '是否参加',
exportType string comment '红包类别',
shareImgUrl string comment '分享url',
createTime string comment '创建时间',
updateTime string comment '更改时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"promotionId":"promotionId",
"redPaperId":"redPaperId",
"userId":"userId",
"amount":"amount",
"haveDone":"haveDone",
"exportType":"exportType",
"shareImgUrl":"shareImgUrl",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/h5marketing.t_redPaper_record?authSource=admin');





--业务广告表
--module.t_business_ad
--hive映射mongo2hive.module_t_business_ad:mongodb中的module.t_business_ad
drop table mongo2hive.module_t_business_ad;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_business_ad
(
id string comment 'id',
adTitle string comment '业务广告的名称',
companyId string comment '投放的公司id',
companyName string comment '投放的公司名称',
adType string comment '广告类型 1:精品课堂  2:会议专区',
businessInfo_businessType string comment '业务类型：1精品课堂 和 2会议专区,可不传',
businessInfo_courseId string comment '课堂id',
businessInfo_minutes string comment '第几分钟出现',
businessInfo_bannerImg string comment 'bannerImg',
businessInfo_classId string comment '班级Id',
businessInfo_classTitle string comment '班级名',
businessInfo_courseName string comment '课堂名',
businessInfo_lessonId string comment '课程id',
businessInfo_lessonName string comment '课程名',
businessInfo_materialTime string comment '课件的时长',
businessInfo_meetingId string comment '会议id',
businessInfo_meetingName string comment '会议名称',
surveyType string comment '调查类型 1:调查表 2:得分表 3:网络推广会',
surveyOnePoint string comment '答题单次可领的学币',
surveyTotalPoint string comment '答题可领的总学币',
surveyLeftPoint string comment '答题可领的剩余学币',
surveyEndTime string comment '调查表答题截至时间',
range_rangeType string comment '推送范围',
range_userCheck string comment '推送范围',
status string comment '1上架/2下架标识',
createUserId string,
createTime string,
updateTime string,
surveys string comment '调查表的id集合',
freezeId string comment '冻结账户id',
transactionIds string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"adTitle":"adTitle",
"companyId":"companyId",
"companyName":"companyName",
"adType":"adType",
"businessInfo_businessType":"businessInfo.businessType",
"businessInfo_courseId":"businessInfo.courseId",
"businessInfo_minutes":"businessInfo.minutes",
"businessInfo_bannerImg":"businessInfo.bannerImg",
"businessInfo_classId":"businessInfo.classId",
"businessInfo_classTitle":"businessInfo.classTitle",
"businessInfo_courseName":"businessInfo.courseName",
"businessInfo_lessonId":"businessInfo.lessonId",
"businessInfo_lessonName":"businessInfo.lessonName",
"businessInfo_materialTime":"businessInfo.materialTime",
"businessInfo_meetingId":"businessInfo.meetingId",
"businessInfo_meetingName":"businessInfo.meetingName",
"surveyType":"surveyType",
"surveyOnePoint":"surveyOnePoint",
"surveyTotalPoint":"surveyTotalPoint",
"surveyLeftPoint":"surveyLeftPoint",
"surveyEndTime":"surveyEndTime",
"range_rangeType":"range.rangeType",
"range_userCheck":"range.userCheck",
"status":"status",
"createUserId":"createUserId",
"createTime":"createTime",
"updateTime":"updateTime",
"surveys":"surveys",
"freezeId":"freezeId",
"transactionIds":"transactionIds"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_business_ad?authSource=admin');



--业务广告网络推广会的答题记录表
--module.t_business_ad_survey_record
--hive映射mongo2hive.module_t_business_ad_survey_record:mongodb中的module.t_business_ad_survey_record
drop table mongo2hive.module_t_business_ad_survey_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_business_ad_survey_record
(
id string comment 'id',
adId string comment '广告id',
answers string comment '用户回答记录',
userId string comment '用户id',
createTime string,
updateTime string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"adId":"adId",
"answers":"answers",
"userId":"userId",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_business_ad_survey_record?authSource=admin');



--调查表
--health.t_survey
--hive映射mongo2hive health_t_survey:mongodb中的health.t_survey
drop table mongo2hive.health_t_survey;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_survey
(
id string comment '调查表id',
appName string comment '应用来源->FAQ：医生圈, material：药企圈',
title string comment '调查表名称',
des string comment '调查表描述',
groupId string comment '集团id',
status string comment '调查表状态，0无效，1有效，9已删除',
createTime string comment '创建时间',
createUserId string comment '创建人用户id',
createUserType string comment '创建人用户类型：1患者、2医助、3医生、4客服、5集团、6导医、8护士、9店主、10企业用户、11药店成员、100游客',
updateTime string comment '更新时间',
updateUserId string comment '更新人用户id',
updateUserType string comment '更新人用户类型：1患者、2医助、3医生、4客服、5集团、6导医、8护士、9店主、10企业用户、11药店成员、100游客',
deleteTime string comment '删除时间',
deleteUserId string comment '删除人用户id',
deleteUserType string comment '删除人用户类型：1患者、2医助、3医生、4客服、5集团、6导医、8护士、9店主、10企业用户、11药店成员、100游客',
unionId string comment '用于标记是否是同一张表，同一个调查表，不管编辑多少次都是一样的',
versions string comment '调查表版本，当编辑时，版本会加1',
range string comment '可见范围，1公开，2私密',
questionList array<struct<question:struct<seq:int,name:string,type:int>,options:array<string>>> comment '题目列表'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"appName":"appName",
"title":"title",
"des":"desc",
"groupId":"groupId",
"status":"status",
"createTime":"createTime",
"createUserId":"createUserId",
"createUserType":"createUserType",
"updateTime":"updateTime",
"updateUserId":"updateUserId",
"updateUserType":"updateUserType",
"deleteTime":"deleteTime",
"deleteUserId":"deleteUserId",
"deleteUserType":"deleteUserType",
"unionId":"unionId",
"versions":"version",
"range":"range",
"questionList":"questionList"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_survey?authSource=admin');




--企业学币信息
--module.t_credit_company
--hive映射mongo2hive.module_t_credit_company:mongodb中的module.t_credit_company
drop table mongo2hive.module_t_credit_company;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_credit_company
(
id string comment 'id',
companyName string comment '公司名',
manager string comment '管理人姓名',
managerTel string comment '管理员状态',
status string comment '公司状态：1正常、2报废',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"companyName":"companyName",
"manager":"manager",
"managerTel":"managerTel",
"status":"status",
"createTime":"createTime",
"updateTime":"updateTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_credit_company?authSource=admin');



--医视云地理位置信息
--esy_equipment_manage.t_location_info
--hive映射mongo2hive.esy_equipment_manage_t_location_info:mongodb中的esy_equipment_manage.t_location_info
drop table mongo2hive.esy_equipment_manage_t_location_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.esy_equipment_manage_t_location_info
(
id string comment 'id',
longitude string comment '经度',
latitude string comment '纬度',
location string comment '地理位置',
createTime string comment '创建时间',
eqId string comment '设备id',
eqNo string comment '设备编号'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"longitude":"longitude",
"latitude":"latitude",
"location":"location",
"createTime":"createTime",
"eqId":"eqId",
"eqNo":"eqNo"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/esy_equipment_manage.t_location_info?authSource=admin');





--活动分享信息
--activity.t_doctor_share
--hive映射mongo2hive.activity_t_doctor_share:mongodb中的activity.t_doctor_share
drop table mongo2hive.activity_t_doctor_share;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.activity_t_doctor_share
(
id string comment 'id',
shareCode string comment '分享编码',
shareType string comment '分享类型',
doctorId string comment '医生userId',
assistantId string comment '助理userId',
bizId string comment '业务Id',
shareContent string comment '分享内容',
shareTime string comment '分享时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"shareCode":"shareCode",
"shareType":"shareType",
"doctorId":"doctorId",
"assistantId":"assistantId",
"bizId":"bizId",
"shareContent":"shareContent",
"shareTime":"shareTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/activity.t_doctor_share?authSource=admin');



--会议录制记录
--health.t_meeting_upload_record
--hive映射mongo2hive.health_t_meeting_upload_record:mongodb中的health.t_meeting_upload_record
drop table mongo2hive.health_t_meeting_upload_record;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_upload_record
(
id string comment '唯一id',
recordId string comment '录制id即meetingid',
recordUrl string comment '录制上传文件地址',
createFrom string comment '表示来源：agora_record=声网录制、 agora_pushflow=推流',
recordDuration string comment '录制文件时长',
userId string comment '用户id',
channelId string comment '通道id、房间号',
recordTime string comment '录制时间',
recordEndTime string comment '录制结束时间',
createTime string comment '创建时间',
persistentId string comment '转码任务id',
persistentStu string comment '状态码 0 成功，1 等待处理，2 正在处理，3 处理失败，4 通知提交失败'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"recordId":"recordId",
"recordUrl":"recordUrl",
"createFrom":"createFrom",
"recordDuration":"recordDuration",
"userId":"userId",
"channelId":"channelId",
"recordTime":"recordTime",
"recordEndTime":"recordEndTime",
"createTime":"createTime",
"persistentId":"persistentId",
"persistentStu":"persistentStu"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_upload_record?authSource=admin');



--医视云地理位置信息
--esy_equipment_manage.t_equipment_info
--hive映射mongo2hive.esy_equipment_manage_t_equipment_info:mongodb中的esy_equipment_manage.t_equipment_info
drop table mongo2hive.esy_equipment_manage_t_equipment_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.esy_equipment_manage_t_equipment_info
(
id string comment '',
eqNo string comment '设备编号',
eqCoded string comment '设备物理编码',
eqName string comment '设备名称',
eqRomId string comment '设备rom绑定id',
eqRomType string comment '设备rom类型',
eqRomVersion string comment '设备rom版本',
eqSpecId string comment '设备硬件规格绑定id',
eqSpecification string comment '设备硬件规格类型',
eqMacAddress string comment '设备mac地址',
flowCardNo string comment '流量卡号',
eqPassword string comment '重置开机密码',
eqStatus string comment '设备状态:1空闲、2使用中、3维修中、4报废、5退货中',
registerType string comment '设备注册方式：auto设备自动注册、web_manualweb后台手动注册',
registerTime string comment '设备注册时间',
stockStatus string comment '库存状态:入库=1、出库=2、运输中=3',
logisticsStatus string comment '物流状态:暂无0、厂商处理发货=1、仓库处理发货=2、运输中=3、客户已签收=4、退货运输中=5、仓库已签收=6',
esyAccountId string comment '绑定的e账户id',
esyAccountNo string comment '绑定的e账户no',
eqSize string comment '设备尺寸',
eqType string comment '设备类型',
motherboardType string comment '设备主板型号',
sourceType string comment '设备来源，0医视圈，1企视圈',
createTime string comment '创建时间',
updateTime string comment '更新时间',
checkStatus string comment '验收状态:1未验收、2已验收',
checkTime string comment '验收日期，毫秒级时间戳',
inspectorNo string comment '质检员编号',
batchNo string comment '厂家批次',
serialNo string comment '设备生成号',
isInstallApp string comment '是否允许安装第三方应用，1允许，0禁止'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"eqNo":"eqNo",
"eqCoded":"eqCoded",
"eqName":"eqName",
"eqRomId":"eqRomId",
"eqRomType":"eqRomType",
"eqRomVersion":"eqRomVersion",
"eqSpecId":"eqSpecId",
"eqSpecification":"eqSpecification",
"eqMacAddress":"eqMacAddress",
"flowCardNo":"flowCardNo",
"eqPassword":"eqPassword",
"eqStatus":"eqStatus",
"registerType":"registerType",
"registerTime":"registerTime",
"stockStatus":"stockStatus",
"logisticsStatus":"logisticsStatus",
"esyAccountId":"esyAccountId",
"esyAccountNo":"esyAccountNo",
"eqSize":"eqSize",
"eqType":"eqType",
"motherboardType":"motherboardType",
"sourceType":"sourceType",
"createTime":"createTime",
"updateTime":"updateTime",
"checkStatus":"checkStatus",
"checkTime":"checkTime",
"inspectorNo":"inspectorNo",
"batchNo":"batchNo",
"serialNo":"serialNo",
"isInstallApp":"isInstallApp"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/esy_equipment_manage.t_equipment_info?authSource=admin');




--申请成为嘉宾记录
--health.t_meeting_apply_compere
--hive映射mongo2hive.health_t_meeting_apply_compere:mongodb中的health.t_meeting_apply_compere
drop table mongo2hive.health_t_meeting_apply_compere;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_apply_compere
(
id string comment 'id',
meetingId string comment '会议id',
userId string comment '申请人',
applyStatus string comment '申请状态：0管理员主动设置、1听众申请、2管理员同意申请、3管理员拒绝申请、4观众取消申请、5申请加入会议',
verifyUserId string comment '审核用户',
createTime string comment '创建时间',
verifyTime string comment '审核时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"userId":"userId",
"applyStatus":"applyStatus",
"verifyUserId":"verifyUserId",
"createTime":"createTime",
"verifyTime":"verifyTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_apply_compere?authSource=admin');




--circledaq.circle_operation_type
--hive映射mongo2hive.circledaq_circle_operation_type:mongodb中的circledaq.circle_operation_type
drop table mongo2hive.circledaq_circle_operation_type;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.circledaq_circle_operation_type
(
id string comment 'id',
type string comment '加分类型',
value string comment '对应加分数值',
description string comment '描述',
icon string comment '图标',
sort string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"type":"type",
"value":"value",
"description":"description",
"icon":"icon",
"sort":"sort"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/circledaq.circle_operation_type?authSource=admin');




--回复信息
--basepost.reply_info
--hive映射mongo2hive.basepost_reply_info:mongodb中的basepost.reply_info
drop table mongo2hive.basepost_reply_info;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.basepost_reply_info
(
id string comment 'id',
postId string comment '所属帖子id',
commentId string comment '所属评论id',
replyId string comment '所属回复id',
cards string comment '卡片内容',
content string comment '回复信息内容',
sortIndex string comment '排序索引',
authorId string comment '作者id',
authorName string comment '作者名称',
createTime string comment '创建时间',
updateTime string comment '更新时间',
statusFlag string comment '状态标识:0删除    1正常'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"postId":"postId",
"commentId":"commentId",
"replyId":"replyId",
"cards":"cards",
"content":"content",
"sortIndex":"sortIndex",
"authorId":"authorId",
"authorName":"authorName",
"createTime":"createTime",
"updateTime":"updateTime",
"statusFlag":"statusFlag"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/basepost.reply_info?authSource=admin');




--会议清晰度等级时长累计信息
--health.t_meeting_dpi_grade
--hive映射mongo2hive.health_t_meeting_dpi_grade:mongodb中的health.t_meeting_dpi_grade
drop table mongo2hive.health_t_meeting_dpi_grade;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.health_t_meeting_dpi_grade
(
id string comment 'id',
meetingId string comment '会议id',
userId string comment '用户id',
agoraUserId string comment '声网参会用户id',
audioGrade string comment '音频累计时长（秒）',
videoSD string comment '标清累计时长（秒）',
videoHD string comment '高清累计时长（秒）',
videoHDP string comment '超清累计时长（秒）',
sid string comment '当次会话uuid',
appId string comment 'appId',
createTime string comment '创建时间'
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"meetingId":"meetingId",
"userId":"userId",
"agoraUserId":"agoraUserId",
"audioGrade":"audioGrade",
"videoSD":"videoSD",
"videoHD":"videoHD",
"videoHDP":"videoHDP",
"sid":"sid",
"appId":"appId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/health.t_meeting_dpi_grade?authSource=admin');



drop table mongo2hive.micro_school_t_learn_log;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_learn_log
(
id string comment '',
courseid string comment '',
userid string comment '',
time string comment '',
action string comment '',
`desc` string comment '',
param string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"courseId":"courseId",
"userId":"userId",
"time":"time",
"action":"action",
"desc":"desc",
"param":"param"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_learn_log?authSource=admin');



drop table mongo2hive.module_t_business_ad_survey;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.module_t_business_ad_survey
(
id string comment '',
userid string comment '',
businessadid string comment '',
point string comment '',
updatetime string comment '',
surveytype string comment '',
name string comment '',
surveyid string comment '',
createtime string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"userId":"userId",
"businessAdId":"businessAdId",
"point":"point",
"updateTime":"updateTime",
"surveyType":"surveyType",
"name":"name",
"surveyId":"surveyId",
"createTime":"createTime"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/module.t_business_ad_survey?authSource=admin');


drop table mongo2hive.micro_school_t_praise_log;
CREATE EXTERNAL TABLE IF NOT EXISTS mongo2hive.micro_school_t_praise_log
(
id string comment '',
classid string comment '',
courseid string comment '',
ownerid string comment '',
userid string comment '',
time string comment '',
clientappid string comment ''
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{
"id":"_id",
"classId":"classId",
"courseId":"courseId",
"ownerId":"ownerId",
"userId":"userId",
"time":"time",
"clientAppId":"clientAppId"
}')
TBLPROPERTIES('mongo.uri'='mongodb://admin:admin@192.168.3.251:27017/micro-school.t_praise_log?authSource=admin');


drop table pro.ods_micro_school_t_praise_log;
create table pro.ods_micro_school_t_praise_log
(
id string comment '',
classid string comment '',
courseid string comment '',
ownerid string comment '',
userid string comment '',
time string comment '',
clientappid string comment ''
)
partitioned by(dt string)
stored as textfile;