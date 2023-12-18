require 'pry'

VALUES = File.read("./input4.txt")

class ParseValues
  def initialize(values)
    @values = values.split("\n")
  end

  def call
    cards =
      values.map.with_index do |row, index|
        card = Card.new(row, index + 1)
        card
      end

    cards.each do |card|
      card.cards_won.each do |card_number|
        card_count[card_number] += card_count[card.number]
      end
    end
    pp card_count.values.sum
  end

  private

  attr_reader :values

  def card_count
    @card_count ||=
      values.map.with_index do |_, index|
        [index + 1, 1]
      end.to_h
  end
end

class Card
  attr_reader :winning_numbers, :revealed_numbers, :number

  def initialize(row, number)
    @number = number
    numbers = row.split(":")[1].split("|")
    @winning_numbers = numbers[0].split(" ")
    @revealed_numbers = numbers[1].split(" ")
  end

  def matches
    revealed_numbers.keep_if { |number| winning_numbers.include?(number) }
  end

  def points
    return 0 if matches.none?

    total = 1
    (matches.count - 1).times { total *= 2 }

    total
  end

  def cards_won
    return [] if matches.none?

    matches.map.with_index do |_match, index|
      number + 1 + index
    end
  end
end

ParseValues.new(VALUES).call
