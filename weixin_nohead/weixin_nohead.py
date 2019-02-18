# -*- coding:utf-8 -*-
import pymysql
from lxml import etree


def replace_block(rsp, content, blocks):
    for block in blocks:
        words = block.split(" ")
        head  = words[0].replace("<", "")
        if 'p>' in head:
            head = 'p'
        content_nodes = rsp.xpath('//'+ head)
        if content_nodes == False:
            continue

        block_score = []
        print(str(len(content_nodes)))
        for node in content_nodes:
            n_content = etree.tostring(node, method='html').decode("utf-8")
            score = block_sim(block, n_content)
            block_score.append((n_content, score))

        if len(block_score) > 0:
            final_list = sorted(block_score, key=lambda x: x[1], reverse=True)
            print(str(final_list[0][1]))
            final_block = final_list[0][0]
            if final_list[0][1] > 0.43:
                content = content.replace(final_block, '')
                print("delete block *******")
                print(final_block)
                if '<!--more-->' in final_block:
                    content = add_more(content)
    return content


def block_sim(block1, block2):
    blocks1 = block1.split(' ')
    blocks2 = block2.split(' ')
    words1 = set()
    words2 = set()
    all_words = set()
    common_count = 0

    for word in blocks1:
        words1.add(word)
        all_words.add(word)

    for word in blocks2:
        words2.add(word)
        all_words.add(word)

    for word2 in words2:
        if word2 in words1:
            common_count += 1
    score = common_count/len(all_words)
    return score

def replace_content(gid, wxname, content):
    rsp = etree.HTML(content)
    replace_strs = get_delete_blocks(wxname)
    rule_count = len(replace_strs)
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
        print(str(len(content_nodes)))
        for node in content_nodes:
            n_content = etree.tostring(node, method='html').decode("utf-8")
            score = block_sim(block, n_content)
            block_score.append((n_content, score))

        if len(block_score) > 0:
            final_list = sorted(block_score, key=lambda x: x[1], reverse=True)
            final_block = final_list[0][0]
            if final_list[0][1] > 0.43:
                content = content.replace(final_block, '')
                match_count += 1
                if '<!--more-->' in final_block:
                    content = add_more(content)

    write_wechat_matched(gid, wxname, rule_count, match_count)
    return content

def add_more(content):
    c_list = content.split("</p>")
    if len(c_list) >= 2:
        str_content = c_list[0] + '</p>' + c_list[1] + '</p>' + '\n<!--more-->'
        str_left = '</p>'.join(c_list[2:])
        content = str_content + str_left
    return content

def save_delete_blocks(wxname):
    replace_strs = get_delete_blocks(wxname)
    datas = []

    if len(replace_strs) > 0:
        for rs in replace_strs:
            datas.append((rs, wxname))

        # 数据库连接
        con = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')
        # 数据库游标
        cue = con.cursor()
        try:
            cue.executemany('INSERT INTO wp_delete_blocks (blocks,source) values(%s,%s)', datas)
        except Exception as e:
            print('Insert error:', e)
            con.rollback()
        else:
            con.commit()
        con.close()

    write_wechat_matched(wxname, 1)


def update_wechat_matched(wxname, num):
    db = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')
    cursor = db.cursor()
    try:
        str_sql = 'update wp_wechat_matched set matched = %d where wechat_name = "%s"' % (num, wxname)
        cursor.execute(str_sql)
        db.commit()
    except Exception as e:
        db.rollback()
        print(e)
    finally:
        db.close()


def save_delete_block(block, wxname):
    if block and wxname:
        # 数据库连接
        con = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')
        # 数据库游标
        cue = con.cursor()
        try:
            cue.execute('INSERT INTO wp_delete_blocks (blocks,source) values(%s,%s)', [block, wxname])
        except Exception as e:
            print('Insert error:', e)
            con.rollback()
        else:
            con.commit()
        con.close()


