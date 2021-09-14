---
layout: post
title: Rerunning Minitest failed tests
description: Easily rerun failed tests with this Minitest reporter
tags: [minitest, ruby, testing]
redirect_from:
- /2021/08/23/minitest-rerun-failed-tests/
---

## Update: Its now a gem :-)
I finally got around to making a gem for rerunning failed tests with Minitest. 

Find it on Github here: [minitest-rerun-failed](https://github.com/houen/minitest-rerun-failed)

---

## Background

I have started using [Minitest](https://github.com/seattlerb/minitest) instead of [RSpec](https://github.com/rspec/rspec) for my Rails testing.

The learning curve was a bit tricky, since they approach testing in somewhat different ways. But Minitest is a joy to use once I got the hang of it. I dont even miss `let!`'s at all. In retrospect, I had picked up some bad testing habits. Now my tests are much simpler and more verbose. Thanks to Minitest and [Ryan Davis](https://www.zenspider.com/) they are also faster.

## But: I want to easily rerun failed tests with Minitest

One thing I was missing in Minitest from RSpec was a way to very easily rerun just my failed tests from the last test run. 

So I wrote a custom reporter based on [Minitest-reporters](https://github.com/minitest-reporters/minitest-reporters) to do just that.

## Installation (outdated - [use the gem instead](https://github.com/houen/minitest-rerun-failed))
1. Install [Minitest-reporters](https://github.com/minitest-reporters/minitest-reporters)
1. Add the [file below](#minitest-failed-tests-reporter-code) to your project
1. Include it with Minitest-reporters at the end of the list like this:

```ruby
# You can put the file wherever you like
require 'your/path/to/failed_tests_reporter.rb'

# ...

Minitest::Reporters.use! [
  Minitest::Reporters::ProgressReporter.new, # This is just my preferred reporter. Use the one(s) you like.
  Minitest::Reporters::FailedTestsReporter.new(verbose: true, include_line_numbers: true)
]
```

## Output of failed tests reporter
### List of failed tests
I recommed you add it at the end of the reporters list. When doing so and using the "verbose: true" option , the failed test reporter will output a list of all failed tests at the end of your test run. This will give you a way to easily run single tests in an IDE (I use [Rubymine](https://www.jetbrains.com/ruby/) myself) while still having a clear overview of which ones needs fixing.

### The Seed
Do you know the minitest seed issue? The seed is displayed only at the top of a test run.

I have worked in many companies with very, very verbose test output. Hundreds of lines of warnings, etc. etc. 

This means that the seed is long gone from my terminal scroll history when my tests are finished.

The failed test reporter will output the seed at the end of a test run for exactly this reason.

### Failed tests file
When not run with option `file_output: false`, the reporter will place a file called `.minitest_failed_tests.txt` in the project root. This file lists the failed test files (with line numbers if option `include_line_numbers: true`). The path to put the file in is configurable when initializing the reporter.

## How to rerun just the failed tests
After running my tests, there will be the new file `.minitest_failed_tests.txt` in my project dir.

I can now rerun only failed tests with:

```
bundle exec rails test $(cat .minitest_failed_tests.txt)
```

## Source code
Source code of Minitest failed tests reporter:

**test/support/minitest/reporters/failed_tests_reporter.rb** (this is where I like to put it)

```ruby
{% include_relative assets/2021-08-23-minitest-rerun-failed-tests/failed_tests_reporter.rb %}
```
