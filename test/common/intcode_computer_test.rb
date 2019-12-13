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
    assert_output(/1/) do
      computer.run(1)
    end
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
    assert_output(/1/) do
      computer.run(8)
    end
    computer.reset!
    assert_output(/0/) do
      computer.run(0)
    end

    computer = AOC2019::Common::IntcodeComputer.new('3,9,7,9,10,9,4,9,99,-1,8')
    assert_output(/1/) do
      computer.run(7)
    end
    computer.reset!
    assert_output(/0/) do
      computer.run(8)
    end
  end

  def test_jumps_immediate_mode
    computer = AOC2019::Common::IntcodeComputer.new('3,3,1108,-1,8,3,4,3,99')
    assert_output(/1/) do
      computer.run(8)
    end
    computer.reset!
    assert_output(/0/) do
      computer.run(9)
    end

    computer = AOC2019::Common::IntcodeComputer.new('3,3,1107,-1,8,3,4,3,99')
    assert_output(/1/) do
      computer.run(-1)
    end
    computer.reset!
    assert_output(/0/) do
      computer.run(9)
    end
  end

  def test_branching_position_mode
    program = '3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_output(/1/) do
      computer.run(10)
    end
    computer.reset!
    assert_output(/0/) do
      computer.run(0)
    end
  end

  def test_branching_immediate_mode
    program = '3,3,1105,-1,9,1101,0,0,12,4,12,99,1'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_output(/1/) do
      computer.run(5)
    end
    computer.reset!
    assert_output(/0/) do
      computer.run(0)
    end
  end

  def test_relative_base
    program = '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_output(
      /109\n1\n204\n-1\n1001\n100\n1\n100\n1008\n100\n16\n101\n1006\n101\n0\n99/
    ) do
      computer.run
    end
  end

  def test_large_memory_support
    program = '4,1000,99'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_output(/0/) do
      computer.run
    end
  end

  def test_large_number_support
    program = '1102,34915192,34915192,7,4,7,99,0'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_output(/1219070632396864/) do
      computer.run
    end

    program = '104,1125899906842624,99'
    computer = AOC2019::Common::IntcodeComputer.new(program)
    assert_output(/1125899906842624/) do
      computer.run
    end
  end
end
