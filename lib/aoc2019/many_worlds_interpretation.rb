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

      update_map
      puts "Part 2: #{collect_keys(['@0', '@1', '@2', '@3'])}"
    end

    def collect_keys(starts = ['@0'], got = [], cache = {})
      cache_key = [starts.sort.join, got.sort.join]
      return cache[cache_key] if cache.key?(cache_key)

      accessible = keys_accessible_from(starts, got)
      if accessible.empty?
        val = 0
      else
        steps = []

        accessible.each do |robot, key, dist|
          temp = starts[robot]
          starts[robot] = key
          steps << dist + collect_keys(starts, got + [key], cache)
          starts[robot] = temp
        end

        val = steps.min
      end

      cache[cache_key] = val
    end

    def keys_accessible_from(starts, got = [])
      access = []

      starts.each_with_index do |start, robot|
        @all_routes[start].each do |key, (route, needed)|
          next if got.include?(key)

          access << [robot, key, route.length - 1] if (needed - got).empty?
        end
      end

      access.select do |a|
        result = true
        (access - [a]).each do |aa|
          result = starts.each do |start|
            next if @all_routes[start][a[1]].nil?
            break false if @all_routes[start][a[1]][0].include?(@keys[aa[1]])
          end
          break unless result
        end
        result
      end
    end

    def update_map
      x, y = @entrance['@0']
      @map[y - 1][x - 1..x + 1] = ['@', '#', '@']
      @map[y][x - 1..x + 1] = ['#', '#', '#']
      @map[y + 1][x - 1..x + 1] = ['@', '#', '@']
      @entrance['@0'] = [x - 1, y - 1]
      @entrance['@1'] = [x + 1, y - 1]
      @entrance['@2'] = [x - 1, y + 1]
      @entrance['@3'] = [x + 1, y + 1]
      @all_routes = find_routes
    end

    private

    def find_routes
      astar = ::AOC2019::Common::AStar.new(@map, @walls)
      all_routes = { '@0' => {}, '@1' => {}, '@2' => {}, '@3' => {} }

      @keys.each do |key, loc|
        @entrance.each do |e, e_loc|
          route = astar.solve(e_loc, loc)
          all_routes[e][key] = [route, keys_needed(route)] unless route.nil?
        end
        all_routes[key] = {}

        @keys.each do |k, l|
          next if k == key

          if all_routes[k].nil? || all_routes[k][key].nil?
            route = astar.solve(loc, l)
            all_routes[key][k] = [route, keys_needed(route)] unless route.nil?
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
      entrance = {}
      keys = {}
      doors = {}

      map.each_with_index do |line, y|
        line.each_with_index do |char, x|
          entrance['@0'] = [x, y] if char == '@'
          keys[char] = [x, y] if ('a'..'z').cover?(char)
          doors[char.downcase] = [x, y] if ('A'..'Z').cover?(char)
        end
      end

      [map, entrance, keys, doors]
    end
  end
end
