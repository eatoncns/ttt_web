require 'result_presenter'
require 'ttt_core'

RSpec.describe ResultPresenter do
  describe "#message" do
    context "with a drawn board" do
      it "returns appropriate message" do
        board = TttCore::Board.from_a(["X", "X", "O", "O" ,"O", "X", "X", "X", "O"])
        result_presenter = ResultPresenter.new(board)
        expect(result_presenter.message).to eq "It's a draw!"
      end
    end
  end

  describe "#message" do
    context "with a won board" do
      it "returns appropriate message" do
        board = TttCore::Board.from_a(["X", "X", "X", "O" ,"O", "", "", "", ""])
        result_presenter = ResultPresenter.new(board)
        expect(result_presenter.message).to eq "X wins. Congratulations!"
      end
    end
  end
end
