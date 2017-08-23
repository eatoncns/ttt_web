require 'ttt_core'

class WebGame
  attr_reader :mode

  def self.configure(mode)
    board = TttCore::Board.new
    player_one = mode.player_one_type.new("X")
    player_two = mode.player_two_type.new("O")
    core_game = TttCore::Game.new(board, player_one, player_two)
    if mode.computer_first?
      core_game.take_turn()
    end
    new(core_game, mode)
  end

  def initialize(game, mode)
    @game = game
    @mode = mode
  end

  def advance(params)
    move = params[:move].to_i
    @game.player_chooses(move)
    if computer_move_required?
      @game.take_turn()
    end
  end

  def next_page
    if @game.over?
      "/result"
    else
      "/game"
    end
  end

  def board
    @game.board
  end

  def current_player
    @game.current_player
  end

  def next_player
    @game.next_player
  end

  private
    def computer_move_required?
      @mode.has_computer? && !@game.over?
    end
end
