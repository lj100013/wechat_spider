-------------mysql2hive的映射表------------

--运营分析一期中用到的表
--circle.circle
--circle.circle_member
--circle.circle_member_role


add jar hdfs://nn:8020//jar/qubole-hive-JDBC-0.0.7.jar; 

--circle.circle映射表
drop table mysql2hive.circle_circle;
CREATE EXTERNAL TABLE mysql2hive.circle_circle
(
id string comment 'id', 
userId string comment '用户id',
sortName string,
name string comment '圈子(科室)可编辑的名称',
type string comment '(1圈子 2虚拟科室)',
introduction string,
logo string,
label string,
auditing string comment '0不需要审核 1需要',
charge string comment '0 不收费 1收费',
freeTime string comment '免费月数 charge = 1才可设置 ',
invite string comment '0 不允许成员邀请 1允许',
hasChildren string comment '0 表示没嵌套 1有',
flag string comment '1正常 2解散',
memberCount string comment '成员总数',
masterCount string comment '圈主总数',
managerCount string comment '管理员总数',
createTime string comment '创建时间',
updateUserId string comment '更新者用户id',
updateTime string comment '更新时间',
masterAreaName string comment '冗余圈主的地区 省市区',
masterName string comment '冗余圈主的姓名',
masterSpeciality string comment '冗余圈主的特长',
deptIds string comment '圈子设置所属科室id',
deptNames string comment '圈子设置所属科室名称',
isprivate string comment '1私密圈子0非私密圈子'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle",
  "mapred.jdbc.output.table.name" = "circle",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);


--circle.circle_member映射表
drop table mysql2hive.circle_circle_member;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_member
(
id string comment 'id',
circleId string comment '圈子id',
userId string comment '用户id',
permanentFree string comment '0否 1永久免费',
status string comment '1正常 2欠费',
expirationTime string comment '过期时间',
createTime string comment '创建时间',
updateTime string comment '更新时间',
conversationGroupId string comment '分组id',
noticeStatusTime string
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_member",
  "mapred.jdbc.output.table.name" = "circle_member",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);

--circle.circle_member_role映射表
drop table mysql2hive.circle_circle_member_role;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_member_role
(
id string comment 'id',
circleId string comment '圈子id',
userId string comment '用户id',
`role` string comment '1管理员 2圈主  3顾问',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_member_role",
  "mapred.jdbc.output.table.name" = "circle_member_role",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);


--运营分析二期中用到的表
--medicine-literature.articleInfo
--medicine-literature.pay_record
--medicine-literature.user_article
--medicine-literature.user_integral


--medicine-literature.articleInfo映射表
drop table mysql2hive.medicine_literature_articleInfo;
CREATE EXTERNAL TABLE mysql2hive.medicine_literature_articleInfo
(
id string comment '文献id',
articleID string comment '论文ID(万方)',
type string comment '资源类型(WF_QK：期刊论文,WF_XW：学位论文,WF_HY：会议论文)',
title string comment '标题',
creator string comment '作者',
source string comment '来源(期刊名、母体文献、授予单位)',
keyWords string comment '关键词',
`year` string comment '年份',
dbid string comment '资源类型',
directDownload string comment '是否直接下载全文（true 直接下载，false 手工流程）默认false',
url string comment '七牛地址',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/medicine-literature",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="articleInfo",
  "mapred.jdbc.output.table.name" = "articleInfo",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);
--medicine-literature.pay_record映射表
drop table mysql2hive.medicine_literature_pay_record;
CREATE EXTERNAL TABLE mysql2hive.medicine_literature_pay_record
(
id string comment '消费记录id',
userId string comment '用户id',
articleInfoId string comment '文献id',
integral string comment '消费的积分',
credit string comment '消费的学币',
createTime string comment '消费产生时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/medicine-literature",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="pay_record",
  "mapred.jdbc.output.table.name" = "pay_record",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);
--medicine-literature.user_article映射表
drop table mysql2hive.medicine_literature_user_article;
CREATE EXTERNAL TABLE mysql2hive.medicine_literature_user_article
(
userId string comment '用户id',
articleInfoId string comment '文献id',
createTime string comment '用户下载文献的时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/medicine-literature",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="user_article",
  "mapred.jdbc.output.table.name" = "user_article",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);
