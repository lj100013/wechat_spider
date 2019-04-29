#!/data/anaconda3/bin
#coding:utf-8
from dxy_spider import DxySpider
from ymt_spider import YmtSpider
from multiprocessing.dummy import Pool as ThreadPool
import logging
import sys
import argparse
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filename='yishiyu_spider.log',
                    filemode='a')
if __name__ == "__main__":
    dxy_url = [('http://heart.dxy.cn/tag/news', '心血管'), ('http://endo.dxy.cn/tag/news', '内分泌'),
               ('http://neuro.dxy.cn/tag/news', '神经'), ('http://chest.dxy.cn/tag/news', '呼吸'),
               ('http://oncol.dxy.cn/tag/news', '肿瘤'), ('http://hematol.dxy.cn/tag/news', '血液'),
               ('http://gi.dxy.cn/tag/news', '消化'), ('http://infect.dxy.cn/tag/news', '感染'),
               ('http://orthop.dxy.cn/tag/news', '骨科'), ('http://prs.dxy.cn/tag/news', '整形'),
               ('http://surg.dxy.cn/tag/news', '普外'), ('http://neurosurg.dxy.cn/tag/news', '神外'),
               ('http://thorac.dxy.cn/tag/news', '胸外'), ('http://anesth.dxy.cn/tag/news', '麻醉'),
               ('http://urol.dxy.cn/tag/news', '泌尿'), ('http://ophth.dxy.cn/tag/news', '眼科'),
               ('http://neph.dxy.cn/tag/news', '肾内'), ('http://rheum.dxy.cn/tag/news', '风湿'),
               ('http://obgyn.dxy.cn/tag/news', '妇产'), ('http://pediatr.dxy.cn/tag/news', '儿科'),
               ('http://derm.dxy.cn/tag/news', '皮肤'), ('http://dental.dxy.cn/tag/news', '口腔'),
               ('http://ccm.dxy.cn/tag/news', '重症'), ('http://rehab.dxy.cn/tag/news', '康复'),
               ('http://radiol.dxy.cn/tag/news', '影像'), ('http://ultrasound.dxy.cn/tag/news', '超声'),
               ('http://psych.dxy.cn/tag/news', '精神'), ('http://otol.dxy.cn/tag/news', '耳鼻喉')]

    ymt_url = [('http://news.medlive.cn/heart/info/','心血管内科',1),('http://news.medlive.cn/neuro/info/','神经内科',2),
               ('http://news.medlive.cn/endocr/info/','内分泌科',5),('http://news.medlive.cn/gi/info/','消化科',3),
               ('http://news.medlive.cn/liver/info/','肝病科',4),('http://news.medlive.cn/infect/info/','感染科',12),
               ('http://news.medlive.cn/cancer/info/','肿瘤科',6),('http://news.medlive.cn/hema/info/','血液科',7),
               ('http://news.medlive.cn/pul/info/','呼吸科',9),('http://news.medlive.cn/neph/info/','肾内科',10),
               ('http://news.medlive.cn/imm/info/','风湿免疫科',11),('http://news.medlive.cn/psy/info/','精神科',8),
               ('http://news.medlive.cn/surgery/info/','普通外科',13),('http://news.medlive.cn/ns/info/','神经外科',14),
               ('http://news.medlive.cn/chest/info/','胸心外科',15),('http://news.medlive.cn/orth/info/','骨科',17),
               ('http://news.medlive.cn/uro/info/','泌尿外科',16),('http://news.medlive.cn/ps/info/','整形外科',18),
               ('http://news.medlive.cn/anes/info/','麻醉科',19),('http://news.medlive.cn/obgyn/info/','妇产科',20),
               ('http://news.medlive.cn/ped/info/','儿科',21),('http://news.medlive.cn/derm/info/','皮肤性病科',25),
               ('http://news.medlive.cn/oph/info/','眼科',22),('http://news.medlive.cn/ent/info/','耳鼻咽喉科',23),
               ('http://news.medlive.cn/oral/info/','口腔科',24),('http://news.medlive.cn/em/info/','急诊/重症',26),
               ('http://news.medlive.cn/xctmr/info/','影像科',27),('http://news.medlive.cn/lab/info/','检验科',28)]
    parser = argparse.ArgumentParser(description='manual to this script')
    parser.add_argument('--first_time', type=bool, default=False)
    args = parser.parse_args()
    first_time = args.first_time
    dxy = DxySpider(first_time=first_time)
    pool = ThreadPool(6)
    pool.map_async(dxy.crawl_page_source, dxy_url)
    ymt = YmtSpider(first_time=first_time)
    pool.map_async(ymt.crawl_page_source, ymt_url)
    pool.close()
    pool.join()
