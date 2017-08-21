class BoardPresenter
  def initialize(board)
    @board = board
  end

  def rows
    @board.space_rows
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
