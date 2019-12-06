# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/universal_orbit_map'

class AOC2019::UniversalOrbitMapTest < Minitest::Test
  RAW = "COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L"
  MAP = {
    'COM' => ['B'],
    'B' => ['C', 'G'],
    'C' => ['D'],
    'D' => ['E', 'I'],
    'E' => ['F', 'J'],
    'G' => ['H'],
    'J' => ['K'],
    'K' => ['L']
  }.freeze

  def setup
    @uom = ::AOC2019::UniversalOrbitMap.new
  end

  def test_build_orbit_map
    assert_equal(MAP, @uom.build_orbit_map(RAW))
  end

  def test_orbit_depths
    assert_equal(42, @uom.orbit_depths(MAP).sum)
  end
end
