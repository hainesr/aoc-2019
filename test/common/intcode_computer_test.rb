# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/common/intcode_computer'

class AOC2019::Common::IntcodeComputerTest < Minitest::Test
  def test_new
    computer = AOC2019::Common::IntcodeComputer.new('1,0,4,0,99')
    assert_equal([1, 0, 4, 0, 99], computer.memory)
  end

  def test_run
    computer = AOC2019::Common::IntcodeComputer.new('3,0,4,0,99')
    assert_equal([1], computer.run(1))
    assert_equal([1, 0, 4, 0, 99], computer.memory)

    computer = AOC2019::Common::IntcodeComputer.new('1002,4,3,4,33')
    computer.run(1)
    assert_equal([1002, 4, 3, 4, 99], computer.memory)

    computer = AOC2019::Common::IntcodeComputer.new('1101,100,-1,4,0')
    computer.run(1)
    assert_equal([1101, 100, -1, 4, 99], computer.memory)
  end

  def test_jumps_position_mode
    computer = AOC2019::Common::IntcodeComputer.new('3,9,8,9,10,9,4,9,99,-1,8')
    assert_equal([1], computer.run(8))
    computer.reset!
    assert_equal([0], computer.run(0))

    computer = AOC2019::Common::IntcodeComputer.new('3,9,7,9,10,9,4,9,99,-1,8')
    assert_equal([1], computer.run(7))
    computer.reset!
    assert_equal([0], computer.run(8))
  end

  def test_jumps_immediate_mode
    computer = AOC2019::Common::IntcodeComputer.new('3,3,1108,-1,8,3,4,3,99')
    assert_equal([1], computer.run(8))
    computer.reset!
    assert_equal([0], computer.run(9))

    computer = AOC2019::Common::IntcodeComputer.new('3,3,1107,-1,8,3,4,3,99')
    assert_equal([1], computer.run(-1))
    computer.reset!
    assert_equal([0], computer.run(9))
  end

  def test_branching_position_mode
    program = '3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_equal([1], computer.run(10))
    computer.reset!
    assert_equal([0], computer.run(0))
  end

  def test_branching_immediate_mode
    program = '3,3,1105,-1,9,1101,0,0,12,4,12,99,1'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_equal([1], computer.run(5))
    computer.reset!
    assert_equal([0], computer.run(0))
  end

  def test_relative_base
    program = '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_equal(
      [
        109, 1, 204, -1, 1001, 100, 1, 100,
        1008, 100, 16, 101, 1006, 101, 0, 99
      ],
      computer.run
    )
  end

  def test_large_memory_support
    program = '4,1000,99'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_equal([0], computer.run)
  end

  def test_large_number_support
    program = '1102,34915192,34915192,7,4,7,99,0'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_equal([1_219_070_632_396_864], computer.run)

    program = '104,1125899906842624,99'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_equal([1_125_899_906_842_624], computer.run)
  end
end
