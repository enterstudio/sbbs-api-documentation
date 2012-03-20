---
title: 站内信 | 虎踞龙蟠BBS API
---

# 站内信API

## 获取信箱内的信件

    GET /mailbox/get

### 别名 

收件箱

    GET /mailbox/inbox

发件箱

    GET /mailbox/sent

垃圾箱

    GET /mailbox/deleted

### 范例

    http://bbs.seu.edu.cn/api/mailbox/inbox.json

### 参数

type
: _必需_ **int** 信箱类型
  0 收件箱
  1 发件箱
  2 垃圾箱

start
: _可选_ **int** 起始下标

limit
: _可选_ **int** 最多获取话题数

### 返回

<%= headers 200 %>
<%= json(:mailbox_get) %>

## 获取信件内容

    GET /mail/get

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
<%= json(:mail_get) %>

