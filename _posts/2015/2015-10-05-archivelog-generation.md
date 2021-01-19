---
layout: post
title: Archive log generated per day or per hour
subtitle: This is to find the historical archive log generation report.
show-avatar : false
permalink: /blog/archivelog-generation
date: 2015-10-05 00:00:00 -0400
comments: true
published: true
categories: []
tags: [oracle , rman]

---

Simple query to find the archive generated

```sql
select trunc(completion_time),count(1),round(count(1)*200/1024) from v$archived_log group by  trunc(completion_time) order by  trunc(completion_time);
```

Query to give size of archive generated perday in GB

```sql
SELECT A.*,
Round(A.Count#*B.AVG#/1024/1024/1024) Daily_Avg_GB
FROM
(
SELECT
To_Char(First_Time,'YYYY-MM-DD') DAY,
Count(1) Count#,
Min(RECID) Min#,
Max(RECID) Max#
FROM
v$log_history
GROUP
BY To_Char(First_Time,'YYYY-MM-DD')
ORDER
BY 1 DESC
) A,
(
SELECT
Avg(BYTES) AVG#,
Count(1) Count#,
Max(BYTES) Max_Bytes,
Min(BYTES) Min_Bytes
FROM
v$log
) B;
```

Query to give archive generation on an hourly basis

```sql
set pagesize 120;
set linesize 200;
col day for a8;
select
    to_char(first_time,'YY-MM-DD') day,
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),'999') "00",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),'999') "01",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),'999') "02",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),'999') "03",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),'999') "04",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),'999') "05",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),'999') "06",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),'999') "07",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),'999') "08",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),'999') "09",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),'999') "10",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),'999') "11",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),'999') "12",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),'999') "13",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),'999') "14",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),'999') "15",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),'999') "16",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),'999') "17",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),'999') "18",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),'999') "19",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),'999') "20",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),'999') "21",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),'999') "22",
    to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),'999') "23",
    COUNT(*)
from v$log_history
group by to_char(first_time,'YY-MM-DD')
order by day ;
```


### For sizing of archive log destination,
* it should be twice the size of maximum archive generated per day.  

* compressed backup of archive logs comes to 30 % of actual archive log size.