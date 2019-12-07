# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/crossed_wires'

class AOC2019::CrossedWiresTest < Minitest::Test
  STEPS = [
    ['R8', 'U5', 'L5', 'D3'],
    ['U7', 'R6', 'D4', 'L4']
  ].freeze

  PATHS = [
    ['1,0', '2,0', '3,0', '4,0', '5,0', '6,0', '7,0', '8,0', '8,1', '8,2',
     '8,3', '8,4', '8,5', '7,5', '6,5', '5,5', '4,5', '3,5', '3,4', '3,3',
     '3,2'],
    ['0,1', '0,2', '0,3', '0,4', '0,5', '0,6', '0,7', '1,7', '2,7', '3,7',
     '4,7', '5,7', '6,7', '6,6', '6,5', '6,4', '6,3', '5,3', '4,3', '3,3',
     '2,3']
  ].freeze

  TEST_WIRES = [
    [
      "R75,D30,R83,U83,L12,D49,R71,U7,L72\n" \
      'U62,R66,U55,R34,D71,R55,D58,R83',
      159, 610
    ], [
      "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\n" \
      'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7',
      135, 410
    ]
  ].freeze

  def setup
    @cw = ::AOC2019::CrossedWires.new
  end

  def test_generate_path
    assert_equal(PATHS[0], @cw.generate_path(STEPS[0]))
    assert_equal(PATHS[1], @cw.generate_path(STEPS[1]))
  end

  def test_closest_intersection
    TEST_WIRES.each do |steps, closest, _|
      input = steps.split("\n").map { |line| line.split(',') }
      wire1 = @cw.generate_path(input[0])
      wire2 = @cw.generate_path(input[1])
      intersections = (wire1.to_set & wire2.to_set).to_a
      assert_equal(closest, @cw.closest_intersection(intersections))
    end
  end

  def test_shortest_intersection
    TEST_WIRES.each do |steps, _, shortest|
      input = steps.split("\n").map { |line| line.split(',') }
      wire1 = @cw.generate_path(input[0])
      wire2 = @cw.generate_path(input[1])
      intersections = (wire1.to_set & wire2.to_set).to_a
      assert_equal(
        shortest,
        @cw.shortest_intersection(wire1, wire2, intersections)
      )
    end
  end
end
