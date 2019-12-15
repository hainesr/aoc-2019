# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class SpaceStoichiometry < Day
    def run
      recipe = parse(read_input_file)

      puts "Part 1: #{cost(recipe, :FUEL, 1)}"
      puts "Part 2: #{max_fuel(recipe, 1_000_000_000_000)}"
    end

    def cost(recipe, name, quantity, need = {}, waste = {})
      waste[name] ||= 0
      need[name] ||= 0

      reaction_quantity, inputs = recipe[name]
      mult = [((quantity - waste[name]) / reaction_quantity.to_f).ceil, 0].max

      if quantity < waste[name]
        waste[name] -= quantity
      else
        need[name] -= waste[name]
        waste[name] = mult * reaction_quantity - need[name] if name != :FUEL
        inputs.each do |in_name, in_quant|
          need[in_name] ||= 0
          need[in_name] += mult * in_quant
          cost(recipe, in_name, in_quant * mult, need, waste) if in_name != :ORE
        end
      end

      need[name] = 0
      need[:ORE]
    end

    def max_fuel(recipe, n)
      (1..n).bsearch { |i| cost(recipe, :FUEL, i) > n } - 1
    end

    def parse(input)
      recipe = {}

      lines = input.split("\n").map { |l| l.split(' => ') }
      lines.each_with_object(recipe) do |line, acc|
        n, c = line[1].split

        a = {}
        line[0].split(', ').map(&:split).each do |i, j|
          a[j.to_sym] = i.to_i
        end

        acc[c.to_sym] = [n.to_i, a]
      end

      recipe
    end
  end
end
