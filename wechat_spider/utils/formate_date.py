#coding:utf-8
def formate_date(create_date):
    date_time = create_date.replace('年', '-')
    date_time = date_time.replace('月', '-')
    date_time = date_time.replace('日', '')
    date_time = date_time + ' 00:00:00'
    return date_time