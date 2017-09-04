require 'board_json'
require 'ttt_core'

RSpec.describe BoardJson do
  it "encodes board state as JSON" do
    board = TttCore::Board.from_a(["X", "", "", "O", "", "X", "", "", ""])
    expected_json = "{\"dimension\":3,\"marks\":[\"X\",\"\",\"\",\"O\",\"\",\"X\",\"\",\"\",\"\"]}"    
    expect(BoardJson.encode(board)).to eq expected_json
  end
end
