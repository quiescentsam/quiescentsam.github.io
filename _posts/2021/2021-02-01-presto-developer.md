---
layout: post
title: How to Find a table in Presto
subtitle: presto commands
show-avatar : false
permalink: /blog/presto-developer
date: 2021-02-01 00:15:00 -0400
comments: true
published: false
categories: []
tags: [presto, aws]

---

I wanted to find a table in presto cluster and was looking for something similar to dba_ or v$ views in oracle to find the table.

Below is the query we can use to find with name starting with 'table'


```sql
select table_schema,
table_name
from information_schema.tables
where table_name like 'table%'
and table_schema not in ('information_schema', 'pg_catalog')
and table_type = 'BASE TABLE'
order by table_schema,
table_name;
```

Output is below format

|**table_schema**|**table_name**|
-------  |------------- 
|prod_schema|	table|
|prod_schema|	table2|