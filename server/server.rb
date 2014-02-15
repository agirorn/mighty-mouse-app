#!/usr/bin/env ruby
require 'sinatra'
require 'multi_json'
require 'pp'

def debug
  @debug ||= ENV.include? "DEBUG"
end

def debug_log(message)
  puts message if debug
end

get "/" do
  # redirect '/index.html'
  File.read(File.join('public', 'index.html'))
end

get '/hi' do
  "Hello World!"
end

post '/move' do
  debug_log '#'*80
  raw_params = request.body.read
  params = MultiJson.load(raw_params)
  x = params["x"]
  y = params["y"]
  offsetX = params["offsetX"]
  offsetY = params["offsetY"]
  debug_log "X: #{x}"
  debug_log "Y: #{y}"
  debug_log "offsetX: #{offsetX}"
  debug_log "offsetY: #{offsetY}"

  MultiJson.dump({
    status: 'ok',
    x: x,
    y: y,
    offsetX: offsetX,
    offsetY: offsetY
  })
end

post '/click' do
  debug_log '#'*80
  debug_log '# CLICK!'
  debug_log '#'*80
  MultiJson.dump({ status: 'ok' })
end
