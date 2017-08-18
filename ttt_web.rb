require 'sinatra/base'
require_relative 'lib/game_mode'

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
    redirect '/game'
  end

  run! if app_file == $0
end
