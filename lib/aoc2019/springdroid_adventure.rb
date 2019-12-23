# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class SpringdroidAdventure < Day
    SCRIPT = ([
      'NOT C T',
      'NOT A J',
      'OR T J',
      'AND D J',
      'WALK'
    ].join("\n") + "\n").chars.map(&:ord)

    def run
      computer = Common::IntcodeComputer.new(read_input_file)

      puts "Part 1: #{computer.run(SCRIPT)[-1]}"
    end
  end
end
