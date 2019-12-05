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

    assert_output(/1/) do
      @sa.run_program([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], 8)
    end

    assert_output(/0/) do
      @sa.run_program([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], 0)
    end

    assert_output(/1/) do
      @sa.run_program([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], 7)
    end

    assert_output(/0/) do
      @sa.run_program([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], 8)
    end

    assert_output(/1/) do
      @sa.run_program([3, 3, 1108, -1, 8, 3, 4, 3, 99], 8)
    end

    assert_output(/0/) do
      @sa.run_program([3, 3, 1108, -1, 8, 3, 4, 3, 99], 9)
    end

    assert_output(/1/) do
      @sa.run_program([3, 3, 1107, -1, 8, 3, 4, 3, 99], -1)
    end

    assert_output(/0/) do
      @sa.run_program([3, 3, 1107, -1, 8, 3, 4, 3, 99], 9)
    end

    assert_output(/1/) do
      @sa.run_program(
        [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9],
        10
      )
    end

    assert_output(/0/) do
      @sa.run_program(
        [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9],
        0
      )
    end

    assert_output(/1/) do
      @sa.run_program(
        [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1],
        5
      )
    end

    assert_output(/0/) do
      @sa.run_program(
        [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1],
        0
      )
    end
  end
end
