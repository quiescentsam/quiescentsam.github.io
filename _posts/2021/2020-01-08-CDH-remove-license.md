---
layout: post
title: How to remove the license from a Cloudera Cluster
subtitle: Process to remove license from a cloudera cluster
show-avatar : false
permalink: /blog/cdh-remove-license
date: 2021-01-08 00:00:00 -0400
comments: true
published: true
categories: []
tags: [cdh, license]

---

Recently we wanted to remove license for one of our clusters, and we used the following approach to remove the license from the cluster. We are on CDH 5.11 which is very old and gone out of support.

For planning, first step it to evaluate the licensed feature currently in use. If you are actively using any of such features, it might affect the functionality and cause major issues if not planned properly.
 on the top of my head, the key features like below needs to checked 
    
    * Rolling upgrade of CDH,
    * Manage Key Trustee and Cloudera Navigator,
    * Configuration versioning and history,
    * Restoring a configuration using the API,
    * LDAP authentication for Cloudera Manager
    * SAML authentication
    * Data encryption with KMS
    * Cloudera Manager user roles
    * Alert by SNMP
    * Automated backup and disaster recovery
    * File browsing, searching, and disk quota management
    * HBase, MapReduce, Impala, and YARN usage reports
    * Metadata management and augmentation
    * Ingest policies
    * Auditing and Lineage

For a complete list, I suggest working with Cloudera Support or documentation to get complete information.

Coming to technical steps for removing license, converting from Enterprise to Express edition. Since Cloudera Manager 5.11 (less the 5.13) does not have an option to remove license from cloudera manager UI, we have to use the database approach, ie, we would be deleting the license key from backend database of the Cloudera manager.

First, Log in to Cloudera Manager and stop the Cloudera Management Services. (Host Monitor, Event server, Alert Publisher, etc)

Next from the Cloudera Manager server shell, Stop Cloudera Manager.
   
```shell
service cloudera-scm-server stop
```

We can check the  the Cloudera Manager database instance name and credentials from the `db.properties` file.
Default location of the file is `/etc/cloudera-scm-server/db.properties`   

Use the values of below parameters for connecting to database.

```hocon
com.cloudera.cmf.db.type=$DBTYPE   
com.cloudera.cmf.db.host=$DBHOST:$DBPORT
com.cloudera.cmf.db.name=$DBNAME
com.cloudera.cmf.db.user=$DBUSER
com.cloudera.cmf.db.password=$DBPASS
```

If DBPORT is empty, use default port 3306 for mysql, I am covering steps for Mysql and Postgres, but steps would be fairly same for other databases like oracle and MsSql as well.

Start with backing up the dataabse

```shell
\\For MySQL:# 

mysqldump -h $DBHOST -P $DBPORT -u $DBUSER -p $DBNAME > /root/backup.`date +%Y-%m-%d:%H:%M`. sql

For Postgres:# 

pg_dump -h $DBHOST -p $DBPORT -U $DBUSER -W $DBNAME > /root/backup.`date +%Y-%m-%d:%H:%M`.sql
```

Then, login to databases
```shell
For MySQL:#

mysql -h $DBHOST -P $DBPORT -u $DBUSER -p $DBNAME

For Postgres:# 

psql -h $DBHOST -p $DBPORT -U $DBUSER -W $DBNAME
```   

Type the $DBPASS when requested.
Update the record to remove the license key.

```sql
update CONFIGS set VALUE = '' where ATTR = 'license_key';
```

Validate the changes

```sql
select CONFIG_ID, ATTR, VALUE from CONFIGS where ATTR = 'license_key';
+-----------+-------------+-------+
-- | CONFIG_ID | ATTR | VALUE |
-- +-----------+-------------+-------+| 79 | license_key | |+-----------+-------------+-------+
1 row in set (0.00 sec)8. 
```

Quit the shell

```sql
For MySQL:mysql> quit
For Postgres:scm> \q
```

Once completed, restart the Cloudera manager server.
   
```shell 
service cloudera-scm-server start
```

Once Cloudera manager is started, login to Cloudera Manager and start the Cloudera Management Services. Finally, just restart the services and make sure, everything is working fine.


When check the license page, you would notice that Cloudera Express is in use and tab for BDR(backup) is gone now.

