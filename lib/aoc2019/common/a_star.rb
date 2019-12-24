# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

module AOC2019
  module Common
    class AStar
      STEPS = {
        four: [
          [0, 1], [1, 0], [0, -1], [-1, 0]
        ],
        eight: [
          [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]
        ]
      }.freeze

      def initialize(map, walls = '#')
        @map = map
        @walls = [*walls]
      end

      def solve(start_pos, end_pos, ways = :four)
        start_node = Node.new(nil, start_pos)
        end_node = Node.new(nil, end_pos)
        open_list = []
        closed_list = []

        open_list.push start_node

        while open_list.length.positive?
          current_node = open_list.min { |a, b| a.f <=> b.f }
          open_list.delete current_node
          closed_list.push current_node
          return path(current_node) if current_node == end_node

          children = []
          STEPS[ways].each do |new_position|
            x = current_node.position[0] + new_position[0]
            y = current_node.position[1] + new_position[1]

            next if !(0...@map.length).cover?(y) ||
                    !(0...@map[0].length).cover?(x)
            next if @walls.include?(@map[y][x])

            children.push Node.new(current_node, [x, y])
          end

          children.each do |child|
            next if closed_list.include?(child)

            child.g = current_node.g + 1
            child.h = ((child.position[0] - end_node.position[0])**2) +
                      ((child.position[1] - end_node.position[1])**2)

            node = open_list.find_index(child)
            next if !node.nil? && child.g > open_list[node].g

            open_list.push child
          end
        end
      end

      def path(node)
        path = []

        until node.nil?
          path.push node.position
          node = node.parent
        end

        path.reverse
      end

      class Node
        attr_accessor :g, :h
        attr_reader :parent, :position

        def initialize(parent = nil, position = nil)
          @parent = parent
          @position = position
          @g = 0
          @h = 0
        end

        def f
          @g + @h
        end

        def ==(other)
          @position == other.position
        end
      end
    end
  end
end
