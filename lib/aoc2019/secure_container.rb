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

      puts "Part 1: #{count_passwords(input)}"
    end

    def count_passwords(range)
      count = 0

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

                  count += 1 if repeated_digits?(digits)
                end
              end
            end
          end
        end
      end

      count
    end

    def repeated_digits?(digits)
      digits.group_by { |d| d }.values.map(&:length).max > 1
    end
  end
end
