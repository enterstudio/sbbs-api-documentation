---
title: 版面搜索 | 虎踞龙蟠BBS API
---

# 版面搜索API

## 版面搜索

    GET /search/boards

### 范例

    http://bbs.seu.edu.cn/api/search/boards.json?name=%E8%B6%B3%E7%90%83

### 参数

name
: _必需_ **string** 版面名或者版面关键词

### 返回

<%= headers 200 %>
<%= json(:search_boards) %>

