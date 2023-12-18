require 'pry'

VALUES = File.read("./input2.txt")

# 1814676 -> too high
class ParseValues
  def initialize(values)
    @values = values
  end

  def call
    games =  @values.split("\n").map do |row|
      game = Game.new(row)
      pp game.to_h
      game
    end
    # puts games.select(&:possible?).sum(&:id)
    puts games.sum(&:power)
  end
end

class Game
  def initialize(row)
    @row = row
  end

  def id
    /(?:Game )(?<int>\d+)/.match(row)[:int].to_i
  end

  def red
    results.map do |result|
      match = /(?<red>\d+) red/m.match(result)
      next 0 if match.nil?

      match[:red].to_i
    end
  end

  def green
    results.map do |result|
      match = /(?<green>\d+) green/m.match(result)
      next 0 if match.nil?

      match[:green].to_i
    end
  end

  def blue
    results.map do |result|
      match = /(?<blue>\d+) blue/m.match(result)
      next 0 if match.nil?

      match[:blue].to_i
    end
  end

  # 12 red cubes, 13 green cubes, and 14 blue cubes
  def possible?
    red.all? { |count| count <= 12 } &&
      green.all? { |count| count <= 13 } &&
      blue.all? { |count| count <= 14 }
  end

  # The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
  def power
    red.max * green.max * blue.max
  end

  def to_h
    {
      id:,
      red:,
      green:,
      blue:,
      power:
    }
  end

  def results
    row.split(";")
  end
  attr_reader :row
end
ParseValues.new(VALUES).call
