# frozen_string_literal: true

# Advent of Code 2019
#
# Robert Haines
#
# Public Domain

require 'aoc2019'

module AOC2019
  class PlanetOfDiscord < Day
    INPUT = <<~EOINPUT
      ###.#
      ..#..
      #..#.
      #....
      .#.#.
    EOINPUT

    # Which squares are adjacent to each position?
    # [z, x, y] - left, up, right, down.
    ADJ_MAP = [
      [
        [ # 0, 0
          [-1, 1, 2], [-1, 2, 1], [0, 1, 0], [0, 0, 1]
        ],
        [ # 1, 0
          [0, 0, 0], [-1, 2, 1], [0, 2, 0], [0, 1, 1]
        ],
        [ # 2, 0
          [0, 1, 0], [-1, 2, 1], [0, 3, 0], [0, 2, 1]
        ],
        [ # 3, 0
          [0, 2, 0], [-1, 2, 1], [0, 4, 0], [0, 3, 1]
        ],
        [ # 4, 0
          [0, 3, 0], [-1, 2, 1], [-1, 3, 2], [0, 4, 1]
        ]
      ],
      [
        [ # 0, 1
          [-1, 1, 2], [0, 0, 0], [0, 1, 1], [0, 0, 2]
        ],
        [ # 1, 1
          [0, 0, 1], [0, 1, 0], [0, 2, 1], [0, 1, 2]
        ],
        [ # 2, 1
          [0, 1, 1], [0, 2, 0], [0, 3, 1],
          [1, 0, 0], [1, 1, 0], [1, 2, 0], [1, 3, 0], [1, 4, 0]
        ],
        [ # 3, 1
          [0, 2, 1], [0, 3, 0], [0, 4, 1], [0, 3, 2]
        ],
        [ # 4, 1
          [0, 3, 1], [0, 4, 0], [-1, 3, 2], [0, 4, 2]
        ]
      ],
      [
        [ # 0, 2
          [-1, 1, 2], [0, 0, 1], [0, 1, 2], [0, 0, 3]
        ],
        [ # 1, 2
          [0, 0, 2], [0, 1, 1],
          [1, 0, 0], [1, 0, 1], [1, 0, 2], [1, 0, 3], [1, 0, 4],
          [0, 1, 3]
        ],
        [], # 2, 2 - MIDDLE
        [ # 3, 2
          [1, 4, 0], [1, 4, 1], [1, 4, 2], [1, 4, 3], [1, 4, 4],
          [0, 3, 1], [0, 4, 2], [0, 3, 3]
        ],
        [ # 4, 2
          [0, 3, 2], [0, 4, 1], [-1, 3, 2], [0, 4, 3]
        ]
      ],
      [
        [ # 0, 3
          [-1, 1, 2], [0, 0, 2], [0, 1, 3], [0, 0, 4]
        ],
        [ # 1, 3
          [0, 0, 3], [0, 1, 2], [0, 2, 3], [0, 1, 4]
        ],
        [ # 2, 3
          [0, 1, 3],
          [1, 0, 4], [1, 1, 4], [1, 2, 4], [1, 3, 4], [1, 4, 4],
          [0, 3, 3], [0, 2, 4]
        ],
        [ # 3, 3
          [0, 2, 3], [0, 3, 2], [0, 4, 3], [0, 3, 4]
        ],
        [ # 4, 3
          [0, 3, 3], [0, 4, 2], [-1, 3, 2], [0, 4, 4]
        ]
      ],
      [
        [ # 0, 4
          [-1, 1, 2], [0, 0, 3], [0, 1, 4], [-1, 2, 3]
        ],
        [ # 1, 4
          [0, 0, 4], [0, 1, 3], [0, 2, 4], [-1, 2, 3]
        ],
        [ # 2, 4
          [0, 1, 4], [0, 2, 3], [0, 3, 4], [-1, 2, 3]
        ],
        [ # 3, 4
          [0, 2, 4], [0, 3, 3], [0, 4, 4], [-1, 2, 3]
        ],
        [ # 4, 4
          [0, 3, 4], [0, 4, 3], [-1, 3, 2], [-1, 2, 3]
        ]
      ]
    ].freeze

    def run
      state = read(INPUT)
      puts "Part 1: #{part1(state)}"
      puts "Part 2: #{part2(state)}"
    end

    def part1(state)
      mem = [biodiversity(state)]
      loop do
        state = tick(state)
        bio = biodiversity(state)
        return bio if mem.include?(bio)

        mem << bio
      end
    end

    def part2(state)
      state_map = {}
      (-101..101).each do |i|
        state_map[i] = empty_state
      end
      state_map[0] = state

      200.times do
        state_map = tick2(state_map)
      end

      state_map.values.flatten.sum
    end

    def tick2(state)
      new_state = {
        -101 => empty_state,
        101 => empty_state
      }
      (-100..100).each do |depth|
        new_state[depth] ||= []
        (0..4).each do |y|
          new_state[depth][y] ||= []
          (0..4).each do |x|
            current = state[depth][y][x]
            adj = adjacent2(state, depth, x, y)
            new_state[depth][y][x] = if current == 1
                                       adj == 1 ? 1 : 0
                                     else
                                       [1, 2].include?(adj) ? 1 : 0
                                     end
          end
        end
      end

      new_state
    end

    def adjacent2(state, depth, x, y)
      ADJ_MAP[y][x].reduce(0) do |acc, a|
        acc + state[depth + a[0]][a[2]][a[1]]
      end
    end

    def tick(state)
      new_state = []
      (0..4).each do |y|
        new_state[y] = []
        (0..4).each do |x|
          current = state[y][x]
          adj = adjacent(state, x, y)
          new_state[y][x] = if current == 1
                              adj == 1 ? 1 : 0
                            else
                              [1, 2].include?(adj) ? 1 : 0
                            end
        end
      end

      new_state
    end

    def biodiversity(state)
      state.flatten.reverse.join.to_i(2)
    end

    def adjacent(state, x, y)
      [[x - 1, y], [x, y - 1], [x + 1, y], [x, y + 1]].delete_if do |i, j|
        i.negative? || j.negative? || i > 4 || j > 4
      end.reduce(0) { |acc, c| acc + state[c[1]][c[0]] }
    end

    def read(input)
      input.split("\n").map(&:chars).map do |line|
        line.map { |c| c == '#' ? 1 : 0 }
      end
    end

    def empty_state
      [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    end
  end
end
