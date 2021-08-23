---
layout: post
title: Minitest Rerun failed tests
description: Easily rerun failed tests with this Minitest reporter
tags: [ruby, testing, minitest]
---

I have started using [Minitest](https://github.com/seattlerb/minitest) instead of [RSpec](https://github.com/rspec/rspec) for my Rails testing.

The learning curve was a bit tricky, since they approach testing in somewhat different ways. But Minitest is a joy to use once I got the hang of it. I dont even miss `let!`'s at all. In retrospect, I had picked up some bad testing habits from RSpec. Now my tests are much simpler and more verbose. Thanks to Minitest and [Ryan Davis](https://www.zenspider.com/) they are also faster.

## Rerunning failed tests easily with Minitest

One thing I was missing in Minitest from RSpec was a way to very easily rerun just my failed tests from the last test run. 

So I wrote a custom reporter based on [Minitest-reporters](https://github.com/minitest-reporters/minitest-reporters) to do just that.

It should really be a gem instead, and I might get around to "gemify" it at a later point.

## How to rerun failed tests

I add the [file below](#minitest-failed-tests-reporter-code) to a project and include it with Minitest-reporters like this:

```ruby
Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new, Minitest::Reporters::FailedTestsReporter.new(verbose: true, include_line_numbers: true)]
```

I can now rerun only failed tests with:

```
bundle exec rails test $(cat .minitest_failed_tests.txt)
```

## Minitest failed tests reporter code

**test/support/minitest/reporters/failed_tests_reporter.rb**
```ruby
{% include_relative 2021-08-23-minitest-rerun-failed-tests/failed_tests_reporter.rb %}
```