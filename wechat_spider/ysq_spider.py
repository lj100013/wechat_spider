import logging
from multiprocessing.dummy import Pool as ThreadPool
from multhread_spider import pipeline2db
from spider import Spider

logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
weixin_names = [("好医生","QK","ysq"),("丁香园","QK","ysq"),("看医界","INFO","ysq"),("医学界消化肝病频道","NKAC","ysq"),("小大夫漫画","QK","ysq"),("消化界","NKAC","ysq"),
                ("MedSci梅斯","QK","ysq"),("华医网","QK","ysq"),("IBD学术情报官","NKAC","ysq"),("爱肝联盟","CRAC","ysq"),("临床肝胆病杂志","WKAB","ysq"),
                ("消化时间","NKAC","ysq"),("医脉通消化科","NKAC","ysq"),("孙锋医生","WKAC","ysq"),("基层医师公社","QK","ysq"),("医学界","QK","ysq"),
                ("医学界心血管频道","NKAA","ysq"),("心血管时间","NKAA","ysq"),("心在线","NKAA","ysq"),("中国循环杂志","NKAA","ysq"),("医脉通心内频道","NKAA","ysq"),
                ("哈特瑞姆心脏之声","NKAA","ysq"),("医学之声","QK","ysq"),("医学界急诊与重症频道","JZ","ysq"),("医路向前巍子","JZ","ysq"),("医学界神经病学频道","NKAB","ysq"),
                ("神经时间","NKAB","ysq"),("神经病学俱乐部","NKAB","ysq"),("医脉通神经科","NKAB","ysq"),("国际眼科时讯","YK","ysq"),("医信眼科","YK","ysq"),
                ("眼视光观察","YK","ysq"),("视远惟明▪惟视眼科","YK","ysq"),("医脉通泌尿外科","WKAA","ysq"),("泌尿科那点事儿","WKAA","ysq"),("泌尿外科郭医生","WKAA","ysq"),
                ("医学界外科频道","WKAG","ysq"),("中国实用外科杂志","WKAC","ysq"),("儿科时间","EK","ysq"),("医学界儿科频道","EK","ysq"),("国际儿科学杂志","EK","ysq"),
                ("医学界精神病学频道","JS","ysq"),("儿科学大查房","EKAB","ysq"),("人卫儿科","EKAB","ysq"),("中国儿科前沿论坛","EKAB","ysq"),("皮肤时间","PFAB","ysq"),
                ("实用皮肤病学杂志","PFAB","ysq"),("肝胆外科","WKAB","ysq"),("肾内时间","NKAL","ysq"),("医脉通肾内频道","NKAL","ysq"),("透析圈","NKAL","ysq"),
                ("感染时间","NKAJ","ysq"),("SIFIC感染官微","NKAJ","ysq"),("医脉通抗感染","NKAJ","ysq"),("医学界感染频道","NKAJ","ysq"),("中华医学网","NKAM","ysq"),
                ("海上柳叶刀","NKAM","ysq"),("医学内刊","NKAM","ysq"),("每日医学资讯","INFO","ysq"),("医师报","INFO","ysq"),("医脉通","INFO","ysq"),("健康界","INFO","ysq"),
                ("生物谷","INFO","ysq"),("内分泌时间","NKAD","ysq"),("神经科技","WKAH","ysq"),("医学界风湿免疫频道","NKAE","ysq"),("医学界临床药学频道","QK","ysq"),
                ("老虎讲骨","WKAR","ysq"),("放疗时空","JY","ysq"),("医学界检验频道","JY","ysq"),("医学界影像诊断与介入频道","JY","ysq"),("放射沙龙","JY","ysq"),
                ("健康点healthpoint","WKAT","ysq"),("肿瘤时间","WKAT","ysq"),("医学界肿瘤频道","WKAT","ysq"),("感染科空间","NKAJ","ysq"),("SIFIC感染科普笔记","NKAJ","ysq"),
                ("下夜班","QK","ysq"),("医闻速递","INFO","ysq"),("三甲传真","INFO","ysq"),("创新医学网","QK","ysq"),("爱肝一生微课堂","CRAC","ysq"),
                ("国际肝胆胰疾病杂志","CRAC","ysq"),("胃肠肿瘤外科","WKAC","ysq"),("儿科助手","EK","ysq"),("中华儿科杂志","EKAB","ysq"),("儿科空间","EK","ysq"),
                ("中国实用儿科杂志","EK","ysq"),("皮肤科钟华","PFAB","ysq"),("CSDCMA皮科时讯论坛","PFAB","ysq"),("医生汇心血管论坛","NKAA","ysq"),
                ("医脉通急诊重症科","JZ","ysq"),("急诊医学资讯","JZ","ysq"),("中国急救医学杂志","JZ","ysq"),("急诊时间","JZ","ysq"),("中国小儿急救医学","JZ","ysq"),
                ("重症医学","JZ","ysq"),("精神时间","JS","ysq"),("精神康复","JS","ysq"),("医脉通精神科","JS","ysq"),("大话精神","JS","ysq"),("神经科的那些事","NKAB","ysq"),
                ("神经医学社区","NKAB","ysq"),("神经脊柱时讯","NKAB","ysq"),("医学界呼吸频道","NKAF","ysq"),("中国眼科医生","YK","ysq"),("SIFIC感染循证资讯","NKAJ","ysq"),
                ("中华消化外科杂志","NKAC","ysq"),("朝阳心脏超声","NKAA","ysq"),("危重症文献学习","ZZ","ysq"),("中华重症医学电子杂志","ZZ","ysq"),("神经现实","SJ","ysq"),
                ("神经介入资讯","SJ","ysq"),("医药魔方","INFO","ysq"),("赛博蓝","INFO","ysq"),("中洪博元医学实验帮","INFO","ysq"),("医咖会","INFO","ysq"),
                ("生物学霸","INFO","ysq")]
# spider = Spider()
pool = ThreadPool(4)
pool.map_async(pipeline2db, weixin_names)
pool.close()
pool.join()