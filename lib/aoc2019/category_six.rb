# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class CategorySix < Day
    def run
      code = read_input_file
      puts "Part 1: #{run_network(code)}"
    end

    def run_network(nic, part = 1)
      num = 50
      computers = []
      input_queues = Array.new(num) { [] }

      (0...num).each do |i|
        computers[i] = Common::IntcodeComputer.new(nic)
        input_queues[i] << i
      end

      loop do
        (0...num).each do |i|
          if input_queues[i].empty?
            input = -1
          else
            input = input_queues[i]
            input_queues[i] = []
          end

          output = computers[i].run(input)
          next if output.empty?

          output.each_slice(3) do |address, x, y|
            return y if address == 255 && part == 1

            input_queues[address] << x << y
          end
        end
      end
    end
  end
end
