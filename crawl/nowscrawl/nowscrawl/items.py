# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class NowscrawlItem(scrapy.Item):
    # define the fields for your item here like
    post_name = scrapy.Field()
    organization = scrapy.Field()
    article_year = scrapy.Field()
    key_word = scrapy.Field()
    source = scrapy.Field()
    post_title = scrapy.Field()
    post_content = scrapy.Field()
    author = scrapy.Field()
    first_author = scrapy.Field()
