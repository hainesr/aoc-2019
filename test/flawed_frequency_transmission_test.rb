# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2019/flawed_frequency_transmission'

class AOC2019::FlawedFrequencyTransmissionTest < Minitest::Test
  BIG1 = '80871224585914546619083218645595'
  BIG2 = '19617804207202209144916044189917'
  BIG3 = '69317163492948606335995924319873'

  def setup
    @fft = ::AOC2019::FlawedFrequencyTransmission.new
  end

  def test_base_digit
    assert_equal(1, @fft.base_digit(1, 1))
    assert_equal(0, @fft.base_digit(1, 2))
    assert_equal(0, @fft.base_digit(2, 1))
  end

  def test_fft
    assert_equal('48226158', @fft.fft('12345678', 1))
    assert_equal('24176176', @fft.fft(BIG1, 100)[0..7])
    assert_equal('73745418', @fft.fft(BIG2, 100)[0..7])
    assert_equal('52432133', @fft.fft(BIG3, 100)[0..7])
  end

  def test_upper_fft
    assert_equal(
      '84462026', @fft.upper_fft('03036732577212944063491565474664', 100)
    )
    assert_equal(
      '78725270', @fft.upper_fft('02935109699940807407585447034323', 100)
    )
    assert_equal(
      '53553731', @fft.upper_fft('03081770884921959731165446850517', 100)
    )
  end
end
