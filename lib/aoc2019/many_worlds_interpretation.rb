# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/a_star'

module AOC2019
  class ManyWorldsInterpretation < Day
    attr_reader :doors, :entrance, :keys, :map

    def initialize(input = read_input_file, walls = '#')
      @map, @entrance, @keys, @doors = read_map(input)
      @walls = walls
      @all_routes = find_routes
    end

    def run
      puts "Part 1: #{collect_keys}"
    end

    def collect_keys(start = '@', got = [], cache = {})
      cache_key = [start, got.sort.join]
      return cache[cache_key] if cache.key?(cache_key)

      accessible = keys_accessible_from(start, got)
      if accessible.empty?
        val = 0
      else
        steps = []

        accessible.each do |key, dist|
          steps << dist + collect_keys(key, got + [key], cache)
        end

        val = steps.min
      end

      cache[cache_key] = val
    end

    def keys_accessible_from(start, got = [])
      access = []

      @all_routes[start].each do |key, (route, needed)|
        next if got.include?(key)

        access << [key, route.length - 1] if (needed - got).empty?
      end

      access.select do |a|
        (access - [a]).each do |aa|
          break false if @all_routes[start][a[0]][0].include?(@keys[aa[0]])
        end
      end
    end

    private

    def find_routes
      astar = ::AOC2019::Common::AStar.new(@map, @walls)
      all_routes = { '@' => {} }

      @keys.each do |key, loc|
        route = astar.solve(@entrance, loc)
        all_routes['@'][key] = [route, keys_needed(route)]
        all_routes[key] = {}

        @keys.each do |k, l|
          next if k == key

          if all_routes[k].nil? || all_routes[k][key].nil?
            route = astar.solve(loc, l)
            all_routes[key][k] = [route, keys_needed(route)]
          else
            route, needed = all_routes[k][key]
            all_routes[key][k] = [route.reverse, needed]
          end
        end
      end

      all_routes
    end

    def keys_needed(route)
      needed = []

      @doors.each do |door, loc|
        needed << door if route.include?(loc)
      end

      needed
    end

    def read_map(input)
      map = input.split("\n").map(&:chars)
      entrance = nil
      keys = {}
      doors = {}

      map.each_with_index do |line, y|
        line.each_with_index do |char, x|
          entrance = [x, y] if char == '@'
          keys[char] = [x, y] if ('a'..'z').cover?(char)
          doors[char.downcase] = [x, y] if ('A'..'Z').cover?(char)
        end
      end

      [map, entrance, keys, doors]
    end
  end
end
