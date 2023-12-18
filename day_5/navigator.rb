# frozen_string_literal: true
class Navigator
  attr_reader :maps

  def initialize(maps)
    @maps = maps
  end

  def lookup(number)
    map_to_use = maps.find do |map|
      map.includes?(number)
    end

    return number if map_to_use.nil?

    map_to_use.convert(number)
  end
end
