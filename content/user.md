---
title: 用户 | 虎踞龙蟠BBS API
---

# 用户接口

## 获取用户信息

    GET /user/:id

### 范例

    http://bbs.seu.edu.cn/api/user/fool.json

### 返回

<%= headers 200 %>
<%= json(:user) %>
