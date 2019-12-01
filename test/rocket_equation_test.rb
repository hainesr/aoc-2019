# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/rocket_equation'

class AOC2019::RocketEquationTest < Minitest::Test
  FUEL_FOR_MASS = {
    12 => 2,
    14 => 2,
    1_969 => 654,
    100_756 => 33_583
  }.freeze

  TOTAL_FUEL_FOR_MASS = {
    12 => 2,
    14 => 2,
    1_969 => 966,
    100_756 => 50_346
  }.freeze

  def setup
    @re = ::AOC2019::RocketEquation.new
  end

  def test_fuel_for_mass
    FUEL_FOR_MASS.each do |mass, fuel|
      assert_equal(fuel, @re.fuel_for_mass(mass))
    end
  end

  def test_fuel_required
    assert_equal(
      FUEL_FOR_MASS.values.sum,
      @re.fuel_required(FUEL_FOR_MASS.keys)
    )
  end

  def test_total_fuel_required
    TOTAL_FUEL_FOR_MASS.each do |mass, fuel|
      assert_equal(fuel, @re.total_fuel_required([mass]))
    end

    assert_equal(
      TOTAL_FUEL_FOR_MASS.values.sum,
      @re.total_fuel_required(TOTAL_FUEL_FOR_MASS.keys)
    )
  end
end
