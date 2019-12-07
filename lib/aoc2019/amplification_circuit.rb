# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class AmplificationCircuit < Day
    def run
      prog = read_input_file.chomp.split(',').map(&:to_i)

      puts "Part 1: #{optimal_phase_setting(prog)}"
      puts "Part 2: #{optimal_feedback_setting(prog)}"
    end

    def optimal_phase_setting(prog)
      [0, 1, 2, 3, 4].permutation(5).each_with_object([]) do |setting, acc|
        acc << test_setting(prog, setting)
      end.max
    end

    def optimal_feedback_setting(prog)
      [5, 6, 7, 8, 9].permutation(5).each_with_object([]) do |setting, acc|
        acc << feedback_setting(prog, setting)
      end.max
    end

    def test_setting(prog, setting)
      out = 0

      setting.each do |s|
        out, = run_program(prog.dup, [s, out])
      end

      out
    end

    def feedback_setting(prog, settings)
      a, b, c, d, e = settings
      all_state = [
        [prog.dup, [a, 0], 0],
        [prog.dup, [b], 0],
        [prog.dup, [c], 0],
        [prog.dup, [d], 0],
        [prog.dup, [e], 0]
      ]

      i = 0
      loop do
        prog, inputs, in_pc = all_state[i]
        out, pc, state = run_program(prog, inputs, in_pc)

        all_state[i][2] = pc

        if i == 4
          return out if state == :halt

          i = 0
        else
          i += 1
        end
        all_state[i][1] << out
      end
    end

    def run_program(prog, inputs, pc = 0)
      state = :running
      i = pc
      out = nil

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
          input = inputs.shift
          if input.nil?
            state = :paused
            break
          end

          prog[prog[i + 1]] = input
          i += 2
        when 4
          param1 = im1 ? prog[i + 1] : prog[prog[i + 1]]
          out = param1
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
          state = :halt
          break
        end
      end

      [out, i, state]
    end
  end
end
