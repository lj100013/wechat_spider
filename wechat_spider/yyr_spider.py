import logging
import threading
import numpy as np
from crawl_from_search import Spider
logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
weixin_names = [("赛柏蓝","INFO","yyr","oIWsFtwICTz_e61YkBoqO0EBmNe0"),("健识局","INFO","yyr","oIWsFt9OhKi1JuD6Q9CgchiPEeyo"),("华招医药网","INFO","yyr","oIWsFt8og3SAZplQYml3nXYrbLPc"),("医招采","INFO","yyr","oIWsFtyv9Sgsq5zn0e09sHIG0dU8"),("全药网","INFO","yyr","oIWsFt-2M1xfTzflYhobpssA3nVI"),
                ("药店经理人","INFO","yyr","oIWsFtxs6VX_9Rg2Zw0YsNrdx0jU"),("E药经理人","INFO","yyr","oIWsFt4VB568fyliI-kDMZPcFAwM"),("看医界","INFO","yyr","oIWsFt1nSRo2MUGrJxs6U_4K6tGg"),("中国药闻","INFO","yyr","oIWsFt0x7q5rbIbxrYj8C1nA74XU"),("E药汇","INFO","yyr","oIWsFt9kbDlV_dnGW2-8pJ-DLUmY"),("药智网","INFO","yyr","oIWsFt4JqF5DtVB0D1exYUa0VDMc"),
                ("中国医药创新促进会","INFO","yyr","oIWsFt5wXHny0HcHq3itN9608cKA"),("生物谷","INFO","yyr","oIWsFt3tuNDaR6imEZMSMSfHHXXY"),("医药经济报","INFO","yyr","oIWsFt2Y2762RezQQmzojx_gs_eU"),("丁香园","QK","yyr","oIWsFtxjqoo5QkBuV87xUyTqpAOs"),
                ("蒲公英","INFO","yyr","oIWsFt1w7-YPEV1-jK0z__bUbWWM"),("医疗器械创新网","INFO","yyr","oIWsFt03hMr2MWe7jM6VufPy32f4"),("药渡","INFO","yyr","oIWsFtxEG4A7S4TY26Gj3p8JDf1Y"),("药物分析之家","INFO","yyr","oIWsFt0UYUogTnWdbBPX6hgMways"),("药物简讯","INFO","yyr","oIWsFt2d9EL5rQs7TiZLThEWs7NU"),
                ("健康界", "INFO", "yyr", "oIWsFt78EOgJ5Ejv0EHnQ6DPEZn0"),("生物探索","INFO","yyr","oIWsFt6deoOz8YLH-bssUJjzMTVA"),("医药地理","INFO","yyr","oIWsFt8yVQ_x87OSq27c7xrwNT-o"),("医药魔方","INFO","yyr","oIWsFt9ZB_FH_EA9epinddFmCpa0"),("ClindataPlus","INFO","yyr","oIWsFt9R7WaOqBn1_1Kqyb_cVtSU"),
                ("中国药店","INFO","yyr","oIWsFt_C8PsWSiDQiS4ub7iilW4w"),("医药新零售模式","INFO","yyr","oIWsFt-4DLBTFDXfo5G11AaO2COM"),("新浪医药","INFO","yyr","oIWsFt-YuWg_4UazZdF4rM6y2IfI"),("医药卫生报","INFO","yyr","oIWsFtzurcN7u2clzKbID0Ft5x6w"),
                ("医药观察家网","INFO","yyr","oIWsFt4DEvQfq649RUCVEum_hXsQ"),("环球医药网","INFO","yyr","oIWsFt_KQinDURz4REJoh3FM_-VM"),("第一药店财智","INFO","yyr","oIWsFt7MhmPPTvi5raQrkCN0mXCY"),("21世纪药店","INFO","yyr","oIWsFt-qNY7smL09E0AWcwl53mFM"),("好医生","QK","yyr","oIWsFtwpWXQR-SIV4VxF9CcpOKKM"),
                ("国药汇","INFO","yyr","oIWsFt_bnCYNbJuf1ob2DxOmYFYU"),("制药业","INFO","yyr","oIWsFt-4TgrBotOyUoGbtS4RHI0Y"),("三甲传真","INFO","yyr","oIWsFtx_83zYUcZ1j8CvTLL6IB78"),("医管通","INFO","yyr","oIWsFt_jCoVO7_JDUGEopdzDS-GQ"),("医学论坛网","INFO","yyr","oIWsFtxyCk9N09rwUnNGj7qxjlPI"),
                ("中国医院院长","INFO","yyr","oIWsFt8GgkwE5sOfJnJ-yc0VFejY"),("医师报","INFO","ysq","oIWsFtzi0PibaU3PgrbPNdU3b0qE"),("医药代表","INFO","yyr","oIWsFt7KWd9UMTeWG2_XzK2ujee4"),("医蟹","INFO","yyr","oIWsFt6ceeUFHC_H3OQzhu4l59iA"),("联众医药网","INFO","yyr","oIWsFtyKH8hYKRuvk5F1w957GY1w"),
                ("寿险微课堂","INFO","yyr","oIWsFt5yE_lJ_giDEwKL7OCpmJx8"),("医保微社区","INFO","yyr","oIWsFt_TC61pWWru5T22_9ghvhFY"),("寿险一点通","INFO","yyr","oIWsFt3hDMRNHHv1Sa4urD4DhGVM"),("重疾险百科","INFO","yyr","oIWsFt9hLKdJI8Dsy23Y8iZqlOEg"),("泰康人寿保险","INFO","yyr","oIWsFt6RbgO2u8cI_KweoE0JHUTU"),
                ("中国保险报","INFO","yyr","oIWsFtzlugTbjcWuYgddGTG-0eaM"),("高医医保物价","INFO","yyr","oIWsFtwykJjsuzOeGcFSuZfa3qWs"),("平安健康保险","INFO","yyr","oIWsFtxgIwpnTF8RUnxZOfnvQj3k")]
# ("中国医药报","INFO","yyr","oIWsFtxZvbhP_vGSWyDl5kvFXGTE"),("药明康德","INFO","yyr","oIWsFt8_gjduyEZ5LGGmM38Y6E2k"),("医学界", "QK", "yyr", "oIWsFtxoA8ylvPBmVUVQW_vaa4q8"),("动脉网","INFO","yyr","oIWsFt0kQ1EA-vmZ-KSCZ7OzN7ws"),


num_threads = 4
def start_crawl(spider,sub_weixin_name):
    for weixin_name in sub_weixin_name:
        spider.pipeline2db(weixin_name,'day',retrytimes=3)
for sub_weixin_name in np.array_split(weixin_names,num_threads):
    spider = Spider()
    threading.Thread(target=start_crawl, args=(spider,sub_weixin_name,)).start()