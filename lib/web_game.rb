class WebGame
  attr_reader :mode

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
      @mode.include?("c") && !@game.over?
    end
end
