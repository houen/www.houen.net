---
layout: home
title: Front page
description: Web home of me (Søren Houen) where I write about Software Engineering
permalink: /
robots: noindex, follow
---

# Søren Houen

On this site you can find: 
- [Basic info about me]({% link _pages/about.md %}).
- Things I [blog about](/blog). Mostly software engineering.
- My thoughts on [ways to work well in software engineering](/work-guide)
- [Books](/books) i recommend reading

### My latest blog posts
{% for post in site.posts limit:10 %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}
