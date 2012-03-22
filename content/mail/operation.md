---
title: 信件管理 | 虎踞龙蟠BBS API
---

# 信件管理API

## 删除信件

删除成功时返回0。

    GET /mail/delete

### 参数

type
: _必需_ **int** 信箱类型
  0 收件箱
  1 发件箱
  2 垃圾箱

id
: _必需_ **int** 信件ID

### 返回

<%= headers 200 %>
<%= json(:result) %>
