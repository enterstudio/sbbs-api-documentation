---
title: 话题 | 虎踞龙蟠BBS API
---

# 话题API

## 获取话题内容

获取指定ID的帖子以及全部跟贴

    GET /topic/:board/:id

### 范例

    http://bbs.seu.edu.cn/api/topic/SEUExpress/402645.js?limit=3

### 参数

raw
: _可选_ **boolean** 是否过滤引文（默认为false）

start
: _可选_ **int** 起始下标

limit
: _可选_ **int** 最多获取话题数

### 返回

<%= headers 200 %>
<%= json(:topic_get) %>

