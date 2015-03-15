---
layout: page
title: Programming...
tagline: Various bits of pieces of coding adventures 
---
{% include JB/setup %}

# Welcome

A quick by-line on what the webpage is for. 

## Posts

<ul class="posts">
{% for post in site.posts %}
<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>

## R packages

## GRASS GIS addons

## Arduino libraries











