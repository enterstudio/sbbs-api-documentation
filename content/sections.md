---
title: 分区信息 | 虎踞龙蟠BBS API
---

# 分区API

分区接口将返回全部分区信息和版面信息，由于版面极少变更且数据量较大，应用应该在相当长的时间范围内只调用一次分区接口，并由用户手动选择刷新。

分区信息中包含了分区与版面之间的递归层次关系，应用应该提供目录式浏览方式。详见[版面元数据](/api-documentaion/models/)。

## 分区

    GET /sections

### 范例

    http://bbs.seu.edu.cn/api/sections.json

### 参数

up
: _可选_ **boolean** 自动增加..作为上级目录（默认为false）

### 返回

<%= headers 200 %>
<%= json(:sections) %>
