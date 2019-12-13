# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class NBodyProblem < Day
    INPUT = [
      [3, 3, 0],
      [4, -16, 2],
      [-10, -6, 5],
      [-3, 0, -13]
    ].freeze

    def run
      system = System.create(INPUT)
      system.steps(1000)
      puts "Part 1: #{system.energy}"

      system = System.create(INPUT)
      puts "Part 2: #{system.repeat}"
    end
  end

  Body = Struct.new(:x, :y, :z, :vx, :vy, :vz) do
    def move
      self.x += vx
      self.y += vy
      self.z += vz
    end

    def energy
      (x.abs + y.abs + z.abs) * (vx.abs + vy.abs + vz.abs)
    end
  end

  class System
    def initialize(bodies = [])
      @bodies = bodies
    end

    def energy
      @bodies.reduce(0) { |acc, b| acc + b.energy }
    end

    def repeat
      [:x, :y, :z].map do |dim|
        i = 0
        t = 0
        seen = {}

        loop do
          step_v
          step_p
          i += 1
          hash = coords_for(dim).pack('ssss')

          if seen[hash].nil?
            seen[hash] = i
          elsif i - seen[hash] == 1
            ord = t
            t = i - ord
            break t if ord.positive?
          end
        end
      end.reduce(1, :lcm) * 2
    end

    def steps(n)
      n.times do
        step_v
        step_p
      end
    end

    def step_v
      @bodies.combination(2) do |b1, b2|
        [[:x, :vx], [:y, :vy], [:z, :vz]].each do |c, v|
          if b1[c] > b2[c]
            b1[v] -= 1
            b2[v] += 1
          elsif b1[c] < b2[c]
            b1[v] += 1
            b2[v] -= 1
          end
        end
      end
    end

    def step_p
      @bodies.each(&:move)
    end

    def coords_for(dim)
      @bodies.map { |b| b.send(dim.to_sym) }
    end

    def self.create(data)
      bodies = []

      data.each do |x, y, z|
        bodies << Body.new(x, y, z, 0, 0, 0)
      end

      System.new(bodies)
    end
  end
end
