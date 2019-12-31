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

  MAP5 = <<~EOMAP5
    #######
    #a.#Cd#
    ##...##
    ##.@.##
    ##...##
    #cB#Ab#
    #######
  EOMAP5

  MAP6 = <<~EOMAP6
    ###############
    #d.ABC.#.....a#
    ######...######
    ######.@.######
    ######...######
    #b.....#.....c#
    ###############
  EOMAP6

  MAP7 = <<~EOMAP7
    #############
    #g#f.D#..h#l#
    #F###e#E###.#
    #dCba...BcIJ#
    #####.@.#####
    #nK.L...G...#
    #M###N#H###.#
    #o#m..#i#jk.#
    #############
  EOMAP7

  READ1 = [
    ['#', '#', '#', '#', '#', '#', '#', '#', '#'],
    ['#', 'b', '.', 'A', '.', '@', '.', 'a', '#'],
    ['#', '#', '#', '#', '#', '#', '#', '#', '#']
  ].freeze

  CONV5 = [
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', 'a', '.', '#', 'C', 'd', '#'],
    ['#', '#', '@', '#', '@', '#', '#'],
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', '#', '@', '#', '@', '#', '#'],
    ['#', 'c', 'B', '#', 'A', 'b', '#'],
    ['#', '#', '#', '#', '#', '#', '#']
  ].freeze

  def test_init
    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP1)
    assert_equal(READ1, mwi.map)

    assert_equal([5, 1], mwi.entrance['@0'])

    assert_equal([7, 1], mwi.keys['a'])
    assert_equal([1, 1], mwi.keys['b'])

    assert_equal([3, 1], mwi.doors['a'])
  end

  def test_update_map
    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP5)
    mwi.update_map

    assert_equal(CONV5, mwi.map)
    assert_equal([2, 2], mwi.entrance['@0'])
    assert_equal([4, 4], mwi.entrance['@3'])
  end

  def test_keys_accessible_from
    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP1)
    assert_equal([[0, 'a', 2]], mwi.keys_accessible_from(['@0']))
    assert_equal([[0, 'b', 6]], mwi.keys_accessible_from(['a'], ['a']))
    assert_equal([], mwi.keys_accessible_from(['b'], ['a', 'b']))

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP4)
    assert_equal(
      [[0, 'a', 15], [0, 'd', 3], [0, 'e', 5], [0, 'f', 7]],
      mwi.keys_accessible_from(['@0'])
    )
    assert_equal(
      [[0, 'c', 1], [0, 'd', 14], [0, 'e', 12], [0, 'f', 10]],
      mwi.keys_accessible_from(['a'], ['a'])
    )

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP5)
    mwi.update_map
    assert_equal(
      [[0, 'a', 2]],
      mwi.keys_accessible_from(['@0', '@1', '@2', '@3'])
    )
    assert_equal(
      [[3, 'b', 2]],
      mwi.keys_accessible_from(['@0', '@1', '@2', '@3'], ['a'])
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

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP5)
    mwi.update_map
    assert_equal(8, mwi.collect_keys(['@0', '@1', '@2', '@3']))

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP6)
    mwi.update_map
    assert_equal(24, mwi.collect_keys(['@0', '@1', '@2', '@3']))

    mwi = ::AOC2019::ManyWorldsInterpretation.new(MAP7)
    mwi.update_map
    assert_equal(72, mwi.collect_keys(['@0', '@1', '@2', '@3']))
  end
end
