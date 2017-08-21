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
    game = Games[session["session_id"]]
    erb :game, :locals => { :board => BoardPresenter.new(game.board) }
  end

  post '/game' do
    game = Games[session["session_id"]]
    game.advance(params)
    redirect game.next_page()
  end

  get '/result' do
    game = Games[session["session_id"]]
    erb :result, :locals => { :result => ResultPresenter.new(game.board) }
  end

  run! if app_file == $0
end
