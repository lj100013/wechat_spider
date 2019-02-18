# -*- coding: utf-8 -*-
from lc.youdu_sever import *
import scrapy
import json
from lc.items import LcItem


class KdSpider(scrapy.Spider):
    name = 'ykd_zn'
    allowed_domains = ['xingshulin.com']

    def start_requests(self):
        self.old_urls = database_filter("7")
        headers = {
            "Content-Type": "application/json",
            "Cookie": "X-Security-Id=e52f7bd10e1ee721b97241ebc791fd141e030ece; X-User-Agent=epocket/7.6.2 (iPhone8,1,iOS 11.4) net/WIFI channelId/1000; X-User-Token=7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D; appName=epocket; appVersion=7.6.2; deviceId=e52f7bd10e1ee721b97241ebc791fd141e030ece; featureList=noNav|uploadImage|circle|userActivity|pureUpload|deviceId|goCertify|pushController|tabRedDot|openJournal|literature|openEpocketVipPage|openUrl|goSearch|openBook|browseImage|toast|previewImage|recordAudio|certifyNew|lifeCycle|noLoin|openCircleController|publishRecord|editImage|nativeGoBack|useTabBar|shareCallback|drugHome|openGuide; acw_tc=AQAAAPP1fXwJrgIA97APt/aiNapTIE2H; appType=ios; sessionKey=7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22164c4ef2d05248-0f1bcadf5c28898-704f1564-3d10d-164c4ef2d061c7%22%7D",
        }
        data = {"typeId": "0", "categoryId": "236", "pageSize": "20", "pageIndex": ""}
        data_d = json.loads(json.dumps(data))
        for i in range(0, 100):
            data_d["pageIndex"] = str(i)
            data = json.dumps(data_d)
            base_url = "https://epocket.xingshulin.com/guide/getGuideListByCategoryId"
            yield scrapy.Request(url=base_url, cookies={
                "X-Security-Id": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                "X-User-Agent": "epocket/7.6.2 (iPhone8,1,iOS 11.4) net/WIFI channelId/1000",
                "X-User-Token": "7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                "appName": "epocket",
                "appVersion": "7.6.2",
                "deviceId": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                "featureList": "noNav|uploadImage|circle|userActivity|pureUpload|deviceId|goCertify|pushController|tabRedDot|openJournal|literature|openEpocketVipPage|openUrl|goSearch|openBook|browseImage|toast|previewImage|recordAudio|certifyNew|lifeCycle|noLoin|openCircleController|publishRecord|editImage|nativeGoBack|useTabBar|shareCallback|drugHome|openGuide",
                "acw_tc": "AQAAAPP1fXwJrgIA97APt/aiNapTIE2H",
                "appType": "ios",
                "sessionKey": "7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                "sensorsdata2015jssdkcross": "%7B%22distinct_id%22%3A%22164c4ef2d05248-0f1bcadf5c28898-704f1564-3d10d-164c4ef2d061c7%22%7D",
            }, body=data, method="POST", headers=headers, dont_filter=True)

    def parse(self, response):
        headers = {
            "Content-Type": "application/json",
            "Cookie": "X-Security-Id=e52f7bd10e1ee721b97241ebc791fd141e030ece; X-User-Agent=epocket/7.6.2 (iPhone8,1,iOS 11.4) net/WIFI channelId/1000; X-User-Token=7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D; appName=epocket; appVersion=7.6.2; deviceId=e52f7bd10e1ee721b97241ebc791fd141e030ece; featureList=noNav|uploadImage|circle|userActivity|pureUpload|deviceId|goCertify|pushController|tabRedDot|openJournal|literature|openEpocketVipPage|openUrl|goSearch|openBook|browseImage|toast|previewImage|recordAudio|certifyNew|lifeCycle|noLoin|openCircleController|publishRecord|editImage|nativeGoBack|useTabBar|shareCallback|drugHome|openGuide; acw_tc=AQAAAPP1fXwJrgIA97APt/aiNapTIE2H; appType=ios; sessionKey=7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22164c4ef2d05248-0f1bcadf5c28898-704f1564-3d10d-164c4ef2d061c7%22%7D",
        }
        content_url = "https://epocket.xingshulin.com/guide/v2//{}"
        item = {}
        if response.text:
            try:
                data_list = json.loads(response.text.replace(u"\u44ec", u""))
                for d in data_list["obj"]["guideVoList"]:
                    item["create_time"] = d["createTime"]
                    item["source"] = d["organization"]
                    item["title"] = d["guideName"]
                    id = d["id"]
                    yield scrapy.Request(url=content_url.format(str(id)), cookies={
                        "X-Security-Id": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                        "X-User-Agent": "epocket/7.6.2 (iPhone8,1,iOS 11.4) net/WIFI channelId/1000",
                        "X-User-Token": "7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                        "appName": "epocket",
                        "appVersion": "7.6.2",
                        "deviceId": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                        "featureList": "noNav|uploadImage|circle|userActivity|pureUpload|deviceId|goCertify|pushController|tabRedDot|openJournal|literature|openEpocketVipPage|openUrl|goSearch|openBook|browseImage|toast|previewImage|recordAudio|certifyNew|lifeCycle|noLoin|openCircleController|publishRecord|editImage|nativeGoBack|useTabBar|shareCallback|drugHome|openGuide",
                        "acw_tc": "AQAAAPP1fXwJrgIA97APt/aiNapTIE2H",
                        "appType": "ios",
                        "sessionKey": "7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                        "sensorsdata2015jssdkcross": "%7B%22distinct_id%22%3A%22164c4ef2d05248-0f1bcadf5c28898-704f1564-3d10d-164c4ef2d061c7%22%7D",
                    }, method="GET", headers=headers, callback=self.parse_content, dont_filter=True,
                                         meta={"item": item})
            except:
                pass
        else:
            print("无数据返回")

    def parse_content(self, response):
        if response.text:
            try:
                pre_item = response.meta["item"]
                datas = json.loads(response.text)["obj"]["guide"]
                content = datas["summary"] + "\n" + '<a href={}>查看文献</a>'.format(datas["pdfLink"])
                item = LcItem()
                item["create_time"] = pre_item["create_time"]
                item["source"] = pre_item["source"]
                item["title"] = pre_item["title"]
                item["content"] = content
                item["author"] = datas["journal"]
                item["key_word"] = ""
                creat_year = item["create_time"].split("-")[0]
                item["gid"] = parse_title(item["title"] + item["source"])
                if int(creat_year) >= 0 and item["gid"] not in self.old_urls:
                    yield item
                else:
                    print("过滤gid生成的年份为：", item["gid"], creat_year, )
            except:
                pass
