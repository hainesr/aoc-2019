# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/common/a_star'

class AOC2019::Common::AStarTest < Minitest::Test
  MAP = [
    [0, 0, 1, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 1, 1, 1],
    [0, 0, 1, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 1, 1, 1, 1, 0, 1],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
    [1, 0, 1, 1, 1, 0, 1, 1, 0, 0],
    [0, 0, 1, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ].freeze

  def test_node_new
    node = ::AOC2019::Common::AStar::Node.new
    assert_nil node.parent
    assert_nil node.position
    assert_equal(0, node.g)
    assert_equal(0, node.h)
    assert_equal(0, node.f)
  end

  def test_node_f
    node = ::AOC2019::Common::AStar::Node.new
    node.g = 2
    node.h = 3
    assert_equal(5, node.f)
  end

  def test_astar
    astar = ::AOC2019::Common::AStar.new(MAP)
    assert_equal(20, astar.solve([3, 7], [8, 1]).length)
    assert_equal(13, astar.solve([3, 7], [8, 1], :eight).length)
  end
end
