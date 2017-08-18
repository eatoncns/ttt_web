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
    let(:board) { TttCore::Board.new }
    let(:game_double) { double("Game", { :player_chooses => nil, :board => board, :over? => false }) }
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

      context "when space is marked" do
        it "displays mark on button" do
          board.set_mark(3, "X")
          response = get '/game', {}, 'rack.session' => session 
          attributes = { :value => 3, :text => "X" }
          expect(response.body).to have_tag(:button, attributes)
        end

        it "disables button" do
          board.set_mark(3, "X")
          response = get '/game', {}, 'rack.session' => session 
          expect(response.body).to have_tag("button[disabled!='']")
        end
      end
    end

    describe "POST" do

      def post_with_session
        env 'rack.session', session
        post '/game', 'move' => '3'
      end

      it "updates game with chosen move" do
        expect(game_double).to receive(:player_chooses).with(3)
        post_with_session()
      end

      context "when game is not over" do
        it "redirects to /game" do
          response = post_with_session()
          expect(response).to redirect_to "/game"
        end
      end

      context "when game is over" do
        it "redirects to /result" do
          allow(game_double).to receive(:over?).and_return(true)
          response = post_with_session()
          expect(response).to redirect_to "/result"
        end
      end
    end
  end

  describe "GET to /result" do
    let(:board) { TttCore::Board.from_a(["X", "X", "X", "O", "O", "", "", "", ""]) }
    let(:game_double) { double("Game", { :board => board }) }
    let(:session) { { :game => game_double } }
    let (:response) { get '/result', {}, 'rack.session' => session }

    it "returns OK response" do
      expect(response.status).to eq 200
    end

    it "displays winner" do
      expect(response.body).to have_tag(:p, :text => /X wins/)
    end
  end
end
