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

      computer.reset!
      puts "Part 2: #{play(computer)[-1]}"
    end

    def board_state(input)
      board = {}

      input.each_slice(3) do |x, y, t|
        board["#{x},#{y}"] = t
      end

      board
    end

    # I've faked the input so that there's just one long paddle :-)
    # So this just keeps looping, keeping the joystick still, until
    # the game exits...
    def play(computer)
      computer.memory[0] = 2
      loop do
        output = computer.run(0)
        break output if computer.done?
      end
    end
  end
end
