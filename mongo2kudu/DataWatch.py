import datetime
import pymongo
from impala.dbapi import connect
import pymysql
import sys
import configparser
import smtplib
from email.mime.text import MIMEText

conf = configparser.ConfigParser()
conf.read(r"D:\job_script\utils\config.ini")
# conf.read("/data/job_pro/utils/config.ini")
CONF_HOST = conf.get('conf_mysql', 'host')
CONF_PORT = conf.get('conf_mysql', 'port')
CONF_UN = conf.get('conf_mysql', 'username')
CONF_PW = conf.get('conf_mysql', 'password')
CONF_DB = conf.get('conf_mysql', 'database')
database = sys.argv[1].split('.')[0]
table = sys.argv[1].split('.')[1]

# 导入mysql配置表
config_con = pymysql.connect(host=CONF_HOST, port=int(CONF_PORT), user=CONF_UN, password=CONF_PW, db=CONF_DB)
config_cur = config_con.cursor()
try:
    sql = "select * from test.KuduETL_config where kudu_db='%s' and kudu_collection='%s';" % (database,table)
    config_cur.execute(sql)
    results = config_cur.fetchone()
    # print(results)
    source_type = results[0]
    source_host = results[1]
    source_port = results[2]
    source_username = results[3]
    source_password = results[4]
    source_db = results[5]
    source_collection = results[6]
    kudu_host = results[7]
    kudu_port = results[8]
    kudu_db = results[9]
    kudu_collection = results[10]
except:
   print ("Error: unable to fetch data")
finally:
    config_con.close()

# 统计来源数据
if source_type == 'mongo':
    mongo_con = pymongo.MongoClient(host=source_host, port=int(source_port), username=source_username, password=source_password)
    mongo_db = mongo_con.get_database(source_db)
    mongo_collection = mongo_db.get_collection(source_collection)
    try:
        source_count = mongo_collection.find().count()
    except:
        print("Error: unable to fetch data")
    finally:
        mongo_con.close()
elif source_type == 'mysql':
    mysql_con = pymysql.connect(host=source_host, port=int(source_port), user=source_username, password=source_password,db=source_db)
    mysql_cur = mysql_con.cursor()
    try:
        sql = "select count(*) from %s" % (source_collection)
        mysql_cur.execute(sql)
        source_count = mysql_cur.fetchone()[0]
    except:
        print("Error: unable to fetch data")
    finally:
        mysql_con.close()

# 统计kudu数据
kudu_con = connect(host=kudu_host, port=int(kudu_port),user='hive',password='hive')
kudu_cur = kudu_con.cursor()
sql = 'select count(*) from %s.%s;' % (kudu_db,kudu_collection)
kudu_cur.execute(sql)
kudu_count = kudu_cur.fetchall()[0][0]

date =  datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
difference = abs(source_count-kudu_count)

# 如果不一致，发送邮件
if difference != 0:
    mailserver = "smtp.163.com"
    username_send = 'kuduconfig@163.com'
    password = 'a123456'
    username_recv = ['kuduconfig@163.com', 'user2@dachentech.com.cn']
    content=  '<table color="CCCC33" width="800" border="1" cellspacing="0" cellpadding="5" text-align="center">' \
                        '<tr>' \
                                '<td style="background:#000; color:#FFF"><center><b>统计时间</b></center></td>' \
                                '<td style="background:#000; color:#FFF"><center><b>源表类型</b></center></td>' \
                                '<td style="background:#000; color:#FFF"><center><b>源表</b></center></td>' \
                                '<td style="background:#000; color:#FFF"><center><b>源表总数</b></center></td>' \
                                '<td style="background:#000; color:#FFF"><center><b>目标表</b></center></td>' \
                                '<td style="background:#000; color:#FFF"><center><b>目标表总数</b></center></td>' \
                                '<td style="background:#000; color:#FFF"><center><b>差值</b></center></td>' \
                        '</tr>' \
                        '<tr>' \
                                '<td><center>%s</center></td>' \
                                '<td><center>%s</center></td>' \
                                '<td><center>%s.%s</center></td>' \
                                '<td><center>%s</center></td>' \
                                '<td><center>%s.%s</center></td>' \
                                '<td><center>%s</center></td>' \
                                '<td><font color="#FF0000"><center>%s</center><font></td>' \
              '</tr>' \
              '</table>' % (date,source_type.upper(),source_db,source_collection,source_count,kudu_db,kudu_collection,kudu_count,difference)
    mail = MIMEText(content,"html","utf-8")
    mail['Subject'] = '错误：数据不一致'
    mail['From'] = username_send
    mail['To'] = ','.join(username_recv)
    try:
        smtp = smtplib.SMTP(mailserver, port=25)  # 连接邮箱服务器，smtp的端口号是25
        # smtp=smtplib.SMTP_SSL('smtp.qq.com',port=465) #QQ邮箱的服务器和端口号
        smtp.login(username_send, password)
        smtp.sendmail(username_send, username_recv, mail.as_string())  # 参数分别是发送者，接收者，第三个是把上面的发送邮件的内容变成字符串
        print("发送成功")
    except smtp.SMTPException:
        print("发送失败")
    finally:
        smtp.quit()