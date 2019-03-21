require 'singleton'

class Deck
  include Singleton
  def initialize
    @cards = Array.new(52)
    52.times do |i|
      case i
      when 0..12
        @cards << Card.new(i+1, :spades) 
      when 13..25
        @cards << Card.new((i%13)+1, :hearts)
      when 26..38
        @cards << Card.new((i%13)+1, :clubs)
      when 39..52
        @cards << Card.new((i%13)+1, :diamonds)
      end
    end
  end
end