# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class RocketEquation < Day
    def run
      input = read_input_file.split("\n").map(&:to_i)

      puts "Part 1: #{total_fuel_required(input)}"
    end

    def total_fuel_required(input)
      input.reduce(0) do |sum, mass|
        sum + ((mass / 3).floor - 2)
      end
    end
  end
end
