---
layout: post
title: "How to change Timezone setting for Dbeaver"
subtitle: Dbeaver settigns 
show-avatar : false
permalink: /blog/dbeaver-timezone
date: 2021-02-02 00:15:00 -0400
comments: true
published: false
categories: []
tags: [spark, aws]

---

On Mac

Go to Finder > Applications
Right click on DBeaver and select Show Package Contents
Open Contents\Eclipse\dbeaver.ini
After the -vmargs line, add this: -Duser.timezone=UTC
Save file and restart DBeaver
Limitation: You’ll have to redo this for every version upgrade.




Windows

Go to DBeaver install directory C:\Program Files\DBeaver
Open dbeaver.ini
After the -vmargs line, add this: -Duser.timezone=UTC
Save file and restart DBeaver