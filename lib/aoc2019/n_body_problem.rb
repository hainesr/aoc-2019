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

    def self.create(data)
      bodies = []

      data.each do |x, y, z|
        bodies << Body.new(x, y, z, 0, 0, 0)
      end

      System.new(bodies)
    end
  end
end
