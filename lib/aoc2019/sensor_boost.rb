# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class SensorBoost < Day
    def run
      computer = Common::IntcodeComputer.new(read_input_file)
      puts "Part 1: #{computer.run(1)[0]}"

      computer.reset!
      puts "Part 2: #{computer.run(2)[0]}"
    end
  end
end
