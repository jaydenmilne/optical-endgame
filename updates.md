---
title: Updates
nav_order: 4
permalink: /updates/
description: We'll post any updates here
---

# Project updates

We'll post any relevant updates here.

{% if site.posts.size > 0 %}
<div class="post-list">
{% for post in site.posts %}
  <article class="post-list-item">
    <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
    <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
    {% if post.description %}<p>{{ post.description }}</p>{% else %}{{ post.excerpt }}{% endif %}
  </article>
{% endfor %}
</div>
{% else %}
No updates have been published yet.
{% endif %}

[Subscribe via RSS]({{ '/feed.xml' | relative_url }}){: .rss-link }
