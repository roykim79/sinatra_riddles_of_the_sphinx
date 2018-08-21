require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set :show_exceptions, false

describe 'the riddle path', :type => :feature do
  it 'sends to user to the riddles page where they will be asked a question' do
    visit '/'
    click_button'Proceed'
    expect(page).to have_content '?'
  end

  it 'checks if the given answer is correct and displays a failure message if incorrect' do
    visit '/'
    click_button 'Proceed'
    fill_in 'answer', :with => 'foo'
    click_button 'Go!'
    expect(page).to have_content 'Wrong'
  end

  it 'sends to user to a success page after answering 3 riddles correctly' do
    visit '/'
    click_button 'Proceed'
    fill_in 'answer', :with => '2'
    click_button 'Go!'
    fill_in 'answer', :with => '4'
    click_button 'Go!'
    fill_in 'answer', :with => 'Newspaper'
    click_button 'Go!'
    expect(page).to have_content 'Success!'
  end
end

describe 'the random riddle path', :type => :feature do
  it 'sends the user to a random riddle to answer' do
    visit '/'
    click_button 'Proceed'
    expect(page).to have_content '?'
  end
end
