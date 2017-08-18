require 'game_mode'

RSpec.describe GameMode do
  it "configures game with empty board" do
    game = GameMode.configure()
    board = game.board
    expect(board.empty_spaces().length).to eq board.size
  end

  it "configures game with web players" do
    game = GameMode.configure()
    expect(game.current_player).to be_a WebPlayer
  end
end
