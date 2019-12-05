# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'rubygems'
require 'bundler/setup'

require 'aoc2019/day'

module AOC2019
  INPUT_DIR = ::File.expand_path('../etc', __dir__)

  DAY_MAP = [
    nil,
    'rocket_equation',
    'program_alarm',
    'crossed_wires',
    'secure_container'
  ].freeze

  def self.class_from_day(day)
    class_name = day.split('_').map(&:capitalize).join
    class_path = "AOC2019::#{class_name}"
    class_path.split('::').reduce(Object) { |o, c| o.const_get c }
  end
end
