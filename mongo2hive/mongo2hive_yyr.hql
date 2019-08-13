--运营分析一期中用到的表
--同一个sql允许并行任务的最大线程数
set hive.exec.parallel.thread.number=5;
set mapreduce.map.memory.mb=4096; 
set mapreduce.map.java.opts=-Xmx3600m;
set mapreduce.reduce.memory.mb=4096; 
set mapreduce.reduce.java.opts=-Xmx3600m;

--插入:mongo2hive.yy_post_t_post到pro.ods_yyr_t_post
insert overwrite table pro.ods_yyr_t_post PARTITION(dt='${hivevar:preday}')
select
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(type,'\\n|\\r','')) as type,
trim(regexp_replace(source,'\\n|\\r','')) as source,
trim(regexp_replace(columnId,'\\n|\\r','')) as columnId ,
trim(regexp_replace(contentType,'\\n|\\r','')) as contentType ,
trim(regexp_replace(title,'\\n|\\r','')) as title ,
trim(regexp_replace(coverUrl,'\\n|\\r','')) as coverUrl ,
trim(regexp_replace(content_text,'\\n|\\r','')) as content_text ,
trim(regexp_replace(content_richTextId,'\\n|\\r','')) as content_richTextId ,
trim(regexp_replace(contentUrl,'\\n|\\r','')) as contentUrl ,
content_pics ,
content_videos ,
content_audios ,
content_supplements,
content_attachments ,
trim(regexp_replace(creator,'\\n|\\r','')) as creator ,
trim(regexp_replace(author_id,'\\n|\\r','')) as author_id ,
trim(regexp_replace(author_type,'\\n|\\r','')) as author_type ,
trim(regexp_replace(author_name,'\\n|\\r','')) as author_name ,
trim(regexp_replace(author_workunit,'\\n|\\r','')) as author_workunit ,
trim(regexp_replace(author_position,'\\n|\\r','')) as author_position ,
trim(regexp_replace(author_headpic,'\\n|\\r','')) as author_headpic ,
trim(regexp_replace(isdel,'\\n|\\r','')) as isdel ,
trim(regexp_replace(isHide,'\\n|\\r','')) as isHide ,
trim(regexp_replace(statis_readCount,'\\n|\\r','')) as statis_readCount ,
trim(regexp_replace(statis_commentCount,'\\n|\\r','')) as statis_commentCount ,
trim(regexp_replace(statis_likeCount,'\\n|\\r','')) as statis_likeCount ,
trim(regexp_replace(status,'\\n|\\r','')) as status ,
trim(regexp_replace(shareWords,'\\n|\\r','')) as shareWords ,
trim(regexp_replace(shareIcon,'\\n|\\r','')) as shareIcon ,
trim(regexp_replace(top,'\\n|\\r','')) as top ,
trim(regexp_replace(topTime,'\\n|\\r','')) as topTime ,
safeLabel ,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime ,
trim(regexp_replace(updateTime,'\\n|\\r','')) as updateTime 
from mongo2hive.yy_post_t_post;