require 'sinatra/base'
require_relative 'lib/game_mode'
require_relative 'lib/web_game'
require_relative 'lib/board_presenter'
require_relative 'lib/result_presenter'
require_relative 'lib/board_encode'

Games = {}

class Application < Sinatra::Base
  enable :sessions unless test?

  options "*" do
    setupCORS()
    halt 200
  end

  before do
    setupCORS()
  end

  def setupCORS
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "HEAD,GET,POST,PUT,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept" 
  end

  get '/' do
    erb :index
  end

  post '/new-game' do
    game = create_game_for_session()
    redirect game.next_page()
  end

  get '/game' do
    game = game_from_session_or_redirect()
    erb :game, :locals => { :board => BoardPresenter.new(game.board) }
  end

  post '/game' do
    game = game_from_session_or_redirect()
    game.advance(params)
    redirect game.next_page()
  end

  get '/result' do
    game = game_from_session_or_redirect()
    erb :result, :locals => { :result => ResultPresenter.new(game.board) }
  end

  before '/api/*' do
    content_type :json
  end

  post '/api/new-game' do
    game = create_game_for_session()
    BoardEncode.as_json(game.board)
  end

  post '/api/game' do
    game = game_from_session_or_redirect()
    game.advance(params)
    BoardEncode.as_json(game.board)
  end

  post '/api/result' do
    game = game_from_session_or_redirect()
    BoardEncode.result_as_json(game.board)
  end

  def create_game_for_session()
    mode = GameMode.new(params)
    game = WebGame.configure(mode)
    Games[session["session_id"]] = game
  end

  def game_from_session_or_redirect
    session_id = session["session_id"]
    if Games.has_key?(session_id) then
      return Games[session_id]
    end
    redirect "/"
  end

  run! if app_file == $0
end
