# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class CrossedWires < Day
    def run
      input = read_input_file.split("\n").map { |line| line.split(',') }
      wire1 = generate_path(input[0])
      wire2 = generate_path(input[1])

      intersections = (wire1.to_set & wire2.to_set).to_a

      puts "Part 1: #{closest_intersection(intersections)}"
    end

    def closest_intersection(intersections)
      intersections.map do |i|
        i.split(',').map(&:to_i).reduce(0) { |acc, c| acc + c.abs }
      end.min
    end

    def generate_path(steps)
      x = 0
      y = 0

      steps.each_with_object([]) do |step, path|
        dir = step[0]
        mag = step[1..-1].to_i

        mag.times do
          case dir
          when 'U'
            y += 1
          when 'D'
            y -= 1
          when 'R'
            x += 1
          when 'L'
            x -= 1
          end

          path << "#{x},#{y}"
        end
      end
    end
  end
end
