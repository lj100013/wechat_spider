from dbutil import es, mongoclient,starttime
db = mongoclient['health']
user_tb = db['user']
for user in user_tb.find({"suspend":4}):
    es_id=user['_id']
    print("suspend:"+str(es_id))
    es.delete(index='search', doc_type='user', id=es_id,ignore=[400, 404])

for user in user_tb.find({"doctor.departments":{"$exists":False}}):
    es_id=user['_id']
    print("invalid:"+str(es_id))
    es.delete(index='search', doc_type='user', id=es_id,ignore=[400, 404])