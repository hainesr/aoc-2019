# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'
require_relative 'common/a_star'

module AOC2019
  class OxygenSystem < Day
    MOVES = [
      nil,
      [0, 1],   # North
      [0, -1],  # South
      [-1, 0],  # West
      [1, 0]    # East
    ].freeze

    FULL_MAP = <<~EOMAP
      #########################################
      #     #                 #   #       #V  #
      # ##### # ########### ### # # ### # ### #
      #   #   #   #       # #   # #   # # #   #
      ### # ##### # ##### # # ### ##### # # ###
      #   #   # #   #   # # #   #   #   # #   #
      # # ### # ####### # # ### ### # ### ### #
      # # #   #         # #   # #   # #       #
      # # # ####### ##### # ### # ### #########
      # # #         #     # #   #   # #       #
      # # ######### # ### ### ##### # # ##### #
      # #     #   # #   # #   # #   #   # #   #
      # ### ### # # ### # # ### # ### ### # ###
      #   # #   #     # # # #   # #       #   #
      # # ### ######### # # ### # ########### #
      # #     # #       # #     # #       #   #
      ####### # # ##### ### ##### # ##### # # #
      #     #   #     # #   #     #     #   # #
      # ### ######### ### ### ####### # ##### #
      #   #   #       #   #S#       # # #   # #
      ### ### # ##### # ### # ##### ### # ### #
      #   #   # #     #   # # #     #   #     #
      # ### ### # ####### # ### ##### ### #####
      # #   #   # #     # #   # #       #     #
      # ### # ##### ### # ### # # ##### #######
      #   #   #   # # #   # #   #     #       #
      ### ##### # # # ##### ######### ####### #
      #   #     # # #     #     # #   #       #
      # ### ##### # ### # # ### # # ### ##### #
      # #   #     #     #   #   #     #   # # #
      # # ### ### ########### ######### # # # #
      #   # # # # #         #     #   # # # # #
      # ### # # # # ####### ##### # # ### # # #
      #     # #   #   # #   #   #   #   # #   #
      ##### # ### ### # # # ### ####### # #####
      # #   #   #   #   # #         #   # #   #
      # # ##### ####### # # ######### ### # # #
      #   #   #         # # #     #   #     # #
      # ##### ########### ### ### # ######### #
      #                 #       #             #
      #########################################
    EOMAP

    def run
      # Uncomment the next two lines to explore the map initially
      # computer = Common::IntcodeComputer.new(read_input_file)
      # map, start, valve = find_exit(computer)

      # Load the pre-explored map.
      map, start, valve = load_map(FULL_MAP)

      astar = Common::AStar.new(map, 0)
      route = astar.solve(start, valve)
      puts "Part 1: #{route.length - 1}"

      route = astar.solve(valve, [7, 11])
      puts "Part 2: #{route.length - 1}"
    end

    def find_exit(droid)
      x = 0
      y = 0
      map = { [x, y] => 0 }

      loop do
        move = Random.rand(1..4)
        output = droid.run(move).first
        new_x = (x + MOVES[move].first)
        new_y = (y + MOVES[move].last)

        map[[new_x, new_y]] = output
        next if output.zero?
        break if output == 2

        x = new_x
        y = new_y
      end

      build_map(map)
    end

    def build_map(raw_map)
      minx, maxx = raw_map.keys.minmax_by { |c| c[0] }
      miny, maxy = raw_map.keys.minmax_by { |c| c[1] }
      minx = minx.first
      maxx = maxx.first
      miny = miny.last
      maxy = maxy.last
      start = [minx.abs, miny.abs]

      map = []
      valve = []

      (miny..maxy).each do |y|
        mapy = y + start.last
        map[mapy] = []
        (minx..maxx).each do |x|
          mapx = x + start.first
          point = raw_map.fetch([x, y], 0)
          map[mapy][mapx] = point
          valve = [mapx, mapy] if point == 2
        end
      end

      [map, start, valve]
    end

    def draw_map(map, start, valve, route)
      glyphs = ['#', ' ', 'V', 'S', '.']
      m = map.dup
      route.each { |x, y| m[y][x] = 4 }
      m[valve.last][valve.first] = 2
      m[start.last][start.first] = 3
      m.each do |line|
        puts line.map { |c| glyphs[c] }.join
      end
    end

    def load_map(input)
      map = []
      start = nil
      valve = nil

      input.split("\n").map.with_index do |line, y|
        map[y] = []
        line.chars.each_with_index do |c, x|
          map[y][x] = c == '#' ? 0 : 1
          start = [x, y] if start.nil? && c == 'S'
          valve = [x, y] if valve.nil? && c == 'V'
        end
      end

      [map, start, valve]
    end
  end
end
