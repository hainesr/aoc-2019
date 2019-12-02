# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/program_alarm'

class AOC2019::ProgramAlarmTest < Minitest::Test
  def setup
    @pa = ::AOC2019::ProgramAlarm.new
  end

  def test_run_program
    assert_equal([2, 0, 0, 0, 99], @pa.run_program([1, 0, 0, 0, 99]))
    assert_equal([2, 3, 0, 6, 99], @pa.run_program([2, 3, 0, 3, 99]))
    assert_equal([2, 4, 4, 5, 99, 9801], @pa.run_program([2, 4, 4, 5, 99, 0]))
    assert_equal(
      [30, 1, 1, 4, 2, 5, 6, 0, 99],
      @pa.run_program([1, 1, 1, 4, 99, 5, 6, 0, 99])
    )
  end
end
