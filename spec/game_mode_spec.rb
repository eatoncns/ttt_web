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

  context "when mode is human vs human" do
    it "configures game with web players" do
      params["mode"] = "hvh"
      game = GameMode.configure(params)
      expect(game.current_player).to be_a WebPlayer
      expect(game.next_player).to be_a WebPlayer
    end
  end

  context "when mode is human vs computer" do
    it "configures game with appropriate players" do
      params["mode"] = "hvc"
      game = GameMode.configure(params)
      expect(game.current_player).to be_a WebPlayer
      expect(game.next_player).to be_a TttCore::Computer
    end
  end
end
