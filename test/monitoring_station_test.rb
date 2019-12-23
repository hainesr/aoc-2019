# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/monitoring_station'

class AOC2019::MonitoringStationTest < Minitest::Test
  TEST1 = ".#..#\n.....\n#####\n....#\n...##"
  ASTEROIDS1 = [
    [1, 0], [4, 0],
    [0, 2], [1, 2], [2, 2], [3, 2], [4, 2],
    [4, 3],
    [3, 4], [4, 4]
  ].freeze

  def setup
    @ms = ::AOC2019::MonitoringStation.new
  end

  def test_read_asteroids
    chart = @ms.read_chart(TEST1)
    assert_equal(ASTEROIDS1, @ms.read_asteroids(chart))
  end
end
