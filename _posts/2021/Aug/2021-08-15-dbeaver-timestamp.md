---
layout: post
title: "How to change Timezone setting for Dbeaver on your Laptop"
subtitle: Dbeaver settigns 
show-avatar : false
permalink: /blog/dbeaver-timezone
date: 2021-08-15 00:16:00 -0400
comments: true
published: true
categories: []
tags: [dbeaver, laptop]

---

To change the timezone sitting on your Dbeaver, by default it shows the timestamp in local time 
 zone and if we want to force UTC or a specific timezone, follow the below steps.

Since this file is overwritten when you reinstall or upgrade, You’ll have to redo this for every
version upgrade.

## If you are on a Mac

* Go to Finder > Applications
* Right click on DBeaver and select Show Package Contents
* Open Contents\Eclipse\dbeaver.ini
* After the -vmargs line, add this: `-Duser.timezone=UTC`
* Save file and restart DBeaver


## If you are on a Windows System

* Go to DBeaver install directory `C:\Program Files\DBeaver`
* Open dbeaver.ini
* After the -vmargs line, add this: `-Duser.timezone=UTC`
* Save file and restart DBeaver