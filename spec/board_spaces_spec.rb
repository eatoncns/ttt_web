require 'board_spaces'
require 'ttt_core'

RSpec.describe BoardSpaces do
  describe "#space_rows" do
    it "returns spaces making up rows" do
      board = TttCore::Board.new
      board_spaces = BoardSpaces.new(board)
      expect(board_spaces.space_rows().to_a).to eq [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    end
  end
  
  describe "#winning_spaces" do

    context "given board with winning row" do
      let(:board) { TttCore::Board.from_a(["X", "X", "X",
                                           "O", "O", "",
                                           "", "", ""]) }
      let(:board_spaces) { BoardSpaces.new(board) }

      it "should return winning row spaces" do
        expect(board_spaces.winning_spaces()).to eq [1, 2, 3]
      end
    end 

    context "given board with winning column" do
      let(:board) { TttCore::Board.from_a(["", "X", "O",
                                           "", "X", "O",
                                           "", "X", ""]) }
      let(:board_spaces) { BoardSpaces.new(board) }

      it "should return winning column spaces" do
        expect(board_spaces.winning_spaces()).to eq [2, 5, 8]

      end
    end

    context "given board with winning diagonal" do
      let(:board) { TttCore::Board.from_a(["", "O", "X",
                                           "", "X", "O",
                                           "X", "", ""]) }
      let(:board_spaces) { BoardSpaces.new(board) }

      it "should return winning column spaces" do
        expect(board_spaces.winning_spaces()).to eq [3, 5, 7]
      end
    end
    
    context "given board with no winner" do
      let(:board) { TttCore::Board.from_a(["", "O", "X",
                                           "", "X", "O",
                                           "", "", ""]) }
      let(:board_spaces) { BoardSpaces.new(board) }

      it "should return empty array" do
        expect(board_spaces.winning_spaces()).to eq []
      end
    end
  end
end
