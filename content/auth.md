---
title: 身份验证 | 虎踞龙蟠BBS API
---

# 身份验证

虎踞龙蟠BBS现在支持两种身份验证方式：cookie和token。

通过cookie的验证方式主要是为了方便调试，在BBS网站上登录之后，你就可以以登录用户的身份执行API操作，直接在浏览器中进行调试。

对于普通应用我们要求使用token方式进行验证，未来我们将提供OAuth验证方式。

## 通过token验证流程

对于大部分应用，身份验证按照如下方式进行

### 1. 获取token

    GET http://bbs.seu.edu.cn/api/token.json

### 参数

user
: _必需_ **string** - 用户id

pass
: _必需_ **string** - 用户密码

### 返回

<%= headers 200 %>
<%= json(:token) %>

`token`字段中保存了用户token。

注意：如果你已经在浏览器中登录过，那么此时cookie验证方式将优先于token验证方式。也就是说，无论你的`user`和`pass`参数如何，返回的token都属于当前登录的用户。

### 2. 调用时附带token

对于要求身份验证的API，你需要在调用时附上`token`参数。如果没有附上`token`参数，将按照cookie来进行身份验证。

以发贴为例，此API要求用户进行登录，在调用时需要附上`token`，如

    http://bbs.seu.edu.cn/api/topic/post.json?token=Zm9vbA==:==asdfoHYLkEW0n2ltyx5QKO....

## 注意事项

### 1. token有效期

当前token的有效期为无限长，也就是说一次登录后就再也不需要登录第二次。但是用户修改密码或者其它敏感信息后，token将会设为无效。所以应用必须准备应对token无效的情况。

在未来可能会为token设定一个有效期。

### 2. OAuth

目前暂时没有使用OAuth验证，但是未来将会全面切换到OAuth验证，应用需要为此做好准备。

### 3. URI编码

传入token时要注意将token进行URI编码，避免可能的Bug。

## 登录与登出

API目前是无状态的，也就是说使用API的用户将处于不在线状态，并且不计算在线时间和上站次数。未来将提供专门用于维护登录状态的API。


