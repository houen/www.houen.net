---
layout: post
title: 'Ruby: Map an Array to a Hash'
tags: [code, Ruby, Ruby on Rails]
---

![ruby-map-array-to-hash](/assets/2014-05-08-ruby-map-array-to-hash/sharp.png)

Sometimes you need to map an array value to a hash structure. It could be that you have a set of keys, and you want to map some values related to those keys to a hash in order to return it from a function. Or something else, what do I know. 

But I do know a nice, clean way to do it:

The below example is a little basic – but it should still show the gist of it.

```ruby
lookup_table = { arms: 15, legs: 25, head: 42 }
keys = %w'arms legs'
keys.map{ |key| [key.to_sym, lookup_table[key.to_sym]] }.to_h

# => {:arms=>15, :legs=>25}
```

And now we have mapped our array to a hash.

With the lookup table in this code, we could have of course just extracted a subset of our lookup\_table. 

But what if it wasn’t such a convenient lookup\_table? What if it was methods defined on another class that we want to extract values from? Or database values? For this case, the above little trick of mapping to a Hash can come quite in handy once in a while.

## Book Recommendation
I would recommend you read the [Eloquent Ruby](https://amzn.to/3pkdkQZ) book – I found it **very** good, and have often recommended it to interview candidates who needed a little extra Ruby knowledge.

[![Recommended Ruby book: Eloquent Ruby](/assets/books/addison_wesley_eloquent_ruby.png)](https://amzn.to/3pkdkQZ)
