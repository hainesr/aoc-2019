# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/secure_container'

class AOC2019::SecureContainerTest < Minitest::Test
  def setup
    @sc = ::AOC2019::SecureContainer.new
  end

  def test_repeated_digits
    assert @sc.repeated_digits?([1, 1, 1, 1, 1, 1])
    assert @sc.repeated_digits?([1, 2, 3, 4, 5, 5])
    assert @sc.repeated_digits?([1, 1])
    refute @sc.repeated_digits?([1, 2])
    refute @sc.repeated_digits?([1, 2, 3, 4, 5, 6])
  end
end
