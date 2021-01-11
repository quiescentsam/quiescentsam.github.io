---
layout: note
title: Use of jq in aws cli
show-avatar : false
permalink: /personalblog/awscli-with-jq
date: 2017-07-19 00:00:00 -0400
comments: true
tags: [aws, jq, cloud, iaas]
---
`jq` is resourceful and helps in getting all the operations done, which query options fails

for example, I was struggling to pass a shell variable to cli command which I was able to do though jq

below command lets me get the exact name of the emr cluster and passing cluster ID as shell variable.
```shell
aws emr list-clusters --region $region |jq -r --arg cid "$cid"  '.Clusters[] | select(.Id == $cid ) | .Name'
```

Example to query the instances tag

```shell
aws ec2 describe-instances  --region us-east-1 --instance-ids i-02426396b622c2b23   2> /dev/null | jq -r '.Reservations[].Instances[].Tags[] | select(.Key=="owner") | .Value'
```
