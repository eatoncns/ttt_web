require 'ttt_core'
require_relative 'web_player'
require_relative 'web_game'

module GameMode
  
  def GameMode.configure()
    board = TttCore::Board.new
    player_one = WebPlayer.new("X")
    player_two = WebPlayer.new("O")
    core_game = TttCore::Game.new(board, player_one, player_two)
    return WebGame.new(core_game)
  end

end
