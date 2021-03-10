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


Furthermore, if we want to find the owner of the tables also, we can use below query also

```sql
SELECT n.nspname AS schema_name
 , pg_get_userbyid(c.relowner) AS table_owner
 , c.relname AS table_name
 , CASE WHEN c.relkind = 'v' THEN 'view' ELSE 'table' END 
   AS table_type
 , d.description AS table_description
 FROM pg_class As c
 LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
 LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
 LEFT JOIN pg_description As d 
      ON (d.objoid = c.oid AND d.objsubid = 0)
 WHERE c.relkind IN('r', 'v') 
 AND c.relname like '%table_name%'
ORDER BY n.nspname, c.relname ;
```
