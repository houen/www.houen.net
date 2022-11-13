---
layout: post
tags: [ruby on rails]
title: "Rails: How to fix cookie_jar nil error: undefined method `cookies’ for nil:NilClass"
---

## Rails: How to fix cookie_jar nil error: undefined method `cookies’ for nil:NilClass

I recently ran into this little gem of an error after upgrading to Rails 3.2 and Draper to 1.1.0

```ruby
undefined method `cookies' for nil:NilClass
```

The error was coming from my ApplicationController. Not knowing what it was caused by, I searched around, but couldnt find the solution. In the ned I fixed it by adding an if request to my method:

```ruby
def current_user
  @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if request && cookies[:auth_token]
end
```
