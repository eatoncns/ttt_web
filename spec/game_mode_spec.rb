require 'game_mode'
require 'ttt_core'

RSpec.describe GameMode do
  let(:params) { {} }

  it "configures a web game" do
    expect(GameMode.configure(params)).to be_a WebGame
  end

  it "configures game with empty board" do
    game = GameMode.configure(params)
    board = game.board
    expect(board.empty_spaces().length).to eq board.size
  end

  def configure(mode)
    params["mode"] = mode
    GameMode.configure(params)
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
      expect(game.mode).to eq "hvh" 
    end
  end

  context "when mode is human vs computer" do
    let(:game) { configure("hvc") }

    it "configures game with appropriate players" do
      expect(game.current_player).to be_a WebPlayer
      expect(game.next_player).to be_a TttCore::Computer
    end
    
    it "sets game mode" do
      expect(game.mode).to eq "hvc"
    end
  end
end
