# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class MonitoringStation < Day
    def run
      chart = read_chart(read_input_file)
      asteroids = read_asteroids(chart)
      visible = visible_asteroids(chart, asteroids)
      max_visible = visible.max_by { |a| a[2].length }

      puts "Part 1: #{max_visible[2].length}"

      angles = kill_asteroids(max_visible)
      x, y, = angles.sort_by { |a| a[2] }[199]

      puts "Part 2: #{x * 100 + y}"
    end

    def kill_asteroids(data)
      base_x, base_y, asteroids = data
      asteroids.map do |x, y|
        dx = x - base_x.to_f
        dy = y - base_y.to_f

        angle = dx / (dx.abs + dy.abs)
        angle = -angle + 2 if dy.positive?
        angle %= 4

        [x, y, angle]
      end
    end

    def visible_asteroids(chart, asteroids)
      results = []

      asteroids.each do |ax, ay|
        seen = []
        asteroids.each do |bx, by|
          next if ax == bx && ay == by

          xdiff = bx - ax
          ydiff = by - ay

          dx = xdiff / xdiff.gcd(ydiff)
          dy = ydiff / xdiff.gcd(ydiff)
          visible = true

          tx = ax + dx
          ty = ay + dy
          until tx == bx && ty == by
            visible = false if chart[ty][tx] != '.'
            tx += dx
            ty += dy
          end

          seen << [bx, by] if visible
        end

        results << [ax, ay, seen]
      end

      results
    end

    def read_chart(raw)
      raw.split.map { |lines| lines.chomp.chars }
    end

    def read_asteroids(chart)
      chart.map.with_index do |row, y|
        row.each_index.select do |x|
          row[x] == '#'
        end.map do |x|
          [x, y]
        end
      end.flatten(1)
    end
  end
end
