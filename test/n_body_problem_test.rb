# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/n_body_problem'

class AOC2019::NBodyProblemTest < Minitest::Test
  SYSTEM1 = [
    [-1, 0, 2],
    [2, -10, -7],
    [4, -8, 8],
    [3, 5, -1]
  ].freeze

  def test_energy
    system = ::AOC2019::System.create(SYSTEM1)
    system.steps(10)
    assert_equal(179, system.energy)
  end

  def test_coords_for
    system = ::AOC2019::System.create(SYSTEM1)
    assert_equal([-1, 2, 4, 3], system.coords_for(:x))
    assert_equal([2, -7, 8, -1], system.coords_for('z'))
  end
end
