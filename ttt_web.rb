require 'sinatra/base'
require_relative 'lib/game_mode'
require_relative 'lib/result_presenter'

class Application < Sinatra::Base
  enable :sessions unless test?

  get '/' do
    erb :index
  end

  post '/new-game' do
    game = GameMode.configure()
    session[:game] = game
    redirect '/game'
  end

  get '/game' do
    game = session[:game]
    erb :game, :locals => { :board => game.board }
  end

  post '/game' do
    move = params["move"].to_i
    game = session[:game]
    game.player_chooses(move)
    if game.over? then
      redirect '/result'
    else
      redirect '/game'
    end
  end

  get '/result' do
    game = session[:game]
    erb :result, :locals => { :result => ResultPresenter.new(game.board) }
  end

  run! if app_file == $0
end
