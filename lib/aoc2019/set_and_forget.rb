# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class SetAndForget < Day
    MAIN_ROUTINE = "A,B,A,B,C,A,C,A,C,B\n".chars.map(&:ord)
    FUNC_A = "R,12,L,8,L,4,L,4\n".chars.map(&:ord)
    FUNC_B = "L,8,R,6,L,6\n".chars.map(&:ord)
    FUNC_C = "L,8,L,4,R,12,L,6,L,4\n".chars.map(&:ord)
    DEBUG = "n\n".chars.map(&:ord)

    def run
      computer = Common::IntcodeComputer.new(read_input_file)
      image = format(computer.run)

      puts "Part 1: #{calibrate(image)}"

      computer.reset!
      computer.memory[0] = 2
      inputs = [MAIN_ROUTINE, FUNC_A, FUNC_B, FUNC_C, DEBUG]
      puts "part 2: #{computer.run(inputs)[-1]}"
    end

    def draw(image)
      image.map do |line|
        puts line.map { |c| c == '.' ? ' ' : c }.join
      end
    end

    def calibrate(image)
      x_dim = image[0].length
      y_dim = image.length

      coords = []
      (2..(y_dim - 2)).each do |y|
        (2..(x_dim - 2)).each do |x|
          next unless image[y][x] == '#'

          if image[y - 1][x] == '#' && image[y + 1][x] == '#' &&
             image[y][x - 1] == '#' && image[y][x + 1] == '#'
            coords.push [x, y]
          end
        end
      end

      coords.reduce(0) { |acc, (x, y)| acc + x * y }
    end

    def format(image)
      image.map(&:chr).join.split.map(&:chars)
    end
  end
end
