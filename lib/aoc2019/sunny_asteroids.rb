# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class SunnyAsteroids < Day
    def run
      input = read_input_file.split(',').map(&:to_i)

      puts 'Part 1:'
      run_program(input.dup, 1)

      puts 'Part 2:'
      run_program(input.dup, 5)
    end

    def run_program(prog, input)
      i = 0

      loop do
        instruction = prog[i].digits.reverse
        (5 - instruction.length).times { instruction.unshift(0) }

        op = instruction[-2] * 10 + instruction[-1]
        im2 = instruction[1] == 1
        im1 = instruction[2] == 1

        case op
        when 1
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          param2 = im2 ? prog[i + 2] : prog[prog[i + 2]]
          prog[prog[i + 3]] = param1 + param2
          i += 4
        when 2
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          param2 = im2 ? prog[i + 2] : prog[prog[i + 2]]
          prog[prog[i + 3]] = param1 * param2
          i += 4
        when 3
          prog[prog[i + 1]] = input
          i += 2
        when 4
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          puts param1
          i += 2
        when 5
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          param2 = im2 ? prog[i + 2] : prog[prog[i + 2]]
          if param1.zero?
            i += 3
          else
            i = param2
          end
        when 6
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          param2 = im2 ? prog[i + 2] : prog[prog[i + 2]]
          if param1.zero?
            i = param2
          else
            i += 3
          end
        when 7
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          param2 = im2 ? prog[i + 2] : prog[prog[i + 2]]
          prog[prog[i + 3]] = param1 < param2 ? 1 : 0
          i += 4
        when 8
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          param2 = im2 ? prog[i + 2] : prog[prog[i + 2]]
          prog[prog[i + 3]] = param1 == param2 ? 1 : 0
          i += 4
        when 99
          break
        end
      end

      prog
    end
  end
end
