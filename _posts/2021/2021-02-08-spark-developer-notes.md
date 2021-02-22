---
layout: post
title: "Caused by: MetaException(message:Access Denied: ALTER_TABLE on  "
subtitle: spark.sql.hive.caseSensitiveInferenceMode
show-avatar : false
permalink: /blog/spark-developer-metaexception
date: 2021-02-02 00:15:00 -0400
comments: true
published: false
categories: []
tags: [spark, aws]

---

* How to get the count of columns for a dataframe

```scala
scala> my_df.columns.size
res10: Int = 2
```

Once I set this, the error is gone!!!

[Stackoverflow reference link](https://stackoverflow.com/questions/57821080/user-does-not-have-privileges-for-altertable-addcols-while-using-spark-sql-to-re)