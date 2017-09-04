require 'board_json'
require 'ttt_core'

RSpec.describe BoardJson do
  describe "#encode" do
    it "encodes board state as JSON" do
      board = TttCore::Board.from_a(["X", "", "", "O", "", "X", "", "", ""])
      expected_json = "{\"dimension\":3,\"marks\":[\"X\",\"\",\"\",\"O\",\"\",\"X\",\"\",\"\",\"\"],\"game_over\":false}"
      expect(BoardJson.encode(board)).to eq expected_json
    end
  end

  describe "#encode_result" do
    it "encodes result as JSON" do
      board = TttCore::Board.from_a(["X", "X", "X", "O", "O", "", "", "", ""])
      expected_json = "{\"drawn\":false,\"winning_mark\":\"X\",\"winning_spaces\":[1,2,3]}"
      expect(BoardJson.encode_result(board)).to eq expected_json
    end
  end
end
