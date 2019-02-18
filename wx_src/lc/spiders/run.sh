#!/bin/bash
python /data/job_pro/dataX/wx_src/lc/spiders/get_weixin_source.py
cd /data/job_pro/dataX/wx_src/lc/spiders/ && scrapy crawl wx
preday=`date -d "yesterday" +%Y-%m-%d`
impala-shell -q "invalidate metadata ods.ods_article_source"
impala-shell -q "upsert into dw.dw_article_source_d 
select id,if(url like '%mp.weixin.qq.com%','微信公众号','网站') as type,url,source,title,createtime from ods.ods_article_source where dt>='$preday'"