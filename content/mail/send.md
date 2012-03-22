---
title: 写信 | 虎踞龙蟠BBS API
---

# 写信API

## 写信/回信

当reid为0时写新信，否则回复指定信件。发信成功时返回0。

    POST /mail/send

### 参数

user
: _必需_ **string** 收信人

title
: _必需_ **string** 站内信主题

content
: _必需_ **string** 站内信内容

reid
: _可选_ **int** 不为0时表示回复此ID的站内信，否则写新信（默认为0）

noquote
: _可选_ **boolean** 不要自动引用原文（默认为false）

### 返回

<%= headers 200 %>
<%= json(:result) %>

