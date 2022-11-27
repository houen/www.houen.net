---
title: 'Rails: How to upload a file or image to ActiveStorage via URL'
layout: post
tags: [Rails, ActiveStorage]
---

```ruby
  # Easy upload of logo via web url
  def image_url=(url)
    uri = URI.parse(url)
    extname = File.extname(uri.path)
    filename = "#{name.parameterize.underscore}#{extname}"
    image.attach(io: uri.open, filename: filename)
  end
```
