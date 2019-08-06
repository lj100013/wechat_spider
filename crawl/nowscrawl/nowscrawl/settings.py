# -*- coding: utf-8 -*-

# Scrapy settings for nowscrawl project
#
# For simplicity, this file contains only settings considered important or
# commonly used. You can find more settings consulting the documentation:
#
#     https://doc.scrapy.org/en/latest/topics/settings.html
#     https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
#     https://doc.scrapy.org/en/latest/topics/spider-middleware.html

import configparser
conf = configparser.ConfigParser()
conf.read("/data/job_pro/utils/config.ini")
MYSQL_HOST=conf.get('weixin', 'host')
MYSQL_PORT=int(conf.get('weixin', 'port'))
MYSQL_USER=conf.get('weixin', 'user')
MYSQL_PASSWORD=conf.get('weixin', 'password')

BOT_NAME = 'nowscrawl'

LOG_LEVEL= 'WARNING'

SPIDER_MODULES = ['nowscrawl.spiders']
NEWSPIDER_MODULE = 'nowscrawl.spiders'
# REDIRECT_ENABLED = False

# 你自己数据库的名称
MYSQL_DB = 'wordpress'
CHARSET = 'utf8'

# JOBDIR='wf_job'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'nowscrawl (+http://www.yourdomain.com)'

# Obey robots.txt rules
# ROBOTSTXT_OBEY = True

# Configure maximum concurrent requests performed by Scrapy (default: 16)
CONCURRENT_REQUESTS = 64
CONCURRENT_REQUESTS_PER_DOMAIN = 64
CONCURRENT_REQUESTS_PER_IP = 64
DOWNLOAD_DELAY = 1
# Configure a delay for requests for the same website (default: 0)
# See https://doc.scrapy.org/en/latest/topics/settings.html#download-delay
# See also autothrottle settings and docs

# The download delay setting will honor only one of:

# Disable cookies (enabled by default)
#COOKIES_ENABLED = False

# Disable Telnet Console (enabled by default)
#TELNETCONSOLE_ENABLED = False

# Override the default request headers:
DEFAULT_REQUEST_HEADERS = {
    'Accept-Language': 'en',
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36",
    "Accept-Language": "zh-CN,zh;q=0.9",
}

# Enable or disable spider middlewares
# See https://doc.scrapy.org/en/latest/topics/spider-middleware.html
#SPIDER_MIDDLEWARES = {
#    'nowscrawl.middlewares.NowscrawlSpiderMiddleware': 543,
#}

# Enable or disable downloader middlewares
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
# DOWNLOADER_MIDDLEWARES = {
#    'nowscrawl.middlewares.NowscrawlDownloaderMiddleware': 543,
# }

# Enable or disable extensions
# See https://doc.scrapy.org/en/latest/topics/extensions.html
#EXTENSIONS = {
#    'scrapy.extensions.telnet.TelnetConsole': None,
#}

# Configure item pipelines
# See https://doc.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   'nowscrawl.pipelines.NowscrawlPipeline': 300,
}

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

