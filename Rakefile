# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'rake/testtask'

task default: :test

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Run code for a day, or days, of advent of code'
task :run do
  ARGV[1..-1].each do |day|
    day = day.chomp.to_i
    next if day < 1 || day > 25

    puts "Advent of Code 2019 day #{day}"
    system "./aoc-2019 #{day}"
  end
  exit
end
