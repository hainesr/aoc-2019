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
        @rb = 0
      end

      def reset!
        @memory = @_mem_bak.dup
        @pc = 0
        @rb = 0
      end

      def param(n, modes)
        raw = @memory.fetch(@pc + n, 0)
        case modes[n - 1]
        when 0
          @memory.fetch(raw, 0)
        when 1
          raw
        when 2
          @memory.fetch(raw + @rb, 0)
        end
      end

      def write_param(n, modes)
        raw = @memory.fetch(@pc + n, 0)
        modes[n - 1] == 2 ? raw + @rb : raw
      end

      def run(*input)
        input.flatten!
        output = []

        loop do
          instruction = @memory.fetch(@pc, 0).digits.reverse
          (5 - instruction.length).times { instruction.unshift(0) }

          op = instruction[-2] * 10 + instruction[-1]
          modes = instruction[0..2].reverse

          case op
          when 1
            @memory[write_param(3, modes)] = param(1, modes) + param(2, modes)
            @pc += 4
          when 2
            @memory[write_param(3, modes)] = param(1, modes) * param(2, modes)
            @pc += 4
          when 3
            @memory[write_param(1, modes)] = input.shift
            @pc += 2
          when 4
            output << param(1, modes)
            @pc += 2
          when 5
            if param(1, modes).zero?
              @pc += 3
            else
              @pc = param(2, modes)
            end
          when 6
            if param(1, modes).zero?
              @pc = param(2, modes)
            else
              @pc += 3
            end
          when 7
            @memory[write_param(3, modes)] =
              param(1, modes) < param(2, modes) ? 1 : 0
            @pc += 4
          when 8
            @memory[write_param(3, modes)] =
              param(1, modes) == param(2, modes) ? 1 : 0
            @pc += 4
          when 9
            @rb += param(1, modes)
            @pc += 2
          when 99
            break
          end
        end

        output
      end
    end
  end
end
