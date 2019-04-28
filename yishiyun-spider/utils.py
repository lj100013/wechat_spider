import requests
import json
import time
import logging

def get_ip(retrytimes):
    """
    get proxy ip
    :return: host:port
    """
    zhi_ma_apiUrl = "http://webapi.http.zhimacangku.com/getip?num=1&type=1&pro=&city=0&yys=0&port=1&pack=34734&ts=0&ys=0&cs=0&lb=1&sb=0&pb=4&mr=1&regions="
    res = ''
    try:
        if retrytimes > 0:
            res = requests.get(zhi_ma_apiUrl).text
            json.loads(res)
            time.sleep(3)
            return get_ip(retrytimes - 1)
        else:
            return ""
    except:
        logging.warning("获取代理ip成功{}".format(res))
        return res.strip('\r\n')