---
layout: post
title: How to disable kerberos in a CDH cluster
subtitle: Dekerberization of hadoop cluster
permalink: /blog/disable-kerberos-on-CDH/
date: 2020-12-23 00:00:00 -0400
comments: true
published: true
categories: []
tags: [hadoop, CDH, kerberos]

---

I am sure the first question arising in any sane person's mind is why are we doing it? normally everyone goes the other way, we would want to make our cluster more secure and kerberize the cluster.  And here I am, going the other way. It is due to change in how we want to use the clusters in the future.

* All of our clusters are no-more multi-tenant, so losing authorization was lesser of a concern. We no longer needed to secure data between applications.
* We used Redhat's IPA as our Identity Provider and since we were moving to Centos, we wanted to get rid on IPA as well.

I have covered the changes made to cluster configuration through Cloudera manager, but I am sure same changes can be easily made using Ambari as well.


---
## Hadoop Properties to change

| Service | Property Name | Property Value|
| ------:| -----------:|-----------:|
| Zookeeper   | `enableSecurity (Enable Kerberos Authentication)` | False (uncheck)|
| HDFS | `hadoop.security.authentication` | Simple|
| HDFS | `hadoop.security.authorization` | False (uncheck)|
| HDFS | `dfs.datanode.address` | from 1004 (for Kerberos) to 50010 (default)|
| HDFS | `dfs.datanode.http.address` | from 1006 (for Kerberos) to 50075 (default)|
| HDFS | Data Directory Permissions | from 700 to 755|
| Hbase | `hbase.security.authentication` | Simple|
| Hbase | `hbase.security.authorization` | Simple|
| Solr | Solr Secure Authentication | simple|
| Kafka | kerberos.auth.enable | Stop and delete Role|
| Hue | Kerberos Ticket Renewer | False|

After removing kerberos authentication, to maintain the behavior in which all yarn container are executed as user submitting the yarn job and not as `nobody` user, we have to make changes in below parameters.

| Service | Property Name | Property Value|
| ------:| -----------:|-----------:|
| Yarn | `yarn.nodemanager.linux-container-executor.nonsecure-mode.local-user` | yarn|
| Yarn | `yarn.nodemanager.linux-container-executor.nonsecure-mode.limit-users` | false|

In CDH 5.11 , second parameter needs to set in safety and NOT just unchecking the parameter in Cloudera Manager, just edit parameter `YARN Service Advanced Configuration Snippet (Safety Valve)` for yarn-site.xml


* As we are removing kerberos authentication, we have to get need to stop and delete Sentry which provides authorization. Before stopping and deleting the sentry service, make below changes in the configuration.

| Service | Property Name | Property Value|
| ------:| -----------:|-----------:|
| Solr | Sentry Service | none|
| Hive | Sentry Service | none|
| Impala | Sentry Service | none|
| Hue | Sentry Service | none|
| Kafka | Sentry Service | none|


* Clear yarn usercache - follow the steps detailed here in
  [Cloudera community](https://community.cloudera.com/t5/Community-Articles/How-to-clear-local-file-cache-and-user-cache-for-yarn/ta-p/245160 "community article") Delete the cache on all nodes and all the usercache carefully on all the nodes, here is a sample command I used on the hosts with nodemanager roles `rm -rf  /mnt/dsk/*/yarn/nm/usercache/*'`

## Code changes

* Impala
* hive
* spark




