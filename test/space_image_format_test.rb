# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/space_image_format'

class AOC2019::SpaceImageFormatTest < Minitest::Test
  TEST_DATA = '123456789012'

  def setup
    @sif = ::AOC2019::SpaceImageFormat.new
  end

  def test_image_layers
    assert_equal(
      [[1, 2, 3, 4, 5, 6], [7, 8, 9, 0, 1, 2]],
      @sif.image_layers(TEST_DATA, 3, 2)
    )
  end

  def test_image_checksum
    image = @sif.image_layers(TEST_DATA, 3, 2)
    assert_equal(1, @sif.image_checksum(image))
  end
end
