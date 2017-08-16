require 'ttt_web'

RSpec.describe Application do
  let(:app) { Application.new }

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello world!')
  end
end
