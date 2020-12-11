---
layout: page
title: Notes - Big Data
comments: false
permalink: /notes/bigdata/
---
<ul>
  {% for note in site.notes-bigdata %}
    <li>
      <a href="{{ note.url }}">{{ note.title }}</a>
    </li>
  {% endfor %}
</ul>
