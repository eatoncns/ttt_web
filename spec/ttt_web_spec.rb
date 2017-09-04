require 'ttt_web'

RSpec.describe Application do
  let(:app) { Application.new }
  let(:session_id) { 1234 }
  let(:session) { { "session_id" => session_id } }

  describe "GET to /" do
    let (:response) { get '/' }

    it "returns OK response" do
      expect(response.status).to eq 200
    end

    it "displays a form for configuring game" do
      expect(response.body).to have_form("/new-game", "post") do
        with_select("mode") do
          with_option("Human vs Human", "hvh")
          with_option("Human vs Computer", "hvc")
          with_option("Computer vs Human", "cvh")
        end
        with_select("board_dimension") do
          with_option("3x3", "3")
          with_option("4x4", "4")
        end
        with_submit("New Game")
      end
    end
  end

  describe "POST to /new-game" do
    it "creates game" do
      post '/new-game', {}, 'rack.session' => session
      expect(Games.has_key?(session_id)).to be true  
    end

    it "redirects to /game" do
      response = post '/new-game', {}, 'rack.session' => session
      expect(response).to redirect_to "/game"
    end
  end

  describe "/game" do
    let(:board) { TttCore::Board.new }
    let(:game_double) { instance_double("WebGame", { :advance => nil, :next_page => "/game", :board => board }) }
    before(:each) { Games[session_id] = game_double }

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

      context "when no game is associated to session id" do
        before(:each) { Games.clear() }

        it "redirects back to index" do
          expect(response).to redirect_to "/"
        end
      end
    end

    describe "POST" do
      let(:params) { { 'move' => '3' }}

      def post_with_session
        env 'rack.session', session
        post '/game', params
      end

      it "advances game" do
        expect(game_double).to receive(:advance).with(params)
        post_with_session()
      end

      it "redirects to next page" do
        response = post_with_session()
        expect(response).to redirect_to game_double.next_page()
      end

      context "when no game is associated to session id" do
        before(:each) { Games.clear() }

        it "redirects back to index" do
          response = post_with_session()
          expect(response).to redirect_to "/"
        end
      end
    end
  end

  describe "GET to /result" do
    let(:board) { TttCore::Board.from_a(["X", "X", "X", "O", "O", "", "", "", ""]) }
    let(:game_double) { double("Game", { :board => board }) }
    before(:each) { Games[session_id] = game_double }
    let (:response) { get '/result', {}, 'rack.session' => session }

    it "returns OK response" do
      expect(response.status).to eq 200
    end

    it "displays result message" do
      expect(response.body).to have_tag(:p, :text => /X wins/)
    end

    it "displays button to play again" do
      expect(response.body).to have_form("/", "get") do
        with_submit("New Game")
      end
    end

    context "when no game is associated to session id" do
      before(:each) { Games.clear() }

      it "redirects back to index" do
        expect(response).to redirect_to "/"
      end
    end
  end

  describe "POST to /api/new-game" do
    let(:response) { post '/api/new-game', {}, 'rack.session' => session }

    it "returns OK response" do
      expect(response.status).to eq 200
    end

    it "creates game" do
      expect(Games.has_key?(session_id)).to be true
    end

    it "returns JSON response" do
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "POST to /api/game" do
    let(:board) { TttCore::Board.new }
    let(:game_double) { instance_double("WebGame", { :advance => nil, :next_page => "/game", :board => board }) }
    before(:each) { Games[session_id] = game_double }
    let(:params) { { 'move' => '3' }}

    def post_with_session
      env 'rack.session', session
      post '/api/game', params
    end

    it "advances game" do
      expect(game_double).to receive(:advance).with(params)
      post_with_session()
    end
    
    it "returns JSON response" do
      response = post_with_session()
      expect(response.content_type).to eq "application/json"
    end
  end
end
