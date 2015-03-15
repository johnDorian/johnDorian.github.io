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
{% for post in site.posts limit:1 %}
<li>
                <a href="{{ post.url }}">
                <div>{{ post.content |truncatehtml | truncatewords: 60 }}</div>
                </a>
              </li>
{% endfor %}
</ul>

## R packages


## GRASS GIS addons

## Arduino libraries

## Research papers









