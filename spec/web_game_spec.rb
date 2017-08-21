require 'web_game'

RSpec.describe WebGame do
  let(:game) { double("Game", { :take_turn => nil, :player_chooses => nil, :over? => false }) }
  let(:web_game) { WebGame.new(game, "hvh") }

  describe "#advance" do
    context "when mode is human vs human" do
      it "makes move in input" do
        expect(game).to receive(:player_chooses).with(3)
        web_game.advance(:move => "3")
      end
      
      it "does not take another turn" do
        expect(game).to_not receive(:take_turn)
        web_game.advance(:move => "3")
      end
    end

    context "when mode is human vs computer" do
      let(:web_game) { WebGame.new(game, "hvc") }

      it "makes move in input" do
        expect(game).to receive(:player_chooses).with(3)
        web_game.advance(:move => "3")
      end

      it "makes computer move as well" do
        expect(game).to receive(:take_turn)
        web_game.advance(:move => 3)
      end
    end
  end

  describe "#next_page" do
    context "when game is not over" do
      it "returns /game" do
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
