---
title: 收藏夹 | 虎踞龙蟠BBS API
---

# 收藏夹API

## 获取收藏夹

    GET /fav/get

### 范例

    http://bbs.seu.edu.cn/api/fav/get.json

### 参数

up
: _可选_ **boolean** 自动增加..作为上级目录（默认为false）

### 返回

<%= headers 200 %>
<%= json(:fav_get) %>

