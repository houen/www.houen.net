---
layout: post
title: Capybara finding and Selecting hidden elements and text
description: How to use find and select hidden elements and text with Capybara using visible false and any for hidden text elements.
tags: [kill process, mac, mac osx, process]
---

## Finding hidden elements

After upgrading an older version of [the Capybara gem](https://github.com/teamcapybara/capybara) to something a bit more modern, you may come across a lot of errors regarding finding hidden elements and hidden text, like this:

```
Capybara::ElementNotFound: Unable to find visible css ...
```

The error above is because Capybara by default no longer “sees” hidden elements. Hidden elements can be many things. Most common are content hidden by CSS and content out of the current viewport (screen).

## Tell Capybara to look for hidden elements as well

To fix it, you must add `visible: false` or `visible: :all` to your test code.

This:

```ruby
find('span')
```

Becomes:

```ruby
find('span', visible: false)
```

The same goes for other selectors such as all and first. Now Capybara will be able to find the element. However, calling .text may simply produce nil on the element.

## Capybara still cannot see the text

There is a particularly annoying addition to the above: In order for Capybara to find and select the hidden **text** of the hidden elements, you can no longer simply do `.text`. You have to instead do `.text(:all)`, as described in the Capybara docs [here](https://rubydoc.info/github/jnicklas/capybara/master/Capybara%2FNode%2FElement:text).

## Finding and selecting hidden text

So now our final Capybara text selector becomes:

```ruby
sometext = find('span', visible: false).text(:all)
```

That is all that is required. As a final comment, please note that you can also have Capybara work like it used to and “see” hidden elements and hidden text by default:

```ruby
Capybara.ignore_hidden_elements = false
```

I generally tend to avoid this option, though, since it is not recommended by the author / contributors. This argument may sound silly, but since it is not recommended, they are going to be coding in a different direction in the future. This might lead to difficulty down the line. Better to just get it done with now.

And it can be done.

I have upgraded several Ruby / Rails projects where the LOC (lines of code) of the `app/` folder was 35000+ and while fixing capybaras use of hidden text is tedious work, it can generally be completed within a working day or two.

Happy coding!
