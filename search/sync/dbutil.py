from elasticsearch import Elasticsearch
import pymongo
import pymysql
import configparser
conf = configparser.ConfigParser()
conf.read("/data/job_pro/utils/config.ini")
MYSQL_HOST=conf.get('mysql', 'host')
MYSQL_PORT=int(conf.get('mysql', 'port'))
MYSQL_USER=conf.get('mysql', 'user')
MYSQL_PASSWORD=conf.get('mysql', 'password')
ES_HOST=conf.get('es', 'host')
ES_PORT=int(conf.get('es', 'port'))
MONGO_HOST=conf.get('mongo', 'host')
MONGO_PORT=conf.get('mongo', 'port')
MONGO_USER=conf.get('mongo', 'user')
MONGO_PASSWORD=conf.get('mongo', 'password')

MONGO_CONECT = "mongodb://" + MONGO_HOST + ":" + MONGO_PORT + "/"
mysqlcircledb = pymysql.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, "circle")
mysqlcoursedb = pymysql.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, "circle_school")
es = Elasticsearch([{'host': ES_HOST, 'port': ES_PORT}])
mysql_settings = {'host': MYSQL_HOST, 'port': MYSQL_PORT, 'user': MYSQL_USER, 'passwd': MYSQL_PASSWORD}
mongoclient = pymongo.MongoClient(MONGO_CONECT,username=MONGO_USER,password=MONGO_PASSWORD)
starttime=1544976000

# 生产环境
#mysqlcircledb = pymysql.connect("120.79.73.179", "etl_user", "readsgaP3", "circle")
#mysqlcoursedb = pymysql.connect("120.79.73.179", "etl_user", "readsgaP3", "circle_school")
#es = Elasticsearch([{'host': '39.108.135.243', 'port': 9280}])
#mysql_settings = {'host': '120.79.73.179', 'port': 3306, 'user': 'etl_user', 'passwd': 'readsgaP3'}
#mongoclient = pymongo.MongoClient('mongodb://120.79.73.179:27017/',username='etl_user',password='readsgaP3')
#starttime=1561392000
