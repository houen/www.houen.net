---
layout: post
title: "Ruby: Working with regex capture groups"
description: Working with Capture Groups when doing regex matching
tags: [ruby, regex, capture groups, match, scan]
img_path: /assets/2022-11-16-ruby-regex-capture-group-to-variable/regex-capture-using-scan.png
img_width: 393
img_height: 73
---

Like most Ruby / Rails developers, I use Regular Expressions a lot in my work. When doing so I often forget the different options I have for getting regex capture groups into variables. So here are the best ones:

## Using `match` - easy, but only returns a single captured group

![Ruby regex capture groups using match](/assets/2022-11-16-ruby-regex-capture-group-to-variable/regex-capture-using-match.png)

This method excels in its simplicity. Another benefit is the `.captures` method of accessing the capture groups. With this and the safety operator (`&.`) we can easily handle the case where no match is found.

```ruby
"a ab1 ab2".match(/(ab[0-9])/)&.captures

# => ["ab1"]
```

## Using `scan` - returns all matched groups as an array

![Ruby regex capture groups using scan](/assets/2022-11-16-ruby-regex-capture-group-to-variable/regex-capture-using-scan.png)

I tend to prefer `match` to scan mostly out of habit, but `scan` offers two good benefits:
- Returns all capture groups, whereas `match` returns only one
- The ability to immediately assign captures to variables

```ruby
"a ab1 ab2".scan(/(ab[0-9])/)
# => [["ab1"], ["ab2"]]
```

To also assign the capture groups immediately, use an array assignment:

```ruby
a, b = "a ab1 ab2".scan(/(ab[0-9])/)
# => [["ab1"], ["ab2"]]

# irb(main):005:0> a
# => ["ab1"]
# irb(main):006:0> b
# => ["ab2"]
```

## Using =~ operator with named captures (I rarely use this one)

This is mostly useful when you have a string where you know exactly what parts you want to match. I tend to avoid this one. I dislike that the variable names are a part of the regex. I tend to find regexes complicated enough as they are. I do not need to add more complexity just to assign variables.

That said, for large regexes with mane captures, this method can be quite handy.

```ruby
/a (?<a1>ab[0-9]) (?<a2>ab[0-9])/ =~ "a ab1 ab2"
# => 0

# irb(main):010:0> a1
# => "ab1"
# irb(main):011:0> a2
# => "ab2"
```

## Recommendation: Rubular

![Rubular - a Ruby regular expression editor](/assets/2022-11-16-ruby-regex-capture-group-to-variable/rubular.jpg)

I would like to give a big shout-out to [Rubular](https://rubular.com/), a Ruby regular expression editor and tester.

This little tool has been around since at least 2013, always works, and is amazingly simple to use. Also no ads. None.

Whenever I cannot remember eg. what the shortcode is for "Any non-whitespace character" I open Rubular. Thank you [Michael Lovitt](https://lovitt.net/) [@lovitt.](https://twitter.com/lovitt)
