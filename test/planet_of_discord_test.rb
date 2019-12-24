# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/planet_of_discord'

class AOC2019::PlanetOfDiscordTest < Minitest::Test
  INPUT1 = <<~EOI1
    ....#
    #..#.
    #..##
    ..#..
    #....
  EOI1

  PARSED1 = [
    [0, 0, 0, 0, 1],
    [1, 0, 0, 1, 0],
    [1, 0, 0, 1, 1],
    [0, 0, 1, 0, 0],
    [1, 0, 0, 0, 0]
  ].freeze

  MIN1 = [
    [1, 0, 0, 1, 0],
    [1, 1, 1, 1, 0],
    [1, 1, 1, 0, 1],
    [1, 1, 0, 1, 1],
    [0, 1, 1, 0, 0]
  ].freeze

  def setup
    @pod = ::AOC2019::PlanetOfDiscord.new
  end

  def test_input
    assert_equal(PARSED1, @pod.read(INPUT1))
  end

  def test_biodiversity
    assert_equal(1_205_552, @pod.biodiversity(PARSED1))
  end

  def test_adjacent
    assert_equal(1, @pod.adjacent(PARSED1, 0, 0))
    assert_equal(1, @pod.adjacent(PARSED1, 0, 1))
    assert_equal(0, @pod.adjacent(PARSED1, 2, 3))
  end

  def test_tick
    assert_equal(MIN1, @pod.tick(PARSED1))
  end
end
