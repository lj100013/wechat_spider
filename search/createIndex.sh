curl -XPUT http://cdh3:9200/search_v2 -d'{
  "settings": {
    "refresh_interval": "5s",
    "number_of_shards": 6,
    "number_of_replicas": 2,
    "analysis": {
      "filter": {
        "edge_ngram_filter": {
          "type": "edge_ngram",
          "min_gram": 1,
          "max_gram": 50
        },
        "pinyin_first_letter_and_full_pinyin_filter": {
          "type": "pinyin",
          "keep_first_letter": true,
          "keep_full_pinyin": false,
          "keep_joined_full_pinyin": true,
          "keep_none_chinese": false,
          "keep_original": false,
          "limit_first_letter_length": 16,
          "lowercase": true,
          "trim_whitespace": true,
          "keep_none_chinese_in_first_letter": true
        },
        "pinyin_full_filter": {
          "type": "pinyin",
          "keep_first_letter": false,
          "keep_full_pinyin": false,
          "keep_joined_full_pinyin": true,
          "keep_none_chinese": false,
          "keep_original": false,
          "limit_first_letter_length": 16,
          "lowercase": true,
          "trim_whitespace": true,
          "keep_none_chinese_in_first_letter": true,
          "keep_none_chinese_in_joined_full_pinyin": true
        },
        "pinyin_simple_filter": {
          "type": "pinyin",
          "keep_first_letter": true,
          "keep_separate_first_letter": false,
          "keep_full_pinyin": false,
          "keep_original": false,
          "limit_first_letter_length": 16,
          "none_chinese_pinyin_tokenize": false,
          "lowercase": true
        }
      },
      "analyzer": {
        "pinyinKeySimpleAnalyzer": {
          "type": "custom",
          "tokenizer": "keyword",
          "filter": [
            "pinyin_simple_filter",
            "lowercase"
          ]
        },
        "pinyinKeyFullAnalyzer": {
          "type": "custom",
          "tokenizer": "keyword",
          "filter": [
            "pinyin_full_filter",
            "lowercase"
          ]
        },
        "pinyin_analyzer": {
          "type": "custom",
          "tokenizer": "ik_smart",
          "filter": [
            "pinyin_first_letter_and_full_pinyin_filter",
            "lowercase"
          ]
        }
      }
    }
  },
  "mappings": {
    "_default_": {
      "properties": {
        "id": {
          "type": "keyword",
          "index": "not_analyzed"
        },
        "circleid": {
          "type": "keyword",
          "index": "not_analyzed"
        },
        "circlename": {
          "type": "keyword",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "src": {
          "type": "keyword",
          "index": "not_analyzed",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "hospital": {
          "type": "text",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "title": {
          "type": "text",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "dept": {
          "type": "text",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "expertise": {
          "type": "text",
          "index_options": "offsets",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "content": {
          "type": "text",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "label": {
          "type": "text",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "caption": {
          "type": "text",
          "analyzer": "ik_max_word",
          "fields": {
            "pinyin": {
              "type": "text",
              "store": "no",
              "term_vector": "with_positions_offsets",
              "analyzer": "pinyin_analyzer"
            }
          }
        },
        "pic": {
          "type": "keyword",
          "index": "not_analyzed"
        },
        "clickcount": {
          "type": "long",
          "index": "not_analyzed"
        },
        "word": {
          "type": "keyword",
          "fields": {
            "pinyin": {
              "analyzer": "pinyin_analyzer",
              "term_vector": "with_positions_offsets",
              "store": "no",
              "type": "text"
            }
          }
        },
        "livingid": {
          "type": "keyword",
          "index": "not_analyzed"
        },
        "type": {
          "type": "keyword",
          "index": "not_analyzed"
        },
        "classid": {
          "type": "keyword",
          "index": "not_analyzed"
        },
        "updatetime": {
          "type": "keyword",
          "index": "not_analyzed"
        }
      }
    }
  }
}'