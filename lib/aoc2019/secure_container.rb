# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class SecureContainer < Day
    def run
      input = '172851-675869'.split('-').map(&:to_i)

      results = count_passwords(input)
      puts "Part 1: #{results[0]}"
      puts "Part 2: #{results[1]}"
    end

    def count_passwords(range)
      count_all = 0
      count_pair = 0

      (1..6).each do |a|
        (a..9).each do |b|
          (b..9).each do |c|
            (c..9).each do |d|
              (d..9).each do |e|
                (e..9).each do |f|
                  digits = [a, b, c, d, e, f]
                  num = a * 100_000 + b * 10_000 + c * 1_000 +
                        d * 100 + e * 10 + f
                  break if num > range[1]
                  next if num < range[0]
                  next unless repeated_digits?(digits)

                  count_all += 1
                  count_pair += 1 if repeated_pair?(digits)
                end
              end
            end
          end
        end
      end

      [count_all, count_pair]
    end

    def repeated_digits?(digits)
      digits.group_by { |d| d }.values.map(&:length).max > 1
    end

    def repeated_pair?(digits)
      digits.group_by { |d| d }.values.map(&:length).include? 2
    end
  end
end
