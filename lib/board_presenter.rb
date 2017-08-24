require_relative 'board_spaces'

class BoardPresenter
  def initialize(board)
    @board = board
    @board_spaces = BoardSpaces.new(@board)
  end

  def rows
    @board_spaces.space_rows
  end

  def mark(space)
    @board.get_mark(space)
  end

  def disabled(space)
    if mark(space).empty?()
      ""
    else
      "disabled"
    end
  end
end
