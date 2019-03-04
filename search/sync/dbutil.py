from elasticsearch import Elasticsearch
import pymongo
import pymysql

# 生产环境
mysqlcircledb = pymysql.connect("120.79.73.179", "etl_user", "readsgaP3", "circle")
mysqlcoursedb = pymysql.connect("120.79.73.179", "etl_user", "readsgaP3", "circle_school")
es = Elasticsearch([{'host': '39.108.135.243', 'port': 9280}])
mysql_settings = {'host': '120.79.73.179', 'port': 3306, 'user': 'etl_user', 'passwd': 'readsgaP3'}
mongoclient = pymongo.MongoClient('mongodb://120.79.73.179:27017/',username='etl_user',password='readsgaP3')
starttime=1551628800

# mysqlcircledb = pymysql.connect("192.168.3.162", "root", "123456", "circle")
# mysqlcoursedb = pymysql.connect("192.168.3.162", "root", "123456", "circle_school")
# es = Elasticsearch([{'host': '192.168.3.121', 'port': 9200}])
# mysql_settings = {'host': '192.168.3.162', 'port': 3306, 'user': 'root', 'passwd': '123456'}
# mongoclient = pymongo.MongoClient('mongodb://192.168.3.162:27017/',username='admin',password='SOh3TbYhx8ypJPxmt')
# starttime=1544976000