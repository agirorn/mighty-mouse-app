ENV['RACK_ENV'] = 'test'

require_relative '../server.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'
require 'pry'

describe 'The Mighty Mouse App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "returns the AngularJS application" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('clientApp')
  end

  it "accepts move command" do
    post '/move',
          MultiJson.dump({
            x:19,
            y:20,
            offsetX: 12,
            offsetY: 22
          }),
          { 'Content-Type' => 'application/json' }

    expect(last_response).to be_ok
    expect( MultiJson.load last_response.body  ).to eq({
      'status' => 'ok',
      'x' => 19,
      'y' => 20,
      'offsetX' => 12,
      'offsetY' => 22
    })
  end

  it "accepts move command" do
    post '/click', '', { 'Content-Type' => 'application/json' }

    expect(last_response).to be_ok
    expect( MultiJson.load last_response.body  ).to eq({
      'status' => 'ok'
    })
  end

end
