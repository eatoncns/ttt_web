require_relative 'board_spaces'

class ResultPresenter
  def initialize(board)
    @board = board
    @board_spaces = BoardSpaces.new(@board)
  end

  def rows
    @board.space_rows()
  end

  def mark(space)
    @board.get_mark(space)
  end

  def bgcolor(space)
    if @board_spaces.winning_spaces().include?(space)
      "green"
    else
      ""
    end 
  end 

  def message
    if @board.drawn?
      "It's a draw!"
    else
      "#{@board.winning_mark} wins. Congratulations!"
    end
  end
end
