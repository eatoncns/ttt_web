require 'web_game'
require 'game_mode'

RSpec.describe WebGame do
  let(:mode) { GameMode.new("hvh") }

  describe ".configure" do
    it "configures game with empty board" do
      game = WebGame.configure(mode)
      board = game.board
      expect(board.empty_spaces().length).to eq board.size
    end

    def configure(params_mode)
      mode = GameMode.new("mode" => params_mode)
      WebGame.configure(mode)
    end

    context "when mode is human vs human" do
      let(:game) { configure("hvh") }

      it "configures game with web players" do
        expect(game.current_player).to be_a WebPlayer
        expect(game.next_player).to be_a WebPlayer
      end

      it "configures X to play first" do
        expect(game.current_player.mark).to eq "X" 
      end

      it "configures O to play second" do
        expect(game.next_player.mark).to eq "O"
      end

      it "sets game mode" do
        expect(game.mode).to_not be nil 
      end
    end

    context "when mode is human vs computer" do
      let(:game) { configure("hvc") }

      it "configures game with appropriate players" do
        expect(game.current_player).to be_a WebPlayer
        expect(game.next_player).to be_a TttCore::Computer
      end
      
      it "sets game mode" do
        expect(game.mode).to_not be nil
      end
    end
    
    context "when mode is computer vs human" do
      let(:game) { configure("cvh") }

      it "takes intiial computer turn" do
        expect(game.current_player).to be_a WebPlayer
        expect(game.next_player).to be_a TttCore::Computer
      end
      
      it "sets game mode" do
        expect(game.mode).to_not be nil
      end
    end
  end

  let(:game) { double("Game", { :take_turn => nil, :player_chooses => nil, :over? => false }) }
  let(:web_game) { WebGame.new(game, mode) }

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
      let(:web_game) { WebGame.new(game, GameMode.new("mode" => "hvc")) }

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
