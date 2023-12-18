# frozen_string_literal: true

require "rspec"
require_relative '../value_map'

RSpec.describe ValueMap do
  describe "#includes?" do
    it "returns true if the value is in range" do
      map = described_class.new(50, 98, 2)

      expect(map.includes?(98)).to be(true)
      expect(map.includes?(99)).to be(true)
    end

    it "returns false if the value is out of range" do
      map = described_class.new(50, 98, 2)

      expect(map.includes?(97)).to be(false)
      expect(map.includes?(100)).to be(false)
      expect(map.includes?(101)).to be(false)
      expect(map.includes?(-1)).to be(false)
    end
  end

  describe "#convert" do
    it "returns nil if out of range" do
      map = described_class.new(50, 98, 2)

      expect(map.convert(10)).to be(nil)
    end

    it "returns the converted value" do
      map = described_class.new(50, 98, 2)

      expect(map.convert(98)).to be(50)
      expect(map.convert(99)).to be(51)
    end

    it "returns the converted value" do
      map = described_class.new(98, 50, 2)

      expect(map.convert(50)).to be(98)
      expect(map.convert(51)).to be(99)
    end
  end

  describe "#offset" do
    it "returns the difference between the destination and source" do
      map = described_class.new(50, 98, 2)

      expect(map.offset).to be(48)
    end
  end
end
