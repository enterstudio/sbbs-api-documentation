---
title: 搜索 | 虎踞龙蟠BBS API
---

# 搜索API

文章搜索API使用和[虎踞龙蟠搜索](http://bbs.seu.edu.cn/s)相同的引擎，在未来将提供如自动纠错、相关搜索、时间范围、结果过滤等功能。目前仅提供基础的文章搜索功能。

[虎踞龙蟠搜索](http://bbs.seu.edu.cn/s)的高级查询语句可以在API中正常使用。

## 文章搜索

    GET /search/topics

### 范例

    http://bbs.seu.edu.cn/api/search/topics.json?keys=test

### 参数

keys
: _必需_ **string** 关键词

start
: _可选_ **int** 起始下标

limit
: _可选_ **int** 最多获取结果数

### 返回

<%= headers 200 %>
<%= json(:search_topics) %>

