---
title: 调用约定 | 虎踞龙蟠BBS API
---

# 调用约定

本站全部API遵循统一的调用约定，本页详述了这些约定。后页如非特定说明，均默认使用下面的约定。

## URL约定

API的调用前缀统一为`http://bbs.seu.edu.cn/api`，后文中对于API的描述，如

    GET /users/:user/gists

表示通过`GET`方式下载`http://bbs.seu.edu.cn/api/users/:user/gists.json`。

链接最后的`.json`表示API返回的格式，如`.xml`、`.json`、`.rss`等。**目前本站仅支持`.json`返回格式**。

## 返回格式约定

一次成功的调用返回如下：

<%= headers 200 %>
<%= json(:example_success) %>

其中，`root`字段表示返回结果，`root`可以是`mail`、`topics`等等。`time`字段表示服务器当前时间戳。`cost`字段表示此次API消耗时间，单位是ms。而`success`字段表示此次调用成功与否。

一次失败的调用返回如下：

<%= headers 200 %>
<%= json(:example_error) %>

多出的`error`字段用中文描述了出错的原因，可以直接在程序中引用。

目前HTTP返回代码全部是200，但不要依赖这一行为，未来可能根据错误的类型返回不同的HTTP代码。

另外API支持JSONP模式，任意API调用时传入`callback`参数即可。

## 编码

本站API的输入输出编码全部为UTF-8，如果想要使用GBK编码，可以在调用时使用参数`gbk=1`。

目前不推荐使用GBK编码。

