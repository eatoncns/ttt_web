require 'ttt_core'
require_relative 'web_player'
require_relative 'web_game'

module GameMode
  
  def GameMode.configure(params)
    mode = params["mode"] || "hvh"
    player_one, player_two = configure_players(mode)
    board = TttCore::Board.new
    core_game = TttCore::Game.new(board, player_one, player_two)
    WebGame.new(core_game, mode)
  end

  def GameMode.configure_players(mode)
    mode_first, mode_second = mode.split("v")
    player_one = player_from_mode(mode_first).new("X")
    player_two = player_from_mode(mode_second).new("O")
    [player_one, player_two]
  end

  def GameMode.player_from_mode(mode)
    if mode == "h"
      return WebPlayer
    end
    TttCore::Computer
  end
end
