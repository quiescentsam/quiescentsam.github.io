---
layout: post
title: "Caused by: MetaException(message:Access Denied: ALTER_TABLE on  "
subtitle: spark.sql.hive.caseSensitiveInferenceMode
show-avatar : false
permalink: /blog/spark-developer-metaexception
date: 2021-02-02 00:15:00 -0400
comments: true
published: true
categories: []
tags: [spark, aws]

---

I was working on a spark scala project where I hit the issue `Caused by: MetaException(message:Access Denied: ALTER_TABLE on`, but interestingly I was not running any ALTER TABLE or even a DML, 
then why did I get this error.

A small google search showed that it was because of spark 2.2's default value of `* INFER_AND_SAVE *` for `spark.sql.hive.caseSensitiveInferenceMode`. It simply means that spark tries to read the schema( Case of table name and columns names) from query and save it to actual table. That is where these `ALTER TABLE` statements game from.

So how to solve the issue, just set the value to `* INFER_ONLY*`

```scala
spark.conf.set("spark.sql.hive.caseSensitiveInferenceMode", "INFER_ONLY")
```

Once I set this, the error is gone!!!

[reference link] (https://stackoverflow.com/questions/57821080/user-does-not-have-privileges-for-altertable-addcols-while-using-spark-sql-to-re)