# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class LcItem(scrapy.Item):
    title = scrapy.Field()
    content = scrapy.Field()
    author = scrapy.Field()
    key_word = scrapy.Field()
    source = scrapy.Field()
    create_time = scrapy.Field()
    gid = scrapy.Field()
    wxname  = scrapy.Field()
