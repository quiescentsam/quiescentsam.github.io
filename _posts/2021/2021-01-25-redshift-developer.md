---
layout: post
title: How to Find a table in Redshift
subtitle: redshift commands
show-avatar : false
permalink: /blog/redshift-developer
date: 2021-01-25 00:00:00 -0400
comments: true
published: true
categories: []
tags: [redshift, aws]

---

I wanted to find a table in redshift cluster and was looking for something similar to dba_ or v$ views in oracle to find the table.

Below is the query we can use.


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
|prod_schema|	prod_table|
|prod_schema|	prod_table2|