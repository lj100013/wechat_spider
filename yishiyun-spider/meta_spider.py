# -*- coding:utf-8 -*-
from abc import abstractmethod
import configparser
import logging
import pymysql
import hashlib
import requests
import base64
import json
from urllib import request
from datetime import timedelta, date

class Spider(object):
    """YISHIYUN meta Spider definition."""

    def __init__(self,
                 first_time,
                 retryTimes=3):
        self.retryTimes = retryTimes
        self.first_time = first_time

    @abstractmethod
    def crawl_page_source(self, url):
        """crawl page source from web """
        pass

    def _parseConfig(self):
        conf = configparser.ConfigParser()
        conf.read("config.ini")
        secs = conf.sections()
        #mysql
        host = conf.get('mysqldb', 'host')
        port = conf.getint('mysqldb', 'port')
        user = conf.get('mysqldb', 'user')
        password = conf.get('mysqldb', 'password')
        db = conf.get('mysqldb', 'db1')
        charset = conf.get('mysqldb', 'charset')
        #七牛云地址
        self.qiuniu_url = conf.get('qiniu', 'url')
        self.replace_host = conf.get('qiniu', 'replace_host')
        con = pymysql.connect(host=host, port=port, user=user, passwd=password, db=db, charset=charset)
        con.autocommit(True)
        cue = con.cursor()
        return con,cue

    def _get_name_term_id(self,name):
        """
        get id of source name
        """
        con, cue = self._parseConfig()
        cue.execute("select term_id from wp_terms where name = '{}'".format(name))
        result = cue.fetchall()
        if len(result) >= 1:
            term_id = result[0][0]
        else:
            logging.error("failed to get the term_id of name")
            term_id = None
        con.close()
        return term_id

    def save_data2db(self,item):
        """
        save data into mysql db
        """
        con,cue = self._parseConfig()
        remark = "<br />注：本网所有转载内容系出于传递信息之目的，且明确注明来源和/或作者，不希望被转载的媒体或个人可与我们联系，我们将立即进行删除处理，所有内容及观点仅供参考，不构成任何诊疗建议，对所引用信息的准确性和完整性不作任何保证"
        item["content"] = str(item["content"]) + remark
        try:
            cue.execute(
                "insert into wp_posts (post_author,post_date,post_date_gmt,post_content,post_title,post_status,post_name,guid,author,dept,source) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                ["1", item["create_time"], item["create_time"], item["content"], item["title"], "publish", item["gid"],
                 item["gid"],item["author"], item["dept"], item["source"], ])
            term_id = self._get_name_term_id(item['source'])
            cue.execute(
                "INSERT INTO wordpress.wp_term_relationships(object_id,term_taxonomy_id, term_order)  SELECT LAST_INSERT_ID(),{},0 from wp_posts limit 1".format(term_id)
            )
            logging.info("insert into db successfully!")
        except Exception as e:
            logging.warning("failed to insert data into mysql:{}".format(e))
            con.rollback()
        finally:
            con.close()

    def is_exists(self,guid):
        """return if the title exists in db"""
        con,cue = self._parseConfig()
        try:
            cue.execute("SELECT post_name FROM wp_posts where guid = '%s'" % (guid))
            result = cue.fetchall()
            con.close()
            if len(result) > 0:
                return True
            else:
                return False
        except Exception as e:
            con.close()
            logging.error('failed to query mysql:{}'.format(e))


    def parse_title(self,title):
        ids = title
        if len(title) < 2:
            logging.warning("the title should be not empty")
            return ""
        try:
            post_name = hashlib.md5(ids.encode(encoding='UTF-8')).hexdigest()
            return post_name
        except Exception as e:
            logging.error("Existing illegal chars in title:{}".format(e))
            return ''

    def replace_img_url(self,imgUrls,content,source):
        for link0 in imgUrls:
            if source == '医脉通web':
                if '../..' in link0:
                    link1 = link0.replace('../..','http://news.medlive.cn')
                elif 'http://cmsadmin.medlive.cn' in link0:
                    link1 = link0.replace('http://cmsadmin.medlive.cn','http://news.medlive.cn')
                elif 'http://' not in link0:
                    link1 = 'http://news.medlive.cn' + link0
                else:
                    link1 = link0
                content = content.replace('<p class="txt_888">(&#26412;&#32593;&#31449;&#25152;&#26377;&#20869;&#23481;&#65292;&#20961;&#27880;&#26126;&#26469;&#28304;&#20026;&#8220;&#21307;&#33033;&#36890;&#8221;&#65292;&#29256;&#26435;&#22343;&#24402;&#21307;&#33033;&#36890;&#25152;&#26377;&#65292;&#26410;&#32463;&#25480;&#26435;&#65292;&#20219;&#20309;&#23186;&#20307;&#12289;&#32593;&#31449;&#25110;&#20010;&#20154;&#19981;&#24471;&#36716;&#36733;&#65292;&#21542;&#21017;&#23558;&#36861;&#31350;&#27861;&#24459;&#36131;&#20219;&#65292;&#25480;&#26435;&#36716;&#36733;&#26102;&#39035;&#27880;&#26126;&#8220;&#26469;&#28304;&#65306;&#21307;&#33033;&#36890;&#8221;&#12290;&#26412;&#32593;&#27880;&#26126;&#26469;&#28304;&#20026;&#20854;&#20182;&#23186;&#20307;&#30340;&#20869;&#23481;&#20026;&#36716;&#36733;&#65292;&#36716;&#36733;&#20165;&#20316;&#35266;&#28857;&#20998;&#20139;&#65292;&#29256;&#26435;&#24402;&#21407;&#20316;&#32773;&#25152;&#26377;&#65292;&#22914;&#26377;&#20405;&#29359;&#29256;&#26435;&#65292;&#35831;&#21450;&#26102;&#32852;&#31995;&#25105;&#20204;&#12290;)</p>','')
            else:
                link1 = link0
            link_list = link0.split("/")
            strName = link_list[-1]
            fname = base64.b64encode(strName.encode('utf-8'))
            fname = fname.decode('utf-8')
            img_format = '.png'
            if '.jpeg' in link0:
                img_format = '.jpeg'
            elif '.gif' in link0:
                img_format = '.gif'
            elif '.jpg' in link0:
                img_format = '.jpg'
            first_string = 'src="'+ self.replace_host + 'esy_'+fname + img_format
            origian_first = 'src="' + link0
            content = content.replace(origian_first, first_string)
            file_name = 'esy_' + fname + img_format
            try:
                self.write2_qiniu(link1, file_name)
            except Exception as e:
                logging.error("failed to upload pic into qiniu!:{}".format(e))
        return content

    def write2_qiniu(self,imgUrl, name):
        """
        sava image into qiniu
        """
        try:
            img = requests.get(url=imgUrl)
            pic = base64.b64encode(img.content)
            qiniu_data = {"fileName": name, "contentBytes": pic.decode(encoding='utf-8')}
            textmod = json.dumps(qiniu_data).encode(encoding='utf-8')
            header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
                           "Content-Type": "application/json"}
            req = request.Request(url=self.qiuniu_url, data=textmod, headers=header_dict)
            res = request.urlopen(req)

        except Exception as e:
            logging.warning("retry to save image into qiniu:{}".format(e))

    def get_deadline(self,days_ago):
        '''
         if n>=0,date is larger than today
         if n<0,date is less than today
         date format = "YYYY-MM-DD"
         '''
        return str(date.today() - timedelta(days=days_ago))
