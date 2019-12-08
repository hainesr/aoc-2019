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
      puts 'Part 2:'
      image_output(image_render(image), 25, 6)
    end

    def image_output(image, w, _)
      image.each_slice(w) do |line|
        puts line.map { |l| l.zero? ? ' ' : '#' }.join
      end
    end

    def image_render(image)
      result = image[0]

      image[1..-1].each do |layer|
        layer.each_with_index do |p, i|
          result[i] = p if result[i] == 2
        end
      end

      result
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
