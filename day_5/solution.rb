require 'pry'
require_relative 'almanac'

VALUES = File.read('./input.txt')

class ParseValues
  def initialize(values)
    @values = values.split("\n\n")
    @seeds ||= @values.shift.delete('seeds:').split(' ')
  end

  def call
    min_location = seeds.map do |seed_number|
      location_number = almanac.seed_to_location(seed_number.to_i)
      pp [seed_number, location_number]
      location_number
    end.min

    pp min_location
  end

  private

  attr_reader :values, :seeds

  def almanac
    return @almanac if instance_variable_defined?(:@almanac)

    hash = values.map do |value|
      label, value = value.split(":\n")
      [label, value.split("\n")]
    end.to_h

    @almanac = Almanac.new(hash)
  end
end

ParseValues.new(VALUES).call
