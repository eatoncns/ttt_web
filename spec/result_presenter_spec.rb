require 'result_presenter'
require 'ttt_core'

RSpec.describe ResultPresenter do
  let(:drawn_board) { TttCore::Board.from_a(["X", "X", "O", "O" ,"O", "X", "X", "X", "O"]) }
  let(:winning_board) { TttCore::Board.from_a(["X", "X", "X", "O" ,"O", "", "", "", ""]) }

  describe "#message" do
    context "with a drawn board" do
      it "returns appropriate message" do
        result_presenter = ResultPresenter.new(drawn_board)
        expect(result_presenter.message).to eq "It's a draw!"
      end
    end

    context "with a winning board" do
      it "returns appropriate message" do
        result_presenter = ResultPresenter.new(winning_board)
        expect(result_presenter.message).to eq "X wins. Congratulations!"
      end
    end
  end

  describe "#bgcolor" do
    let(:result_presenter) { ResultPresenter.new(winning_board) }

    it "returns green for winning space" do
      expect(result_presenter.bgcolor(2)).to eq "green"
    end

    it "returns empty string for non-winning space" do
      expect(result_presenter.bgcolor(4)).to eq ""
    end
  end
end
