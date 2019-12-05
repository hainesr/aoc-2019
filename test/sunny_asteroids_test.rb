# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/sunny_asteroids'

class AOC2019::SunnyAsteroidsTest < Minitest::Test
  def setup
    @sa = ::AOC2019::SunnyAsteroids.new
  end

  def test_run_program
    assert_output(/1/) do
      assert_equal([1, 0, 4, 0, 99], @sa.run_program([3, 0, 4, 0, 99], 1))
    end

    assert_equal([1002, 4, 3, 4, 99], @sa.run_program([1002, 4, 3, 4, 33], 1))
    assert_equal(
      [1101, 100, -1, 4, 99],
      @sa.run_program([1101, 100, -1, 4, 0], 1)
    )
  end
end
