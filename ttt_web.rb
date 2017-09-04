require 'sinatra/base'
require 'json'
require_relative 'lib/game_mode'
require_relative 'lib/web_game'
require_relative 'lib/board_presenter'
require_relative 'lib/result_presenter'
require_relative 'lib/board_json'

Games = {}

class Application < Sinatra::Base
  enable :sessions unless test?

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

  post '/api/new-game' do
    content_type :json
    game = create_game_for_session()
    BoardJson.encode(game.board)
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
