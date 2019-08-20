import logging
import threading
import numpy as np
from crawl_from_search import Spider
logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
weixin_names = [("赛柏蓝","INFO","yyr","oIWsFtwICTz_e61YkBoqO0EBmNe0"),("健识局","INFO","yyr","oIWsFt9OhKi1JuD6Q9CgchiPEeyo"),("药明康德","INFO","yyr","oIWsFt8_gjduyEZ5LGGmM38Y6E2k"),("华招医药网","INFO","yyr","oIWsFt8og3SAZplQYml3nXYrbLPc"),("医招采","INFO","yyr","oIWsFtyv9Sgsq5zn0e09sHIG0dU8"),("全药网","INFO","yyr","oIWsFt-2M1xfTzflYhobpssA3nVI"),
                ("药店经理人","INFO","yyr","oIWsFtxs6VX_9Rg2Zw0YsNrdx0jU"),("E药经理人","INFO","yyr","oIWsFt4VB568fyliI-kDMZPcFAwM"),("看医界","INFO","yyr","oIWsFt1nSRo2MUGrJxs6U_4K6tGg"),("中国药闻","INFO","yyr","oIWsFt0x7q5rbIbxrYj8C1nA74XU"),("E药汇","INFO","yyr","oIWsFt9kbDlV_dnGW2-8pJ-DLUmY"),("药智网","INFO","yyr","oIWsFt4JqF5DtVB0D1exYUa0VDMc"),
                ("动脉网","INFO","yyr","oIWsFt0kQ1EA-vmZ-KSCZ7OzN7ws"),("中国医药创新促进会","INFO","yyr","oIWsFt5wXHny0HcHq3itN9608cKA")]

num_threads = 2
def start_crawl(spider,sub_weixin_name):
    for weixin_name in sub_weixin_name:
        spider.pipeline2db(weixin_name,'alltime',retrytimes=3)
for sub_weixin_name in np.array_split(weixin_names,num_threads):
    spider = Spider()
    threading.Thread(target=start_crawl, args=(spider,sub_weixin_name,)).start()