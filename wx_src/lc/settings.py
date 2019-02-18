
# -*- coding: utf-8 -*-

# Scrapy settings for lc project
#
# For simplicity, this file contains only settings considered important or
# commonly used. You can find more settings consulting the documentation:
#
#     https://doc.scrapy.org/en/latest/topics/settings.html
#     https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
#     https://doc.scrapy.org/en/latest/topics/spider-middleware.html

BOT_NAME = 'lc'
SPIDER_MODULES = ['lc.spiders']
NEWSPIDER_MODULE = 'lc.spiders'
COMMANDS_MODULE = 'lc.commands'

LOG_LEVEL = 'WARNING'

# JOBDIR='wf_job'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'lc (+http://www.yourdomain.com)'

# Obey robots.txt rules
# ROBOTSTXT_OBEY = True

# Configure maximum concurrent requests performed by Scrapy (default: 16)
CONCURRENT_REQUESTS = 16

# Configure a delay for requests for the same website (default: 0)
# See https://doc.scrapy.org/en/latest/topics/settings.html#download-delay
# See also autothrottle settings and docs
#DOWNLOAD_DELAY = 1
# The download delay setting will honor only one of:
#CONCURRENT_REQUESTS_PER_DOMAIN = 16
#CONCURRENT_REQUESTS_PER_IP = 16

# Disable cookies (enabled by default)
#COOKIES_ENABLED = False

# Disable Telnet Console (enabled by default)
#TELNETCONSOLE_ENABLED = False



# Override the default request headers:
# DEFAULT_REQUEST_HEADERS = {
   # "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
   # "Accept-Encoding": "gzip, deflate",
   # "Accept-Language": "zh-CN,zh;q=0.9",
   # "Cache-Control": "max-age=0",
   # "Cookie": "ymt_pk_id=b03c14d4827e9fac; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22164b59336028a5-02b108c15ff336-3c3c5d0c-2073600-164b5933603253%22%2C%22%24device_id%22%3A%22164b59336028a5-02b108c15ff336-3c3c5d0c-2073600-164b5933603253%22%2C%22props%22%3A%7B%22%24latest_referrer%22%3A%22%22%2C%22%24latest_referrer_host%22%3A%22%22%7D%7D; user_reg_after=1; Hm_lvt_62d92d99f7c1e7a31a11759de376479f=1533620661,1533717675,1533893867,1534384550; _pk_ref.3.a971=%5B%22%22%2C%22%22%2C1534397804%2C%22https%3A%2F%2Fwww.baidu.com%2Flink%3Furl%3DWNzVpIwHI1hSIyDUt23Iezx456eAxG4qGpFvvxj9n17%26wd%3D%26eqid%3Df59838b600001140000000065b519365%22%5D; _pk_ses.3.a971=*; ymtinfo=eyJ1aWQiOiIwIiwicmVzb3VyY2UiOiIiLCJhcHBfbmFtZSI6IiIsImV4dF92ZXJzaW9uIjoiMSJ9; _pk_id.3.a971=b03c14d4827e9fac.1532072816.9.1534399250.1534393471.; Hm_lpvt_62d92d99f7c1e7a31a11759de376479f=1534399251; sess=ST-38231-cWcqVDTEZYXT4Z3CyBd7-cas",
   # "Host": "api.medlive.cn"
# }

# Enable or disable spider middlewares
# See https://doc.scrapy.org/en/latest/topics/spider-middleware.html
#SPIDER_MIDDLEWARES = {
#    'lc.middlewares.LcSpiderMiddleware': 543,
#}

# Enable or disable downloader middlewares
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
#DOWNLOADER_MIDDLEWARES = {
#    'lc.middlewares.LcDownloaderMiddleware': 543,
#}

# Enable or disable downloader middlewares
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
# DOWNLOADER_MIDDLEWARES = {
#     'lc.middlewares.NowscrawlDownloaderMiddleware': 543,
#  }


# Enable or disable extensions
# See https://doc.scrapy.org/en/latest/topics/extensions.html
#EXTENSIONS = {
#    'scrapy.extensions.telnet.TelnetConsole': None,
#}

# Configure item pipelines
# See https://doc.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   'lc.pipelines.LcPipeline': 300,
}

#https://mp.weixin.qq.com/profile?src=3&timestamp=1533096891&ver=1&signature=j4Z-TnzWwgTgYydP2qrrbnCoDRS2j0hyaRoQ1wp4UVICceyjQfd8UeJc7B6eAVSujMz32EvEKaC4RPSHZlq55g==
# Enable and configure the AutoThrottle extension (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/autothrottle.html
#AUTOTHROTTLE_ENABLED = True
# The initial download delay
#AUTOTHROTTLE_START_DELAY = 5
# The maximum download delay to be set in case of high latencies
#AUTOTHROTTLE_MAX_DELAY = 60
# The average number of requests Scrapy should be sending in parallel to
# each remote server
#AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:
#AUTOTHROTTLE_DEBUG = False

# Enable and configure HTTP caching (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html#httpcache-middleware-settings
#HTTPCACHE_ENABLED = True
#HTTPCACHE_EXPIRATION_SECS = 0
#HTTPCACHE_DIR = 'httpcache'
#HTTPCACHE_IGNORE_HTTP_CODES = []
#HTTPCACHE_STORAGE = 'scrapy.extensions.httpcache.FilesystemCacheStorage'