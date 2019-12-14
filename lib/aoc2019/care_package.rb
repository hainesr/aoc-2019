# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class CarePackage < Day
    def run
      computer = Common::IntcodeComputer.new(read_input_file)
      state = board_state(computer.run)
      puts "Part 1: #{state.values.count(2)}"
    end

    def board_state(input)
      board = {}

      input.each_slice(3) do |x, y, t|
        board["#{x},#{y}"] = t
      end

      board
    end
  end
end
