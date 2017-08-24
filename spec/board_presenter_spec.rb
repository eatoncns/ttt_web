require 'board_presenter'

RSpec.describe BoardPresenter do
  let(:board) { double("Board", { :get_mark => "" }) }
  let(:presenter) { BoardPresenter.new(board) }
  let(:space) { 3 }

  describe "#mark" do
    it "forwards to board" do
      expect(board).to receive(:get_mark).with(space)
      expect(presenter.mark(space)).to eq board.get_mark(space)
    end
  end

  describe "#disabled" do
    context "when space is empty" do
      it "returns empty string" do
        expect(presenter.disabled(space)).to eq ""
      end
    end

    context "when space is not empty" do
      it "returns disabled string" do
        allow(board).to receive(:get_mark).with(space).and_return("X")
        expect(presenter.disabled(space)).to eq "disabled"
      end
    end
  end
end
