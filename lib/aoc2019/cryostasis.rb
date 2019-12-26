# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'
require_relative 'common/intcode_computer'

module AOC2019
  class Cryostasis < Day
    COMMANDS = [
      'w', 's', 'take polygon',
      'n', 'e', 'n', 'w', 'take boulder',
      'e', 'n', 'take manifold',
      'w', 's', 'e', 's', 'take fixed point',
      'n', 'w', 'n', 'n', 'e', 'e', 'n', 'x'
    ].freeze

    def run
      computer = Common::IntcodeComputer.new(read_input_file)
      puts "Part 1: #{repl(computer, COMMANDS.dup)}"
    end

    def repl(computer, commands = [], save = false)
      history = []
      input = []
      interactive = commands.empty?

      loop do
        prompt = computer.run(input).map(&:chr).join
        puts prompt if interactive
        input = interactive ? STDIN.gets.chomp : commands.shift

        input = case input
                when 'x'
                  break if interactive

                  return prompt.scan(/\d+/).first
                when 'n'
                  'north'
                when 'e'
                  'east'
                when 's'
                  'south'
                when 'w'
                  'west'
                else
                  input
                end

        history << input
        input = input.chars.map(&:ord) << 10
      end

      save(history) if save
    end

    def save(history)
      filename = "#{class_snake_case}.save"
      filename = ::File.join(INPUT_DIR, filename)
      puts "Saving game to: #{filename}"

      ::File.open(filename, 'w') do |file|
        history.each { |line| file.write(line + "\n") }
      end
    end
  end
end
