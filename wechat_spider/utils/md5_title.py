#coding:utf-8
import hashlib
import logging

def parse_title(title):
    ids = title
    if len(title) < 2:
        logging.warning("length of title less than two chars!")
        return ""
    try:
        post_name = hashlib.md5(ids.encode(encoding='UTF-8')).hexdigest()
        return post_name
    except Exception as e:
        logging.error("exists illegal character!!{}".format(e))
        return ""
