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
random_mode = false

def get_random_riddle(list)
  random_int = rand(0..list.length)
  random_riddle = Riddle.new(list.slice!(random_int, 1)[0])
  random_riddle
end

def get_next_riddle(random, riddle_number, random_riddles)
  if random
    next_riddle = get_random_riddle(random_riddles)
  else
    next_riddle = Riddle.new(RIDDLES[riddle_number])
  end
  next_riddle
end

get '/' do
  riddle_number = 0
  correct_answers = 0
  random_riddles = RIDDLES[0..RIDDLES.length]
  random_mode = false
  erb(:landing)
end

get '/riddles' do
  if params[:random]
    random_mode = true
  end
  current_riddle = get_next_riddle(random_mode, riddle_number, random_riddles)
  @riddle = current_riddle
  erb(:input)
end

post '/riddles' do
  answer = params.fetch('answer')
  if current_riddle.correct?(answer)
    riddle_number += 1
    correct_answers += 1
    if correct_answers == 3
      erb(:success)
    else
      current_riddle = get_next_riddle(random_mode, riddle_number, random_riddles)
      @riddle = current_riddle
      erb(:input)
    end
  else
    erb(:failure)
  end
end
