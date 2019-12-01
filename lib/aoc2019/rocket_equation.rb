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

      puts "Part 1: #{fuel_required(input)}"
      puts "Part 2: #{total_fuel_required(input)}"
    end

    def fuel_required(input)
      input.reduce(0) do |sum, mass|
        sum + fuel_for_mass(mass)
      end
    end

    def total_fuel_required(input)
      input.reduce(0) do |sum, mass|
        total = 0
        loop do
          mass = fuel_for_mass(mass)
          break unless mass.positive?

          total += mass
        end
        sum + total
      end
    end

    def fuel_for_mass(mass)
      (mass / 3).floor - 2
    end
  end
end
