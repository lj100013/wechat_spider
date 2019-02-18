# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class LcItem(scrapy.Item):
    id = scrapy.Field()
    str_url = scrapy.Field()
    source = scrapy.Field()
    title = scrapy.Field()
    content = scrapy.Field()
    createTime = scrapy.Field()
    dt = scrapy.Field()
