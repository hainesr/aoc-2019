# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/amplification_circuit'

class AOC2019::AmplificationCircuitTest < Minitest::Test
  TEST_PROGS = [
    ['3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0', 43_210],
    ['3,23,3,24,1002,24,10,24,1002,23,-1,23,' \
      '101,5,23,23,1,24,23,23,4,23,99,0,0', 54_321],
    ['3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,' \
      '1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0', 65_210]
  ].freeze

  def setup
    @ac = ::AOC2019::AmplificationCircuit.new
  end

  def test_optimal_phase_setting
    TEST_PROGS.each do |input, max|
      prog = input.split(',').map(&:to_i)
      assert_equal(max, @ac.optimal_phase_setting(prog))
    end
  end
end
