# Advent of Code 2019
## Robert Haines

My attempt at doing [Advent of Code 2019](http://adventofcode.com/2019) in Ruby, with tests and all the trimmings.

[![Build Status](https://travis-ci.org/hainesr/aoc-2019.svg?branch=master)](https://travis-ci.org/hainesr/aoc-2019)
[![Maintainability](https://api.codeclimate.com/v1/badges/c5309e30ce5c9f6ed043/maintainability)](https://codeclimate.com/github/hainesr/aoc-2019/maintainability)

### Usage

After cloning, and changing into the `aoc-2019` directory, run:

```shell
$ gem install bundler
$ bundle install
$ rake
```

This will set everything up and run all the tests.

To run the solution for a particular day:

```shell
$ ./aoc-2019 <day>
```

Or via `rake`:

```shell
$ rake run <day>
```

You can run multiple days like this:

```shell
$ rake run <day_1> <day_2> ... <day_n>
```

### Licence

[Public Domain](http://unlicense.org).
