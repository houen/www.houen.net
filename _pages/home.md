---
layout: home
title: Home
permalink: /
---

## Welcome

On this site you can find: 
- [Basic info about me (Søren)]({% link _pages/about.md %}).
- Things I [blog about](/blog). Mostly software engineering.
- My thoughts on [ways to work well in software engineering](/work-guide)
- [Books](/books) i recommend reading

### My latest blog posts
{% for post in site.posts limit:10 %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}
