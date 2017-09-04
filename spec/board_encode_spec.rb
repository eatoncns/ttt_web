require 'board_encode'
require 'ttt_core'

RSpec.describe BoardEncode do
  describe "#as_json" do
    it "encodes board state as JSON" do
      board = TttCore::Board.from_a(["X", "", "", "O", "", "X", "", "", ""])
      expected_json = "{\"dimension\":3,\"marks\":[\"X\",\"\",\"\",\"O\",\"\",\"X\",\"\",\"\",\"\"],\"game_over\":false}"
      expect(BoardEncode.as_json(board)).to eq expected_json
    end
  end

  describe "#result_as_json" do
    it "encodes result as JSON" do
      board = TttCore::Board.from_a(["X", "X", "X", "O", "O", "", "", "", ""])
      expected_json = "{\"drawn\":false,\"winning_mark\":\"X\",\"winning_spaces\":[1,2,3]}"
      expect(BoardEncode.result_as_json(board)).to eq expected_json
    end
  end
end
