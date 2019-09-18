import configparser

config = configparser.ConfigParser()

#config.read(r"F:\bigdata_project\utils\config.ini")
config.read("/data/job_pro/utils/config.ini")
words_lib_path = "/data/job_pro/dataX/3content/utils/words_lib"
stop_words_path = '/data/job_pro/dataX/3content/utils/stop_words.txt'
#mysql config
mysql_host = config.get('weixin', 'host')
mysql_port = config.getint('weixin', 'port')
mysql_user = config.get('weixin', 'username')
mysql_password = config.get('weixin', 'password')
mysql_db = config.get('weixin', 'database')

#mongo config
mongo_host = config.get('mongo', 'host')
mongo_port = config.getint('mongo', 'port')
mongo_user = config.get('mongo', 'user')
mongo_password = config.get('mongo', 'password')
mongo_authentication = config.get('mongo', 'authentication')

#发帖接口地址
yyr_post_url = config.get('3content', 'yyr_post_info_url')