import logging
import threading
import numpy as np
from spider import Spider
logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
weixin_names = [("赛柏蓝","INFO","yyr"),("健识局","INFO","yyr"),("药明康德","INFO","yyr"),("华招医药网","INFO","yyr"),("医招采","INFO","yyr"),("全药网","INFO","yyr"),
                ("药店经理人","INFO","yyr"),("E药经理人","INFO","yyr"),("看医界","INFO","yyr"),("中国药闻","INFO","yyr"),("E药汇","INFO","yyr"),("药智网","INFO","yyr"),
                ("动脉网","INFO","yyr"),("中国医药创新促进会","INFO","yyr")]

num_threads = 2
def start_crawl(spider,sub_weixin_name):
    for weixin_name in sub_weixin_name:
        spider.pipeline2db(weixin_name)
for sub_weixin_name in np.array_split(weixin_names,num_threads):
    spider = Spider()
    threading.Thread(target=start_crawl, args=(spider,sub_weixin_name,)).start()