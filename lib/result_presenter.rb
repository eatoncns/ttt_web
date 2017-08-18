class ResultPresenter
  def initialize(board)
    @board = board
  end

  def message
    if @board.drawn?
      "It's a draw!"
    else
      "#{@board.winning_mark} wins. Congratulations!"
    end
  end
end
