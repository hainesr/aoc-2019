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
      puts "Part 2: #{run_network(code, 2)}"
    end

    def run_network(nic, part = 1)
      num = 50
      computers = []
      input_queues = Array.new(num) { [] }

      (0...num).each do |i|
        computers[i] = Common::IntcodeComputer.new(nic)
        input_queues[i] << i
      end

      nat_input = []
      nat_y_save = -1

      loop do
        idle = true

        (0...num).each do |i|
          if input_queues[i].empty?
            input = -1
          else
            input = input_queues[i]
            input_queues[i] = []
            idle = false
          end

          output = computers[i].run(input)
          next if output.empty?

          output.each_slice(3) do |address, x, y|
            if address == 255
              return y if part == 1

              nat_input = [x, y]
            else
              input_queues[address] << x << y
            end
          end
        end

        next unless idle

        input_queues[0] = nat_input
        return nat_y_save if nat_input[1] == nat_y_save

        nat_y_save = nat_input[1]
      end
    end
  end
end
