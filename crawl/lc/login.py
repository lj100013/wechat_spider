import requests


def login_():
    s = requests.Session()
    loginurl = 'http://www.medlive.cn/api/auth/quick_login'
    logindata = {"type": "android",
                 "app_name": "guide_android",
                 "vid": "864081036700438"}

    headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'User-Agent': 'Apache-HttpClient/UNAVAILABLE (java 1.4)',
        'Host': 'www.medlive.cn',
        'Connection': 'Keep-Alive',
        'Accept-Encoding': 'text/html;charset=utf-8',
        'Content-Length': '55',
    }

    # 提交登陆信息，开始登陆
    data = s.post(url=loginurl, data=logindata, headers=headers, stream=True, verify=False)
    loginResult = data.text
    return loginResult
