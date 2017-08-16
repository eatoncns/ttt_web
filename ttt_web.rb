require 'sinatra/base'
require 'ttt_core'

class Application < Sinatra::Base
  
  get '/game' do
    board = TttCore::Board.new
    erb :game, :locals => { :board => board }
  end

  run! if app_file == $0
end
