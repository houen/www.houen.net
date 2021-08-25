module Minitest
    module Reporters
      # Source: https://www.houen.net/2021/08/23/minitest-rerun-failed-tests/
      # Author: Søren Houen
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
      class FailedTestsReporter < BaseReporter
  
        def initialize(options = {})
          super(options)
  
          # Output to console?
          @verbose              = options.fetch(:verbose, true)
          # Output to file?
          @file_output          = options.fetch(:file_output, true)
          # What path to file?
          @output_path          = options.fetch(:output_path, '.')
          # Include line numbers? (failed_test.rb:42 or just failed_test.rb)
          @include_line_numbers = options.fetch(:include_line_numbers, true)
  
          @output_file_path     = File.join(@output_path, '.minitest_failed_tests.txt')
        end
  
        def record(test)
          tests << test
        end
  
        def report
          super
          failure_paths      = []
          file_output_str = ''
          curdir = FileUtils.pwd
  
          tests.each do |test|
            next if test.skipped?
            next unless test.failure.present?
  
            # DEBUG OUTPUT STR
            # p '============================================='
            # p "Failure:\n#{test.class}##{test.name} [#{test.failure.location}]\n#{test.failure.class}: #{test.failure.message}"
            # p '============================================='
  
            # Build a haystack string from failures and errors to find test file location in
            tmp_haystack_str = test.failure.location
            tmp_haystack_str += test.to_s
            unless test.failure.is_a?(MiniTest::UnexpectedError)
              trace = filter_backtrace(test.failure.backtrace)
              trace.each do |line|
                # Add text with the correct failure line location for FAIL results
                tmp_haystack_str += line
              end
            end
  
            # Get file name and optionally line number from haystack
            if @include_line_numbers
              regex = /\s*(.+_test\.rb:[0-9]+)/
            else
              regex = /\s*(.+_test\.rb):[0-9]+/
            end
  
            # Failure location as best we can from haystack
            failure_file_location = tmp_haystack_str.match(regex)&.to_a&.fetch(1, nil)
            # Skip to next if we could not find anything
            next unless failure_file_location
            # Make path relative if absolute
            failure_file_location = failure_file_location.gsub(curdir, '')
            failure_file_location = failure_file_location.gsub(/^\//,'')
  
            # Store for outputting
            failure_paths << failure_file_location if failure_file_location
          end
  
          # OUTPUT RESULTS
          if failure_paths.present?
            _puts("")
            headline = @include_line_numbers ? 'Failed tests:' : 'Failed test files:'
            _puts(headline)
            failure_paths.uniq.each do |file_path|
              file_output_str << "#{file_path}\n"
              _puts red(file_path)
            end
          end
  
          File.write(@output_file_path, file_output_str, encoding: 'UTF-8')
        end
  
        private
  
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
  