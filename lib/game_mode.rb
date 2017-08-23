require 'ttt_core'
require_relative 'web_player'

class GameMode
 
  Computer = TttCore::Computer
  Human = WebPlayer

  attr_reader :player_one_type
  attr_reader :player_two_type

  def initialize(params)
    mode = params["mode"] || "hvh"
    initialize_player_types(mode)
  end

  def initialize_player_types(mode)
    mode_first, mode_second = mode.split("v")
    @player_one_type = type_from_mode(mode_first)
    @player_two_type = type_from_mode(mode_second)
  end

  def type_from_mode(mode)
    if mode == "c"
      return Computer
    end
    Human 
  end

  def computer_first?
    @player_one_type == Computer
  end

  def has_computer?
    @player_one_type == Computer || @player_two_type == Computer
  end 
  
end
