# frozen_string_literal: true

require_relative 'value_map'
require_relative 'navigator'

class Almanac
  attr_reader :hash, :seeds

  def initialize(hash)
    @hash = hash
  end

  def seed_to_location(seed_number)
    soil_number = Navigator.new(seed_to_soil_map).lookup(seed_number)
    fertilizer_number = Navigator.new(soil_to_fertilizer_map).lookup(soil_number)
    water_number = Navigator.new(fertilizer_to_water_map).lookup(fertilizer_number)
    light_number = Navigator.new(water_to_light_map).lookup(water_number)
    temperature_number = Navigator.new(light_to_temperature_map).lookup(light_number)
    humidity_number = Navigator.new(temperature_to_humidity_map).lookup(temperature_number)
    _location_number = Navigator.new(humidity_to_location_map).lookup(humidity_number)
  end

  def seed_to_soil_map
    @seed_to_soil_map ||= build_map("seed-to-soil map")
  end

  def soil_to_fertilizer_map
    @soil_to_fertilizer_map ||= build_map("soil-to-fertilizer map")
  end

  def fertilizer_to_water_map
    @fertilizer_to_water_map ||= build_map("fertilizer-to-water map")
  end

  def water_to_light_map
    @water_to_light_map ||= build_map("water-to-light map")
  end

  def light_to_temperature_map
    @light_to_temperature_map ||= build_map("light-to-temperature map")
  end

  def temperature_to_humidity_map
    @temperature_to_humidity_map ||= build_map("temperature-to-humidity map")
  end

  def humidity_to_location_map
    @humidity_to_location_map ||= build_map("humidity-to-location map")
  end

  private

  def build_map(label)
    hash[label].map do |mapping|
      dest_start, source_start, range_length = mapping.split(' ')
      ValueMap.new(dest_start.to_i, source_start.to_i, range_length.to_i)
    end.sort_by(&:source_start)
  end
end
