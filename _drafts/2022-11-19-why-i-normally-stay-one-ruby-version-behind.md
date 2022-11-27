---
title: "Why I normally stay one Ruby version behind"
layout: post
tags: [Ruby, Rails]
---

I normally do not use the "latest and greatest" in software. So often the first version of something contains errors and bugs. This goes even for minor versions. 
While a minor version might fix some bugs, it might also introduce new ones.

## Rails new project with Propshaft and Tailwind using Ruby 3.1.2 raises errors

I was recently reminded of the above when a colleague asked me why I set `.ruby-version` to 3.1.1 on our newest Rails project, and now 3.1.2 which is currently the newest.

All I could tell him was "I tried 3.1.2 with Rails for a pet project and it blew up". I could not remember why at the time.

Well, today I tried again:

![Rails new blows up with Ruby 3.1.2](//Users/houen/work/houen.net/www.houen.net/assets/2022-11-19-why-i-normally-stay-one-ruby-version-behind/rails-new-blows-up-with-ruby-3-1-2.jpg)

## `Rails new` => `NameError: uninitialized constant Gem::Source`

```shell
rbenv local 3.1.2
gem install rails
# ...
# 12 gems installed
rails new --asset-pipeline=propshaft --css=tailwind MyApp
# ...
#    run  bundle install
# [3936, #<Thread:0x000000010cb38cf8 run>, #<NameError: uninitialized constant Gem::Source
# ...
```

There were two errors here:

- `NameError: uninitialized constant Gem::Source`
  - First this blew up w/ Propshaft: `Could not find gem 'propshaft' in locally installed gems.`
  - Then afterwards with Redis: `Could not find gem 'redis (~> 4.0)' in locally installed gems.`

Normally the Rails installer just takes care of this? I got past it with Propshaft by running `gem install propshaft`. Maybe I could install these all by hand and things will work. But: **I am not going to do that**.

Why not?

Because installing Rails should be the most basic, simple, stable part of this whole experience. But the journey of Ruby 3.1.2 started out with Rails not being compatible. This promises as _VERY_ bumpy ride ahead.

## Simplest solution? Ruby 3.1.1

Lets switch to Ruby 3.1.1 and try again:

```shell
rbenv local 3.1.1
rails new --asset-pipeline=propshaft --css=tailwind MyApp

# ...
# Bundle complete! 17 Gemfile dependencies, 73 gems now installed.
# ...
# Rebuilding...
# Done in 351ms.
```

It "just works". Note that I do not really care what the issue is. I am not out to solve a Rails issue with Ruby 3.1.2. I am trying to start a project.

## Better solution? `gem update bundler`

```shell

```
