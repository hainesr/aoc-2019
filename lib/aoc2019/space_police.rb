# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class SpacePolice < Day
    DIRECTIONS = [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0]
    ].freeze

    def run
      computer = Common::IntcodeComputer.new(read_input_file)

      puts "Part 1: #{track_robot(computer).length}"

      computer.reset!
      puts 'Part 2:'
      draw_registration(computer)
    end

    def draw_registration(brain)
      track = track_robot(brain, 1)
      dim_x, dim_y = track.keys.transpose.map(&:minmax).map do |lo, hi|
        (lo..hi)
      end

      dim_y.reverse_each do |y|
        line = []
        dim_x.each do |x|
          line << (track.fetch([x, y], 0).zero? ? ' ' : '#')
        end
        puts line.join
      end
    end

    def track_robot(brain, start = 0)
      x = 0
      y = 0
      dir = [0, 1]
      track = { [0, 0] => start }

      loop do
        coord = [x, y]
        current_colour = track.fetch(coord, 0)
        paint, turn = brain.run(current_colour)

        track[coord] = paint
        dir = new_dir(dir, turn)
        x += dir[0]
        y += dir[1]

        break if brain.done?
      end

      track
    end

    def new_dir(dir, turn)
      ci = DIRECTIONS.index(dir)
      turn = turn.zero? ? -1 : 1
      ni = ci + turn
      ni = 0 if ni == 4
      DIRECTIONS[ni]
    end
  end
end
