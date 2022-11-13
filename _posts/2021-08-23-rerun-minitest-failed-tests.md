---
layout: post
title: "Minitest: Rerun failed tests"
description: Rerun minitest failed tests easily
tags: [minitest, ruby, testing]
redirect_from:
- /2021/08/23/minitest-rerun-failed-tests/
- /minitest-rerun-failed-tests/
---

> ## Update: Its now a gem :-)
> I finally got around to making a gem to rerun failed tests with Minitest.
> 
> Find it on Github here: [minitest-rerun-failed](https://github.com/houen/minitest-rerun-failed)

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
# frozen_string_literal: true

module Minitest
  module Reporters
    # Source: https://www.houen.net/2021/08/23/minitest-rerun-failed-tests/
    # License: MIT
    #
    # Outputs failed tests to screen and / or file
    # Allows to rerun only failed tests with minitest if added to Minitest::Reporters.use!
    #
    # Example:
    #   In test_helper.rb or similar:
    #   Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new, Minitest::Reporters::FailedTestsReporter.new(verbose: true, include_line_numbers: true)]
    #
    #   Now after a failed test run, rerun failed tests only with: `bundle exec rails test $(cat .minitest_failed_tests.txt)`
    #
    class FailedTestsReporter < Minitest::Reporters::BaseReporter
      def initialize(options = {})
        super(options)
        @options = options

        # Include line numbers? (failed_test.rb:42 or just failed_test.rb)
        @include_line_numbers = options.fetch(:include_line_numbers, true)
        # Output to console?
        @verbose = options.fetch(:verbose, true)
        # Output to file?
        @file_output = options.fetch(:file_output, true)
        # What path to file?
        @output_path = options.fetch(:output_path, ".")
        FileUtils.mkdir_p(@output_path) if @output_path

        @output_file_path = File.join(@output_path, ".minitest_failed_tests.txt")
      end

      def record(test)
        tests << test
      end

      def report
        super

        failure_paths = []
        file_output   = []
        curdir        = FileUtils.pwd

        tests.each do |test|
          next if test.skipped?
          next if test.failure.nil?

          # DEBUG OUTPUT STR
          # p '============================================='
          # p "Failure:\n#{test.class}##{test.name} [#{test.failure.location}]\n#{test.failure.class}: #{test.failure.message}"
          # p '============================================='

          failure_file_location = find_failure_location(test, curdir)
          failure_paths << failure_file_location if failure_file_location
        end

        output_results(failure_paths, file_output)
        File.write(@output_file_path, file_output.join("\n"), encoding: "UTF-8")
      end

      private

      def find_failure_location(test, curdir)
        # Build a haystack string from failures and errors to find test file location in
        tmp_haystack = []
        tmp_haystack << test.failure.location
        tmp_haystack << test.to_s
        # Add filtered backtrace unless it is an unexpected error, which do not have a useful trace
        tmp_haystack << filter_backtrace(test.failure.backtrace).join unless test.failure.is_a?(MiniTest::UnexpectedError)

        # Get failure location as best we can from haystack
        if @include_line_numbers
          failure_file_location = tmp_haystack.join[/(.+_test\.rb:[0-9]+)/, 1]
        else
          failure_file_location = tmp_haystack.join[/(.+_test\.rb):[0-9]+/, 1]
        end

        return unless failure_file_location

        # Make path relative if absolute
        failure_file_location.gsub!(curdir, "")
        failure_file_location.gsub!(%r{^/}, "")

        failure_file_location
      end

      def output_results(failure_paths, file_output)
        return if failure_paths.empty?

        _puts("")
        headline = @include_line_numbers ? "Failed tests: #{failure_paths.count} (seed #{@options[:seed]}):" : "Failed test files: #{failure_paths.count} (seed #{@options[:seed]}):"
        _puts(headline)
        failure_paths.uniq.each do |file_path|
          file_output << file_path.to_s
          _puts red(file_path.strip)
        end
      end

      def _puts(str)
        return unless @verbose

        puts(str)
      end

      def print_padded_comment(line)
        puts "##{pad(line)}"
      end

      def color?
        return @color if defined?(@color)

        @color = @options.fetch(:color) do
          io.tty? && (
            ENV["TERM"] =~ /^screen|color/ ||
              ENV["EMACS"] == "t"
          )
        end
      end

      def green(string)
        color? ? ANSI::Code.green(string) : string
      end

      def yellow(string)
        color? ? ANSI::Code.yellow(string) : string
      end

      def red(string)
        color? ? ANSI::Code.red(string) : string
      end
    end
  end
end
```
