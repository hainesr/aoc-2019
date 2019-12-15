# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/space_stoichiometry'

class AOC2019::SpaceStoichiometryTest < Minitest::Test
  IN1 = <<~EOIN1.strip
    10 ORE => 10 A
    1 ORE => 1 B
    7 A, 1 B => 1 C
    7 A, 1 C => 1 D
    7 A, 1 D => 1 E
    7 A, 1 E => 1 FUEL
  EOIN1

  IN2 = <<~EOIN2
    157 ORE => 5 NZVS
    165 ORE => 6 DCFZ
    44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
    12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
    179 ORE => 7 PSHF
    177 ORE => 5 HKGWZ
    7 DCFZ, 7 PSHF => 2 XJWVT
    165 ORE => 2 GPVTF
    3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
  EOIN2

  IN3 = <<~EOIN3
    171 ORE => 8 CNZTR
    7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
    114 ORE => 4 BHXH
    14 VRPVC => 6 BMBT
    6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
    6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
    15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
    13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
    5 BMBT => 4 WPTQ
    189 ORE => 9 KTJDG
    1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
    12 VRPVC, 27 CNZTR => 2 XDBXC
    15 KTJDG, 12 BHXH => 5 XCVML
    3 BHXH, 2 VRPVC => 7 MZWV
    121 ORE => 7 VRPVC
    7 XCVML => 6 RJRHP
    5 BHXH, 4 VRPVC => 5 LTCX
  EOIN3

  def setup
    @ss = ::AOC2019::SpaceStoichiometry.new
  end

  def test_1
    recipe = @ss.parse(IN1)
    assert_equal(31, @ss.cost(recipe, :FUEL, 1))
  end

  def test_2
    recipe = @ss.parse(IN2)
    assert_equal(13_312, @ss.cost(recipe, :FUEL, 1))
    assert_equal(82_892_753, @ss.max_fuel(recipe, 1_000_000_000_000))
  end

  def test_3
    recipe = @ss.parse(IN3)
    assert_equal(2_210_736, @ss.cost(recipe, :FUEL, 1))
    assert_equal(460_664, @ss.max_fuel(recipe, 1_000_000_000_000))
  end

  def test_parse
    recipe = @ss.parse(IN1)
    assert_equal(1, recipe[:FUEL][0])
    assert_equal(7, recipe[:FUEL][1][:A])
  end
end
