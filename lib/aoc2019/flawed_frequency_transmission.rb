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
      puts "Part 2: #{upper_fft(read_input_file, 100)}"
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

    def upper_fft(input, n)
      offset = input[0..6].to_i
      input = (input.chomp.chars.map(&:to_i) * 10_000)[offset..-1]

      n.times do
        suffix_sum = 0
        (0..(input.length - 1)).reverse_each do |i|
          input[i] = suffix_sum = (suffix_sum + input[i]) % 10
        end
      end

      input.join[0..7]
    end

    def base_digit(multiplier, i)
      pattern_length = 4 * multiplier
      BASE_PATTERN[i % pattern_length / multiplier]
    end
  end
end
