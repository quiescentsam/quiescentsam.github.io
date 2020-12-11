---
layout: page
title: Notes - Devops
comments: false
permalink: /notes/devops/
---
<ul>
  {% for note in site.notes-devops %}
    <li>
      <a href="{{ note.url }}">{{ note.title }}</a>
    </li>
  {% endfor %}
</ul>
