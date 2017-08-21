require 'game_mode'

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

  it "configures game with web players" do
    game = GameMode.configure(params)
    expect(game.current_player).to be_a WebPlayer
  end
end
