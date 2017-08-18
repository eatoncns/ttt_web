require 'ttt_web'

RSpec.describe Application do
  let(:app) { Application.new }
  let(:session) { {} }

  describe "GET to /game" do
    it "creates game in session" do
      get '/game', {}, 'rack.session' => session
      expect(session.has_key?(:game)).to be true  
    end
  end
end
