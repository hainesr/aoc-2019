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
    def run
      computer = Common::IntcodeComputer.new(read_input_file)
      image = format(computer.run)

      puts "Part 1: #{calibrate(image)}"
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
