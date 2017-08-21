require 'web_game'

RSpec.describe WebGame do
  let(:game) { double("Game") }
  let(:web_game) { WebGame.new(game) }

  describe "#advance" do
    it "makes move in input" do
      expect(game).to receive(:player_chooses).with(3)
      web_game.advance(:move => "3")
    end
  end

  describe "#next_page" do
    context "when game is not over" do
      it "returns /game" do
        allow(game).to receive(:over?).and_return(false)
        expect(web_game.next_page()).to eq "/game"
      end
    end

    context "when game is over" do
      it "returns /result" do
        allow(game).to receive(:over?).and_return(true)
        expect(web_game.next_page()).to eq "/result"
      end
    end
  end
end
