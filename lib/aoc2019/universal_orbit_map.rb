# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class UniversalOrbitMap < Day
    def run
      map = build_orbit_map(read_input_file)

      puts "Part 1: #{orbit_depths(map).sum}"
    end

    def orbit_depths(map, root = 'COM', val = 0, acc = [])
      acc << val
      val += 1
      moons = map[root]
      return [0] if moons.nil?

      moons.each do |moon|
        orbit_depths(map, moon, val, acc)
      end

      acc
    end

    def build_orbit_map(input)
      raw = input.split("\n").map { |o| o.split(')') }
      map = {}

      raw.each do |centre, moon|
        map[centre] = map[centre].nil? ? [moon] : map[centre] + [moon]
      end

      map
    end
  end
end
