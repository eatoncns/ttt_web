class WebGame
  def initialize(game)
    @game = game
  end

  def advance(params)
    move = params[:move].to_i
    @game.player_chooses(move)
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
end
