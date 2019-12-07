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
      puts "Part 2: #{count_orbital_moves(map)}"
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

    def path_to_node(map, node, acc, root = 'COM')
      return false if root.nil?

      acc << root
      return true if root == node

      moons = map[root]
      if moons.nil?
        # If there are no moons the root of this map is not in the path.
        # Remove it.
        acc.pop
        return false
      end

      if path_to_node(map, node, acc, moons[0]) ||
         (!moons[1].nil? && path_to_node(map, node, acc, moons[1]))
        return true
      end

      # If we get here then the root of this map is not in the path. Remove it.
      acc.pop
      false
    end

    def lowest_common_ancestor(map, r = 'COM', n1 = 'YOU', n2 = 'SAN')
      p1 = []
      p2 = []

      return if !path_to_node(map, n1, p1, r) || !path_to_node(map, n2, p2, r)

      i = 0
      loop do
        break if p1[i] != p2[i]

        i += 1
      end

      p1[i - 1]
    end

    def count_orbital_moves(map)
      root = lowest_common_ancestor(map)
      you_path = []
      san_path = []

      path_to_node(map, 'YOU', you_path, root)
      path_to_node(map, 'SAN', san_path, root)

      you_path.length + san_path.length - 4
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
