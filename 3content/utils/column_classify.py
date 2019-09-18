from sklearn.externals import joblib
import pickle
from sklearn.feature_extraction.text import CountVectorizer
import jieba
import re
from pymongo import MongoClient
from utils.parse_config import *

jieba.load_userdict(words_lib_path)


stop_words = []
with open(stop_words_path, 'r', encoding='utf-8') as f1:
    for stop_word in f1.readlines():
        stop_words.append(stop_word.strip())


lr_model = pickle.load(open('/data/job_pro/dataX/3content/utils/logistic.pickle','rb'))
loaded_vec = CountVectorizer(decode_error="replace", vocabulary=pickle.load(open("/data/job_pro/dataX/3content/utils/vectorizer.pickle", "rb")))
tfidftransformer = pickle.load(open("/data/job_pro/dataX/3content/utils/transformer.pickle", "rb"))
# lr_model = joblib.load(open('/data/job_pro/dataX/3content/utils/logistic.pkl','rb'))
# loaded_vec = CountVectorizer(decode_error="replace", vocabulary=pickle.load(open("/data/job_pro/dataX/3content/utils/vectorizer.pickle", "rb")))
# tfidftransformer = pickle.load(open("/data/job_pro/dataX/3content/utils/transformer.pickle", "rb"))

def query_column():
    client = MongoClient('mongodb://{}:{}@{}:{}/'.format(mongo_user,mongo_password,mongo_host,mongo_port))
    db = client['yy_post']
    col = db["t_column"]
    columns = ['其他','创新','医保','医院','招采','法规','研报','药企','药品','药店']
    name_id = {}
    for name in columns:
        for x in col.find({"name":name},{"_id":1}):
            id = str(x['_id'])
            name_id[name] = id
    client.close()
    return name_id

def transform_char(content):
    sc = re.compile('<script.*?</script>', re.S)
    content = sc.sub('', content)
    dr = re.compile(r'<[^>]+>', re.S)
    dd = dr.sub('', content)
    res = ''
    for i in dd.split(";"):
        data = i.replace("&#", '').replace('\n', '').strip()
        if len(data) > 0:
            try:
                res += chr(int(data))
            except:
                nu = re.compile(r'/d', re.S)
                other = dr.sub('', data)
                no = data.replace(other, '')
                try:
                    res += (other.replace('\n', '').strip() + chr(int(no)))
                except:
                    res += other.replace('\n', '').strip()
    return res

def column_classification(text):
    text = transform_char(text)
    labels = ['其他','创新','医保','医院','招采','法规','研报','药企','药品','药店']
    seg_word = " ".join([i for i in list(jieba.cut(text)) if i not in stop_words])
    tfidf = tfidftransformer.transform(loaded_vec.transform([seg_word]))
    return labels[lr_model.predict(tfidf)[0]-1]
