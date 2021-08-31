---
layout: post
title: Capybara tips and tricks
description: Easily get and list all attributes for a Capybara element with .native
tags: [capybara, ruby, testing]
---

## Finding and getting things

### Get all attributes for element

To get all attributes for a Capybara element, use `#native#attributes`

```ruby
find(".some-css-selector", visible: false).native.attributes
```

## Hosts and ports

### Host
```ruby
Capybara.app_host = 'https://www.example.com'

assert_equal "#{Capybara.app_host}/my_cool_page"
```

### Port
```ruby
Capybara.server_port = 31337

assert_equal "#{Capybara.app_host}:#{Capybara.server_port}/my_cool_page"
```
