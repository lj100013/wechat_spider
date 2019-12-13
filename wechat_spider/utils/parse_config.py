import configparser

conf = configparser.ConfigParser()
#conf.read(r"F:\bigdata_project\utils\config.ini")
conf.read("/data/job_pro/utils/config.ini")
mysql_host=conf.get('weixin', 'host')
mysql_port=int(conf.get('weixin', 'port'))
mysql_user=conf.get('weixin', 'username')
mysql_password=conf.get('weixin', 'password')
mysql_db=conf.get('weixin', 'database')
mysql_charset=conf.get('weixin', 'charset')

img_base_url=conf.get('weixin', 'img_base_url')
qiniu_service_url=conf.get('weixin', 'qiniu_service_url')