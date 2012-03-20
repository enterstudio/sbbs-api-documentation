---
title: 版面操作 | 虎踞龙蟠BBS API
---

# 版面操作API

## 版面标记已读

    GET /board/:name/markread

### 范例

    http://bbs.seu.edu.cn/api/board/Test/markread.json

### 返回

<%= headers 200 %>
<%= json(:result) %>

