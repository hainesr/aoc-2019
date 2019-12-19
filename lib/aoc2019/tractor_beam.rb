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

      computer.reset!
      x, y = rectangle(computer, 100)
      puts "Part 2: #{x * 10_000 + y}"
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

    def rectangle(computer, size)
      x = 1_500
      y = 1_000
      size -= 1

      loop do
        loop do
          computer.reset!
          if computer.run(x, y).first.zero?
            y += 1
            next
          end

          computer.reset!
          return [x - size, y] if computer.run(x - size, y + size).first == 1

          x += 1
        end
      end
    end
  end
end
