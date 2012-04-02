---
title: 发文 | 虎踞龙蟠BBS API
---

# 发文API

## 发表/回复话题

当reid为0时发表新话题，否则回复指定话题。发文成功时会立即返回发表的话题。

    POST /topic/post

### 范例

    http://bbs.seu.edu.cn/api/topic/post.json?board=Test&title=test&content=test

### 参数

board
: _必需_ **string** 版面名

title
: _必需_ **string** 话题标题

content
: _必需_ **string** 话题内容

reid
: _可选_ **int** 不为0时表示回复此ID的话题，否则发表新话题（默认为0）

notopten
: _可选_ **boolean** 不上十大（默认为false）

noquote
: _可选_ **boolean** 不要自动引用原文（默认为false）

anony
: _可选_ **boolean** 匿名发文，考虑到本站目前仅有Psychology版为匿名版面，因此不在版面元数据中提供匿名版面属性。应用开发时仅需要在此版发文时提供匿名选项（默认为false）

### 返回

<%= headers 200 %>
<%= json(:topic_post) %>

