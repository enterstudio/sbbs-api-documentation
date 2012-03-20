---
title: 分区十大 | 虎踞龙蟠BBS API
---

# 分区十大API

本站提供全站热门话题的统计API，应用可以据此显示全站概览。

## 首页全站热门

    GET hot/topics

### 范例

    http://bbs.seu.edu.cn/api/hot/topics.json

## 分区热门

    GET /hot/section

### 范例

    http://bbs.seu.edu.cn/api/hot/section.json?section=0

### 参数

section
: _必需_ **int** 分区编号

### 返回

<%= headers 200 %>
<%= json(:hot_section) %>

