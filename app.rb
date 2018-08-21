require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/riddle'
require 'pry'

RIDDLES = [
  {
    :q => 'What is 1 + 1?',
    :a => '2'
  },
  {
    :q => 'What is 2 + 2?',
    :a => '4'
  },
  {
    :q => 'What is black and white and read all over',
    :a => 'newspaper'
  }
]
riddle_number = nil
current_riddle = nil

get '/' do
  riddle_number = 0
  current_riddle = Riddle.new(RIDDLES[riddle_number])
  erb(:landing)
end

get '/riddles' do
  @riddle = Riddle.new(RIDDLES[riddle_number])
  erb(:input)
end

post '/riddles' do
  answer = params.fetch('answer')
  if current_riddle.correct?(answer)
    riddle_number += 1
    if riddle_number == 3
      erb(:success)
    else
      current_riddle = Riddle.new(RIDDLES[riddle_number])
      @riddle = current_riddle
      erb(:input)
    end
  else
    erb(:failure)
  end
end
