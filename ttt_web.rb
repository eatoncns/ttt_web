require 'sinatra/base'
require 'ttt_core'
require_relative 'lib/web_player'

class Application < Sinatra::Base
  set :sessions, true

  get '/game' do
    board = TttCore::Board.new
    player_one = WebPlayer.new("X")
    player_two = WebPlayer.new("O")
    game = TttCore::Game.new(board, player_one, player_two)
    session[:game] = game
    erb :game, :locals => { :board => board }
  end

  post '/game' do
    move = params["move"].to_i
    game = session[:game]
    game.player_chooses(move)
    erb :game, :locals => { :board => game.board }
  end

  run! if app_file == $0
end
