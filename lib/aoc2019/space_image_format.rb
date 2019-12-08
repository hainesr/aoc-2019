# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class SpaceImageFormat < Day
    def run
      data = read_input_file.chomp
      image = image_layers(data, 25, 6)

      puts "Part 1: #{image_checksum(image)}"
    end

    def image_checksum(image)
      layer = image.dup.sort_by! { |l| l.count(0) }.first
      layer.count(1) * layer.count(2)
    end

    def image_layers(data, w, h)
      size = w * h
      data.split('').map(&:to_i).each_slice(size).to_a
    end
  end
end
