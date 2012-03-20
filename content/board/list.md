---
title: 自动完成 | 虎踞龙蟠BBS API
---

# 自动完成API

为了方便应用实现自动补全版面名以及版面搜索的功能，本站提供了简单的自动完成API，返回一个简单的字符串数组供应用匹配。

## 以数组列出全部版面

    GET /board/list

### 范例

    http://bbs.seu.edu.cn/api/board/list.json

### 返回

<%= headers 200 %>
<%= json(:board_list) %>

