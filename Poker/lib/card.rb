class Card
  attr_reader :value, :suit
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    case value
    when 1
      return "A#{suit}"
    when 2..10
      return "#{value}#{suit}"
    when 11
      return "J#{suit}"
    when 12
      return "Q#{suit}"
    when 13
      return "K#{suit}"
    end
  end
end