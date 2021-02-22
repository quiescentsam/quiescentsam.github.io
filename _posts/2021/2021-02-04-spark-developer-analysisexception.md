---
layout: post
title: "org.apache.spark.sql.AnalysisException: Detected implicit cartesian product for INNER join between logical plans  "
subtitle: spark.sql.hive.caseSensitiveInferenceMode
show-avatar : false
permalink: /blog/spark-developer-metaexception
date: 2021-02-02 00:15:00 -0400
comments: true
published: false
categories: []
tags: [spark, aws]

---

I was working on a spark scala project where I hit the issue `Caused by: MetaException(message:Access Denied: ALTER_TABLE on`, but interestingly I was not running any ALTER TABLE or even a DML, 
then why did I get this error.

A small google search showed that it was because of spark 2.2's default value of ` INFER_AND_SAVE ` for `spark.sql.hive.caseSensitiveInferenceMode`. It simply means that spark tries to read the schema( Case of table name and columns names) from query and save it to actual table. That is where these `ALTER TABLE` statements game from.

So how to solve the issue, just set the value to ` INFER_ONLY`


scala> spark.sql("SELECT row_number() over( ORDER BY national_tv_broadcast_date) rownum,stg1.* FROM etl_stg1_national_tv_time_period_projection_fact stg1").show()
org.apache.spark.sql.AnalysisException: Detected implicit cartesian product for INNER join between logical plans
Aggregate [national_tv_broadcast_date_id#40L, national_tv_broadcast_date#625, null, null, national_tv_interval_of_day_key#1049, national_tv_quarter_hour_of_day_id#42, sample_collection_method_key#43, coverage_area_key#44, coverage_area_id#1053, viewing_source_key#46L, viewing_source_id#1055, market_break_key#48, market_break_id#49, 0, 0, demographic_key#50, demographic_id#1061, feed_pattern_code#1062, media_device_category_code#53, content_distribution_type_code#54, N, live_only_projection#1066, live_plus_same_day_projection#1067, live_plus_1_projection#1068, ... 11 more fields], [national_tv_broadcast_date_id#40L, national_tv_broadcast_date#625, national_tv_interval_of_day_key#1049, national_tv_quarter_hour_of_day_id#42, sample_collection_method_key#43, coverage_area_key#44, coverage_area_id#1053, viewing_source_key#46L, viewing_source_id#1055, market_break_key#48, market_break_id#49, demographic_key#50, demographic_id#1061, feed_pattern_code#1062, media_device_category_code#53, content_distribution_type_code#54, live_only_projection#1066, live_plus_same_day_projection#1067, live_plus_1_projection#1068, live_plus_2_projection#1069, live_plus_3_projection#1070, live_plus_4_projection#1071, live_plus_5_projection#1072, live_plus_6_projection#1073, ... 6 more fields]

```scala
spark.conf.set("spark.sql.crossJoin.enabled", "true")
```

Once I set this, the error is gone!!!

[Stackoverflow reference link](https://stackoverflow.com/questions/57821080/user-does-not-have-privileges-for-altertable-addcols-while-using-spark-sql-to-re)