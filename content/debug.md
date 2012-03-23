---
title: 调试技巧 | 虎踞龙蟠BBS API
---

# 调试技巧

## 浏览器中调试

默认情况下`.json`格式的文件会被浏览器当作文件下载下来，如果想要直接在浏览器中看到输出结果，可以使用`.js`作为后缀。比如

    http://bbs.seu.edu.cn/api/user.js

## 用curl调试

由于输出的文本经过了编码，所以浏览器和文本编辑器中无法直接看到中文内容，也没有整齐的格式，这时可以使用curl来进行调试，比如

<pre class="terminal">
$ curl http://bbs.seu.edu.cn/api/user.json | json_reformat 
{
  "user": {
    "id": "guest",
    "name": "东南晨曦",
    "avatar": "http://bbs.seu.edu.cn/wForum/",
    "lastlogin": 1332492886,
    "level": "新人",
    "posts": 8,
    "perform": -9999,
    "experience": -9999,
    "medals": 0,
    "logins": 101974,
    "life": 59
  },
  "time": 1332505125,
  "cost": 3,
  "success": true
}
</pre>

这样同时也模拟了实际应用中的情形，推荐使用。