--medicine-literature.user_integral映射表
drop table mysql2hive.medicine_literature_user_integral;
CREATE EXTERNAL TABLE mysql2hive.medicine_literature_user_integral
(
id string comment '积分id',
userId string comment '用户id',
balance string 
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/medicine-literature",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="user_integral",
  "mapred.jdbc.output.table.name" = "user_integral",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--活动-用户行为中用的表
--activitywwh.activity_config
--activitywwh.activity_user


--activitywwh.activity_config映射表
drop table mysql2hive.activitywwh_activity_config;
CREATE EXTERNAL TABLE mysql2hive.activitywwh_activity_config
(
id string comment '',
name string comment '活动名称',
application string comment '1:医生圈 2:药企圈',
ifDispark string comment '是否已经开放 0:否 1:是',
status string comment '活动状态 1:未开始 2:报名中 3 答题进行中 4:已结束',
companyId string comment '公司id',
beginTime string comment '开始时间',
disparkTime string comment '开放时间',
participationType string comment '参与范围类型  1:不限范围 2:导入人员',
slogan string comment '广告语',
sponsorLogo string comment '赞助商logo',
screenUrl string comment '投屏地址',
totalIntegral string comment '总奖金',
prizewinnerType string comment '计算获奖人方式 1:百分比 2:总人数',
prizewinner string comment '获奖人数或者百分比',
highestIntegral string comment '个人最高奖金',
lowestIntegral string comment '个人最低奖金',
warmUpTime string comment '暖场时间',
warmUpBeforeUrl string comment '暖场前素材',
warmUpUrl string comment '暖场素材',
warmUpLaterUrl string comment '暖场后素材',
answerAtTime string comment '答题开始于',
answerAsTime string comment '答题时长',
answerId string comment '题目集id',
passMark string comment '及格分数',
createTime string comment '创建时间',
createUserId string comment '',
updateUserId string comment '',
updateTime string comment '',
bonusAllot string comment '奖金分配模式 1:随机 2:排名',
display string comment '是否在app列表显示 1:显示 2:不显示',
levelJson string comment '档次设置 json字符串',
command string comment '活动口令',
manageUser string comment '管理员人员列表',
createCompanyId string comment '创建人的公司id',
beFrom string comment '创建自哪个平台 1：运营平台 2：药企圈',
linkType string comment '被关联类型 meeting会议管理 activity活动',
linkId string comment '被关联活动id'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/activitywwh",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="activity_config",
  "mapred.jdbc.output.table.name" = "activity_config",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);
--activitywwh.activity_user映射表
drop table mysql2hive.activitywwh_activity_user;
CREATE EXTERNAL TABLE mysql2hive.activitywwh_activity_user
(
id string comment 'id',
activityId string comment '活动id',
userId string comment '用户id',
markTotal string comment '总得分',
time string comment '耗时 秒',
applyTime string comment '报名时间',
ifPass string comment '是否入围 1:入围 2:未入围',
redPacket string comment '获得红包金额 单位1积分 1学币',
questionJson string comment '回答问题记录,未回答完拼接空字符串 ["D(+1)","B(+0)"]' 
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/activitywwh",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="activity_user",
  "mapred.jdbc.output.table.name" = "activity_user",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--推荐系统中用到的表
--circle.circle_living_vedio
--circle.circle_living



--circle.circle_living_vedio映射表
drop table mysql2hive.circle_circle_living_video;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_living_video
(
id string comment 'id',
rId string comment '三方点播id',
circleId string comment '圈子id',
webcastId string comment '三方直播id',
coverUrl string comment '直播封面URL',
password string comment '密码',
subject string comment '主题',
description string comment '介绍',
number string comment '编号',
url string comment '普通参加者加入URL',
plan string comment '议程信息',
speakerInfo string comment '演讲人信息',
recordStartTime string comment '录播开始时间',
recordEndTime string comment '录播结束时间',
size string ,
publishFlag string comment '0不显示1显示',
userId string comment '最后设置人',
updateTime string comment '修改时间',
createTime string comment '创建时间',
deptId string comment '科室id',
recommend string comment '是否推荐',
recommendTime string comment '推荐时间',
noticed string comment '直播开始是否已通知',
relateActivityCnt string comment '关联活动数量',
guestName string comment '嘉宾名称',
webcastPlatform string comment '直播平台',
speakerIntroImg string comment '直播医生简介图片'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_living_vedio",
  "mapred.jdbc.output.table.name" = "circle_living_vedio",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);
--circle.circle_living映射表
drop table mysql2hive.circle_circle_living;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_living
(
id string comment 'id',
circleId string comment '圈子或者科室id',
webcastId string comment '三方直播id',
subject string comment '直播主题',
coverUrl string comment '直播封面URL',
description string comment '直播描述',
number string comment '直播编号',
organizerJoinUrl string comment '组织者加入URL',
organizerToken string comment '组织者加入口令',
panelistJoinUrl string comment '嘉宾加入URL',
panelistToken string comment '嘉宾加入口令',
attendeeJoinUrl string comment '普通参加者加入URL',
attendeeToken string comment '普通参加者口令',
startTime string comment '开始时间',
endTime string comment '结束时间',
plan string comment '议程信息',
speakerInfo string comment '演讲人信息',
maxAttendees string comment '最大并发点数',
loginRequired string comment '是否要求用户登录',
opened string comment '是否公开',
switchClient string comment '是否允许升级到客户端方式',
realtime string comment '是否开启实时功能',
aac string comment 'AAC开启将导致直播时WEB端用户使用语音功能失效',
telconf string comment '值为（0,1,2）中的一个分别对应着0: 不开启  1: 仅开启外呼邀请 2: 开启外呼邀请，同时接受电话呼入',
sec string comment '表示密码是经过加密的',
action string comment '0-创建 101—用户进入102—会议创建103—直播开始104—暂停直播（上课）105—停止直播（上课）106—录制件产生107—退出直播教室 110—用户异常离开',
publishFlag string comment '0不显示1显示',
deleteFlag string comment '1已标记为删除',
isSendSms string comment '1-已通知 0 未通知',
userId string comment '最后设置人',
updateTime string comment '修改时间',
createTime string comment '创建时间',
pushCount string comment '0',
relateActivityCnt string comment '关联活动数量',
deptId string comment '科室id',
deptName string comment '科室名称',
recommend string comment '是否推荐',
recommendTime string comment '推荐时间',
noticed string comment '直播开始是否已通知',
hallFlag string comment '是否发布至大厅1发布0，不发布',
columnName string comment '栏目名称',
extDesc string comment '推广描述',
speakerId string comment '演讲人Id',
guestName string comment '嘉宾名称',
webcastPlatform string comment '直播平台',
speakerIntroImg string comment '直播医生简介图片',
guestNumber string comment '嘉宾码'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_living",
  "mapred.jdbc.output.table.name" = "circle_living",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);


--推荐系统二期
--circle_school.t_course
--hive映射mysql2hive.circle_school_t_course:mysql中的circle_school.t_course
drop table mysql2hive.circle_school_t_course;
CREATE EXTERNAL TABLE mysql2hive.circle_school_t_course
(
id  string ,
classId  string comment '讲堂id',
courseId  string comment '课程id',
theme  string comment '课程主题',
form  string comment '课程形式 0-幻灯片形式 1-聊天形式',
type  string comment '课程类型 0-公开课 1-收费课',
coverImgUrl  string comment '课程封面地址',
ownerId  string comment '讲师id',
ownerName  string comment '讲师名称',
ownerDeptId  string comment '讲师部门id',
ownerDeptName  string ,
ownerHospitalId  string ,
ownerHospitalName  string ,
ownerHeadPic  string ,
ownerAcademicTitle  string ,
beginTime  string comment '开始时间',
createId  string comment '创建人id',
createTime  string comment '记录创建时间',
status  string comment '课程状态,0草稿1发布2结束',
publishType  string comment '课程发布类型,0全员公开,1指定圈子范围,2讲师所在科室',
relateActivityCnt  string comment '活动关联数',
createName  string,
checkStatus string comment '审核状态（0 未审核 1 已审核）',
checkId string comment '审核人id',
checkTime string comment '审核时间',
grade string comment '等级 A B C',
liveType string comment '直播方式 0录播 1直播 默认1',
safeLabel string comment '安全标签',
gradeSuggest string comment '建议等级 A B C',
contractRelate string comment '合同关联状态',
contractState string comment '已关联合同状态'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://120.79.73.179:3306/circle_school?useSSL=false",
  "mapred.jdbc.username"="etl_user",
  "mapred.jdbc.input.table.name"="t_course",
  "mapred.jdbc.output.table.name" = "t_course",
  "mapred.jdbc.password"="readsgaP3",
  "mapred.jdbc.hive.lazy.split"= "false"
);

--推荐系统二期
--circle_school.t_course_dept
--hive映射mysql2hive.circle_school_t_course_dept:mysql中的circle_school.t_course_dept
drop table mysql2hive.circle_school_t_course_dept;
CREATE EXTERNAL TABLE mysql2hive.circle_school_t_course_dept
(
id string,
classId string comment '讲堂id',
courseId string comment '课程id',
deptName string comment '适用科室名称',
createTime string comment '记录创建时间',
deptCode string
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle_school?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_course_dept",
  "mapred.jdbc.output.table.name" = "t_course_dept",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--推荐系统二期
--circle_school.t_course_lable
--hive映射mysql2hive.circle_school_t_course_lable:mysql中的circle_school.t_course_lable
drop table mysql2hive.circle_school_t_course_lable;
CREATE EXTERNAL TABLE mysql2hive.circle_school_t_course_lable
(
id string,
classId string comment '讲堂id',
courseId string comment '课程id',
ownerId string comment '讲师id',
lable string comment '标签名称'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle_school?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_course_lable",
  "mapred.jdbc.output.table.name" = "t_course_lable",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);


--推荐系统二期
--circle_school.t_course_range
--hive映射mysql2hive.circle_school_t_course_range:mysql中的circle_school.t_course_range
drop table mysql2hive.circle_school_t_course_range;
CREATE EXTERNAL TABLE mysql2hive.circle_school_t_course_range
(
id string comment 'id',
classId string comment '讲堂id',
courseId string comment '课程id',
ownerId string comment '讲师id',
circleId string comment '圈子id',
circleName string comment '圈子名称',
circleAuditing string comment '加入圈子是否需要审核',
createTime string comment '记录创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle_school?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_course_range",
  "mapred.jdbc.output.table.name" = "t_course_range",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--运营分析四期
--health.p_image_data
--hive映射mysql2hive.health_p_image_data:mysql中的health.p_image_data
drop table mysql2hive.health_p_image_data;
CREATE EXTERNAL TABLE mysql2hive.health_p_image_data
(
id string comment '主键',
relation_id string comment '关联id',
user_id string comment '用户id',
image_url string comment '图像路径',
image_type string comment '图像类型:1.病例图像,2.病情图像,3.诊断记录,4.诊断录音,5.头像,5.医生认证图片,6.医生身份证图片/**身份证图片*/,11.关怀小结图片,12.关怀小结录音',
time_long string comment '时长'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/health?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="p_image_data",
  "mapred.jdbc.output.table.name" = "p_image_data",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);


--医生认领论文关系表
--medicine-literature.user_treatise
--hive映射mysql2hive.medicine_literature_user_treatise:mysql中的medicine-literature.user_treatise
drop table mysql2hive.medicine_literature_user_treatise;
CREATE EXTERNAL TABLE mysql2hive.medicine_literature_user_treatise
(
id string comment 'PRIMARY ID',
user_id string comment '用户ID',
treatise_id string comment '论文ID',
status string comment '1-已认领 2-不是我的',
create_time string comment '记录生成时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/medicine-literature?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="user_treatise",
  "mapred.jdbc.output.table.name" = "user_treatise",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--精品课堂报名表
--excellent_class.j_class_signup
--hive映射mysql2hive.excellent_class_j_class_signup:mysql中的excellent_class.j_class_signup
drop table mysql2hive.excellent_class_j_class_signup;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_class_signup
(
id string comment 'PRIMARY ID',
classId string comment '班级id',
courseId string comment '课程id',
userId string comment '报名用户id',
isadmin string comment '是否是管理员或者讲师（1是0否）',
name string comment '用户名称（同步）',
telephone string comment '手机号（同步）',
headPicFileName string comment '头像（同步）',
title string comment '职称（同步）',
companyName string comment '医院名称（同步）',
departments string comment '科室或者部门（同步）',
userStatus string comment '用户状态',
payType string comment '支付方式（0、免支付 1、听课卷 2、学币 3、人民币（微信支付） 4、招人代付）',
amount string comment '金额',
preferentialId string comment '听课卷',
companyId string comment '听课卷投放企业',
payTime string comment '购买成功时间',
orderId string comment '订单id',
payVoJson string,
payUserJson string,
status string comment '状态（1购买成功 2未成功 3订单已取消）',
isrefund string comment '是否已经退款（0无 1是）',
source string comment '报名来源',
createTime string,
updateTime string
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://120.79.73.179:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="etl_user",
  "mapred.jdbc.input.table.name"="j_class_signup",
  "mapred.jdbc.output.table.name" = "j_class_signup",
  "mapred.jdbc.password"="readsgaP3",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--精品课堂班级考试表
--excellent_class.j_class_exam
--hive映射mysql2hive.excellent_class_j_class_exam:mysql中的excellent_class.j_class_exam
drop table mysql2hive.excellent_class_j_class_exam;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_class_exam
(
id string comment 'PRIMARY ID',
relateId string comment '关联id',
userId string comment '用户id',
examinationId string comment '问题Id',
type string comment '考试类型（1课件考试，2毕业考试）',
createTime string comment '创建时间',
updateTime string comment '更新时间',
classId string comment '班级id',
totalScore string comment '得分表总分',
getScore string comment '得分',
answerJson string comment '答卷信息',
spentTime string comment '耗时（单位秒）',
rightCount string comment '答对题数'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_class_exam",
  "mapred.jdbc.output.table.name" = "j_class_exam",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--精品课堂调查表
--excellent_class.j_class_survey
--hive映射mysql2hive.excellent_class_j_class_survey:mysql中的excellent_class.j_class_survey
drop table mysql2hive.excellent_class_j_class_survey;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_class_survey
(
id string comment 'PRIMARY ID',
classId string comment '班级id',
relateId string comment '关联id',
userId string comment '用户id',
surveyId string comment '调查表id',
answerId string comment '答案id',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_class_survey",
  "mapred.jdbc.output.table.name" = "j_class_survey",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--精品课堂课堂表
--excellent_class.j_course
--hive映射mysql2hive.excellent_class_j_course:mysql中的excellent_class.j_course
drop table mysql2hive.excellent_class_j_course;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_course
(
id string comment 'PRIMARY ID',
name string comment '课程名称',
courseUrl string comment '课程图片url',
introduction string comment '课程简介（富文本）',
introductionUrl string comment '课程简介富文本url',
departmentLabels string comment '科室标签名称集合',
diseaseLabels string comment '疾病标签名称集合',
customLabels string comment '自定义标签名称集合',
purchaseNotes string comment '购买须知',
questionnaireId string comment '课程调查表id',
examinationId string comment '课程考试id',
certificateTemplateId string comment '结业证书id',
system string comment '发布的系统  1 医生圈  2 药企圈  3 医患圈',
createUserId string comment '创建人',
topping string comment '置顶状态   1置顶  2不置顶',
toppingTime string comment '置顶时间',
createTime string comment '创建时间',
updateTime string comment '更新时间',
status string comment '状态  1 上架 2 下架'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_course",
  "mapred.jdbc.output.table.name" = "j_course",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--精品课堂听课券表
--coupon.coupon_apply
--hive映射mysql2hive.coupon_coupon_apply:mysql中的coupon.coupon_apply
drop table mysql2hive.coupon_coupon_apply;
CREATE EXTERNAL TABLE mysql2hive.coupon_coupon_apply
(
id string comment 'PRIMARY ID',
platform string comment '平台类别  1平台听课券；2企业券',
name string comment '卡券名称',
type string comment '卡券类型',
faceValue string comment '卡券面额',
guaranteeNum string comment '保底数，用于分成',
cappingNum string comment '封顶数，数量以内可以使用券，超出需付钱',
cappingNumLeft string comment '封顶剩余名额',
issueNum string comment '发行数（白名单数量）',
issueNumLeft string comment '未分配数量',
bizId string comment '卡券使用的业务标识（课程）',
bizName string comment '业务名称（课程名称）',
subBizId string comment '卡券使用的业务标识二级（班级）',
subBizName string comment '二级业务名称（班级名称）',
sponsorId string comment '卡券赞助商',
sponsorName string comment '卡券赞助商名称',
status string comment '卡券状态',
freezeId string comment '学币冻结id',
createUserId string comment '创建用户id',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/coupon?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="coupon_apply",
  "mapred.jdbc.output.table.name" = "coupon_apply",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);


--精品课堂班级表
--excellent_class.j_class
--hive映射mysql2hive.excellent_class_j_class:mysql中的excellent_class.j_class
drop table mysql2hive.excellent_class_j_class;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_class
(
id string comment 'PRIMARY ID',
courseId string comment '课程id',
name string comment '班级名称',
introduction string comment '简介',
introductionUrl string ,
beginTime string comment '开课时间',
endTime string comment '闭班时间',
term string comment '学期',
signupStartTime string comment '报名开始时间',
signupEndTime string comment '报名结束时间',
managerIds string comment '管理员（可以多个 用,分隔）',
numberLimit string comment '人数限制',
price string comment '价格',
practiceUrl string,
practice string comment '实习',
notice string comment '公告',
noticeTime string comment '公告时间',
guaranteeNum string comment '听课券保底数量',
seq string,
status string comment '班级闭班状态（0整除 1闭班）',
createId string comment '创建人',
createTime string comment '创建时间',
updateTime string comment '修改时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_class",
  "mapred.jdbc.output.table.name" = "j_class",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--精品课堂流程表
--excellent_class.j_class_schedule
--hive映射mysql2hive.excellent_class_j_class_schedule:mysql中的excellent_class.j_class_schedule
drop table mysql2hive.excellent_class_j_class_schedule;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_class_schedule
(
id string comment 'PRIMARY ID',
courseId string comment '课程id',
classId string comment '班级id',
type string comment '类型（1课程课件 2直播类型）',
objectId string comment '课件id 或者 直播id',
isfree string comment '是否免费（1是 0否）',
startTime string comment '开课时间',
tutor string comment '导师',
tutorName string,
answerStartTime string comment '答疑开始时间',
answerEndTime string comment '答疑结束时间',
status string comment '状态',
createTime string,
updateTime string,
subject string comment '直播主题',
ispublish string comment '是否发布（0否1是 默认）',
ischangeAnswer string comment '是否变更答疑时间（0否1是 默认0）'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_class_schedule",
  "mapred.jdbc.output.table.name" = "j_class_schedule",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--精品课堂课件表
--excellent_class.j_courseware
--hive映射mysql2hive.excellent_class_j_courseware:mysql中的excellent_class.j_courseware
drop table mysql2hive.excellent_class_j_courseware;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_courseware
(
id string comment 'PRIMARY ID',
name string comment '课程名称',
coverUrl string comment '课件封面url',
type string comment '课件类型  1视频  2音频',
lecturerId string comment '讲师id',
lecturerIntroduction string comment '讲师信息简介',
questionnaireId string comment '随堂调查id',
examinationId string comment '随堂考试id',
materialId string comment '素材id信息',
status string comment '状态  1 启用 2 草稿  3 删除',
enableTime string comment '启用时间',
createUserId string comment '创建人id',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_courseware",
  "mapred.jdbc.output.table.name" = "j_courseware",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--精品课堂课堂评分表
--excellent_class.j_course_rate
--hive映射mysql2hive.excellent_class_j_course_rate:mysql中的excellent_class.j_course_rate
drop table mysql2hive.excellent_class_j_course_rate;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_course_rate
(
id string comment 'PRIMARY ID',
courseId string comment '课程id',
grade string comment '得分0-5',
userId string comment '用户id',
createTime string,
updateTime string
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_course_rate",
  "mapred.jdbc.output.table.name" = "j_course_rate",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--精品课堂课堂课件关联表
--excellent_class.j_course_courseware
--hive映射mysql2hive.excellent_class_j_course_courseware:mysql中的excellent_class.j_course_courseware
drop table mysql2hive.excellent_class_j_course_courseware;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_course_courseware
(
id string comment 'PRIMARY ID',
courseId string comment '课程id',
courseWareId string comment '课件id',
sort string comment '序号',
createUserId string comment '创建者id',
createTime string COMMENT '创建时间',
updateTime string COMMENT '更新时间',
isfree string COMMENT '是否免费  1 免费 2 收费'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_course_courseware",
  "mapred.jdbc.output.table.name" = "j_course_courseware",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--三方内容
--wordpress.wp_posts
--hive映射mysql2hive.wordpress_wp_posts:mysql中的wordpress.wp_posts
drop table mysql2hive.wordpress_wp_posts;
CREATE EXTERNAL TABLE mysql2hive.wordpress_wp_posts
(
id string comment 'id',
post_date string comment '发布时间',
post_title string comment '标题',
post_type string comment '文章类型(post/page等)',
author string comment '文章作者',
dept string comment '文章关键字',
source string comment '文章来源',
post_flag string comment '',
faq_id string comment '帖子id'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.121:3306/wordpress?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="wp_posts",
  "mapred.jdbc.output.table.name" = "wp_posts",
  "mapred.jdbc.password"="dachen@123",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--直播预约提醒表
--circle.circle_living_remind
--hive映射mysql2hive.circle_circle_living_remind:mysql中的circle.circle_living_remind
drop table mysql2hive.circle_circle_living_remind;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_living_remind
(
id string comment '主键Id',
livingId string comment '直播id',
userId string comment '用户id',
telephone string comment '用户手机号',
remindStatus string comment '15分钟前提醒状态：0未提醒，1已提醒',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_living_remind",
  "mapred.jdbc.output.table.name" = "circle_living_remind",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);






--双旦活动总表
--circle.circle_activity
--hive映射mysql2hive.circle_circle_activity:mysql中的circle.circle_activity
drop table mysql2hive.circle_circle_activity;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_activity
(
id string comment 'id',
type string comment '方案类型1,2',
agreement string comment '协议',
commitLocation string comment '跳转的地方',
imageUrl string comment '图片url',
simageUrl string comment '缩小图片url',
startTime string comment '活动开始时间',
endTime string comment '活动结束时间',
rule string comment '规则',
createTime string comment '创建时间',
name string comment '活动名称',
businessType string comment 'RZHB,TJRZHB....',
creator string comment '创建活动的人',
ruleStartTime string comment '活动推广开始时间',
ruleEndTime string comment '活动推广结束时间',
eid string comment '活动推广开始时间',
companyName string comment '公司名称',
companyId string comment '公司Id',
unFreezeFlag string comment '0未解冻,1已解冻',
rewardType string comment '奖励的类型，YSQ-医生圈 YQQ-药企圈'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_activity",
  "mapred.jdbc.output.table.name" = "circle_activity",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--红包活动主体表
--circle.circle_activity_redpaper
--hive映射mysql2hive.circle_circle_activity_redpaper:mysql中的circle.circle_activity_redpaper
drop table mysql2hive.circle_circle_activity_redpaper;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_activity_redpaper
(
id string comment 'id',
startTime string comment '红包有效时间开始时间',
endTime string comment '红包有效时间结束时间',
rule string comment '领取规则',
name string comment '名称',
grade string comment '档次',
`sum` string comment '红包总数',
mayOptNum string comment '可操作次数',
probability string comment '领取概率',
businessType string comment 'RZHB,TJRZHB....',
createTime string comment '创建时间',
creator string comment '创建活动的人',
activityId string comment '活动业务Id',
activityFlag string comment '活动类型0平台1网络推广',
rewardType string comment '奖励的类型，YSQ-医生圈 YQQ-药企圈'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_activity_redpaper",
  "mapred.jdbc.output.table.name" = "circle_activity_redpaper",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--双旦活动红包方案
--circle.circle_activity_redenvelopes
--hive映射mysql2hive.circle_circle_activity_redenvelopes:mysql中的circle.circle_activity_redenvelopes
drop table mysql2hive.circle_circle_activity_redenvelopes;
CREATE EXTERNAL TABLE mysql2hive.circle_circle_activity_redenvelopes
(
id string comment '红包',
aid string comment '活动id',
sid string comment '活动方案id',
userId string comment '用户Id',
amount string comment '金额(个)',
randomNum string comment '随机数',
createTime string comment '创建时间',
receiveTime string comment '接收时间',
user string comment '用户json'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/circle?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_activity_redenvelopes",
  "mapred.jdbc.output.table.name" = "circle_activity_redenvelopes",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--精品课堂用户领券表
--coupon.coupon_user
--hive映射mysql2hive.coupon_coupon_user:mysql中的coupon.coupon_user
drop table mysql2hive.coupon_coupon_user;
CREATE EXTERNAL TABLE mysql2hive.coupon_coupon_user
(
id string comment 'PRIMARY ID',
applyId string comment '券创建的id',
couponId string comment '券的id',
name string comment '券的名称',
userId string comment '用户id，不一定有',
telephone string comment '手机号',
bizId string comment '业务id（课程id）',
subBizId string comment '子业务id（班级id）',
type string comment '券的类型',
status string comment '券的状态 1：券未使用， 2：券已使用， 3：券已作费， 4:券已过期，5：用户退券',
usingTime string comment '使用时间（报名），0代表未使用',
orderId string comment '订单id',
refundTime string comment '退券时间',
receiveTime string comment '券的领取时间',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/coupon?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="coupon_user",
  "mapred.jdbc.output.table.name" = "coupon_user",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);





--充值记录
--credit.circle_recharge
--hive映射mysql2hive.credit_circle_recharge:mysql中的credit.circle_recharge
drop table mysql2hive.credit_circle_recharge;
CREATE EXTERNAL TABLE mysql2hive.credit_circle_recharge
(
id string comment '0',
payNo string comment '内部订单号',
amount string comment '充值金额（按分存储）',
integral string comment '购买学币',
userId string comment '当前购买用户Id',
rechargeType string comment '1-app充值 3-微信公众号充值',
targerType string comment '充值目标类型 1-圈子充值  2科室充值 3个人',
targerId string comment '圈子或者科室ID',
targerName string comment '圈子或者科室的名称',
status string comment '0新建1成功',
payTime string comment '付款时间',
prepayId string comment '预支付交易会话标识',
openId string comment '微信公众号id用来发微信公众号消息',
createTime string comment '创建时间',
updateTime string comment '修改时间',
remark string comment '留言'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/credit?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="circle_recharge",
  "mapred.jdbc.output.table.name" = "circle_recharge",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);





--用户使用券或者退券的记录
--coupon.user_coupon_detail
--hive映射mysql2hive.coupon_user_coupon_detail:mysql中的coupon.user_coupon_detail
drop table mysql2hive.coupon_user_coupon_detail;
CREATE EXTERNAL TABLE mysql2hive.coupon_user_coupon_detail
(
id string comment 'id',
userId string comment '用户id',
applyId string comment  '券创建的id',
couponId string comment  '券的id',
orderId string comment  '订单id',
description string comment '描述',
faceValue string comment  '面值',
status string comment  '1成功；2失败',
type string comment  '1兑换；2退券,3回滚，4 分成',
bizId string comment  '课程id',
subBizId string comment  '班级id',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/coupon?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="user_coupon_detail",
  "mapred.jdbc.output.table.name" = "user_coupon_detail",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--虚拟子账户表
--credit.credit_virtual_account
--hive映射mysql2hive.credit_credit_virtual_account:mysql中的credit.credit_virtual_account
drop table mysql2hive.credit_credit_virtual_account;
CREATE EXTERNAL TABLE mysql2hive.credit_credit_virtual_account
(
id string comment 'ID',
virtual_id string comment '账户拥有者ID',
balance string comment '账户余额(一定要是无符号整型)',
business_code string comment '业务码',
parent_id string comment '父账户ID',
parent_type string comment '父账户类型 0平台 1个人 2企业 3圈子',
create_time string comment '创建时间',
update_time string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/credit?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="credit_virtual_account",
  "mapred.jdbc.output.table.name" = "credit_virtual_account",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--业务收入表
--credit.credit_business_income
--hive映射mysql2hive.credit_credit_business_income:mysql中的credit.credit_business_income
drop table mysql2hive.credit_credit_business_income;
CREATE EXTERNAL TABLE mysql2hive.credit_credit_business_income
(
id string comment 'ID',
owner_id string comment '拥有者ID',
balance string comment '账户金额',
init_balance string comment '初始化账户金额',
name string comment '账户中文名称',
create_time string comment '创建时间',
update_time string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/credit?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="credit_business_income",
  "mapred.jdbc.output.table.name" = "credit_business_income",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--精品课堂评论表
--excellent_class.j_comment
--hive映射mysql2hive.excellent_class_j_comment:mysql中的excellent_class.j_comment
drop table mysql2hive.excellent_class_j_comment;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_comment
(
id string comment 'PRIMARY ID',
courseId string comment '课程id',
commentatorId string comment '评论人id',
commentatorIntroduction string comment '评论人信息简介',
content string comment '评论内容',
status string comment '评论状态  0 删除  1 正常',
commentId string comment '评论id  回复的评论id',
createTime string comment '创建时间',
updateTime string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_comment",
  "mapred.jdbc.output.table.name" = "j_comment",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--e视云账户信息表
--esy_account_manage.t_account_info
--hive映射mysql2hive.esy_account_manage_t_account_info:mysql中的esy_account_manage.t_account_info
drop table mysql2hive.esy_account_manage_t_account_info;
CREATE EXTERNAL TABLE mysql2hive.esy_account_manage_t_account_info
(
id string comment '账户id',
accountNo string comment '账户号',
accountName string comment '账户名称',
accountUserId string comment '账户的用户id',
accountUserType string comment '账户的用户类型:14-医视 15-企视',
accountHeadImgUrl string comment '账户的用户头像',
edeptId string comment '关联e科室id',
eqId string comment '关联设备id',
eqNo string comment '关联设备编号',
meetingNumber string comment '会议房间号',
manageKey string comment '会议管理密码',
accountStatus string comment '账户状态',
activateGetDay string comment '激活后赠送天数',
validUntil string comment '有效时间',
activateTime string comment '账户激活时间',
createTime string comment '创建时间',
updateTime string comment '更新时间',
useStatus string comment '账户使用状态'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/esy_account_manage?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_account_info",
  "mapred.jdbc.output.table.name" = "t_account_info",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--企视圈关联企业组织信息表
--esy_account_manage.t_account_companyOrg_info
--hive映射mysql2hive.esy_account_manage_t_account_companyOrg_info:mysql中的esy_account_manage.t_account_companyOrg_info
drop table mysql2hive.esy_account_manage_t_account_companyOrg_info;
CREATE EXTERNAL TABLE mysql2hive.esy_account_manage_t_account_companyOrg_info
(
id string comment '主键id',
accountId string comment '账户id',
companyId string comment '企业id',
companyName string comment '企业名称',
orgId string comment '部门id',
orgName string comment '部门名称',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/esy_account_manage?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_account_companyOrg_info",
  "mapred.jdbc.output.table.name" = "t_account_companyOrg_info",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--e视云账户关联e科室信息表
--esy_account_manage.t_account_edept_info
--hive映射mysql2hive.esy_account_manage_t_account_edept_info:mysql中的esy_account_manage.t_account_edept_info
drop table mysql2hive.esy_account_manage_t_account_edept_info;
CREATE EXTERNAL TABLE mysql2hive.esy_account_manage_t_account_edept_info
(
id string comment '主键id',
accountId string comment '账户id',
edeptId string comment '关联e科室id',
edeptName string comment 'e科室名称',
hospitalId string comment '医院id',
hospitalName string comment '医院名称',
hospitalAddress string comment '医院地址',
deptId string comment '科室id',
deptName string comment '科室名称',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/esy_account_manage?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_account_edept_info",
  "mapred.jdbc.output.table.name" = "t_account_edept_info",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--e视云账户缴费记录表
--esy_account_manage.t_account_payment_record
--hive映射mysql2hive.esy_account_manage_t_account_payment_record:mysql中的esy_account_manage.t_account_payment_record
drop table mysql2hive.esy_account_manage_t_account_payment_record;
CREATE EXTERNAL TABLE mysql2hive.esy_account_manage_t_account_payment_record
(
id string comment '主键id',
accountId string comment '账户id',
paymentId string comment '缴费单id',
paymentTime string comment '缴费时间',
paymentAmount string comment '缴费金额:云币(个)/人民币(分)',
unitType string comment '单位类型:云币=1人民币=2',
incrValidUntil string comment '有效期增加天数',
validUntil string comment '有效期',
paymentCode string comment '续费吗',
payUser string comment '缴费人',
remark string comment '备注',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/esy_account_manage?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="t_account_payment_record",
  "mapred.jdbc.output.table.name" = "t_account_payment_record",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);





--e视云账户
--cloud_currency.account
--hive映射mysql2hive.cloud_currency_account:mysql中的cloud_currency.account
drop table mysql2hive.cloud_currency_account;
CREATE EXTERNAL TABLE mysql2hive.cloud_currency_account
(
id string comment 'id',
businessId string comment '创建帐号的业务id',
name string comment '帐户名称',
type string comment '帐号类型(用于类型区分)、ecloud(e视云)、generalledger(总帐)、section（科室）',
status string comment '状态 0正常，1 禁用',
totOut string comment '总收入',
totIncome string comment '总收入',
balance string comment '余额',
updateTime string comment '更新时间',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/cloud_currency?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="account",
  "mapred.jdbc.output.table.name" = "account",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);







--学币投入表
--credit.credit_invest
--hive映射mysql2hive.credit_credit_invest:mysql中的credit.credit_invest
drop table mysql2hive.credit_credit_invest;
CREATE EXTERNAL TABLE mysql2hive.credit_credit_invest
(
id string comment '主键ID',
business_code string comment '业务码',
amount string comment '投入金额',
init_amount string comment '初始金额',
remark string comment '备注说明',
create_time string comment '创建时间',
update_time string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/credit?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="credit_invest",
  "mapred.jdbc.output.table.name" = "credit_invest",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);



--学币投入表
--credit.credit_account_summary
--hive映射mysql2hive.credit_credit_account_summary:mysql中的credit.credit_account_summary
drop table mysql2hive.credit_credit_account_summary;
CREATE EXTERNAL TABLE mysql2hive.credit_credit_account_summary
(
id string comment '主键ID',
amount string comment '汇总金额',
type string comment '账户类型',
name string comment '中文名称',
create_time string comment '创建时间',
update_time string comment '更新时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/credit?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="credit_account_summary",
  "mapred.jdbc.output.table.name" = "credit_account_summary",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);




--学币投入表
--credit.credit_account
--hive映射mysql2hive.credit_credit_account:mysql中的credit.credit_account
drop table mysql2hive.credit_credit_account;
CREATE EXTERNAL TABLE mysql2hive.credit_credit_account
(
id string comment 'id',
account_type string comment '账户类型',
account_id string comment '账户id',
balance string comment '余额',
create_time string comment '创建时间',
update_time string comment '修改时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/credit?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="credit_account",
  "mapred.jdbc.output.table.name" = "credit_account",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);





--精品课堂素材表
--excellent_class.j_material
--hive映射mysql2hive.excellent_class_j_material:mysql中的excellent_class.j_material
drop table mysql2hive.excellent_class_j_material;
CREATE EXTERNAL TABLE mysql2hive.excellent_class_j_material
(
id string comment 'id',
title string comment '素材标题',
type string comment '类型1：视频；2音频',
labelDept string comment '科室标签',
labelDisease string comment '疾病标签',
labelCustom string comment '自定义标签',
audioVideo string comment '音频视频json字符串',
coverUrl string comment '封面图片',
status string comment '状态1：正常；2已删除',
updateTime string comment '更新时间',
createTime string comment '创建时间'
)
STORED BY 'org.apache.hadoop.hive.jdbc.storagehandler.JdbcStorageHandler'
TBLPROPERTIES (
  "mapred.jdbc.driver.class"="com.mysql.jdbc.Driver",
  "mapred.jdbc.url"="jdbc:mysql://192.168.3.162:3306/excellent_class?useSSL=false",
  "mapred.jdbc.username"="root",
  "mapred.jdbc.input.table.name"="j_material",
  "mapred.jdbc.output.table.name" = "j_material",
  "mapred.jdbc.password"="123456",
  "mapred.jdbc.hive.lazy.split"= "false"
);