
class Player
  def initialize(name, deck, game)
    @name = name
    cards = new_round_get_cards
    @hand = Hand.new(cards)
    @pot = 100
    @deck = deck
    @game = game
  end

  def new_round_get_cards
    5.times do 
      card = @deck.cards.sample
      @deck.cards.delete(card)
      @hand << card
    end
  end

  def discard_cards(*cards)
    cards.each do |card|
      @hand.cards.delete(card)
      new_card = @deck.cards.sample
      @deck.cards.delete(new_card)
      @hand.cards << new_card
    end
  end

  def prompt_move
    puts "Would you like to [c]all, [r]aise, or [f]old?"
    input = gets.chomp.downcase
    case input
    when "c"
      # ask game if there is a bet to call or if this is just a check
      # check if @current_pot = ante * #active_players
      # if call, ensure user's pot >= call 
    when "r"
      # prompt user again and get value, make sure user's pot >= raise
    when "f"
      # remove current player from active players for the current round
    end
  end

end