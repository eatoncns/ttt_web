require 'ttt_core'
require_relative 'web_player'
require_relative 'web_game'

module GameMode
  
  def GameMode.configure(params)
    mode = params["mode"]
    player_one, player_two = configure_players(mode)
    board = TttCore::Board.new
    core_game = TttCore::Game.new(board, player_one, player_two)
    WebGame.new(core_game, mode)
  end

  def GameMode.configure_players(mode)
    player_one = WebPlayer.new("X")
    if mode == "hvh" then
      player_two = WebPlayer.new("O")
    else
      player_two = TttCore::Computer.new("O")
    end
    [player_one, player_two]
  end

end
