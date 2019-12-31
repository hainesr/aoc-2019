# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/many_worlds_interpretation'

class AOC2019::ManyWorldsInterpretationTest < Minitest::Test
  MAP1 = <<~EOMAP1
    #########
    #b.A.@.a#
    #########
  EOMAP1

  MAP2 = <<~EOMAP2
    ########################
    #f.D.E.e.C.b.A.@.a.B.c.#
    ######################.#
    #d.....................#
    ########################
  EOMAP2

  MAP3 = <<~EOMAP3
    ########################
    #...............b.C.D.f#
    #.######################
    #.....@.a.B.c.d.A.e.F.g#
    ########################
  EOMAP3

  MAP4 = <<~EOMAP4
    ########################
    #@..............ac.GI.b#
    ###d#e#f################
    ###A#B#C################
    ###g#h#i################
    ########################
  EOMAP4

  READ1 = [
    ['#', '#', '#', '#', '#', '#', '#', '#', '#'],
    ['#', 'b', '.', 'A', '.', '@', '.', 'a', '#'],
    ['#', '#', '#', '#', '#', '#', '#', '#', '#']
  ].freeze

  def test_init
    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP1)
    assert_equal(READ1, mwi.map)

    assert_equal([5, 1], mwi.entrance)

    assert_equal([7, 1], mwi.keys['a'])
    assert_equal([1, 1], mwi.keys['b'])

    assert_equal([3, 1], mwi.doors['a'])
  end

  def test_keys_accessible_from
    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP1)
    assert_equal([['a', 2]], mwi.keys_accessible_from('@'))
    assert_equal([['b', 6]], mwi.keys_accessible_from('a', ['a']))
    assert_equal([], mwi.keys_accessible_from('b', ['a', 'b']))

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP4)
    assert_equal(
      [['a', 15], ['d', 3], ['e', 5], ['f', 7]],
      mwi.keys_accessible_from('@')
    )
    assert_equal(
      [['c', 1], ['d', 14], ['e', 12], ['f', 10]],
      mwi.keys_accessible_from('a', ['a'])
    )
  end

  def test_collect_keys
    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP1)
    assert_equal(8, mwi.collect_keys)

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP2)
    assert_equal(86, mwi.collect_keys)

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP3)
    assert_equal(132, mwi.collect_keys)

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP4)
    assert_equal(81, mwi.collect_keys)
  end
end
