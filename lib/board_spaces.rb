class BoardSpaces
  def initialize(board)
    @board = board
  end

  def winning_spaces
    lines.find { |line| winning_line?(line) } || []
  end

  private

  def winning_line?(line)
    first_value = @board.get_mark(line.first)
    !first_value.empty? && line.all? { |space| @board.get_mark(space) == first_value }
  end

  def lines
    rows + cols + diagonals
  end

  def rows
    (1..@board.size).each_slice(@board.dimension).to_a
  end

  def cols
    rows.transpose
  end

  def diagonals
    [left_to_right, right_to_left]
  end

  def left_to_right
    first_space = 1
    last_space = @board.size
    distance_between_spaces = @board.dimension + 1
    range_array(first_space, last_space, distance_between_spaces)
  end

  def right_to_left
    first_space = @board.dimension
    last_space = @board.size - @board.dimension + 1
    distance_between_spaces = @board.dimension - 1
    range_array(first_space, last_space, distance_between_spaces)
  end

  def range_array(first_space, last_space, distance_between_spaces)
    (first_space..last_space).step(distance_between_spaces).to_a
  end
end
