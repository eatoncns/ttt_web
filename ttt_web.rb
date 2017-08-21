require 'sinatra/base'
require_relative 'lib/game_mode'
require_relative 'lib/board_presenter'
require_relative 'lib/result_presenter'

Games = {}

class Application < Sinatra::Base
  enable :sessions unless test?

  get '/' do
    erb :index
  end

  post '/new-game' do
    game = GameMode.configure(params)
    Games[session["session_id"]] = game
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

  def game_from_session_or_redirect
    session_id = session["session_id"]
    if Games.has_key?(session_id) then
      return Games[session_id]
    end
    redirect "/"
  end

  run! if app_file == $0
end
