# -*- coding: utf-8 -*-
from lc.items import LcItem
from lc.youdu_sever import *
import scrapy
import json
import re


class BlSpider(scrapy.Spider):
    name = 'ykd_bl'
    allowed_domains = ['xingshulin.com']

    def start_requests(self):
        self.old_url = database_filter("8")
        headers = {
            "Content-Type": "application/json",
            "Host": "epocket.xingshulin.com"
        }
        data = {"categoryId": "236", "pageSize": "20", "pageIndex": "1"}
        data_d = json.loads(json.dumps(data))
        for i in range(0, 50):
            data_d["pageIndex"] = str(i)
            data = json.dumps(data_d)
            base_url = "https://epocket.xingshulin.com/medicalCase/getMedicalCaseListByCategoryId"
            yield scrapy.Request(url=base_url, cookies={
                "appType": "ios",
                "featureList": "noNav|uploadImage|circle|userActivity|pureUpload|deviceId|goCertify|pushController|tabRedDot|openJournal|literature|openEpocketVipPage|openUrl|goSearch|openBook|browseImage|toast|previewImage|recordAudio|certifyNew|lifeCycle|noLoin|openCircleController|publishRecord|editImage|nativeGoBack|useTabBar|shareCallback|drugHome|openGuide",
                "sessionKey": "7B30376462643331313935363434656332626638313638386363643463343633653946774431376465244B6924404B6159703478456A4E532A51447856385550647D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B747275657D2C7B307D2C7B323333333935347D2C7B31636231306438623261316134363365386536306231633831653436386336665254456952324C4E406245706F43583151515677434B747046373962314775367D2C7B33353930623135383462656638383261323461306133613666646362623036387D2C7B323031382D30372D32332031373A33353A30357D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                "X-Security-Id": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                "X-User-Agent": "epocket/7.6.2 (iPhone8, 1,iOS 11.4) net/WIFI channelId/1000",
                "X-User-Token": "7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                "appName": "epocket",
                "appVersion": "7.6.2",
                "deviceId": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                "acw_tc": "AQAAAPP1fXwJrgIA97APt/aiNapTIE2H",
                "sensorsdata2015jssdkcross": "%7B%22distinct_id%22%3A%22164c4ef2d05248-0f1bcadf5c28898-704f1564-3d10d-164c4ef2d061c7%22%7D"
            }, body=data, method="POST", headers=headers, dont_filter=True)

    def parse(self, response):
        headers = {
            "Content-Type": "application/json",
            "Host": "epocket.xingshulin.com"
        }
        rsp = response.text.replace(u"\u44ec", u"")
        datas = json.loads(re.sub(r"\s+", "", rsp))
        if datas["result"] is True:
            try:
                data_list = datas["obj"]["medicalCaseVoList"]
                for i in data_list:
                    author = i["authorUnit"]
                    id = json.loads(re.sub(r"\s+", "", json.dumps(i)))["id"]
                    content_url = "https://epocket.xingshulin.com/medicalCase/{}".format(id)
                    yield scrapy.Request(url=content_url, cookies={
                        "appType": "ios",
                        "featureList": "noNav|uploadImage|circle|userActivity|pureUpload|deviceId|goCertify|pushController|tabRedDot|openJournal|literature|openEpocketVipPage|openUrl|goSearch|openBook|browseImage|toast|previewImage|recordAudio|certifyNew|lifeCycle|noLoin|openCircleController|publishRecord|editImage|nativeGoBack|useTabBar|shareCallback|drugHome|openGuide",
                        "sessionKey": "7B30376462643331313935363434656332626638313638386363643463343633653946774431376465244B6924404B6159703478456A4E532A51447856385550647D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B747275657D2C7B307D2C7B323333333935347D2C7B31636231306438623261316134363365386536306231633831653436386336665254456952324C4E406245706F43583151515677434B747046373962314775367D2C7B33353930623135383462656638383261323461306133613666646362623036387D2C7B323031382D30372D32332031373A33353A30357D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                        "X-Security-Id": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                        "X-User-Agent": "epocket/7.6.2 (iPhone8, 1,iOS 11.4) net/WIFI channelId/1000",
                        "X-User-Token": "7B39326132353038393339346334666566626138616262323564376535653539337D2C7B653532663762643130653165653732316239373234316562633739316664313431653033306563657D2C7B66616C73657D2C7B307D2C7B307D2C7B66336562376261373164373234336237386531633062333830623136303061317D2C7B63313536363734333837386239353066353962373337663765643665383066397D2C7B323031382D30372D32332031303A31383A32387D2C7B372E362E327D2C7B65706F636B65747D2C7B65706F636B65745F372E362E322D694F535F31312E347D",
                        "appName": "epocket",
                        "appVersion": "7.6.2",
                        "deviceId": "e52f7bd10e1ee721b97241ebc791fd141e030ece",
                        "acw_tc": "AQAAAPP1fXwJrgIA97APt/aiNapTIE2H",
                        "sensorsdata2015jssdkcross": "%7B%22distinct_id%22%3A%22164c4ef2d05248-0f1bcadf5c28898-704f1564-3d10d-164c4ef2d061c7%22%7D"
                    }, method="GET", headers=headers, dont_filter=True, callback=self.content_parse,
                                         meta={"aut": author})
            except:
                pass

    def content_parse(self, response):
        with open("./ykd_bl.txt", "a")as fw:
            fw.write(response.url + "\n")
        aut = response.meta["aut"]
        item = LcItem()
        rsps = response.text.replace(u"\u44ec", u"").replace(u"\u301c", u"")
        datas = json.loads(re.sub(r"\s+", "", rsps))
        img_re = re.compile('<imgsrc="(.*?)"')
        if datas["errorCode"] == "0":
            try:
                data_list = datas["obj"]["medicalCase"]
                contents = json.dumps(data_list["abstractAbbr"], ensure_ascii=False).split('imgsrc')
                partter = r'\\"(.*?)"alt'
                img_url = img_re.findall(data_list["abstractAbbr"])
                contents_1 = [re.sub(partter, "", c) for c in contents]
                now_u = [du(u, data_list["id"]) for u in img_url if u]
                cz = len(contents_1) - len(now_u)
                for c in range(cz):
                    now_u.append(" ")
                n_content = ["".join([str(j) for j in i]) for i in list(zip(contents_1, now_u))]
                n_content = "".join(n_content).replace("<http:", "\n<img src=\http:").replace(r"==", '').replace('"图',
                                                                                                                 'alt="图').replace(
                    "\\", ' ')
                n_content = n_content.replace('src= h', 'src="h').replace(' alt', '" alt')
                item["content"] = (n_content + "\n作者讨论\n" + data_list["comment"]).replace("\n", "<br/>")
                item["create_time"] = data_list["pubDate"]
                item["title"] = data_list["medicalName"]
                item["author"] = aut
                item["key_word"] = ""
                item["source"] = "医口袋病例"
                item["gid"] = parse_title(item["title"], item["source"])
                if item["gid"] not in self.old_url:
                    yield item
            except:
                pass
