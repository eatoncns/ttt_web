ENV['RACK_ENV'] = 'test'

require_relative '../ttt_web'
require 'rack/test'

RSpec.describe "The TTT web app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello world!')
  end
end
