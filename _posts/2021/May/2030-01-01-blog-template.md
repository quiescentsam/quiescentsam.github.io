---
layout: post
title: Sample title
subtitle: what is it about
show-avatar : false
image: /img/posts/2020/blog-1-spark-template.png 
permalink: /blog/blog-template/
date: 2030-01-01 00:00:00 -0400
comments: true
published: false
categories: []
tags: [blog]

---

* get the list of tables 
  
```shell
[zsssiddiqui1@aglprdhda01 ~]$ hbase shell
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.1.0-cdh6.3.4, rUnknown, Wed Oct 21 08:33:41 PDT 2020
Took 0.0008 seconds
hbase(main):001:0> list
TABLE
test
test1
test2
28 row(s)
Took 0.5540 seconds
=> ["e"]
hbase(main):002:0>
```

* get the sizes of the tables 

hdfs dfs -du -h /hbase/data/default



https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cdh_bdr_hbase_replication.html#topic_20_11


## params chaning

hbase.replication  true

hbase.regionserver.replication.handler.count  --12 need to change

replication.sink.client.retries.number -- 3
replication.sink.client.ops.timeout --  60 sec


## other tools 

count number of rows in a table


hbase org.apache.hadoop.hbase.mapreduce.RowCounter test

`	HBase Counters
BYTES_IN_REMOTE_RESULTS=5077795
BYTES_IN_RESULTS=5077795
MILLIS_BETWEEN_NEXTS=2755
NOT_SERVING_REGION_EXCEPTION=0
NUM_SCANNER_RESTARTS=0
NUM_SCAN_RESULTS_STALE=0
REGIONS_SCANNED=1
REMOTE_RPC_CALLS=1001
REMOTE_RPC_RETRIES=0
ROWS_FILTERED=0
ROWS_SCANNED=100000
RPC_CALLS=1001
RPC_RETRIES=0
org.apache.hadoop.hbase.mapreduce.RowCounter$RowCounterMapper$Counters
ROWS=100000


Location of snapshot 

'[zsssiddiqui1@aglprdhda01 ~]$ hdfs dfs -ls /hbase/.hbase-snapshot
Found 2 items
drwxr-xr-x   - hbase hbase          0 2021-05-18 14:34 /hbase/.hbase-snapshot/.tmp
drwxr-xr-x   - hbase hbase          0 2021-05-18 14:34 /hbase/.hbase-snapshot/test_snapshot'

reference 
https://learnhbase.wordpress.com/2013/03/02/hbase-shell-commands/


* ADD Peer

hbase(main):002:0> add_peer '1', CLUSTER_KEY => "aglprdhda02.availity.net,aglprdhda03.availity.net,aglprdhda04.availity.net:2181:/hbase"
Took 2.3757 seconds
hbase(main):003:0> list_peers
PEER_ID CLUSTER_KEY ENDPOINT_CLASSNAME STATE REPLICATE_ALL NAMESPACES TABLE_CFS BANDWIDTH SERIAL
1 aglprdhda02.availity.net,aglprdhda03.availity.net,aglprdhda04.availity.net:2181:/hbase  ENABLED true   0 false
1 row(s)
Took 0.0431 seconds
=> #<Java::JavaUtil::ArrayList:0x505d2bac>





FInally- check the status of replication


hbase org.apache.hadoop.hbase.mapreduce.replication.VerifyReplication 1 test


21/05/18 17:21:43 INFO mapreduce.Job: Job job_1613523158429_0281 completed successfully
21/05/18 17:21:43 INFO mapreduce.Job: Counters: 49
File System Counters
FILE: Number of bytes read=0
FILE: Number of bytes written=264542
FILE: Number of read operations=0
FILE: Number of large read operations=0
FILE: Number of write operations=0
HDFS: Number of bytes read=165
HDFS: Number of bytes written=0
HDFS: Number of read operations=1
HDFS: Number of large read operations=0
HDFS: Number of write operations=0
HDFS: Number of bytes read erasure-coded=0
Job Counters
Launched map tasks=1
Rack-local map tasks=1
Total time spent by all maps in occupied slots (ms)=8007460
Total time spent by all reduces in occupied slots (ms)=0
Total time spent by all map tasks (ms)=2001865
Total vcore-milliseconds taken by all map tasks=2001865
Total megabyte-milliseconds taken by all map tasks=8199639040
Map-Reduce Framework
Map input records=80002
Map output records=0
Input split bytes=165
Spilled Records=0
Failed Shuffles=0
Merged Map outputs=0
GC time elapsed (ms)=643
CPU time spent (ms)=84010
Physical memory (bytes) snapshot=1288396800
Virtual memory (bytes) snapshot=6232817664
Total committed heap usage (bytes)=2164785152
Peak Map Physical memory (bytes)=1316921344
Peak Map Virtual memory (bytes)=6496219136
HBase Counters
BYTES_IN_REMOTE_RESULTS=4080093
BYTES_IN_RESULTS=4080093
MILLIS_BETWEEN_NEXTS=1989433
NOT_SERVING_REGION_EXCEPTION=0
NUM_SCANNER_RESTARTS=0
NUM_SCAN_RESULTS_STALE=0
REGIONS_SCANNED=2
REMOTE_RPC_CALLS=802
REMOTE_RPC_RETRIES=0
ROWS_FILTERED=0
ROWS_SCANNED=80002
RPC_CALLS=802
RPC_RETRIES=0
org.apache.hadoop.hbase.mapreduce.replication.VerifyReplication$Verifier$Counters
BADROWS=19998
GOODROWS=80002
ONLY_IN_PEER_TABLE_ROWS=19998
File Input Format Counters
Bytes Read=0
File Output Format Counters
Bytes Written=0

-------------
**Bold**
[**Gradle**][98d0a221] link
---
__Advertisement :)__

- __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
  resize in browser.
- __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
  i18n with plurals support and easy syntax.

You will like those projects!

---

# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading


## Horizontal Rules

___

---

***


## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
    - Marker character change forces new list start:
        * Ac tristique libero volutpat at
        + Facilisis in pretium nisl aliquet
        - Nulla volutpat aliquam velit
+ Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```

Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :crush: :cry: :tear: :laughing: :yum:
>
> Shortcuts (emoticons): :-) :-( 8-) ;)

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O


### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

++Inserted text++


### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

==Marked text==


### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

    and multiple paragraphs.

[^second]: Footnote text.


### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

Term 1

:   Definition 1
with lazy continuation.

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
~ Definition 1

Term 2
~ Definition 2a
~ Definition 2b


### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

*[HTML]: Hyper Text Markup Language

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

::: warning
*here be dragons*
:::