require 'game_mode'

RSpec.describe GameMode do
  let(:game_mode) { GameMode.new }
  
  it "configures game with empty board" do
    game = game_mode.configure()
    board = game.board
    expect(board.empty_spaces().length).to eq board.size
  end

  it "configures game with web players" do
    game = game_mode.configure()
    expect(game.current_player).to be_a WebPlayer
  end
end
