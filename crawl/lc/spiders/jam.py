# # -*- coding: utf-8 -*-
# import json
# import os
# import re
# from lc.items import LcItem
# import scrapy
# import datetime
#
#
# class JamSpider(scrapy.Spider):
#     name = 'jam'
#     allowed_domains = ['jamanetwork.com']
#
#     def start_requests(self):
#         headers = {
#             "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36",
#         }
#         base_url = "https://jamanetwork.com/"
#         old_urls = None
#         if os.path.exists("JAMA.txt"):
#             with open("./JAMA.txt")as f:
#                 old_urls = [u.strip() for u in f.readlines()]
#         yield scrapy.Request(url=base_url, headers=headers,meta={"url":old_urls})
#
#     def parse(self, response):
#         if response.meta["url"] is None:
#             old_urls =[]
#         else:
#             old_urls = response.meta["url"]
#         headers = {
#             "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
#             "Accept-Encoding": "gzip, deflate, br",
#             "Accept-Language": "zh-CN,zh;q=0.9",
#             "Cache-Control": "max-age=0",
#             "Connection": "keep-alive",
#             "Cookie": "https://jamanetwork.com/journals/jama/fullarticle/2492881close=true; JAMA NetworkMachineID=636674179757000313; optimizelyEndUserId=oeu1531821177318r0.8186150070623706; __gads=ID=3e28d0b23e6ba3a8:T=1531821178:S=ALNI_MYG7O6Q2hndiTbks1hf-sauzYEGpg; _ga=GA1.2.152386200.1531821177; gaCustomerId=Unknown; gaInstitutionId=Unknown; gaTAMId=Unknown; hrmTracker=ms51ormknq; _gaCorp=GA1.2.937151021.1531821259; CookieBanner_Closed=true; _gid=GA1.2.1309101790.1532417146; _gaCorp_gid=GA1.2.146307619.1532417149; AMA_SessionId=222eqm5ah2hbfryutygbw352; hrmTracker_S=jan59gbufz; _xdClientId=152386200.1531821177; NSC_TDN6_QSPE_BNB_XXX_SS_80=ffffffff09099e3945525d5f4f58455e445a4a423660; _dc_gtm_UA-41194200-1=1; _dc_gtm_UA-25810650-9=1; _dc_gtm_UA-25810650-13=1; _dc_gtm_UA-25810650-12=1; __atuvc=3%7C29%2C15%7C30; __atuvs=5b57d6a08011366b00a; _dc_gtm_UA-25810650-1=1; _dc_gtm_UA-77381884-5=1; _gat_UA-25810650-1=1",
#             "Host": "jamanetwork.com",
#             "Referer": "https://jamanetwork.com/",
#             "Upgrade-Insecure-Requests": "1",
#             "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36"}
#         nodes = list(set(response.xpath("//div[@class='grid-item']/h5/a//@href").extract()))
#         nodes = [i for i in nodes if "https" not in i]
#         for tmp in nodes:
#             content_url = "https://jamanetwork.com" + tmp
#             if content_url not in old_urls:
#                 yield scrapy.Request(url=content_url, callback=self.parse_content, headers=headers)
#             else:
#                 print("过滤去重")
#
#     def parse_content(self, response):
#         with open("./JAMA.txt","a")as fw:
#             fw.write(response.url+"\n")
#         item =LcItem()
#         title = response.xpath('//div[@id="full-text-tab"]/div[5]/div[4]/h1/text()').extract_first()
#         create_time = "".join([i.replace("\xa0",",").strip() for i in response.xpath('//div[@id="full-text-tab"]/div[5]/div[3]/span//text()').extract()])
#         author = "".join([i.replace("\xa0",",").strip() for i in response.xpath('//div[@id="full-text-tab"]/div[5]/div[5]//text()').extract()])
#         content = json.dumps(response.xpath('//div[@id="full-text-tab"]/div[8]/div//text()').extract()).replace("[","").replace("]","").encode("utf-8").decode('unicode_escape')
#         content = re.sub(r"\s+", '","', content)
#         if create_time:
#             item["create_time"] =  datetime.datetime.strptime(create_time, '%B,%d,%Y')
#         else:
#             item["create_time"]=''
#         item["title"] = title
#         item["author"] = author
#         item["content"] = content.replace('"\\r\\n"',"").replace("\\r","").replace("\\n","").replace('","',' ').replace("\r\n"," ").replace(',""'," ")
#         item["key_word"] = ""
#         item["source"] = "JAMA"
#         item["gid"] = ""
#         if len(content) != 0:
#             yield item
