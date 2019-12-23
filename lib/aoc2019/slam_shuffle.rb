# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class SlamShuffle < Day
    attr_reader :deck

    def initialize(num = 10_007)
      @deck = Array.new(num) { |i| i }
    end

    def run
      slam = SlamShuffle.read_shuffle(read_input_file)
      shuffle(slam)
      puts "Part 1: #{deck.find_index(2019)}"
      puts "Part 2: #{part2(slam, 119_315_717_514_047, 101_741_582_076_661)}"
    end

    def part2(s, num, repeats, pos = 2020)
      shuffles = {
        deal: ->(_, m, a, b) { [-a % m, (m - 1 - b) % m] },
        cut: ->(x, m, a, b) { [a, (b - x) % m] },
        deal_incr: ->(x, m, a, b) { [(a * x) % m, (b * x) % m] }
      }
      a = 1
      b = 0

      s.each do |op, param|
        a, b = shuffles[op].call(param, num, a, b)
      end

      r = (b * (1 - a).pow(num - 2, num)) % num
      ((pos - r) * a.pow(repeats * (num - 2), num) + r) % num
    end

    def shuffle(s)
      s.each do |op, param|
        send(op, param)
      end
    end

    def deal(_ = nil)
      @deck.reverse!
    end

    def cut(n)
      @deck.rotate!(n)
    end

    def deal_incr(n)
      length = @deck.length
      tmp_deck = @deck.dup
      (0...length).each { |i| @deck[(i * n) % length] = tmp_deck[i] }
    end

    def self.read_shuffle(input)
      input.split("\n").map do |line|
        line = line.split
        case line[0]
        when 'cut'
          [:cut, line[1].to_i]
        when 'deal'
          if line[1] == 'into'
            [:deal, nil]
          else
            [:deal_incr, line[3].to_i]
          end
        end
      end
    end
  end
end