def write_wechat_matched(id, wxname, count, num):
    db = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')
    cursor = db.cursor()

    try:
        cursor.execute("insert into wp_wechat_matched (ID,wechat_name, rule_count, matched) values(%s, %s, %s, %s)", [id, wxname, count, num])
        db.commit()
    except Exception as e:
        db.rollback()
        print(e)
    finally:
        db.close()


def get_delete_blocks(wxname):
    # 打开数据库连接
    db = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()

    sql = 'select blocks from wp_delete_blocks where source = "%s"' % (wxname)
    # 执行SQL语句
    cursor.execute(sql)
    records = cursor.fetchall()
    datas = []
    for record in records:
        block = record[0]
        if block:
            datas.append(block)
    return datas

def save_replace_content(wxname):
    # 打开数据库连接
    db = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()

    sql = 'select * from wp_posts where source = "%s"' % (wxname)
    # 执行SQL语句
    cursor.execute(sql)
    records = cursor.fetchall()
    for record in records:
        datas = []
        content = record[4]
        new_content = replace_content(wxname, content)

        for n in range(0, len(record)):
            if n == 4:
                datas.append(new_content)
            else:
                datas.append(record[n])

        # 打开数据库连接
        db2 = pymysql.connect("192.168.3.154", "root", "Dachen@222", "wordpress", charset='utf8')

        # 使用 cursor() 方法创建一个游标对象 cursor
        cursor2 = db2.cursor()

        try:
            cursor2.execute(
                "insert into wp_posts_nohead (ID,post_author,post_date,post_date_gmt,post_content,post_title,post_excerpt,post_status,comment_status,ping_status,post_password,post_name,to_ping,pinged,post_modified,post_modified_gmt,post_content_filtered,post_parent,guid,menu_order,post_type,post_mime_type,comment_count,author,dept,source,term_id,post_flag,faq_id) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                datas)
            db2.commit()
        except Exception as e:
            db2.rollback()
            print(e)
        finally:
            db2.close()
    db.close()


if __name__ == '__main__':
    wechat_names = ["每日医学资讯", "医师报", "医脉通", "健康界", "生物谷", "心在线", "中国循环杂志",
                    "哈特瑞姆心脏之声", "医学之声", "医路向前巍子",
                    "神经时间", "神经病学俱乐部", "国际眼科时讯", "医信眼科", "眼视光观察", "泌尿科那点事儿",
                    "中国实用外科杂志", "国际儿科学杂志", "儿科学大查房",
                    "人卫儿科", "中国儿科前沿论坛", "皮肤时间", "实用皮肤病学杂志", "肾内时间", "透析圈", "感染时间", "SIFIC感染官微",
                    "中华医学网", "海上柳叶刀", "医学内刊", "内分泌时间", "神经科技", "老虎讲骨",
                    "放疗时空", "放射沙龙", "健康点healthpoint", "肿瘤时间", "感染科空间", "SIFIC感染科普笔记",
                    "下夜班", "医闻速递", "三甲传真", "创新医学网", "爱肝一生微课堂", "国际肝胆胰疾病杂志", "胃肠肿瘤外科", "儿科助手", "儿科空间",
                    "中国实用儿科杂志",
                    "皮肤科钟华", "CSDCMA皮科时讯论坛", "医生汇心血管论坛", "急诊医学资讯", "中国急救医学杂志", "急诊时间", "中国小儿急救医学",
                    "精神时间", "精神康复", "大话精神", "神经医学社区", "神经脊柱时讯", "中国眼科医生",
                    "SIFIC感染循证资讯", "中华消化外科杂志", "朝阳心脏超声", "中华重症医学电子杂志", "神经现实", "神经介入资讯",
                    "医药魔方", "赛博蓝", "中洪博元医学实验帮", "医咖会", "生物学霸"
                    ]

    # for wxname in wechat_names:
    #     save_replace_content(wxname)
        #update_wechat_matched(wxname, 2)
