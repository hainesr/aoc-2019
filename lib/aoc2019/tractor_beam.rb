# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class TractorBeam < Day
    def run
      computer = Common::IntcodeComputer.new(read_input_file.chomp)
      puts "Part 1: #{scan(computer, 50, 50).flatten.count(1)}"
    end

    def scan(computer, x_dim, y_dim)
      output = []

      y_dim.times do |y|
        output[y] ||= []
        x_dim.times do |x|
          output[y][x] = computer.run(x, y).first
          computer.reset!
        end
      end

      output
    end
  end
end
