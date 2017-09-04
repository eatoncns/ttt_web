require 'json'
require_relative 'board_spaces'

class BoardJson
  def self.encode(board)
    marks = []
    (1..board.size).each {|space| marks << board.get_mark(space)}
    JSON.generate({:dimension => board.dimension,
                   :marks => marks,
                   :game_over => board.game_over?})
  end

  def self.encode_result(board)
    board_spaces = BoardSpaces.new(board)
    JSON.generate({:drawn => board.drawn?,
                   :winning_mark => board.winning_mark,
                   :winning_spaces => board_spaces.winning_spaces})
  end
end
