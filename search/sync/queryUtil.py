from bson.int64 import long

from dbutil import mongoclient,mysqlcircledb,mysqlcoursedb
from bs4 import BeautifulSoup
import time

db = mongoclient['health']
deptTable = db['b_hospitaldept']
user = db['user']

faqdb = mongoclient['module']
faqTable = faqdb['t_faq_question']

basedb=mongoclient['basepost']
baseTable=basedb['post_info']

disdb=mongoclient['diseasediscuss']
disTable=disdb['disease_info']


activity = mongoclient['activity']
t_live_extdesc = activity['t_live_extdesc']

def get_suspend_user(id):
    row=user.find_one({"_id":id})
    return row

def getlivingdesc(id):
    row = t_live_extdesc.find_one({"liveId": str(id)})
    extDesc=''
    if row:
        if row is not None and 'extDesc' in row:
            extDesc = row['extDesc']
    livingDesc =removehtml(extDesc)
    return livingDesc

def removehtml(html):
    soup = BeautifulSoup(html, 'html.parser')
    desc=''
    if len(html)>10 and '<p>' in html :
        for k in soup.find_all('p'):
            if k.string is not None:
                desc = desc + k.string
    return desc
def getDeptName(deptid):
    row = deptTable.find_one({"_id": deptid, "enableStatus": 1})
    return row['name']

def getFaq(id):
    row = faqTable.find_one({"_id":id})
    return row

def getdisease_pics(id):
    time.sleep(5)
    pics=[]
    row = baseTable.find_one({"_id": long(id)})
    if 'attachmentList' in row.get('content'):
        for alist in row['content']['attachmentList']:
            pics.append(alist['url'])
    return pics

def getdisease(disid):
    row=disTable.find_one({"_id": long(disid)})
    return row

def getUserName(userid):
    row = user.find_one({"_id": int(userid)})
    if row:
        return row['name']
    else:
        return ''

def getLivingId(webcastId):
    time.sleep(3)
    mysqlcoursedb.ping(reconnect=True)
    cursor = mysqlcircledb.cursor()
    cursor.execute("SELECT id from circle_living where webcastId='%s'" % (webcastId))
    mysqlcoursedb.commit()
    row = cursor.fetchone()
    mysqlcircledb.close()
    return row

def getCircleName(circleid):
    mysqlcircledb.ping(reconnect=True)
    cursor = mysqlcircledb.cursor()
    cursor.execute("SELECT name from circle where id='%s'" % (circleid))
    mysqlcircledb.commit()
    row = cursor.fetchone()
    mysqlcircledb.close()
    return ''.join(row)



def getClassLable(courseId):
    time.sleep(3)
    mysqlcoursedb.ping(reconnect=True)
    cursor = mysqlcoursedb.cursor()
    cursor.execute("SELECT lable from t_course_lable where courseId='%s'" % (str(courseId)))
    mysqlcoursedb.commit()
    row = cursor.fetchall()
    tagList=[]
    for i in row:
        tagList.append(''.join(i))
    mysqlcoursedb.close()
    return ','.join(tagList)


if __name__ == '__main__':
    print(getDeptName('BJ'))
