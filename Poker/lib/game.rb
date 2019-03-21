class Game
  attr_reader :deck, :active_players, :players, :current_pot, :current_player, :current_dealer
  
  def initialize(*players)
    @deck = Deck.new
    @players = players.map { |player| Player.new(player, @deck, self)}
    @current_pot = 0
    @active_players = @players
    @current_dealer = @players[-1]
    @current_player = @players[0]
  end








end