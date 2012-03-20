---
title: 通知 | 虎踞龙蟠BBS API
---

# 通知API

通知接口提供了用户通知支持，应用可以通过通知接口获取@用户、回复用户的帖子，以及邮箱未读邮件的提醒。

## 获取通知

    GET /notifications

### 范例

    http://bbs.seu.edu.cn/api/notifications.json

### 返回

<%= headers 200 %>
<%= json(:notifications) %>

### 返回说明

mails
: **array** 未读邮件

ats
: **array** @你的帖子

replies
: **array** 回复你的帖子

## 清除通知

清除所有通知，无返回

    GET /clear_notifications

### 范例

    http://bbs.seu.edu.cn/api/clear_notifications.json

