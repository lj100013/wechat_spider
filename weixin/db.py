# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import pymysql
import configparser
conf = configparser.ConfigParser()
#conf.read(r"E:\job_script\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
HOST=conf.get('weixin', 'host')
PORT=int(conf.get('weixin', 'port'))
USER=conf.get('weixin', 'username')
PASSWORD=conf.get('weixin', 'password')
DB=conf.get('weixin', 'database')
CHARSET=conf.get('weixin', 'charset')

'''
----------------  正在爬取 xxx  -------------------
上传图片: xxx.jpg
上传图片: xxx.jpg
insert xxx 
title: md5 
post_date:xxx
插入类型：丁香园 ，对应的：id
----------------------------------------------------
'''


def process_item(item):
    # 数据库连接
    con = pymysql.connect(host=HOST, user=USER, passwd=PASSWORD, db=DB, charset=CHARSET, port=PORT)
    # 数据库游标
    cue = con.cursor()

    # get term_id
    term_id = ''
    str_sql = "SELECT term_id FROM wp_terms where name = '%s'" % (item["wxname"])
    cue.execute(str_sql)
    result = cue.fetchall()
    if len(result) == 1:
        term_id = result[0]

    remark = "<br />注：本网所有转载内容系出于传递信息之目的，且明确注明来源和/或作者，不希望被转载的媒体或个人可与我们联系，我们将立即进行删除处理，所有内容及观点仅供参考，不构成任何诊疗建议，对所引用信息的准确性和完整性不作任何保证"
    print("mysql connect succes")
    item["content"] = str(item["content"]) + remark
    try:
        cue.execute(
            "insert into wp_posts (post_author,post_date,post_date_gmt,post_content,post_title,post_status,post_name,guid,author,dept,source) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            ["1", item["create_time"], item["create_time"], item["content"], item["title"], "publish", item["gid"], item["gid"],
             item["author"], item["key_word"], item["wxname"], ])
        print("*" * 80)
        print("正在爬取:" + item["title"])
        print("{}：insert success".format(item["title"]))
        print("post_date:{}".format(item["create_time"]))
        print("插入来源：{} ，对应的id：{}".format(item["wxname"], item["gid"]))
        print("*" * 80)

        if term_id:
            str_sql = "INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),%s,0 from wp_posts limit 1" % (term_id)
            cue.execute(str_sql)
        # if item["wxname"] == "好医生":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),13,0 from wp_posts limit 1")
        # if item["wxname"] == "丁香园":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),3,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界消化肝病频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),12,0 from wp_posts limit 1")
        # if item["wxname"] == "小大夫漫画":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),11,0 from wp_posts limit 1")
        # if item["wxname"] == "消化界":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),15,0 from wp_posts limit 1")
        # if item["wxname"] == "MedSci梅斯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),26,0 from wp_posts limit 1")
        # if item["wxname"] == "华医网":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),29,0 from wp_posts limit 1")
        # if item["wxname"] == "IBD学术情报官":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),16,0 from wp_posts limit 1")
        # if item["wxname"] == "爱肝联盟":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),17,0 from wp_posts limit 1")
        # if item["wxname"] == "临床肝胆病杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),18,0 from wp_posts limit 1")
        # if item["wxname"] == "消化时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),19,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通消化科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),20,0 from wp_posts limit 1")
        # if item["wxname"] == "孙锋医生":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),21,0 from wp_posts limit 1")
        # if item["wxname"] == "基层医师公社":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),22,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),24,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界心血管频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),45,0 from wp_posts limit 1")
        # if item["wxname"] == "心血管时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),46,0 from wp_posts limit 1")
        # if item["wxname"] == "心在线":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),47,0 from wp_posts limit 1")
        # if item["wxname"] == "中国循环杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),48,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通心内频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),49,0 from wp_posts limit 1")
        # if item["wxname"] == "哈特瑞姆心脏之声":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),50,0 from wp_posts limit 1")
        # if item["wxname"] == "医学之声":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),25,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界急诊与重症频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),51,0 from wp_posts limit 1")
        # if item["wxname"] == "医路向前巍子":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),52,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界神经病学频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),53,0 from wp_posts limit 1")
        # if item["wxname"] == "神经时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),54,0 from wp_posts limit 1")
        # if item["wxname"] == "神经病学俱乐部":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),55,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通神经科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),56,0 from wp_posts limit 1")
        # if item["wxname"] == "国际眼科时讯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),57,0 from wp_posts limit 1")
        # if item["wxname"] == "医信眼科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),58,0 from wp_posts limit 1")
        # if item["wxname"] == "眼视光观察":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),59,0 from wp_posts limit 1")
        # if item["wxname"] == "视远惟明▪惟视眼科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),60,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通泌尿外科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),61,0 from wp_posts limit 1")
        # if item["wxname"] == "泌尿科那点事儿":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),62,0 from wp_posts limit 1")
        # if item["wxname"] == "泌尿外科郭医生":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),63,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界外科频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),64,0 from wp_posts limit 1")
        # if item["wxname"] == "中国实用外科杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),65,0 from wp_posts limit 1")
        # if item["wxname"] == "儿科时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),66,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界儿科频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),67,0 from wp_posts limit 1")
        # if item["wxname"] == "国际儿科学杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),68,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界精神病学频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),69,0 from wp_posts limit 1")
        # if item["wxname"] == "国际皮肤性病学杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),70,0 from wp_posts limit 1")
        # if item["wxname"] == "儿科学大查房":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),71,0 from wp_posts limit 1")
        # if item["wxname"] == "人卫儿科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),72,0 from wp_posts limit 1")
        # if item["wxname"] == "中国儿科前沿论坛":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),73,0 from wp_posts limit 1")
        # if item["wxname"] == "皮肤时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),74,0 from wp_posts limit 1")
        # if item["wxname"] == "实用皮肤病学杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),75,0 from wp_posts limit 1")
        # if item["wxname"] == "肝胆外科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),76,0 from wp_posts limit 1")
        # if item["wxname"] == "肾内时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),77,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通肾内频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),78,0 from wp_posts limit 1")
        # if item["wxname"] == "透析圈":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),79,0 from wp_posts limit 1")
        # if item["wxname"] == "感染时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),80,0 from wp_posts limit 1")
        # if item["wxname"] == "SIFIC感染官微":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),81,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通抗感染":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),82,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界感染频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),83,0 from wp_posts limit 1")
        # if item["wxname"] == "中华医学网":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),84,0 from wp_posts limit 1")
        # if item["wxname"] == "海上柳叶刀":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),85,0 from wp_posts limit 1")
        # if item["wxname"] == "医学内刊":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),23,0 from wp_posts limit 1")
        # if item["wxname"] == "每日医学资讯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),86,0 from wp_posts limit 1")
        # if item["wxname"] == "医师报":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),87,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),88,0 from wp_posts limit 1")
        # if item["wxname"] == "健康界":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),89,0 from wp_posts limit 1")
        # if item["wxname"] == "生物谷":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),90,0 from wp_posts limit 1")
        # if item["wxname"] == "看医界":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),91,0 from wp_posts limit 1")
        # if item["wxname"] == "内分泌时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),92,0 from wp_posts limit 1")
        # if item["wxname"] == "神经科技":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),93,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界风湿免疫频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),94,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界临床药学频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),95,0 from wp_posts limit 1")
        # if item["wxname"] == "老虎讲骨":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),96,0 from wp_posts limit 1")
        # if item["wxname"] == "放疗时空":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),97,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界检验频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),98,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界影像诊断与介入频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),99,0 from wp_posts limit 1")
        # if item["wxname"] == "放射沙龙":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),100,0 from wp_posts limit 1")
        # if item["wxname"] == "健康点healthpoint":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),101,0 from wp_posts limit 1")
        # if item["wxname"] == "肿瘤时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),102,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界肿瘤频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),103,0 from wp_posts limit 1")
        # if item["wxname"] == "感染科空间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),104,0 from wp_posts limit 1")
        # if item["wxname"] == "SIFIC感染科普笔记":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),105,0 from wp_posts limit 1")
        # if item["wxname"] == "下夜班":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),106,0 from wp_posts limit 1")
        # if item["wxname"] == "医闻速递":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),107,0 from wp_posts limit 1")
        # if item["wxname"] == "三甲传真":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),108,0 from wp_posts limit 1")
        # if item["wxname"] == "创新医学网":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),109,0 from wp_posts limit 1")
        # if item["wxname"] == "爱肝一生微课堂":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),110,0 from wp_posts limit 1")
        # if item["wxname"] == "国际肝胆胰疾病杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),111,0 from wp_posts limit 1")
        # if item["wxname"] == "胃肠肿瘤外科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),112,0 from wp_posts limit 1")
        # if item["wxname"] == "儿科助手":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),113,0 from wp_posts limit 1")
        # if item["wxname"] == "中华儿科杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),114,0 from wp_posts limit 1")
        # if item["wxname"] == "儿科空间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),115,0 from wp_posts limit 1")
        # if item["wxname"] == "中国实用儿科杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),116,0 from wp_posts limit 1")
        # if item["wxname"] == "皮肤科钟华":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),117,0 from wp_posts limit 1")
        # if item["wxname"] == "CSDCMA皮科时讯论坛":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),118,0 from wp_posts limit 1")
        # if item["wxname"] == "医生汇心血管论坛":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),119,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通急诊重症科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),120,0 from wp_posts limit 1")
        # if item["wxname"] == "急诊医学资讯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),121,0 from wp_posts limit 1")
        # if item["wxname"] == "中国急救医学杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),122,0 from wp_posts limit 1")
        # if item["wxname"] == "急诊时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),123,0 from wp_posts limit 1")
        # if item["wxname"] == "中国小儿急救医学":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),124,0 from wp_posts limit 1")
        # if item["wxname"] == "重症医学":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),125,0 from wp_posts limit 1")
        # if item["wxname"] == "精神时间":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),126,0 from wp_posts limit 1")
        # if item["wxname"] == "精神康复":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),127,0 from wp_posts limit 1")
        # if item["wxname"] == "医脉通精神科":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),128,0 from wp_posts limit 1")
        # if item["wxname"] == "大话精神":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),129,0 from wp_posts limit 1")
        # if item["wxname"] == "神经科的那些事":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),130,0 from wp_posts limit 1")
        # if item["wxname"] == "神经医学社区":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),131,0 from wp_posts limit 1")
        # if item["wxname"] == "神经脊柱时讯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),132,0 from wp_posts limit 1")
        # if item["wxname"] == "医学界呼吸频道":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),133,0 from wp_posts limit 1")
        # if item["wxname"] == "中国眼科医生":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),134,0 from wp_posts limit 1")
        # if item["wxname"] == "SIFIC感染循证资讯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),135,0 from wp_posts limit 1")
        # if item["wxname"] == "中华消化外科杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),136,0 from wp_posts limit 1")
        # if item["wxname"] == "朝阳心脏超声":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),137,0 from wp_posts limit 1")
        # if item["wxname"] == "危重症文献学习":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),138,0 from wp_posts limit 1")
        # if item["wxname"] == "中华重症医学电子杂志":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),139,0 from wp_posts limit 1")
        # if item["wxname"] == "神经现实":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),140,0 from wp_posts limit 1")
        # if item["wxname"] == "神经介入资讯":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),141,0 from wp_posts limit 1")
        # if item["wxname"] == "医药魔方":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),142,0 from wp_posts limit 1")
        # if item["wxname"] == "赛博蓝":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),143,0 from wp_posts limit 1")
        # if item["wxname"] == "中洪博元医学实验帮":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),144,0 from wp_posts limit 1")
        # if item["wxname"] == "医咖会":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),145,0 from wp_posts limit 1")
        # if item["wxname"] == "生物学霸":
        #     cue.execute(
        #         " INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),146,0 from wp_posts limit 1")
    except Exception as e:
        print('Insert error:', e)
        con.rollback()
    else:
        con.commit()
    con.close()
    return item
