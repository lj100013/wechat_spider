from qiniu import Auth, put_file, etag,BucketManager, CdnManager

access_key = '1TVghGdJZrf4238fjkhPJxVas8kR87xOU0f78UB7'
secret_key = 'jC1N8D3sMpmk-4-X9_rFgM0OvqR6q3lBWnuqCGIw'
auth = Auth(access_key, secret_key)

#要上传的空间
bucket_name = 'content'
bucket = BucketManager(auth)

cdn_manager = CdnManager(auth)
# 需要刷新的文件链接
urls = [
    'http://content.file.mediportal.com.cn/dict'
]
# 刷新链接
refresh_url_result = cdn_manager.refresh_urls(urls)
print(refresh_url_result)

#上传到七牛后保存的文件名
key = 'dict';
#生成上传 Token，可以指定过期时间等
token = auth.upload_token(bucket_name, key, 3600)

#要上传文件的本地路径
localfile = './dict.txt'

ret, info = put_file(token, key, localfile)
print(info)
assert ret['key'] == key
assert ret['hash'] == etag(localfile)

# 刷新链接
refresh_url_result = cdn_manager.refresh_urls(urls)
print(refresh_url_result)