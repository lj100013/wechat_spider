import logging
from multiprocessing.dummy import Pool as ThreadPool
from spider import Spider

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filemode='a')
weixin = Spider()
weixin_names = [("赛柏蓝","INFO","yyr"),("健识局","INFO","yyr"),("药明康德","INFO","yyr"),("华招医药网","INFO","yyr"),("医招采","INFO","yyr"),("全药网","INFO","yyr"),
                ("药店经理人","INFO","yyr"),("E药经理人","INFO","yyr"),("看医界","INFO","yyr"),("中国药闻","INFO","yyr"),("E药汇","INFO","yyr"),("药智网","INFO","yyr"),
                ("动脉网","INFO","yyr"),("中国医药创新促进会","INFO","yyr")]
#weixin_names = [("中国医药创新促进会","INFO","yyr")]
pool = ThreadPool(1)
pool.map(weixin.pipeline2db, weixin_names)
pool.close()
pool.join()