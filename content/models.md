---
title: 元数据 | 虎踞龙蟠BBS API
---

# 元数据

API的元数据对应于应用中的Model，应用应该根据元数据来建立Model简化开发。

## 话题元数据

信件和帖子均使用此元数据。

### 范例

    http://bbs.seu.edu.cn/api/topic/Pet/9435.json

### 字段说明

id
: **int** 帖子id

board
: **string** 帖子所在版面

size
: **int** 帖子大小

read
: **int** 文章阅读数

replies
: **int** 文章回复数

reid
: **int** 回复帖子的id

unread
: **boolean** 是否未读

top
: **boolean** 是否置顶

mark
: **boolean** 是否标记过

author
: **string** 发贴人

time
: **time_t** 发贴时间戳

title
: **string** 标题

content
: **string** 内容

quote
: **string** 帖子引用的内容

quoter
: **string** 引用内容的作者

### 注意

`quote`和`quoter`由分析文本获得，并不可靠。如API中未特定说明，`content`不包含引用的部分。

## 版面元数据

版面、收藏夹、分区均使用此元数据

### 范例

    http://bbs.seu.edu.cn/api/sections.json

### 字段说明

name
: **string** 版面英文名

description
: **string** 版面中文名

count
: **int** 帖子数目

users
: **int** 在线用户数

bm
: **array** 版主

### 分区和收藏夹额外说明

name
: _分区_ **string** 分区中文名

description
: _分区_ **string** 显示`[目录]`或者`[上级目录]`

boards
: _分区_ **array** 分区包含的版面

leaf
: _分区_ **boolean** 是否为叶子节点

### 递归说明

收藏夹和分区都通过`boards`字段递归包含，并提供`leaf`来判断是否为叶子节点，对于一些对递归友好的framework（如Sencha Touch），这样可以极大地简化目录浏览的实现。

## 用户元数据

### 范例

    http://bbs.seu.edu.cn/api/user/fool.json

### 字段说明

id
: **string** 用户ID

name
: **string** 用户中文昵称

avatar
: **uri** 用户头像地址

lastlogin
: **time_t** 上次登录时间

level
: **string** 等级称谓

posts
: **int** 发文数

perform
: **int** 表现值

experience
: **int** 经验值

medals
: **int** 勋章数

logins
: **int** 上站次数

life
: **int** 生命值


