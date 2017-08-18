require 'ttt_core'
require_relative 'web_player'

module GameMode
  
  def GameMode.configure()
    board = TttCore::Board.new
    player_one = WebPlayer.new("X")
    player_two = WebPlayer.new("O")
    return TttCore::Game.new(board, player_one, player_two)
  end

end
