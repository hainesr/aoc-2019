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
    WALK = ([
      'NOT C T',
      'NOT A J',
      'OR T J',
      'AND D J',
      'WALK'
    ].join("\n") + "\n").chars.map(&:ord)

    RUN = ([
      'OR H J',
      'NOT C T',
      'AND T J',
      'NOT T T',
      'OR F T',
      'NOT T T',
      'OR T J',
      'NOT B T',
      'OR T J',
      'NOT A T',
      'OR T J',
      'AND D J',
      'RUN'
    ].join("\n") + "\n").chars.map(&:ord)

    def run
      computer = Common::IntcodeComputer.new(read_input_file)

      puts "Part 1: #{computer.run(WALK)[-1]}"

      computer.reset!
      puts "Part 2: #{computer.run(RUN)[-1]}"
    end
  end
end
