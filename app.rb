require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/riddle'
require './lib/riddles'
require 'pry'

riddle_number = nil
current_riddle = nil
correct_answers = nil
random_riddles = nil

def get_random_riddle(list)
  random_int = rand(0..list.length)
  random_riddle = Riddle.new(list.slice!(random_int, 1)[0])
  random_riddle
end

get '/' do
  riddle_number = 0
  correct_answers = 0
  random_riddles = RIDDLES[0..RIDDLES.length]
  erb(:landing)
end

get '/riddles' do
  current_riddle = Riddle.new(RIDDLES[riddle_number])
  @riddle = current_riddle
  @action = 'riddles'
  erb(:input)
end

get '/random_riddles' do
  current_riddle = get_random_riddle(random_riddles)
  @riddle = current_riddle
  @action = 'random_riddles'
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
      @action = 'riddles'
      erb(:input)
    end
  else
    erb(:failure)
  end
end

post '/random_riddles' do
  answer = params.fetch('answer')
  if current_riddle.correct?(answer)
    correct_answers += 1
    if correct_answers == 3
      erb(:success)
    else
      current_riddle = get_random_riddle(random_riddles)
      @riddle = current_riddle
      @action = 'random_riddles'
      erb(:input)
    end
  else
    erb(:failure)
  end
end
