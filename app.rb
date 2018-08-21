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
    :a => 'Newspaper'
  }
]
riddle_number = 0

get '/' do
  erb(:landing)
end

get '/riddles' do
  riddle_number = 0
  @riddle = Riddle.new(RIDDLES[riddle_number])
  erb(:input)
end

post '/riddles' do
  answer = params.fetch('answer')
  if answer == RIDDLES[riddle_number][:a]
    riddle_number += 1
    if riddle_number == 3
      erb(:success)
    else
      @riddle = Riddle.new(RIDDLES[riddle_number])
      erb(:input)
    end
  else
    erb(:failure)
  end
end
