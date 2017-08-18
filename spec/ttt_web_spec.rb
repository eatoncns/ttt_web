require 'ttt_web'

RSpec.describe Application do
  let(:app) { Application.new }

  describe "POST to /new-game" do
    let(:session) { {} }
    
    it "creates game in session" do
      post '/new-game', {}, 'rack.session' => session
      expect(session.has_key?(:game)).to be true  
    end

    it "redirects to /game" do
      response = post '/new-game', {}, 'rack.session' => session
      expect(response).to redirect_to "/game"
    end
  end

  describe "POST to /game" do
    let(:game_double) { double("Game", :player_chooses => nil, :board => TttCore::Board.new) }
    let(:session) { { :game => game_double } }

    it "updates game with chosen move" do
      expect(game_double).to receive(:player_chooses).with(3)
      env 'rack.session', session
      post '/game', 'move' => '3'
    end
  end
end
