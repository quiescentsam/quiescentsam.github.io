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
tags: [cdh, network, rhel]

---

Hadoop clusters, or for that matter, any cluster which perform data processing does put a lot of pressure on the network infrastructure. So we need to understand and monitor and tune the network performance of the nodes of the cluster.

In this blog I am sharing the shell scripts used to monitor the packet drops at the network interphase on all the nodes of the cluster

This script uses `pssh` tool to ssh to all the host, hence it is needed to have pssh installed, passwordless ssh setup from master node to all nodes and list of all nodes present at '/root/administration/hosts/server_list'


    
```shell
#!/bin/bash

export LC_CTYPE="en_US.UTF-8"

cluster_name="$1"
network_stats_dir="/root/administration/network_stats"

mkdir -p ${network_stats_dir}
rm -f ${network_stats_dir}/network_data_previous
cp ${network_stats_dir}/network_data_current ${network_stats_dir}/network_data_previous

network_interface=$(/sbin/route | grep "^default" | grep -o "[^ ]*$")

if [[ "${network_interface}" == *"eth"* ]]; then
    # For eth* network interfaces
    pssh -h /root/administration/hosts/server_list -i 'hostname; echo "interface `/sbin/route | grep "^default" | grep -o "[^ ]*$"`"; ifconfig `route | grep "^default" | grep -o "[^ ]*$"` | head -6 | grep RX' | grep -v SUCCESS | awk -F" " '{if($1 ~ "domain") a=$1; if($1 ~ "interface") b=$2; if($2 ~ "packets") print a":"b":"$2":"$3":"$4":"$6}' | sort -t : -k 1,1 > ${network_stats_dir}/network_data_current
else
    # For enp* network interfaces
    pssh -h /root/administration/hosts/server_list -i 'hostname; echo "interface `/sbin/route | grep "^default" | grep -o "[^ ]*$"`"; ifconfig `route | grep "^default" | grep -o "[^ ]*$"` | head -7 | grep RX' | grep -v SUCCESS | awk -F" " '{if($1 ~ "domain") a=$1; if($1 ~ "interface") b=$2; if($2 ~ "packets"){c=$2;d=$3;}; if($2 ~ "errors") print a":"b":"c":"d":"$2":"$3":"$4":"$5":"$8":"$9}' | sort -t : -k 1,1 > ${network_stats_dir}/network_data_current
fi

awk -F":" 'NR==FNR {g[$1] = $4;h[$1] = $6;i[$1] = $8;j[$1] = $10;next} {print $1":"$2":"$3":"g[$1]":"$4":"$5":"h[$1]":"$6":"$7":"i[$1]":"$8":"$9":"j[$1]":"$10}' ${network_stats_dir}/network_data_previous ${network_stats_dir}/network_data_current | awk -F":" '{ $15 = $5 - $4; $16 = $8 - $7; $17 = $11 - $10; $18 = $14 - $13 } {if($16 != 0 || $17 != 0 || $18 != 0) print $1"||"$2"||"$3":"$15"||"$6":"$16"||"$9":"$17"||"$12":"$18}' > ${network_stats_dir}/network_data

email_subject=""
echo "" > ${network_stats_dir}/email_body

if [[ -s  ${network_stats_dir}/network_data ]]; then
    email_subject="BAD | ${cluster_name} | Network Stats | $(date +%m:%d:%Y:%H:%M)"
    echo "Network packet errors/drops/frames observed on the below servers:" >> ${network_stats_dir}/email_body
    echo "" >> ${network_stats_dir}/email_body
    cat ${network_stats_dir}/network_data >> ${network_stats_dir}/email_body
    cat ${network_stats_dir}/email_body | mailx -r "from@domain.com" -s "${email_subject}" to@domain.com
#else
#    email_subject="GOOD | ${cluster_name} | Network Stats | $(date +%m:%d:%Y:%H:%M)"
#    echo "No network packet errors/drops/frame observed." >> ${network_stats_dir}/email_body
fi
```





```shell
#!/bin/bash
pssh -h /root/administration/hosts/server_list -i 'hostname;ifconfig | head -5 | grep RX' | grep -v SUCCESS | awk -F" " '{if($1 ~ "domain") x=$1;if($3 ~ "errors") print x":"$2":"$3":"$4":"$6}' | sort -t : -k 1,1 > /root/monitoring_script/network_data_new
awk -F":" 'NR==FNR {h[$1] = $3;g[$1] = $7;next} {print $1":"$2":"h[$1]":"$3":"$6":"g[$1]":"$7}' /root/monitoring_script/network_data_previous /root/monitoring_script/network_data_new | awk -F":" '{ $8 = $4 - $3; $9 = $7 - $6 } {print $1":"$2":"$8":"$5":"$9}' > /root/monitoring_script/network_data
mv /root/monitoring_script/network_data_new /root/monitoring_script/network_data_previous
mailx -a /root/monitoring_script/network_data -s network_stats_$(date +%H:%M:%S-%d%h%y) to@domain.com  < /dev/null
```


