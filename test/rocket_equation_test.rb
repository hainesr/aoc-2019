# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/rocket_equation'

class AOC2019::RocketEquationTest < Minitest::Test
  MASSES = {
    12 => 2,
    14 => 2,
    1_969 => 654,
    100_756 => 33_583
  }.freeze

  def setup
    @re = ::AOC2019::RocketEquation.new
  end

  def test_total_fuel_required
    MASSES.each do |mass, fuel|
      assert_equal(fuel, @re.total_fuel_required([mass]))
    end
  end
end
