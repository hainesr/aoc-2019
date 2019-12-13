# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

module AOC2019
  module Common
    class IntcodeComputer
      attr_reader :memory

      def initialize(prog)
        @memory = prog.split(',').map(&:to_i)
        @_mem_bak = @memory.dup
        @pc = 0
      end

      def reset!
        @memory = @_mem_bak.dup
        @pc = 0
      end

      def run(input)
        loop do
          instruction = @memory[@pc].digits.reverse
          (5 - instruction.length).times { instruction.unshift(0) }

          op = instruction[-2] * 10 + instruction[-1]
          im2 = instruction[1] == 1
          im1 = instruction[2] == 1

          case op
          when 1
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            param2 = im2 ? @memory[@pc + 2] : @memory[@memory[@pc + 2]]
            @memory[@memory[@pc + 3]] = param1 + param2
            @pc += 4
          when 2
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            param2 = im2 ? @memory[@pc + 2] : @memory[@memory[@pc + 2]]
            @memory[@memory[@pc + 3]] = param1 * param2
            @pc += 4
          when 3
            @memory[@memory[@pc + 1]] = input
            @pc += 2
          when 4
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            puts param1
            @pc += 2
          when 5
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            param2 = im2 ? @memory[@pc + 2] : @memory[@memory[@pc + 2]]
            if param1.zero?
              @pc += 3
            else
              @pc = param2
            end
          when 6
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            param2 = im2 ? @memory[@pc + 2] : @memory[@memory[@pc + 2]]
            if param1.zero?
              @pc = param2
            else
              @pc += 3
            end
          when 7
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            param2 = im2 ? @memory[@pc + 2] : @memory[@memory[@pc + 2]]
            @memory[@memory[@pc + 3]] = param1 < param2 ? 1 : 0
            @pc += 4
          when 8
            param1 = im1 ? @memory[@pc + 1] : @memory[@memory[@pc + 1]]
            param2 = im2 ? @memory[@pc + 2] : @memory[@memory[@pc + 2]]
            @memory[@memory[@pc + 3]] = param1 == param2 ? 1 : 0
            @pc += 4
          when 99
            break
          end
        end
      end
    end
  end
end
