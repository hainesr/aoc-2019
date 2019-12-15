# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/space_police'

class AOC2019::SpacePoliceTest < Minitest::Test
  def setup
    @sp = AOC2019::SpacePolice.new
  end

  def test_new_dir
    assert_equal([0, 1], @sp.new_dir([1, 0], 0))
    assert_equal([0, -1], @sp.new_dir([1, 0], 1))
    assert_equal([-1, 0], @sp.new_dir([0, 1], 0))
    assert_equal([0, 1], @sp.new_dir([-1, 0], 1))
  end
end
