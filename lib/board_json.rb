require 'json'

class BoardJson
  def self.encode(board)
    marks = []
    (1..board.size).each {|space| marks << board.get_mark(space)}
    JSON.generate({:dimension => board.dimension, :marks => marks, :game_over => board.game_over?})
  end
end
