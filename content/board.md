---
title: 版面 | 虎踞龙蟠BBS API
---

# 版面API

## 获取版面话题

    GET /board/:name

### 范例

    http://bbs.seu.edu.cn/api/board/Test.json?start=0&limit=3&mode=0

### 参数

mode
: _可选_ **int** 版面模式：
  0 全部帖子（默认）
  1 主题贴
  2 论坛模式
  3 置顶帖
  4 文摘区
  5 保留区

start
: _可选_ **int** 起始下标

limit
: _可选_ **int** 最多获取话题数

### 返回

<%= headers 200 %>
<%= json(:board_get) %>

