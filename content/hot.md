---
title: 十大 | 虎踞龙蟠BBS API
---

# 十大API

## 十大话题

    GET /hot/topten

### 返回

<%= headers 200 %>
<%= json(:hot_topten) %>

## 十大版面

    GET /hot/boards

### 返回

<%= headers 200 %>
<%= json(:hot_boards) %>
