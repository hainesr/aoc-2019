# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class PlanetOfDiscord < Day
    INPUT = <<~EOINPUT
      ###.#
      ..#..
      #..#.
      #....
      .#.#.
    EOINPUT

    def run
      state = read(INPUT)
      puts "Part 1: #{part1(state)}"
    end

    def part1(state)
      mem = [biodiversity(state)]
      loop do
        state = tick(state)
        bio = biodiversity(state)
        return bio if mem.include?(bio)

        mem << bio
      end
    end

    def tick(state)
      new_state = []
      (0..4).each do |y|
        new_state[y] = []
        (0..4).each do |x|
          current = state[y][x]
          adj = adjacent(state, x, y)
          new_state[y][x] = if current == 1
                              adj == 1 ? 1 : 0
                            else
                              [1, 2].include?(adj) ? 1 : 0
                            end
        end
      end

      new_state
    end

    def biodiversity(state)
      state.flatten.reverse.join.to_i(2)
    end

    def adjacent(state, x, y)
      [[x - 1, y], [x, y - 1], [x + 1, y], [x, y + 1]].delete_if do |i, j|
        i.negative? || j.negative? || i > 4 || j > 4
      end.reduce(0) { |acc, c| acc + state[c[1]][c[0]] }
    end

    def read(input)
      input.split("\n").map(&:chars).map do |line|
        line.map { |c| c == '#' ? 1 : 0 }
      end
    end
  end
end
