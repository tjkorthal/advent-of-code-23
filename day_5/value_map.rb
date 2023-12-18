# frozen_string_literal: true

class ValueMap
  attr_reader :dest_start, :source_start, :range_length, :source_end

  # destination range start, the source range start, and the range length.
  def initialize(dest_start, source_start, range_length)
    @dest_start = dest_start
    @source_start = source_start
    @source_end = source_start + range_length - 1
  end

  def includes?(value)
    value >= source_start && value <= source_end
  end

  def convert(value)
    return nil unless includes?(value)

    value - offset
  end

  def offset
    source_start - dest_start
  end
end
