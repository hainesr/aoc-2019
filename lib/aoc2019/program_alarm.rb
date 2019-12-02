# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class ProgramAlarm < Day
    def run
      input = read_input_file.split(',').map(&:to_i)

      prog = input.dup
      prog[1] = 12
      prog[2] = 2

      puts "Part 1: #{run_program(prog)[0]}"

      done = false
      (60..80).each do |noun|
        (60..80).each do |verb|
          prog = input.dup
          prog[1] = noun
          prog[2] = verb

          if run_program(prog)[0] == 19_690_720
            done = true
            puts "Part 2: #{100 * noun + verb}"
            break
          end
          break if done
        end
      end
    end

    def run_program(prog)
      i = 0

      loop do
        case prog[i]
        when 1
          prog[prog[i + 3]] = prog[prog[i + 1]] + prog[prog[i + 2]]
          i += 4
        when 2
          prog[prog[i + 3]] = prog[prog[i + 1]] * prog[prog[i + 2]]
          i += 4
        when 99
          break
        end
      end

      prog
    end
  end
end
