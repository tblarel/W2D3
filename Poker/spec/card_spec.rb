require 'card'

describe Card do
  subject(:card) { Card.new(4, :hearts) }
  describe "#initialize" do
    it "initializes a single card with a value and suit" do 
      expect(card.value).to eq(4)
      expect(card.suit).to eq(:hearts)
    end

    it "expects initializing a card to not raise an error" do
      expect{ Card.new(5, :diamonds) }.to_not raise_error
    end

    
  end
end