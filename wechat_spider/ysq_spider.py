import logging
from multiprocessing.dummy import Pool as ThreadPool
from multhread_spider import pipeline2db
from crawl_newest_one import Spider
import threading
import numpy as np

logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
weixin_names = [("看医界","INFO","ysq","oIWsFt1nSRo2MUGrJxs6U_4K6tGg"),("医学界消化肝病频道","NKAC","ysq","oIWsFtxQH9qW7KF0RarF42QFbdA8"),("小大夫漫画","QK","ysq","oIWsFt5H_m796gi6Tp0sqPzeyns0"),("消化界","NKAC","ysq","oIWsFtw0cbWOCV8KLHdVBnBJNpnE"),
                ("MedSci梅斯","QK","ysq","oIWsFt17fofFF1McrUgFod5gWFHk"),("华医网","QK","ysq","oIWsFt3Qn0mLErSGDUXyHraSsbHQ"),("IBD学术情报官","NKAC","ysq","oIWsFt8GEMlTJidTarGQ32589zr4"),("爱肝联盟","CRAC","ysq","oIWsFt-GWDRf6vGHE9TK6nudt7Yo"),("临床肝胆病杂志","WKAB","ysq","oIWsFt5ZCX-rBXSplX1EAsPcidps"),
                ("消化时间","NKAC","ysq","oIWsFt6gkQdixswooymRlyqo0wg4"),("医脉通消化科","NKAC","ysq","oIWsFt4DRPKTHDQZFSAjqAhm1Zv8"),("孙锋医生","WKAC","ysq","oIWsFt2BFJOPYgjdNETb3LamSdbY"),("基层医师公社","QK","ysq","oIWsFt21kNK0EJBYMPDlZxNWKtuQ"),
                ("医学界心血管频道","NKAA","ysq","oIWsFt9tfv-0waFUW8BI8xg7tTn0"),("心血管时间","NKAA","ysq","oIWsFt0xgjYFwsuAQL-7jKM86PeM"),("心在线","NKAA","ysq","oIWsFtxEn1au2CPjCiXE-1qrajLM"),("中国循环杂志","NKAA","ysq","oIWsFt_3XnV7qCE9wt_Q0-lT6RSc"),("医脉通心内频道","NKAA","ysq","oIWsFtziaAyJONtZUjKgGgxVdb0Y"),
                ("哈特瑞姆心脏之声","NKAA","ysq","oIWsFtyc1OKmelM7a72TTpaJquQs"),("医学之声","QK","ysq","oIWsFt42Ua67Px1WMGYX_OSWf7Ns"),("医学界急诊与重症频道","JZ","ysq","oIWsFt-L6let0XPnndBn3RK-NTzw"),("医路向前巍子","JZ","ysq","oIWsFtwqGWTdunx4-P9_QLN-3GWQ"),("医学界神经病学频道","NKAB","ysq","oIWsFt3pnfmz27HtaTPydmbR0dos"),
                ("神经时间","NKAB","ysq","oIWsFt4QTl3W69qoYn1qCU6LsBmI"),("神经病学俱乐部","NKAB","ysq","oIWsFtwBZ-U4otBT5R8IHfdndoEk"),("医脉通神经科","NKAB","ysq","oIWsFtzhbmyE2ZANllrb2TNw_TWk"),("国际眼科时讯","YK","ysq","oIWsFt5pI5uZEesv4MSQ3bgR8vwM"),("医信眼科","YK","ysq","oIWsFtwstdLFTG-VWh8J9HHBCbsE"),
                ("眼视光观察","YK","ysq","oIWsFt6vVnufaZ0nmH1jWXBXN6bM"),("视远惟明 · 惟视眼科","YK","ysq","oIWsFt4yKZECjyZi9U6mQHpwnRCg"),("医脉通泌尿外科","WKAA","ysq","oIWsFt6ivjwsOd7kVHwtnzG9MeoE"),("泌尿科那点事儿","WKAA","ysq","oIWsFt5NhE8uKAkp61rPEsz5oP4o"),
                ("医学界外科频道","WKAG","ysq","oIWsFt0LOa8hjseAtONiwRcC2-XM"),("中国实用外科杂志","WKAC","ysq","oIWsFt-4CvBTvhUnuVqbMMmW7MNU"),("儿科时间","EK","ysq","oIWsFt0aBj_c737Y-YbwiHAF7JiA"),("医学界儿科频道","EK","ysq","oIWsFtxPShl_a8h2neiq-KQz2Yk8"),("国际儿科学杂志","EK","ysq","oIWsFt217mk90NmjylxNCtHMxsKs"),
                ("医学界精神病学频道","JS","ysq","oIWsFt3x59-MMZIkCaCKSGKit-TE"),("儿科学大查房","EKAB","ysq","oIWsFt3glBn6Bx-WQtPW4Bx-9HA4"),("中国儿科前沿论坛","EKAB","ysq","oIWsFt-i4hYgv4ZFkN9P6iuTCMeA"),("皮肤时间","PFAB","ysq","oIWsFt_MHFDC_0ChFAXSDpFa6dx8"),
                ("实用皮肤病学杂志","PFAB","ysq","oIWsFt36PsM2Pyv39pOSiJVFJnTw"),("肾内时间","NKAL","ysq","oIWsFt7QWMa58cYeJF9VVuvhrQ8s"),("医脉通肾内频道","NKAL","ysq","oIWsFt0izplvrAvtIc441bDSVffs"),("透析圈","NKAL","ysq","oIWsFtwXVUEB74zn8w3jgIKgDkuM"),
                ("感染时间","NKAJ","ysq","oIWsFtwiM0RHDXLvbbzzGWbVlOxY"),("SIFIC感染官微","NKAJ","ysq","oIWsFt8F7iWSrxHMvnkR0L9lHNHc"),("医脉通抗感染","NKAJ","ysq","oIWsFt2t1iV7mZhA65zt7ZTdfFzI"),("医学界感染频道","NKAJ","ysq","oIWsFt_N_Sv3EfBmhiR-pKa1ZFrM"),("中华医学网","NKAM","ysq","oIWsFt91fOFGUeLvxntrPw-0_OAQ"),
                ("海上柳叶刀","NKAM","ysq","oIWsFt_35slNn5GbePNwfDsTs1jU"),("医学内刊","NKAM","ysq","oIWsFt-97NnO9RZLiHKDaiKnGeII"),("每日医学资讯","INFO","ysq","oIWsFt-Leu7nxUoO4uQPvNAJmhMw"),("医脉通","INFO","ysq","oIWsFtzCIRaDqpdqryp9spYlJWB4"),
                ("内分泌时间","NKAD","ysq","oIWsFt5NLY0EY8cIPJXhXtBaEiH0"),("神经科技","WKAH","ysq","oIWsFt0ioZ3wdt2VyRm0VeB_DHFA"),("医学界临床药学频道","QK","ysq","oIWsFt_8N0Mspz2HaAIU7AR8lJ8o"),
                ("老虎讲骨","WKAR","ysq","oIWsFt_QDEItMTM3Hx2jYJdizjUI"),("放疗时空","JY","ysq","oIWsFt5K9WssLOkY5nkFJD8mPeRA"),("医学界检验频道","JY","ysq","oIWsFt_bxW7xJtl8-MCx4tXXvsro"),("医学界影像诊断与介入频道","JY","ysq","oIWsFtz558FeJ_6oEfvtTC2lZu1w"),("放射沙龙","JY","ysq","oIWsFt4CJL9Pl1ovvqL7RbvQfpmQ"),
                ("肿瘤时间","WKAT","ysq","oIWsFtydk_hySUHk8mHr0sB7m7ds"),("医学界肿瘤频道","WKAT","ysq","oIWsFt7mqkD71l6mH-546xOmjoj0"),("感染科空间","NKAJ","ysq","oIWsFtyrg0zkHhXMwT3OzY5R0pjk"),("SIFIC感染科普笔记","NKAJ","ysq","oIWsFtzIFmtZM81S7ZIEif4RJiPc"),
                ("下夜班","QK","ysq","oIWsFt477Pgy9njFV_GfBYCWFQQ0"),("医闻速递","INFO","ysq","oIWsFt0nsJgXG0GPgWi42--KddOk"),("创新医学网","QK","ysq","oIWsFt_PDB4SDfQL2vdDMFy9b36I"),("爱肝一生微课堂","CRAC","ysq","oIWsFtwRHg_tDp3eeXt3CMAEP2Mg"),
                ("国际肝胆胰疾病杂志","CRAC","ysq","oIWsFt7FzlwefstVRQEvTUmsrRTA"),("胃肠肿瘤外科","WKAC","ysq","oIWsFtxEluJjpU22wxz5O2fz2Hy4"),("儿科助手","EK","ysq","oIWsFt5TlufznXdd8XnfStqOJECo"),("中华儿科杂志","EKAB","ysq","oIWsFt65MklRzYa_1IgL7GFKsx_4"),("儿科空间","EK","ysq","oIWsFt5ADTsDPGG5tC-mrfOiL1Sw"),
                ("中国实用儿科杂志","EK","ysq","oIWsFt1HffqFMZRYXW8Mt7kZXgnM"),("皮肤科钟华","PFAB","ysq","oIWsFt0lfQUsFI9Rd-V4Mj1JfVio"),("CSDCMA皮科时讯论坛","PFAB","ysq","oIWsFt-yS2n6nzE_FIDrQ0tLZAQE"),("医生汇心血管论坛","NKAA","ysq","oIWsFty9TM3yADPdtfjlLAi-FyOI"),
                ("医脉通急诊重症科","JZ","ysq","oIWsFt7aFuCPXudpOCKt4b3MbL14"),("急诊医学资讯","JZ","ysq","oIWsFt6KVwRmsLWqpH6Ykr6x3SEI"),("中国急救医学杂志","JZ","ysq","oIWsFt0B735BT6uD9R1HcsQKbehw"),("急诊时间","JZ","ysq","oIWsFt3PphMVFt9K7FQMUTOUAdVE"),("中国小儿急救医学","JZ","ysq","oIWsFt8pAk2fTvpuSt3wWZFjbiUg"),
                ("精神时间","JS","ysq","oIWsFt3qHWU9SATPYU-O8ZN1CWMU"),("精神康复","JS","ysq","oIWsFtwXwloAFvA3aOuH9dREa-FA"),("医脉通精神科","JS","ysq","oIWsFt6k8pUN8DDlmn_Lw5vlHENQ"),("大话精神","JS","ysq","oIWsFt4D_Tsi0y3RLdkLM8jVuKyo"),("神经科的那些事","NKAB","ysq","oIWsFt9SpQgscSR_W0mwdAPodY4w"),
                ("神经医学社区","NKAB","ysq","oIWsFt3ZbBQi0UdbjXiKwVz7Tfw0"),("神经脊柱时讯","NKAB","ysq","oIWsFt0nLL-X33JNFte8HMS0pQzg"),("医学界呼吸频道","NKAF","ysq","oIWsFtx_5bgujKJP50fce_loOrzE"),("中国眼科医生","YK","ysq","oIWsFtyC7M_oa9FGk7h9hX68FrIQ"),("SIFIC感染循证资讯","NKAJ","ysq","oIWsFt5WdNFPqc32sGncsTroWVjc"),
                ("中华消化外科杂志","NKAC","ysq","oIWsFt6sjmOa0CoeSamRM3smLT4E"),("朝阳心脏超声","NKAA","ysq","oIWsFt8BV3mpbXAT0tfhl95cBnE8"),("危重症文献学习","ZZ","ysq","oIWsFt1oGZANTKlnB9ISu1-dQI2g"),("中华重症医学电子杂志","ZZ","ysq","oIWsFt-2dn1KXsuabvaq1-6AuxNY"),("神经现实","SJ","ysq","oIWsFtwwfETSllRETaBcmq1UNJ2c"),
                ("神经介入资讯","SJ","ysq","oIWsFt5BottV6LtklOAk_j-vnMrM"),("赛博蓝","INFO","ysq","oIWsFt4PUA2eFQQKTz_EEjoRV0AA"),("中洪博元医学实验帮","INFO","ysq","oIWsFt-OyHoPwiY-NYV5XS7GrzMI"),("医咖会","INFO","ysq","oIWsFt2Rw5ciTKt-7z_wTIfKiCf4"),
                ("生物学霸","INFO","ysq","oIWsFt-amwZfUydhrpX2KYaNMxKw")]
num_threads = 6
def start_crawl(spider,sub_weixin_name):
    for weixin_name in sub_weixin_name:
        spider.pipeline2db(weixin_name,retrytimes=3)
for sub_weixin_name in np.array_split(weixin_names,num_threads):
    spider = Spider()
    threading.Thread(target=start_crawl, args=(spider,sub_weixin_name,)).start()