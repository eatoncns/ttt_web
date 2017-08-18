require 'sinatra/base'
require 'ttt_core'
require_relative 'lib/game_mode'

class Application < Sinatra::Base
  enable :sessions unless test?

  get '/game' do
    game_mode = GameMode.new
    game = game_mode.configure()
    session[:game] = game
    erb :game, :locals => { :board => game.board }
  end

  post '/game' do
    move = params["move"].to_i
    game = session[:game]
    game.player_chooses(move)
    erb :game, :locals => { :board => game.board }
  end

  run! if app_file == $0
end
