# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class FlawedFrequencyTransmission < Day
    BASE_PATTERN = [0, 1, 0, -1].freeze

    def run
      puts "Part 1: #{fft(read_input_file, 100)[0..7]}"
    end

    def fft(input, n)
      input = input.chomp.chars.map(&:to_i)

      n.times do
        input.length.times do |i|
          sum_result = 0

          (i..input.length).each do |j|
            element = input.fetch(j, 0)
            base = base_digit(i + 1, j + 1)
            sum_result += element * base
          end

          input[i] = sum_result.abs % 10
        end
      end

      input.join
    end

    def base_digit(multiplier, i)
      pattern_length = 4 * multiplier
      BASE_PATTERN[i % pattern_length / multiplier]
    end
  end
end
