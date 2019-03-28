# -*- coding:utf-8 -*-
import pymysql
        print(str(len(content_nodes)))
import lxml.html
etree = lxml.html.etree
import logging
logging.basicConfig(level = logging.INFO,format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
import dbutil
from cos_sim import  cosine


def replace_fail(post_name):
    print("fail:"+post_name)
    datas =[]
    datas.append(post_name)
    sql = 'update wp_posts set ad_flag="fail" where post_name="%s"' %(post_name)
    db.update(sql)

def update_term_relationships(post_name,wxname):
    print("sucess:"+post_name)
    sql_term='select term_id from wp_terms where name="%s"' % wxname
    term_taxonomy_id=db2.queryone(sql_term)
    tid=term_taxonomy_id[0]
    print(type(tid))
    sql_updateterm = 'INSERT INTO wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT max(id),"%d",0 from wp_posts limit 1' % (tid)
    db2.update(sql_updateterm)

def replace_content(post_name,wxname, content):
    rsp = etree.HTML(content)
    replace_strs = get_delete_blocks(wxname)
    if len(replace_strs)==0:
        logging.info("------没有匹配的删除块-----:"+wxname)
        return
    match_count = 0
    for block in replace_strs:
        words = block.split(" ")
        head  = words[0].replace("<", "")
        if 'p>' in head:
            head = 'p'
        content_nodes = rsp.xpath('//'+ head)
        if content_nodes == False:
            continue
        block_score = []
        for node in content_nodes:
            n_content = etree.tostring(node, method='html').decode("utf-8")
            # score = block_sim(block, n_content)
            score = cosine(block,n_content)
            block_score.append((n_content, score))

        if len(block_score) > 0:
            final_list = sorted(block_score, key=lambda x: x[1], reverse=True)
            final_block = final_list[0][0]
            if final_list[0][1] > 70:
                content = content.replace(final_block, '')
                match_count += 1
                if '<!--more-->' in final_block:
                    content = add_more(content)
    return content

def add_more(content):
    c_list = content.split("</p>")
    if len(c_list) >= 2:
        str_content = c_list[0] + '</p>' + c_list[1] + '</p>' + '\n<!--more-->'
        str_left = '</p>'.join(c_list[2:])
        content = str_content + str_left
    return content


def get_delete_blocks(wxname):
    sql = 'select blocks from wp_delete_blocks where source = "%s"' % (wxname)
    records = db.query(sql)
    datas = []
    for record in records:
        block = record[0]
        if block:
            datas.append(block)
    return datas

def save_replace_content(wxname):
    sql = 'select post_author,post_date,post_date_gmt,post_content,post_title,post_status,post_name,post_modified,post_modified_gmt,guid,post_type,author,dept,source,term_id,post_flag from wp_posts where ad_flag is null and source = "%s"'% (wxname)
    records = db.query(sql)
    for record in records:
        datas = []
        content = record[3]
        post_name = record[6]
        new_content = replace_content(post_name,wxname, content)
        if new_content==content or new_content is None:
            replace_fail(post_name)
        else:
            for n in range(0, len(record)):
                if n == 3:
                    datas.append(new_content)
                else:
                    datas.append(record[n])
            db2.insert("insert into wp_posts (post_author,post_date,post_date_gmt,post_content,post_title,post_status,post_name,post_modified,post_modified_gmt,guid,post_type,author,dept,source,term_id,post_flag) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",datas)
            sql_update_flag='update wp_posts set ad_flag="success" where post_name="%s"' % (post_name)
            db.update(sql_update_flag)
            update_term_relationships(post_name,wxname)
if __name__ == '__main__':
    # wechat_names = ["每日医学资讯", "医师报", "医脉通", "健康界", "生物谷", "心在线", "中国循环杂志",
    #                 "哈特瑞姆心脏之声", "医学之声", "医路向前巍子",
    #                 "神经时间", "神经病学俱乐部", "国际眼科时讯", "医信眼科", "眼视光观察", "泌尿科那点事儿",
    #                 "中国实用外科杂志", "国际儿科学杂志", "儿科学大查房",
    #                 "人卫儿科", "中国儿科前沿论坛", "皮肤时间", "实用皮肤病学杂志", "肾内时间", "透析圈", "感染时间", "SIFIC感染官微",
    #                 "中华医学网", "海上柳叶刀", "医学内刊", "内分泌时间", "神经科技", "老虎讲骨",
    #                 "放疗时空", "放射沙龙", "健康点healthpoint", "肿瘤时间", "感染科空间", "SIFIC感染科普笔记",
    #                 "下夜班", "医闻速递", "三甲传真", "创新医学网", "爱肝一生微课堂", "国际肝胆胰疾病杂志", "胃肠肿瘤外科", "儿科助手", "儿科空间",
    #                 "中国实用儿科杂志",
    #                 "皮肤科钟华", "CSDCMA皮科时讯论坛", "医生汇心血管论坛", "急诊医学资讯", "中国急救医学杂志", "急诊时间", "中国小儿急救医学",
    #                 "精神时间", "精神康复", "大话精神", "神经医学社区", "神经脊柱时讯", "中国眼科医生",
    #                 "SIFIC感染循证资讯", "中华消化外科杂志", "朝阳心脏超声", "中华重症医学电子杂志", "神经现实", "神经介入资讯",
    #                 "医药魔方", "赛博蓝", "中洪博元医学实验帮", "医咖会", "生物学霸"
    #                 ]
    wechat_names = ["每日医学资讯"]
    db = dbutil.DB("192.168.3.122",3306,"root", "dachen@123", "wordpress")
    db2 = dbutil.DB("192.168.3.122",3306,"root", "dachen@123", "wordpress2")
    for wxname in wechat_names:
        save_replace_content(wxname)
    db.close()
    db2.close()