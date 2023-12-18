require 'pry'

VALUES = File.read("./input1.txt")

class ParseValues
  WORDS = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
  ]
  FIRST_REGEX = /(zero|one|two|three|four|five|six|seven|eight|nine|\d)/
  LAST_REGEX = /(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|orez|\d)/

  def initialize(values)
    @values = values
  end

  def call
    parsed_values = values.split("\n").map do |row|
      parse_value(row)
    end
    puts "Sum: #{parsed_values.sum}"
  end

  private

  attr_reader :values

  def parse_value(row)
    matches = row.scan(FIRST_REGEX).flatten
    first = WORDS.index(matches.first) || matches.first.to_i
    matches = row.reverse.scan(LAST_REGEX).flatten
    last = WORDS.index(matches.first.reverse) || matches.first.to_i
    "#{first}#{last}".to_i
  end
end

ParseValues.new(VALUES).call
