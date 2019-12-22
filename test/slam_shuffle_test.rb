# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/slam_shuffle'

class AOC2019::SlamShuffleTest < Minitest::Test
  SHUFFLE1 = <<~EOF1
    deal with increment 7
    deal into new stack
    deal into new stack
  EOF1

  SHUFFLE2 = <<~EOF2
    cut 6
    deal with increment 7
    deal into new stack
  EOF2

  SHUFFLE3 = <<~EOF3
    deal into new stack
    cut -2
    deal with increment 7
    cut 8
    cut -4
    deal with increment 7
    cut 3
    deal with increment 9
    deal with increment 3
    cut -1
  EOF3

  def setup
    @ss = ::AOC2019::SlamShuffle.new(10)
  end

  def test_deck
    assert_equal([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], @ss.deck)
  end

  def test_deal
    @ss.deal
    assert_equal([9, 8, 7, 6, 5, 4, 3, 2, 1, 0], @ss.deck)
  end

  def test_cut_pos
    @ss.cut(3)
    assert_equal([3, 4, 5, 6, 7, 8, 9, 0, 1, 2], @ss.deck)
  end

  def test_cut_neg
    @ss.cut(-4)
    assert_equal([6, 7, 8, 9, 0, 1, 2, 3, 4, 5], @ss.deck)
  end

  def test_deal_incr
    @ss.deal_incr(3)
    assert_equal([0, 7, 4, 1, 8, 5, 2, 9, 6, 3], @ss.deck)
  end

  def test_read_shuffle
    assert_equal(
      [[:deal_incr, 7], [:deal, nil], [:deal, nil]],
      ::AOC2019::SlamShuffle.read_shuffle(SHUFFLE1)
    )

    assert_equal(
      [[:cut, 6], [:deal_incr, 7], [:deal, nil]],
      ::AOC2019::SlamShuffle.read_shuffle(SHUFFLE2)
    )
  end

  def test_shuffle_1
    shuffle = ::AOC2019::SlamShuffle.read_shuffle(SHUFFLE1)
    @ss.shuffle(shuffle)
    assert_equal([0, 3, 6, 9, 2, 5, 8, 1, 4, 7], @ss.deck)
  end

  def test_shuffle_2
    shuffle = ::AOC2019::SlamShuffle.read_shuffle(SHUFFLE2)
    @ss.shuffle(shuffle)
    assert_equal([3, 0, 7, 4, 1, 8, 5, 2, 9, 6], @ss.deck)
  end

  def test_shuffle_3
    shuffle = ::AOC2019::SlamShuffle.read_shuffle(SHUFFLE3)
    @ss.shuffle(shuffle)
    assert_equal([9, 2, 5, 8, 1, 4, 7, 0, 3, 6], @ss.deck)
  end
end
