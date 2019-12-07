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

  SAN_MAP = {
    'COM' => ['B'],
    'B' => ['C', 'G'],
    'C' => ['D'],
    'D' => ['E', 'I'],
    'E' => ['F', 'J'],
    'G' => ['H'],
    'J' => ['K'],
    'K' => ['L', 'YOU'],
    'I' => ['SAN']
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

  def test_path_to_node
    path = []
    @uom.path_to_node(SAN_MAP, 'YOU', path)
    assert_equal(['COM', 'B', 'C', 'D', 'E', 'J', 'K', 'YOU'], path)
  end

  def test_lca
    assert_equal('D', @uom.lowest_common_ancestor(SAN_MAP))
  end

  def test_count_orbital_moves
    assert_equal(4, @uom.count_orbital_moves(SAN_MAP))
  end
end
