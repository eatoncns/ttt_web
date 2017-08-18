require 'ttt_web'

RSpec.describe Application do
  let(:app) { Application.new }

  describe "GET to /" do
    let (:response) { get '/' }

    it "returns OK response" do
      expect(response.status).to eq 200
    end

    it "displays a form that POSTs to /new-game" do
      expect(response.body).to have_tag(:form, :action => "/new-game", :method => "post")
    end

    it "displays a submit tag" do
      expect(response.body).to have_tag(:input, :type => "submit")
    end
  end

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

  describe "/game" do
    let(:game_double) { double("Game", { :player_chooses => nil, :board => TttCore::Board.new }) }
    let(:session) { { :game => game_double } }

    describe "GET" do
      let(:response) { get '/game', {}, 'rack.session' => session }

      it "returns OK response" do
        expect(response.status).to eq 200
      end

      it "displays a form that POSTS to /game" do
        expect(response.body).to have_tag(:form, :action => "/game", :method => "post")
      end

      it "displays a button for each space" do
        (1..9).each do |space|
          attributes = { :type => "submit", :name => "move", :value => space.to_s }
          expect(response.body).to have_tag(:button, attributes)
        end 
      end
    end

    describe "POST" do
      it "updates game with chosen move" do
        expect(game_double).to receive(:player_chooses).with(3)
        env 'rack.session', session
        post '/game', 'move' => '3'
      end

      it "redirects to /game" do
        env 'rack.session', session
        response = post '/game', 'move' => '3'
        expect(response).to redirect_to "/game"
      end
    end
  end
end
